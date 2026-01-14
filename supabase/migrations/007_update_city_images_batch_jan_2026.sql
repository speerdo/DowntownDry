-- Update city images based on IMAGE_UPDATES.md
-- Date: January 14, 2026
-- This migration updates image URLs for multiple cities across various states

-- Delaware
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Wilmington%2C_Delaware%2C_USA.jpg/2560px-Wilmington%2C_Delaware%2C_USA.jpg', has_image = true WHERE city_name = 'Wilmington' AND state = 'Delaware';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Newark_DE_Main_Street.jpg', has_image = true WHERE city_name = 'Newark' AND state = 'Delaware';

-- Georgia
UPDATE cities SET image_url = 'http://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Athens_Georgia_City_Hall_1.jpg/2560px-Athens_Georgia_City_Hall_1.jpg', has_image = true WHERE city_name = 'Athens' AND state = 'Georgia';

-- Idaho
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/10/0725wwp01aerial.jpg', has_image = true WHERE city_name = 'Garden City' AND state = 'Idaho';

-- Illinois
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Evergreen_Avenue%2C_Arlington_Heights.jpg/2560px-Evergreen_Avenue%2C_Arlington_Heights.jpg', has_image = true WHERE city_name = 'Arlington Heights' AND state = 'Illinois';

-- Iowa
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Morning_Skyline_-_Des_Moines%2C_Iowa_-_Winter_on_the_Des_Moines_River_%2824805016620%29_%28cropped2%29.jpg/2560px-Morning_Skyline_-_Des_Moines%2C_Iowa_-_Winter_on_the_Des_Moines_River_%2824805016620%29_%28cropped2%29.jpg', has_image = true WHERE city_name = 'Des Moines' AND state = 'Iowa';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Cedar_Rapids_Skyline_%282022%29.jpg/2560px-Cedar_Rapids_Skyline_%282022%29.jpg', has_image = true WHERE city_name = 'Cedar Rapids' AND state = 'Iowa';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c9/Iowa_City_Downtown_June_2021_%28cropped%29.jpg', has_image = true WHERE city_name = 'Iowa City' AND state = 'Iowa';

-- Kansas
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Lawrence%2C_KS_August_2025.jpg/2560px-Lawrence%2C_KS_August_2025.jpg', has_image = true WHERE city_name = 'Lawrence' AND state = 'Kansas';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Olathe_City_Hall.jpg/2560px-Olathe_City_Hall.jpg', has_image = true WHERE city_name = 'Olathe' AND state = 'Kansas';

-- Maryland
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Bethesda_Montage.jpg/1280px-Bethesda_Montage.jpg', has_image = true WHERE city_name = 'Bethesda' AND state = 'Maryland';

-- Massachusetts
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Coolidge_Corner_South_Side%2C_Brookline%2C_MA%2C_USA_-_panoramio.jpg/2560px-Coolidge_Corner_South_Side%2C_Brookline%2C_MA%2C_USA_-_panoramio.jpg', has_image = true WHERE city_name = 'Brookline' AND state = 'Massachusetts';

-- Michigan
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/9/91/Ann_Arbor_Skyline_2021.jpg', has_image = true WHERE city_name = 'Ann Arbor' AND state = 'Michigan';

-- Minnesota
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Chaska%2C_Minnesota_5.jpg/2560px-Chaska%2C_Minnesota_5.jpg', has_image = true WHERE city_name = 'Chaska' AND state = 'Minnesota';

-- Mississippi
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1c/BiloxiLightHouseandVisitorsCenter.jpg', has_image = true WHERE city_name = 'Biloxi' AND state = 'Mississippi';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/23/Oxford%2C_MS_collage.png', has_image = true WHERE city_name = 'Oxford' AND state = 'Mississippi';

-- Montana
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f2/Riverfront-park-laurel-mt-10052010-rogermpeterson.jpg', has_image = true WHERE city_name = 'Laurel' AND state = 'Montana';

-- Nevada
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/8/86/Skyline_of_Carson_City%2C_NV.jpg', has_image = true WHERE city_name = 'Carson City' AND state = 'Nevada';

-- North Dakota
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Downtown_Fargo_Aerial_-_Facing_Southeast_%2851009704407%29.jpg', has_image = true WHERE city_name = 'Fargo' AND state = 'North Dakota';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/FEMA_-_29438_-_Photograph_by_Brenda_Riskey_taken_on_05-17-2006_in_North_Dakota.jpg/2560px-FEMA_-_29438_-_Photograph_by_Brenda_Riskey_taken_on_05-17-2006_in_North_Dakota.jpg', has_image = true WHERE city_name = 'Grand Forks' AND state = 'North Dakota';

-- South Dakota
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/Rapid_City_Skyline_%282022%29.jpg', has_image = true WHERE city_name = 'Rapid City' AND state = 'South Dakota';

-- Utah
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Welcome_to_Mapleton_sign.JPG/2560px-Welcome_to_Mapleton_sign.JPG', has_image = true WHERE city_name = 'Mapleton' AND state = 'Utah';

-- Virginia
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Front_View_of_George_Washington_Masonic_National_Memorial.jpg/960px-Front_View_of_George_Washington_Masonic_National_Memorial.jpg', has_image = true WHERE city_name = 'Alexandria' AND state = 'Virginia';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Old_Town_Hall_%28Fairfax%2C_Virginia%29_%2853890424273%29.jpg/2560px-Old_Town_Hall_%28Fairfax%2C_Virginia%29_%2853890424273%29.jpg', has_image = true WHERE city_name = 'Fairfax' AND state = 'Virginia';

-- Washington
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/3/30/Seattle_Downtown_Aerial%2C_July_2025_%28zoomed%29.jpg', has_image = true WHERE city_name = 'Seattle' AND state = 'Washington';

-- West Virginia
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Charleston%2C_West_Virginia_%282023%29.jpg/2560px-Charleston%2C_West_Virginia_%282023%29.jpg', has_image = true WHERE city_name = 'Charleston' AND state = 'West Virginia';

-- Wyoming
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/53/CheyenneWyoming_%28cropped%29.jpg', has_image = true WHERE city_name = 'Cheyenne' AND state = 'Wyoming';
UPDATE cities SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4b/Casperskyline1to1.jpg', has_image = true WHERE city_name = 'Casper' AND state = 'Wyoming';
