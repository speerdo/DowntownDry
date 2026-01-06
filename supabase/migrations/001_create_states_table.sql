-- Create states table for state-level metadata (images, descriptions, SEO)
-- This mirrors the existing cities table pattern

CREATE TABLE IF NOT EXISTS states (
  id SERIAL PRIMARY KEY,
  state_name VARCHAR(50) UNIQUE NOT NULL,
  state_abbr VARCHAR(2) UNIQUE NOT NULL,
  image_url TEXT,
  description TEXT,
  meta_description VARCHAR(160),
  is_active BOOLEAN DEFAULT false,  -- For soft launch control
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for common queries
CREATE INDEX idx_states_state_name ON states(state_name);
CREATE INDEX idx_states_is_active ON states(is_active);

-- Add RLS policies (matching venues table pattern)
ALTER TABLE states ENABLE ROW LEVEL SECURITY;

-- Allow public read access
CREATE POLICY "Allow public read access on states" 
  ON states FOR SELECT 
  USING (true);

-- Allow authenticated users to insert/update (for admin)
CREATE POLICY "Allow authenticated insert on states" 
  ON states FOR INSERT 
  TO authenticated 
  WITH CHECK (true);

CREATE POLICY "Allow authenticated update on states" 
  ON states FOR UPDATE 
  TO authenticated 
  USING (true);

-- Create trigger to auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_states_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER states_updated_at_trigger
  BEFORE UPDATE ON states
  FOR EACH ROW
  EXECUTE FUNCTION update_states_updated_at();

-- Add comment for documentation
COMMENT ON TABLE states IS 'State-level metadata including images, descriptions, and soft launch control';
COMMENT ON COLUMN states.is_active IS 'Controls whether state appears in soft launch (true = visible)';


