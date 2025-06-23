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

if (!supabaseUrl || !supabaseKey) {
  console.error(
    'Error: PUBLIC_SUPABASE_URL and PUBLIC_SUPABASE_SERVICE_ROLE_KEY (or PUBLIC_SUPABASE_ANON_KEY) must be set in your .env file'
  );
  console.log('Please make sure these are set in your .env file:');
  console.log('PUBLIC_SUPABASE_URL=your_supabase_url');
  console.log(
    'PUBLIC_SUPABASE_SERVICE_ROLE_KEY=your_service_role_key (recommended for data uploads)'
  );
  console.log('PUBLIC_SUPABASE_ANON_KEY=your_anon_key (alternative)');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function uploadCities() {
  console.log('📍 Loading cities data...');

  try {
    // Check if cities already exist
    const { data: existingCities, error: countError } = await supabase
      .from('cities')
      .select('city_name', { count: 'exact' });

    if (countError) {
      console.error('Error checking existing cities:', countError);
      throw countError;
    }

    if (existingCities && existingCities.length > 0) {
      console.log(
        `Found ${existingCities.length} existing cities in database.`
      );
      // Only skip if we have all 878 cities
      if (existingCities.length >= 878) {
        console.log('All cities already uploaded, skipping...');
        return existingCities.map((c) => c.city_name);
      } else {
        console.log(
          'Incomplete upload detected, will clear and re-upload all cities.'
        );
        await supabase.from('venues').delete().neq('id', '');
        await supabase.from('cities').delete().neq('city_name', '');
      }
    }

    const citiesData = JSON.parse(
      readFileSync(join(__dirname, '../data/cities.json'), 'utf8')
    );
    console.log(`Found ${citiesData.length} cities to upload`);

    // Transform data to match database schema and remove duplicates
    const cityMap = new Map();
    citiesData.forEach((city) => {
      if (!cityMap.has(city.city_name)) {
        cityMap.set(city.city_name, {
          city_name: city.city_name,
          full_name: city.full_name,
          state: city.state,
          population: city.population,
          image_url: city.image_url,
          has_image: city.has_image,
          fips_state: city.fips_state,
          fips_place: city.fips_place,
          source: city.source,
        });
      }
    });

    const transformedCities = Array.from(cityMap.values());
    console.log(
      `Removed ${citiesData.length - transformedCities.length} duplicate cities`
    );

    // Upload in batches of 100 to avoid timeouts
    const batchSize = 100;
    let uploadedCount = 0;

    for (let i = 0; i < transformedCities.length; i += batchSize) {
      const batch = transformedCities.slice(i, i + batchSize);

      const { data, error } = await supabase.from('cities').insert(batch);

      if (error) {
        console.error(
          `Error uploading cities batch ${Math.floor(i / batchSize) + 1}:`,
          error
        );
        throw error;
      }

      uploadedCount += batch.length;
      console.log(
        `✅ Uploaded ${uploadedCount}/${transformedCities.length} cities`
      );
    }

    console.log('🎉 All cities uploaded successfully!');
    return transformedCities.map((c) => c.city_name);
  } catch (error) {
    console.error('❌ Error uploading cities:', error);
    throw error;
  }
}

async function uploadVenues(validCities) {
  console.log('🏢 Loading venues data...');

  try {
    const venuesData = JSON.parse(
      readFileSync(
        join(__dirname, '../data/venues-database-FINAL-CORRECT.json'),
        'utf8'
      )
    );
    console.log(`Found ${venuesData.length} venues to filter and upload`);

    // Filter venues to only include those with cities in our cities table
    const validCitiesSet = new Set(validCities);
    const filteredVenues = venuesData.filter((venue) => {
      if (!venue.city) return false;
      return validCitiesSet.has(venue.city);
    });

    console.log(
      `Filtered to ${filteredVenues.length} venues with valid cities`
    );

    if (filteredVenues.length === 0) {
      console.log(
        '⚠️  No venues found with valid cities. Skipping venue upload.'
      );
      return;
    }

    // Transform data to match database schema
    const transformedVenues = filteredVenues.map((venue) => ({
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

    // Upload in batches of 50 to avoid timeouts (venues have more data)
    const batchSize = 50;
    let uploadedCount = 0;

    for (let i = 0; i < transformedVenues.length; i += batchSize) {
      const batch = transformedVenues.slice(i, i + batchSize);

      const { data, error } = await supabase.from('venues').insert(batch);

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
  } catch (error) {
    console.error('❌ Error uploading venues:', error);
    throw error;
  }
}

async function main() {
  console.log('🚀 Starting data upload to Supabase...');

  try {
    // First upload cities
    const validCities = await uploadCities();

    // Then upload venues (filtered by valid cities)
    await uploadVenues(validCities);

    console.log('\n🎊 Data upload completed successfully!');
    console.log('✅ Cities table populated');
    console.log('✅ Venues table populated (filtered by valid cities)');
  } catch (error) {
    console.error('\n💥 Data upload failed:', error);
    process.exit(1);
  }
}

main();
