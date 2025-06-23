import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
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

async function uploadAllVenues() {
  console.log('🚀 Uploading ALL venues from JSON file...');

  try {
    // Load all venues from JSON
    const venuesData = JSON.parse(
      readFileSync(
        join(__dirname, '../data/venues-database-FINAL-CORRECT.json'),
        'utf8'
      )
    );
    console.log(`Found ${venuesData.length} total venues in JSON`);

    // Filter out venues with empty/null cities only
    const validVenues = venuesData.filter(
      (venue) => venue.city && venue.city.trim() !== ''
    );
    console.log(`Found ${validVenues.length} venues with valid cities`);
    console.log(
      `Excluding ${
        venuesData.length - validVenues.length
      } venues with empty/null cities`
    );

    // Get existing cities
    const { data: existingCities, error: cityError } = await supabase
      .from('cities')
      .select('city_name');

    if (cityError) {
      console.error('Error fetching cities:', cityError);
      throw cityError;
    }

    const existingCitySet = new Set(existingCities.map((c) => c.city_name));
    console.log(`Found ${existingCitySet.size} existing cities in database`);

    // Find venues that need new cities
    const venueCities = [...new Set(validVenues.map((v) => v.city))];
    const missingCities = venueCities.filter(
      (city) => !existingCitySet.has(city)
    );

    console.log(`Need to add ${missingCities.length} new cities for venues`);

    // Add missing cities first
    if (missingCities.length > 0) {
      console.log('Adding missing cities...');
      const newCityRecords = missingCities.map((cityName) => {
        // Try to get state from a venue with that city
        const venueWithState = validVenues.find(
          (v) => v.city === cityName && v.state
        );
        return {
          city_name: cityName,
          full_name: venueWithState?.state
            ? `${cityName} city, ${venueWithState.state}`
            : `${cityName} city`,
          state: venueWithState?.state || null,
          population: null,
          image_url: null,
          has_image: false,
          fips_state: null,
          fips_place: null,
          source: 'Added from venue data',
        };
      });

      const { error: addCityError } = await supabase
        .from('cities')
        .insert(newCityRecords);

      if (addCityError) {
        console.error('Error adding cities:', addCityError);
        throw addCityError;
      }
      console.log(`✅ Added ${missingCities.length} new cities`);
    }

    // Clear existing venues to start fresh
    console.log('Clearing existing venues...');
    const { error: deleteError } = await supabase
      .from('venues')
      .delete()
      .neq('id', '');

    if (deleteError) {
      console.error('Error clearing venues:', deleteError);
      throw deleteError;
    }

    // Transform and upload ALL valid venues
    const transformedVenues = validVenues.map((venue) => ({
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

    // Upload in batches
    const batchSize = 50;
    let uploadedCount = 0;

    for (let i = 0; i < transformedVenues.length; i += batchSize) {
      const batch = transformedVenues.slice(i, i + batchSize);

      const { error } = await supabase.from('venues').insert(batch);

      if (error) {
        console.error(
          `Error uploading venues batch ${Math.floor(i / batchSize) + 1}:`,
          error
        );
        throw error;
      }

      uploadedCount += batch.length;
      console.log(
        `✅ Uploaded ${uploadedCount}/${transformedVenues.length} venues`
      );
    }

    console.log('🎉 All venues uploaded successfully!');
    console.log(`📊 Final count: ${transformedVenues.length} venues uploaded`);

    return transformedVenues.length;
  } catch (error) {
    console.error('❌ Error uploading venues:', error);
    throw error;
  }
}

async function main() {
  try {
    const uploadedCount = await uploadAllVenues();
    console.log(
      `\n✅ SUCCESS! Uploaded ${uploadedCount} venues from JSON file`
    );
  } catch (error) {
    console.error('\n💥 Upload failed:', error);
    process.exit(1);
  }
}

main();
