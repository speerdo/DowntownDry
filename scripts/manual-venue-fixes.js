import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config();

const supabaseUrl = process.env.PUBLIC_SUPABASE_URL;
const supabaseKey =
  process.env.PUBLIC_SUPABASE_SERVICE_ROLE_KEY ||
  process.env.PUBLIC_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

// Manually researched venue locations
const venueLocationFixes = [
  {
    id: 'outscraper-sober-venues-1750509410433-1tgaplll6',
    name: 'MOXIE Sober Bar & Social',
    city: 'Minneapolis',
    state: 'Minnesota',
  },
  {
    id: 'outscraper-sober-venues-1750509410431-c1ts7pqw7',
    name: 'Mok Bar Mocktails',
    city: 'Mandarin',
    state: 'Florida', // Mandarin is a neighborhood in Jacksonville, FL
  },
  {
    id: 'kavawiki-1750509410436-kpiik2981',
    name: 'Kalm with Kava',
    city: 'Billings',
    state: 'Montana',
  },
  {
    id: 'outscraper-sober-venues-1750509410432-6xib69vzz',
    name: 'Flying Eagle Kombucha',
    city: 'Fort Myers',
    state: 'Florida',
  },
  // Add more manual fixes as needed
];

async function addMissingCitiesAndVenues() {
  console.log('🔧 Manually fixing venue locations...');

  try {
    // First, add any missing cities
    const uniqueCities = [...new Set(venueLocationFixes.map((v) => v.city))];

    for (const cityName of uniqueCities) {
      const venue = venueLocationFixes.find((v) => v.city === cityName);

      // Check if city exists
      const { data: existingCity } = await supabase
        .from('cities')
        .select('city_name')
        .eq('city_name', cityName)
        .single();

      if (!existingCity) {
        console.log(`Adding missing city: ${cityName}`);
        const { error } = await supabase.from('cities').insert({
          city_name: cityName,
          full_name: `${cityName} city, ${venue.state}`,
          state: venue.state,
          population: null,
          image_url: null,
          has_image: false,
          fips_state: null,
          fips_place: null,
          source: 'Manually researched',
        });

        if (error) {
          console.error(`Error adding city ${cityName}:`, error);
        } else {
          console.log(`✅ Added city: ${cityName}`);
        }
      } else {
        console.log(`City already exists: ${cityName}`);
      }
    }

    // Now add the venues
    for (const venue of venueLocationFixes) {
      console.log(`Adding venue: ${venue.name} in ${venue.city}`);

      const { error } = await supabase.from('venues').insert({
        id: venue.id,
        name: venue.name,
        address: null,
        city: venue.city,
        state: venue.state,
        zip_code: null,
        phone: null,
        website: null,
        latitude: null,
        longitude: null,
        venue_type: 'Bar',
        category: 'sober',
        source: 'Outscraper Sober Venues',
        is_alcohol_free: true,
        serves_kava: false,
        serves_mocktails: true,
        serves_thc: false,
        serves_hemp_drinks: false,
        hemp_brand: null,
        is_dispensary: false,
        scraped_at: null,
        enriched_at: null,
        rating: null,
        data_complete: false,
        enrichment_source: 'Manual research',
        has_google_maps_data: false,
      });

      if (error) {
        if (error.code === '23505') {
          console.log(`Venue already exists: ${venue.name}`);
        } else {
          console.error(`Error adding venue ${venue.name}:`, error);
        }
      } else {
        console.log(`✅ Added venue: ${venue.name}`);
      }
    }

    console.log('\n✅ Manual fixes completed!');
  } catch (error) {
    console.error('❌ Error during manual fixes:', error);
    throw error;
  }
}

addMissingCitiesAndVenues();
