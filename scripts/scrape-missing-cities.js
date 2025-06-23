import { createClient } from '@supabase/supabase-js';
import { readFileSync, writeFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables
import dotenv from 'dotenv';
dotenv.config();

const supabaseUrl = process.env.PUBLIC_SUPABASE_URL;
const supabaseKey =
  process.env.PUBLIC_SUPABASE_SERVICE_ROLE_KEY ||
  process.env.PUBLIC_SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseKey);

// Simple delay function
const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function searchVenueInfo(venueName, address = null) {
  const searchQuery = address
    ? `"${venueName}" "${address}" location city`
    : `"${venueName}" bar restaurant location city`;

  try {
    // Using a simple web search approach
    console.log(`🔍 Searching for: ${searchQuery}`);

    // We'll use a basic fetch to search (you could replace this with Bing API if you have keys)
    const encodedQuery = encodeURIComponent(searchQuery);
    const searchUrl = `https://www.bing.com/search?q=${encodedQuery}`;

    const response = await fetch(searchUrl, {
      headers: {
        'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      },
    });

    if (!response.ok) {
      console.log(`❌ Search failed for ${venueName}`);
      return null;
    }

    const html = await response.text();

    // Extract city information from search results
    const cityInfo = extractCityFromHtml(html, venueName);

    // Add delay to be respectful to the search engine
    await delay(2000);

    return cityInfo;
  } catch (error) {
    console.error(`Error searching for ${venueName}:`, error.message);
    return null;
  }
}

function extractCityFromHtml(html, venueName) {
  try {
    // Look for common patterns in search results
    const patterns = [
      // Address patterns like "123 Main St, CityName, State"
      /(\w+(?:\s+\w+)*),\s*([A-Z]{2})/g,
      // "in CityName" patterns
      /\bin\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*),?\s*([A-Z]{2})?/g,
      // "CityName, State" patterns
      /([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*),\s*([A-Z]{2})/g,
      // Location indicators
      /location[:\s]+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)/gi,
    ];

    const foundLocations = [];

    for (const pattern of patterns) {
      let match;
      while ((match = pattern.exec(html)) !== null) {
        const city = match[1]?.trim();
        const state = match[2]?.trim();

        if (city && city.length > 2 && city.length < 50) {
          // Filter out common false positives
          const blacklist = [
            'Google',
            'Facebook',
            'Twitter',
            'Instagram',
            'Website',
            'Contact',
            'About',
            'Privacy',
            'Terms',
            'Search',
            'Results',
            'Page',
          ];
          if (!blacklist.some((word) => city.includes(word))) {
            foundLocations.push({ city, state });
          }
        }
      }
    }

    // Return the most likely city (first non-generic result)
    if (foundLocations.length > 0) {
      const bestMatch = foundLocations[0];
      console.log(
        `✅ Found potential location: ${bestMatch.city}${
          bestMatch.state ? ', ' + bestMatch.state : ''
        }`
      );
      return bestMatch;
    }

    console.log(`❌ No city found in search results for ${venueName}`);
    return null;
  } catch (error) {
    console.error('Error parsing HTML:', error.message);
    return null;
  }
}

async function scrapeMissingCities() {
  console.log('🕵️ Starting to scrape missing city information...');

  try {
    // Load venues from JSON file
    const venuesData = JSON.parse(
      readFileSync(
        join(__dirname, '../data/venues-database-FINAL-CORRECT.json'),
        'utf8'
      )
    );

    // Find venues with missing cities
    const missingCityVenues = venuesData.filter(
      (venue) => !venue.city || venue.city.trim() === ''
    );
    console.log(
      `Found ${missingCityVenues.length} venues with missing city information`
    );

    if (missingCityVenues.length === 0) {
      console.log('✅ No venues found with missing cities!');
      return;
    }

    console.log('Venues with missing cities:');
    missingCityVenues.forEach((venue, index) => {
      console.log(`${index + 1}. ${venue.name} (ID: ${venue.id})`);
      console.log(`   Address: ${venue.address || 'No address'}`);
    });

    const updatedVenues = [];
    let successCount = 0;

    // Search for each venue
    for (let i = 0; i < missingCityVenues.length; i++) {
      const venue = missingCityVenues[i];
      console.log(
        `\n🔍 [${i + 1}/${missingCityVenues.length}] Searching for: ${
          venue.name
        }`
      );

      const locationInfo = await searchVenueInfo(venue.name, venue.address);

      if (locationInfo && locationInfo.city) {
        const updatedVenue = {
          ...venue,
          city: locationInfo.city,
          state: locationInfo.state || venue.state,
        };
        updatedVenues.push(updatedVenue);
        successCount++;
        console.log(`✅ Updated ${venue.name} -> City: ${locationInfo.city}`);
      } else {
        console.log(`❌ Could not find city for ${venue.name}`);
        // Keep original venue for manual review
        updatedVenues.push({
          ...venue,
          city: 'NEEDS_MANUAL_REVIEW',
          search_attempted: true,
        });
      }
    }

    console.log(`\n📊 Search Results Summary:`);
    console.log(`✅ Successfully found cities: ${successCount}`);
    console.log(
      `❌ Still need manual review: ${missingCityVenues.length - successCount}`
    );

    // Save results to a new file for review
    const outputFile = join(
      __dirname,
      '../data/venues-with-scraped-cities.json'
    );
    writeFileSync(outputFile, JSON.stringify(updatedVenues, null, 2));
    console.log(`\n💾 Results saved to: ${outputFile}`);

    // If we found any cities, offer to upload them
    if (successCount > 0) {
      console.log(
        `\n🚀 Found ${successCount} new cities! These venues can now be uploaded to the database.`
      );

      // Filter out venues that still need manual review
      const validVenues = updatedVenues.filter(
        (v) => v.city !== 'NEEDS_MANUAL_REVIEW'
      );

      if (validVenues.length > 0) {
        await uploadScrapedVenues(validVenues);
      }
    }

    return {
      total: missingCityVenues.length,
      found: successCount,
      needsReview: missingCityVenues.length - successCount,
    };
  } catch (error) {
    console.error('❌ Error during scraping:', error);
    throw error;
  }
}

