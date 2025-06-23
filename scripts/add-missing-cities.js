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

async function addMissingCities() {
  console.log('🔍 Finding cities in venues but not in cities table...');

  try {
    // Get all venue cities
    const venuesData = JSON.parse(
      readFileSync(
        join(__dirname, '../data/venues-database-FINAL-CORRECT.json'),
        'utf8'
      )
    );
    const venueCities = [
      ...new Set(venuesData.map((v) => v.city).filter(Boolean)),
    ];
    console.log(`Found ${venueCities.length} unique cities in venues data`);

    // Get existing cities from database
    const { data: existingCities, error } = await supabase
      .from('cities')
      .select('city_name');

    if (error) {
      console.error('Error fetching existing cities:', error);
      throw error;
    }

    const existingCityNames = new Set(existingCities.map((c) => c.city_name));
    console.log(`Found ${existingCityNames.size} existing cities in database`);

    // Find missing cities
    const missingCities = venueCities.filter(
      (city) => !existingCityNames.has(city)
    );
    console.log(
      `Found ${missingCities.length} missing cities that need to be added`
    );

    if (missingCities.length === 0) {
      console.log('✅ No missing cities found!');
      return;
    }

    // Create basic city records for missing cities
    const newCityRecords = missingCities.map((cityName) => ({
      city_name: cityName,
      full_name: `${cityName} city`,
      state: null, // We'll extract this from venue data if available
      population: null,
      image_url: null,
      has_image: false,
      fips_state: null,
      fips_place: null,
      source: 'Added from venue data',
    }));

    // Try to populate state information from venue data
    newCityRecords.forEach((cityRecord) => {
      const venueWithState = venuesData.find(
        (v) => v.city === cityRecord.city_name && v.state
      );
      if (venueWithState && venueWithState.state) {
        cityRecord.state = venueWithState.state;
        cityRecord.full_name = `${cityRecord.city_name} city, ${venueWithState.state}`;
      }
    });

    // Upload in batches
    const batchSize = 100;
    let uploadedCount = 0;

    for (let i = 0; i < newCityRecords.length; i += batchSize) {
      const batch = newCityRecords.slice(i, i + batchSize);

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
        `✅ Added ${uploadedCount}/${newCityRecords.length} missing cities`
      );
    }

    console.log('🎉 All missing cities added successfully!');
    console.log(
      `📊 Database now has ${
        existingCityNames.size + missingCities.length
      } total cities`
    );

    return missingCities;
  } catch (error) {
    console.error('❌ Error adding missing cities:', error);
    throw error;
  }
}

async function main() {
  console.log('🚀 Adding missing cities to enable full venue coverage...');

  try {
    await addMissingCities();
    console.log(
      '\n✅ Missing cities added! You can now re-run the venue upload to get all venues.'
    );
  } catch (error) {
    console.error('\n💥 Failed to add missing cities:', error);
    process.exit(1);
  }
}

main();
