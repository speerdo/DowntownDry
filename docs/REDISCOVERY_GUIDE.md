# Re-Discovery Guide for Failed Cities

**Purpose:** Re-run discovery for 233 cities (#262-502) that got 0 results due to API quota exhaustion  
**Date Created:** January 14, 2026  
**Status:** Ready to Run

---

## Quick Start

### Option 1: Test First (Recommended)
```bash
# Test with 3 cities to verify everything works
node scripts/rediscover-failed-cities.js --test --limit=3
```

### Option 2: Specific Cities
```bash
# Just Seattle, Miami, and Nashville
node scripts/rediscover-failed-cities.js --cities=Seattle,Miami,Nashville
```

### Option 3: Full Run
```bash
# Process all 233 failed cities
node scripts/rediscover-failed-cities.js --start=262 --end=502
```

---

## Two-Phase Approach

### Phase 1: Discovery & Verification
**Script:** `rediscover-failed-cities.js`  
**Purpose:** Find new venues and verify they qualify  
**Output:** Basic venue data without images  
**Cost:** ~$32-33 for all 233 cities

**What it does:**
- Runs 9 Google Search queries per city
- Extracts potential venues with AI
- Verifies each venue qualifies
- Gets basic data: name, address, phone, website, description
- **Does NOT** get images yet (saves cost)

### Phase 2: Enrichment
**Script:** `enrich-rediscovered-venues.js`  
**Purpose:** Get images and complete data for **approved venues only**  
**Output:** Full venue data ready for database  
**Cost:** ~$0.02-0.03 per venue

**What it does:**
- Gets up to 5 photos per venue
- Fetches complete Place Details
- Validates phone/website
- Generates review HTML for manual approval

---

## Cost Breakdown

### Phase 1: Discovery (All 233 Cities)

**Based on Actual Previous Run:**
- Previous cost: **$5.69 for ~40 cities**
- Cost per city: **$0.14**
- **Estimated total: 233 cities × $0.14 = ~$32-33**

**API Breakdown:**
- Google Custom Search: $5/1,000 queries (after 100 free/day)
  - 233 cities × 9 queries = 2,097 queries
  - Cost: (~2,000 / 1,000) × $5 = **~$10**
- Google Places (Text Search): FREE under 10,000/month
  - Estimated: 500-700 calls = **$0**
- Gemini AI: FREE (within rate limits)
  - Estimated: 2,000-3,000 calls = **$0**
- Additional verification searches: **~$22**

**Total Phase 1: ~$32-33**

### Phase 2: Enrichment (Per Venue)

**Estimated venues found:** 100-200 new venues  
**Cost per venue:** $0.024-0.031

**Per Venue:**
- Place Details API: $0.017 per call
- Place Photos API: $0.007 per photo × 2-3 photos avg
- **Total per venue: ~$0.024-0.031**

**Estimated Phase 2 Total:**
- If 100 venues: 100 × $0.027 = **~$2.70**
- If 150 venues: 150 × $0.027 = **~$4.05**
- If 200 venues: 200 × $0.027 = **~$5.40**

### Grand Total Estimate

**Conservative:** $32 + $2.70 = **~$34.70**  
**Realistic:** $32 + $4.05 = **~$36.05**  
**High end:** $33 + $5.40 = **~$38.40**

**You were right** - this is significantly more expensive than my initial $10 estimate!

---

## Step-by-Step Guide

### Step 1: Test the Script (5 minutes)

```bash
# Test with 3 cities
node scripts/rediscover-failed-cities.js --test --limit=3
```

**Expected output:**
- Processes 3 cities
- Shows search results count
- Finds and verifies venues
- Cost: ~$0.42 (3 × $0.14)

**What to check:**
- ✅ No errors
- ✅ Search results > 0 for cities
- ✅ Venues are being found and verified
- ✅ Files saved to `data/rediscovery_results/`

### Step 2: Run Full Discovery (8-12 hours)

```bash
# Process all 233 cities
node scripts/rediscover-failed-cities.js --start=262 --end=502
```

**What happens:**
- Processes cities sequentially
- Shows progress every 10 cities
- Pauses every 50 cities (5 seconds)
- Saves results per city
- **May pause if daily quota reached** (95 queries/day limit)

**If paused due to quota:**
```bash
# Script will tell you what command to run next day, example:
node scripts/rediscover-failed-cities.js --start=285
```

**Timeline:**
- If quota NOT hit: 8-12 hours for all 233 cities
- If quota hit: Spread over 2-3 days (95 queries/day = ~10 cities/day)

**Monitoring:**
```bash
# Check progress
ls -lh data/rediscovery_results/ | wc -l

# Check summary
cat data/rediscovery_summary.json
```

### Step 3: Review Discovered Venues (30-60 minutes)

```bash
# Check what was found
cat data/rediscovery_summary.json

# Look at specific city results
cat data/rediscovery_results/rediscovery_seattle_washington.json
```

**Review criteria:**
- ✅ Venues look legitimate
- ✅ Descriptions are accurate
- ✅ Boolean flags are correct
- ❌ Mark any false positives

**Create approval list:**
```json
// Create data/approved_venues.json
{
  "approved": [
    "venue_name_1",
    "venue_name_2"
  ],
  "rejected": [
    "venue_name_3"
  ]
}
```

### Step 4: Enrich Approved Venues (30-60 minutes)

```bash
# Preview what will be enriched
node scripts/enrich-rediscovered-venues.js --dry-run

# Enrich all venues (auto-select first photo)
node scripts/enrich-rediscovered-venues.js --apply --auto

# Or enrich specific city
node scripts/enrich-rediscovered-venues.js --apply --auto --city=Seattle
```

**Cost:** ~$0.027 per venue

**What it does:**
- Fetches Place Details for each venue
- Gets up to 5 photos per venue
- Auto-selects first photo as primary (--auto flag)
- Saves enriched data to `data/enriched_rediscovered/`
- Generates review HTML

### Step 5: Review Enriched Data (15-30 minutes)

```bash
# Generate review HTML
node scripts/enrich-rediscovered-venues.js --review

# Open in browser
open data/enrichment_review/enriched_venues_review.html
```

**Review:**
- ✅ Photos look appropriate
- ✅ Phone/website are correct
- ✅ All required fields populated
- 🔄 Change primary image if needed

### Step 6: Upload to Database

```bash
# Coming soon: upload script
node scripts/upload-rediscovered-venues.js --dry-run
node scripts/upload-rediscovered-venues.js --apply
```

---

## Script Features

### Built-in Safety Features

#### 1. Daily Quota Management
- Tracks search queries per day
- Stops at 95 queries/day (stays under 100 limit)
- Resists daily at midnight
- Tells you how to resume

#### 2. Budget Limit
- Hard stop at $40 (configurable)
- Tracks cost in real-time
- Updates estimate every 10 cities

#### 3. Resume Capability
- Skips already-processed cities
- Can stop/start anytime
- Preserves all progress

#### 4. Error Handling
- Detects API quota errors (429)
- Handles network timeouts
- Continues on individual venue errors
- Logs all errors for review

### Command Line Options

#### `rediscover-failed-cities.js`

```bash
# Test mode (3 cities)
--test --limit=3

# Specific range
--start=262 --end=300

# Specific cities
--cities=Seattle,Miami,Nashville

# With limit
--start=262 --limit=20
```

#### `enrich-rediscovered-venues.js`

```bash
# Review HTML only (no API calls)
--review

# Preview (no API calls)
--dry-run

# Apply enrichment
--apply

# Auto-select first photo
--auto

# Filter to city
--city=Seattle

# Combined
--apply --auto --city=Seattle
```

---

## Output Files

### Phase 1: Discovery

**Per-city files:**
```
data/rediscovery_results/
  rediscovery_seattle_washington.json
  rediscovery_miami_florida.json
  ...
```

**Summary file:**
```
data/rediscovery_summary.json
{
  "run_info": { ... },
  "stats": {
    "cities_processed": 233,
    "total_new_venues_found": 156
  },
  "cost_tracking": {
    "estimatedCost": "$32.15"
  }
}
```

### Phase 2: Enrichment

**Per-city files:**
```
data/enriched_rediscovered/
  enriched_seattle_washington.json
  enriched_miami_florida.json
  all_enriched_venues.json
```

**Review HTML:**
```
data/enrichment_review/
  enriched_venues_review.html
```

---

## Troubleshooting

### "Daily Quota Reached"

**Cause:** Hit 95-100 search queries for the day  
**Solution:** Wait until tomorrow, then run the resume command shown

```bash
# Script will show:
node scripts/rediscover-failed-cities.js --start=285
```

### "Budget Limit Reached"

**Cause:** Hit $40 safety limit  
**Solution:** Edit script to increase `MAX_BUDGET_DOLLARS` or review progress

```bash
# Check progress
cat data/rediscovery_summary.json

# Adjust budget in script
# Line 56: const MAX_BUDGET_DOLLARS = 40;
```

### "No Search Results"

**Possible causes:**
1. API key invalid/expired
2. Daily quota exhausted
3. City genuinely has no venues

**Check:**
```bash
# Verify API key works
curl "https://www.googleapis.com/customsearch/v1?key=YOUR_KEY&cx=YOUR_CX&q=test"
```

### "Place Not Found"

**Cause:** Venue name extracted incorrectly or venue doesn't exist  
**Solution:** Normal - script will skip and move to next venue

---

## Priority Cities to Process First

Based on size and likely venue count:

**Top 20 Priority:**
1. Seattle, WA (your concern!)
2. Miami, FL
3. Nashville, TN
4. New Orleans, LA
5. Portland, OR
6. Minneapolis, MN
7. Milwaukee, WI
8. Orlando, FL
9. Tampa, FL
10. Salt Lake City, UT
11. Phoenix, AZ
12. San Diego, CA
13. San Francisco, CA
14. San Jose, CA
15. San Antonio, TX
16. Philadelphia, PA
17. Pittsburgh, PA
18. Richmond, VA
19. Sacramento, CA
20. Tucson, AZ

**Run these first:**
```bash
node scripts/rediscover-failed-cities.js --cities="Seattle,Miami,Nashville,New Orleans,Portland,Minneapolis"
```

---

## Timeline Estimates

### Scenario 1: No Daily Quota Issues
- **Phase 1:** 8-12 hours (all 233 cities)
- **Phase 2:** 1-2 hours (100-200 venues)
- **Total:** 1-2 days

### Scenario 2: Hit Daily Quota
- **Phase 1:** 2-3 days (10-15 cities/day)
- **Phase 2:** 1-2 hours
- **Total:** 3-4 days

### Scenario 3: Priority Cities Only
- **Phase 1:** 2-3 hours (top 20 cities)
- **Phase 2:** 30-45 minutes (40-60 venues)
- **Total:** 4-5 hours

---

## Next Steps

1. **Run test** (3 cities) - verify everything works
2. **Decide approach:**
   - Option A: Full run (all 233 cities, ~$32-36 total)
   - Option B: Priority cities first (top 20, ~$3-5)
   - Option C: Spread over 3 days to stay in free tier (no extra cost)
3. **Run Phase 1** (discovery)
4. **Review results** (30-60 min)
5. **Run Phase 2** (enrichment for approved venues)
6. **Upload to database**

---

## Questions?

**Script not working?**
- Check `.env` has all required API keys
- Verify API keys are valid
- Check quota on Google Cloud Console

**Cost concerns?**
- Start with test mode (3 cities = $0.42)
- Try priority cities first (20 cities = $2.80)
- Can stop anytime and resume later

**Need help?**
- Check log files in `logs/`
- Review error messages
- Check `rediscovery_summary.json` for stats

---

**Created:** January 14, 2026  
**Last Updated:** January 14, 2026  
**Cost Estimate:** $32-36 for complete re-discovery  
**Timeline:** 1-4 days depending on approach
