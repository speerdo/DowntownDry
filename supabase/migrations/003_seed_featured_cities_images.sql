-- Update featured cities with verified images
-- This updates the existing cities table with image_url values

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


