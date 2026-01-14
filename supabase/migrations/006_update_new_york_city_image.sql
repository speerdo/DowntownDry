-- Update New York City featured image
-- This updates the image_url for New York, NY to use the Wikipedia Commons image

UPDATE cities 
SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg/2560px-View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg'
WHERE city_name = 'New York' AND state = 'New York';
