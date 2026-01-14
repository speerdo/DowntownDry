-- Fix cities table unique constraint
-- Issue: idx_cities_city_name is unique on city_name alone, preventing same city names in different states
-- Fix: Drop the old unique index and create a composite unique constraint on (city_name, state)

-- Drop the problematic unique index
DROP INDEX IF EXISTS idx_cities_city_name;

-- Create a proper unique constraint on (city_name, state)
-- This allows cities with the same name in different states (e.g., Wilmington, DE and Wilmington, NC)
CREATE UNIQUE INDEX idx_cities_city_state_unique ON cities(city_name, state);

-- Create a regular non-unique index on city_name for search performance
CREATE INDEX idx_cities_city_name_search ON cities(city_name);
