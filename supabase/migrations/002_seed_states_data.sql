-- Seed initial states data for soft launch (CA, NY, IN, NE)
-- Run this after 001_create_states_table.sql

INSERT INTO states (state_name, state_abbr, image_url, description, meta_description, is_active)
VALUES 
  (
    'California',
    'CA',
    'https://images.unsplash.com/photo-1449034446853-66c86144b0ad?auto=format&fit=crop&w=1600&h=600&q=80',
    'California has become a significant hub for the non-alcoholic beverage movement, leading the nation with diverse offerings ranging from craft mocktails to zero-proof spirits. Major centers like Los Angeles, San Francisco, and San Diego are at the forefront, offering everything from upscale sober bars to traditional kava lounges and innovative THC beverage venues. The state''s progressive culture has embraced the mindful drinking movement, making it easier than ever to find sophisticated alcohol-free options. Whether you''re exploring the arts scene in LA, the tech hubs of the Bay Area, or the coastal vibes of San Diego, California offers a comprehensive landscape of venues committed to providing exceptional non-alcoholic experiences for every taste and occasion.',
    'Find alcohol-free bars, kava lounges & mocktail venues across California. Explore LA, SF, San Diego & more sober-friendly spots.',
    true
  ),
  (
    'New York',
    'NY',
    'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?auto=format&fit=crop&w=1600&h=600&q=80',
    'New York''s legendary nightlife scene now includes a thriving alcohol-free movement. New York City leads the charge with dedicated sober bars, sophisticated mocktail lounges, and innovative venues serving everything from craft NA beers to THC-infused beverages. From Manhattan''s trendy neighborhoods to Brooklyn''s artistic enclaves, the Empire State offers diverse options for those seeking mindful drinking experiences. The city that never sleeps has embraced the sober-curious movement, with venues like Spirited Away and Pocket Bar NYC pioneering the alcohol-free bar concept. Beyond NYC, cities like Buffalo and Rochester are developing their own vibrant scenes, making New York a premier destination for anyone exploring alcohol-free nightlife.',
    'Discover alcohol-free bars in New York City, Brooklyn & beyond. Find mocktail lounges, sober bars & NA venues across NY.',
    true
  ),
  (
    'Indiana',
    'IN',
    'https://images.unsplash.com/photo-1600396022185-1f316bc65fdd?auto=format&fit=crop&w=1600&h=600&q=80',
    'Indiana''s alcohol-free scene is experiencing exciting growth, with Indianapolis emerging as a Midwest hub for mindful drinking. The state combines traditional Midwestern hospitality with innovative approaches to non-alcoholic beverages. Indianapolis leads the way with venues like 8th Day Distillery, which has embraced the movement by offering non-alcoholic canned cocktails and artisanal mocktails. Kava bars are gaining popularity, offering a unique social alternative to traditional bars. From craft NA beer selections at local breweries to dedicated mocktail menus at upscale restaurants, Indiana provides a welcoming environment for those seeking quality alcohol-free options. The growing community reflects a broader cultural shift toward mindful consumption in the heartland.',
    'Find alcohol-free bars & kava lounges in Indiana. Indianapolis leads with mocktail bars, NA venues & sober-friendly spots.',
    true
  ),
  (
    'Nebraska',
    'NE',
    'https://images.unsplash.com/photo-1497450204135-267e19b67e07?auto=format&fit=crop&w=1600&h=600&q=80',
    'Nebraska''s alcohol-free scene is blossoming, with Omaha and Lincoln at the forefront of the state''s mindful drinking movement. The Cornhusker State may surprise visitors with its growing selection of sober-friendly venues, from craft mocktail bars to emerging kava lounges. Omaha''s vibrant Old Market district and Benson neighborhood are home to an increasing number of establishments offering sophisticated non-alcoholic options. Local restaurants and bars are expanding their NA menus to include craft mocktails, zero-proof spirits, and artisanal sodas. The community-focused Midwest culture makes Nebraska''s alcohol-free venues particularly welcoming spaces for connection and socializing without alcohol pressure.',
    'Explore alcohol-free bars in Nebraska. Find mocktail lounges, sober venues & NA options in Omaha, Lincoln & beyond.',
    true
  )
ON CONFLICT (state_name) DO UPDATE SET
  image_url = EXCLUDED.image_url,
  description = EXCLUDED.description,
  meta_description = EXCLUDED.meta_description,
  is_active = EXCLUDED.is_active,
  updated_at = NOW();


