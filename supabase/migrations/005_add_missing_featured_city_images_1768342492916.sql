-- Add missing featured city images
-- Generated: 2026-01-13T22:14:52.916Z
-- Total cities updated: 10

-- Arkansas cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Fayetteville', 'Arkansas', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Downtown_Fayetteville_from_Old_Main_001.jpg', 'Fayetteville, Arkansas')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Delaware cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Rehoboth Beach', 'Delaware', 'https://upload.wikimedia.org/wikipedia/commons/6/67/Rehoboth_Beach_boardwalk_looking_north_toward_Rehoboth_Avenue.jpg', 'Rehoboth Beach, Delaware')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Michigan cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Birmingham', 'Michigan', 'https://upload.wikimedia.org/wikipedia/commons/7/7d/Downtown_Birmingham_MI_2025.jpg', 'Birmingham, Michigan')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Mississippi cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Jackson', 'Mississippi', 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Mississippi_State_Capitol_Building_%2826815684617%29.jpg', 'Jackson, Mississippi')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Missouri cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Columbia', 'Missouri', 'https://upload.wikimedia.org/wikipedia/commons/4/44/Mizzou_Jesse_Thumb.jpg', 'Columbia, Missouri')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- North Carolina cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Hendersonville', 'North Carolina', 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Hendersonville%2C_North_Carolina%2C_USA.jpg', 'Hendersonville, North Carolina')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Ohio cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Lakewood', 'Ohio', 'https://upload.wikimedia.org/wikipedia/commons/7/78/OH_Cuyahoga_Lakewood_Downtown_Historic_District_016.jpg', 'Lakewood, Ohio')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- South Carolina cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Greenville', 'South Carolina', 'https://upload.wikimedia.org/wikipedia/commons/9/93/2024-4-12-Falls_Park_Waterfall_Greenville_South_Carolina_by_Yousef_AbdulHusain.jpg', 'Greenville, South Carolina')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- South Dakota cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Sioux Falls', 'South Dakota', 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Downtown_and_Falls_Park_03-16-24.jpg', 'Sioux Falls, South Dakota')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Virginia cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Arlington', 'Virginia', 'https://upload.wikimedia.org/wikipedia/commons/5/59/Rosslyn_Skyline_from_Theodore_Roosevelt_Bridge.png', 'Arlington, Virginia')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

