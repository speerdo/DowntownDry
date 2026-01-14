-- Add missing featured city images
-- Generated: 2026-01-13T22:16:42.034Z
-- Total cities updated: 21

-- Arkansas cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Fayetteville', 'Arkansas', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Downtown_Fayetteville_from_Old_Main_001.jpg', 'Fayetteville, Arkansas')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Connecticut cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Farmington', 'Connecticut', 'https://upload.wikimedia.org/wikipedia/commons/1/15/Farmington%2C_Connecticut.png', 'Farmington, Connecticut')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Delaware cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Rehoboth Beach', 'Delaware', 'https://upload.wikimedia.org/wikipedia/commons/6/67/Rehoboth_Beach_boardwalk_looking_north_toward_Rehoboth_Avenue.jpg', 'Rehoboth Beach, Delaware')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Florida cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Jensen Beach', 'Florida', 'https://upload.wikimedia.org/wikipedia/commons/5/52/Jensen_Beach_FL_Welcome_Arch_Jensen03.jpg', 'Jensen Beach, Florida')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Big Pine Key', 'Florida', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Monroe_County_Florida_Incorporated_and_Unincorporated_areas_Big_Pine_Key_Highlighted.svg/1920px-Monroe_County_Florida_Incorporated_and_Unincorporated_areas_Big_Pine_Key_Highlighted.svg.png', 'Big Pine Key, Florida')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Palm Harbor', 'Florida', 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Ozona_Sunset.jpg', 'Palm Harbor, Florida')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Davie', 'Florida', 'https://upload.wikimedia.org/wikipedia/commons/5/50/Town_Hall_%28Davie%2C_Florida%29.jpg', 'Davie, Florida')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Dania Beach', 'Florida', 'https://upload.wikimedia.org/wikipedia/commons/4/48/Dania_Beach_FL_Nyberg-Swanson_House_ChofComm01.jpg', 'Dania Beach, Florida')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Georgia cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Blairsville', 'Georgia', 'https://upload.wikimedia.org/wikipedia/commons/7/70/Union_County_Georgia_Courthouse.jpg', 'Blairsville, Georgia')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Hawaii cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Kapaʻa', 'Hawaii', 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Kapaa_Kauai_Hawaii.jpg', 'Kapaʻa, Hawaii')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Kentucky cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Covington', 'Kentucky', 'https://upload.wikimedia.org/wikipedia/commons/1/1e/Covington%2C_Kentucky.jpg', 'Covington, Kentucky')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

-- Maine cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Kittery', 'Maine', 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Lady_Pepperrell_House_Kittery_Point_Maine.jpg', 'Kittery, Maine')
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

-- West Virginia cities
INSERT INTO cities (city_name, state, image_url, full_name)
VALUES ('Charleston', 'West Virginia', 'https://upload.wikimedia.org/wikipedia/commons/3/35/West_Virginia_statehouse.jpg', 'Charleston, West Virginia')
ON CONFLICT (city_name, state) DO UPDATE SET image_url = EXCLUDED.image_url;