async function uploadScrapedVenues(venues) {
  console.log(`\n🚀 Uploading ${venues.length} venues with scraped cities...`);

  try {
    // First, add any new cities that don't exist yet
    const venueCities = [...new Set(venues.map((v) => v.city))];

    const { data: existingCities } = await supabase
      .from('cities')
      .select('city_name');

    const existingCitySet = new Set(existingCities.map((c) => c.city_name));
    const newCities = venueCities.filter((city) => !existingCitySet.has(city));

    if (newCities.length > 0) {
      console.log(`Adding ${newCities.length} new cities...`);
      const newCityRecords = newCities.map((cityName) => ({
        city_name: cityName,
        full_name: `${cityName} city`,
        state: venues.find((v) => v.city === cityName)?.state || null,
        population: null,
        image_url: null,
        has_image: false,
        fips_state: null,
        fips_place: null,
        source: 'Scraped from web search',
      }));

      const { error: cityError } = await supabase
        .from('cities')
        .insert(newCityRecords);

      if (cityError) {
        console.error('Error adding cities:', cityError);
        throw cityError;
      }
      console.log(`✅ Added ${newCities.length} new cities`);
    }

    // Transform and upload venues
    const transformedVenues = venues.map((venue) => ({
      id: venue.id,
      name: venue.name,
      address: venue.address,
      city: venue.city,
      state: venue.state,
      zip_code: venue.zip_code,
      phone: venue.phone,
      website: venue.website,
      latitude: venue.latitude,
      longitude: venue.longitude,
      venue_type: venue.venue_type,
      category: venue.category,
      source: venue.source,
      is_alcohol_free: venue.is_alcohol_free,
      serves_kava: venue.serves_kava,
      serves_mocktails: venue.serves_mocktails,
      serves_thc: venue.serves_thc,
      serves_hemp_drinks: venue.serves_hemp_drinks,
      hemp_brand: venue.hemp_brand,
      is_dispensary: venue.is_dispensary,
      scraped_at: venue.scraped_at,
      enriched_at: venue.enriched_at,
      rating: venue.rating,
      data_complete: venue.data_complete,
      enrichment_source: venue.enrichment_source,
      has_google_maps_data: venue.has_google_maps_data,
    }));

    const { error: venueError } = await supabase
      .from('venues')
      .insert(transformedVenues);

    if (venueError) {
      console.error('Error uploading venues:', venueError);
      throw venueError;
    }

    console.log(
      `✅ Successfully uploaded ${venues.length} venues with scraped cities!`
    );
  } catch (error) {
    console.error('❌ Error uploading scraped venues:', error);
    throw error;
  }
}

async function main() {
  console.log('🕷️ Venue City Scraper Tool');
  console.log('==========================');

  try {
    const results = await scrapeMissingCities();

    console.log('\n📋 Final Summary:');
    console.log(`Total venues processed: ${results.total}`);
    console.log(`Cities found: ${results.found}`);
    console.log(`Still need manual review: ${results.needsReview}`);

    if (results.needsReview > 0) {
      console.log('\n💡 For venues that still need review, you can:');
      console.log(
        '1. Check the saved file: data/venues-with-scraped-cities.json'
      );
      console.log('2. Manually add city information');
      console.log('3. Re-run this script or upload manually');
    }
  } catch (error) {
    console.error('\n💥 Scraping failed:', error);
    process.exit(1);
  }
}

main();
