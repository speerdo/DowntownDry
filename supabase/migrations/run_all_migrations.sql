-- ============================================
-- DOWNTOWN DRY: States & Cities Data Migration
-- Run this in Supabase SQL Editor (Dashboard > SQL Editor)
-- ============================================

-- ============================================
-- PART 1: Create states table
-- ============================================

CREATE TABLE IF NOT EXISTS states (
  id SERIAL PRIMARY KEY,
  state_name VARCHAR(50) UNIQUE NOT NULL,
  state_abbr VARCHAR(2) UNIQUE NOT NULL,
  image_url TEXT,
  description TEXT,
  meta_description VARCHAR(160),
  is_active BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_states_state_name ON states(state_name);
CREATE INDEX IF NOT EXISTS idx_states_is_active ON states(is_active);

-- Enable RLS
ALTER TABLE states ENABLE ROW LEVEL SECURITY;

-- Drop policies if they exist (for re-running)
DROP POLICY IF EXISTS "Allow public read access on states" ON states;
DROP POLICY IF EXISTS "Allow authenticated insert on states" ON states;
DROP POLICY IF EXISTS "Allow authenticated update on states" ON states;

-- Create policies
CREATE POLICY "Allow public read access on states" 
  ON states FOR SELECT 
  USING (true);

CREATE POLICY "Allow authenticated insert on states" 
  ON states FOR INSERT 
  TO authenticated 
  WITH CHECK (true);

CREATE POLICY "Allow authenticated update on states" 
  ON states FOR UPDATE 
  TO authenticated 
  USING (true);

-- Create trigger for updated_at
CREATE OR REPLACE FUNCTION update_states_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS states_updated_at_trigger ON states;
CREATE TRIGGER states_updated_at_trigger
  BEFORE UPDATE ON states
  FOR EACH ROW
  EXECUTE FUNCTION update_states_updated_at();

-- ============================================
-- PART 2: Seed states data (soft launch states)
-- ============================================

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

-- ============================================
-- PART 3: Update cities table with images
-- (Only updates cities that exist in the table)
-- ============================================

-- California cities
UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1534190760961-74e8c1c5c3da?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Los Angeles' AND state = 'California';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'San Francisco' AND state = 'California';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1538964173425-93e221c58496?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'San Diego' AND state = 'California';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1515896769750-31548aa180ed?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Oakland' AND state = 'California';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1558522195-e1201b090344?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Sacramento' AND state = 'California';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1515896769750-31548aa180ed?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Alameda' AND state = 'California';

UPDATE cities SET image_url = 'https://plus.unsplash.com/premium_photo-1681578991015-011429d993b1?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Burbank' AND state = 'California';

UPDATE cities SET image_url = 'https://plus.unsplash.com/premium_photo-1675721471984-79e9b6534830?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Costa Mesa' AND state = 'California';

-- New York cities
UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'New York' AND state = 'New York';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1573261658953-8b29e144d1af?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Brooklyn' AND state = 'New York';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1594050304868-c9299fdba722?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Buffalo' AND state = 'New York';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1550869706-60a6508881bb?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Garden City' AND state = 'New York';

-- Indiana cities
UPDATE cities SET image_url = 'https://plus.unsplash.com/premium_photo-1694475047496-75c657518061?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Indianapolis' AND state = 'Indiana';

UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1600396022185-1f316bc65fdd?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Brownsburg' AND state = 'Indiana';

UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/250219_-_Fishers_Event_Center.jpg/800px-250219_-_Fishers_Event_Center.jpg'
WHERE city_name = 'Fishers' AND state = 'Indiana';

-- Nebraska cities
UPDATE cities SET image_url = 'https://images.unsplash.com/photo-1497450204135-267e19b67e07?auto=format&fit=crop&w=800&h=400&q=80'
WHERE city_name = 'Omaha' AND state = 'Nebraska';

-- ============================================
-- DONE! Verify the data was inserted:
-- ============================================

SELECT state_name, state_abbr, is_active, 
       CASE WHEN image_url IS NOT NULL THEN '✓' ELSE '✗' END as has_image,
       CASE WHEN description IS NOT NULL THEN '✓' ELSE '✗' END as has_desc
FROM states
ORDER BY state_name;


