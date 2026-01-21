# Non-Production Venue Verification Guide

**Last Updated:** January 2026  
**Status:** Ready for Testing  
**Pricing Updated:** January 2026 (reflects new Google API pricing)

---

## 💰 Cost Summary (January 2026 Pricing)

| API | Free Tier | Our Usage | Cost |
|-----|-----------|-----------|------|
| **Google Places** | 10,000/month FREE | ~1,250 requests | **$0** ✅ |
| **Google Search** | 100/day FREE | 12,500 queries | $0-62 |
| **Gemini AI** | 250/day FREE | ~1,250 requests | **$0** ✅ |

| Mode | Total Cost | Time to Complete |
|------|------------|------------------|
| **Ultra-Budget** | **$0** | ~125 days |
| **Balanced** | **~$30** | ~10-15 days |
| **Fast** | **~$62** | ~2-5 days |

---

## 📊 Production vs. Non-Production States

### Production States (ALREADY VERIFIED - DO NOT PROCESS)

These states have been manually verified and should **never** be processed by automated scripts:

| State | Verified Venues | Status |
|-------|-----------------|--------|
| California | 138 | ✅ Fully Verified |
| New York | 111 | ✅ Fully Verified |
| Indiana | 24 | ✅ Verified |
| Nebraska | 3 | ✅ Verified |

**Total Production Venues:** 276 (with description AND image_url)

### Non-Production States (NEED VERIFICATION)

All other states have **unverified venues** that need processing:

| Top Non-Production States | Cities | Venues |
|---------------------------|--------|--------|
| Florida | 99 | 291 |
| Texas | 41 | 130 |
| North Carolina | 23 | 120 |
| District of Columbia | 1 | 66 |
| Illinois | 21 | 62 |
| Massachusetts | 21 | 57 |
| Ohio | 11 | 51 |
| Arizona | 12 | 50 |

**Total Non-Production Venues:** ~1,250+ across 500+ cities

---

## 🧪 Testing Workflow

### Step 1: Test Single City First (RECOMMENDED)

Before running full verification, test on a single city for manual accuracy checking.

```bash
# Default: Portland, Maine (9 venues - good test size)
node scripts/test-single-city.js

# Or specify a different city
node scripts/test-single-city.js "Fort Myers" "Florida"
node scripts/test-single-city.js "Chandler" "Arizona"
node scripts/test-single-city.js "Cedar Rapids" "Iowa"
```

**Good Test Cities (5-15 venues, outside production):**

| City | State | Venues |
|------|-------|--------|
| Portland | Maine | 9 |
| Cedar Rapids | Iowa | 9 |
| Jupiter | Florida | 9 |
| Melbourne | Florida | 9 |
| Chandler | Arizona | 10 |
| Fort Myers | Florida | 10 |
| The Woodlands | Texas | 10 |
| Ellicott City | Maryland | 10 |
| Miami | Florida | 11 |
| Fort Lauderdale | Florida | 13 |

### Step 2: Manual Verification Checklist

After running the test script, review the results:

**For each KEEP decision:**
- [ ] Venue is actually open (verify on Google Maps)
- [ ] Description is accurate and engaging
- [ ] Category flags match reality (kava, mocktails, THC, etc.)
- [ ] Contact info is correct

**For each REMOVE decision:**
- [ ] Venue is actually closed, OR
- [ ] Venue truly doesn't meet DowntownDry criteria

**Results file location:**
```
data/test_verification_[city]_[state].json
```

### Step 3: Full Verification Run

Once test accuracy is confirmed, run full verification:

```bash
node scripts/verify-non-production-cities.js
```

**Features:**
- Automatically excludes production states
- Resume mode: skips already-processed cities
- Saves results per-city (can stop/resume anytime)
- Progress tracking

**Output:**
- `data/verification_results/verification_[city]_[state].json` (per city)
- `data/non_production_verification_summary.json` (overall summary)

---

## 🔧 Script Configuration

### test-single-city.js

```javascript
// Default test city (edit to change)
const DEFAULT_TEST_CITY = 'Portland';
const DEFAULT_TEST_STATE = 'Maine';

// Production states (never process these)
const PRODUCTION_STATES = [
  'California',
  'New York', 
  'Indiana',
  'Nebraska'
];
```

### verify-non-production-cities.js

```javascript
// Test mode (set to null for full run)
const TEST_CITY_LIMIT = null;    // e.g., 5 to test with 5 cities
const TEST_VENUE_LIMIT = null;   // e.g., 3 to test 3 venues per city

// Resume mode - skip already-processed cities
const RESUME_MODE = true;

// Cost mode: 'budget' (free), 'balanced' (~$30), 'fast' (~$62)
const COST_MODE = 'balanced';
```

**Cost Mode Details:**
- `budget`: 10 venues/day, all free APIs, ~125 days
- `balanced`: 125 venues/day, ~$30 total, ~10-15 days  
- `fast`: No daily limits, ~$62 total, ~2-5 days

---

## 💰 Cost Estimates (Updated January 2026)

### API Pricing (Current)

| API | Free Tier | Paid Rate |
|-----|-----------|-----------|
| **Google Places (Text Search Essentials)** | 10,000 requests/month | $32/1,000 after |
| **Google Custom Search** | 100 queries/day | $5/1,000 queries |
| **Gemini 2.5 Flash** | 250 requests/day | $1/1M input tokens |

### Single City Test
- Portland, ME (9 venues): **$0** ✅ (under all free tiers)
- Processing time: ~10-15 minutes

### Full Non-Production Run (~1,250 venues)

| Component | Requests Needed | Cost |
|-----------|-----------------|------|
| Google Places | 1,250 | **$0** (under 10K free) |
| Google Search | 12,500 | $0-62 (depends on speed) |
| Gemini AI | 1,250 | **$0** (250/day × 5 days) |

**Total Cost Options:**

| Mode | Strategy | Cost | Time |
|------|----------|------|------|
| **Ultra-Budget** | Use all free tiers | **$0** | 125 days |
| **Balanced** | Pay for some Search | **~$30** | 10-15 days |
| **Fast** | Pay for all Search | **~$62** | 2-5 days |

**Recommendation:** Balanced mode (~$30) offers best value for time.

---

## 📁 Output Files

### Test Results
```
data/test_verification_portland_maine.json
```

### Full Run Results
```
data/verification_results/
├── verification_addison_texas.json
├── verification_aiea_hawaii.json
├── verification_akron_ohio.json
└── ... (one file per city)

data/non_production_verification_summary.json  # Overall summary
```

---

## ⚠️ Important Notes

1. **Never process production states** - They contain manually verified venues
2. **Always test first** - Run on 1 city before full run
3. **Manual verification** - Spot-check results for accuracy
4. **Resume capability** - Script can be stopped/resumed anytime
5. **API costs** - Only Google Places costs money (~$0.017/request)

---

## 📋 Quick Reference Commands

```bash
# Run Phase 1: Extract all unverified venues
node scripts/01_extract_venues.js

# Test single city (default: Portland, ME)
node scripts/test-single-city.js

# Test specific city
node scripts/test-single-city.js "Miami" "Florida"

# Full non-production verification
node scripts/verify-non-production-cities.js

# View test results
cat data/test_verification_portland_maine.json | jq '.decisions'

# View full run summary
cat data/non_production_verification_summary.json | jq '.overall_decisions'
```

---

## 🎯 Success Criteria

- [ ] Single city test shows >90% accuracy
- [ ] Descriptions are engaging and specific
- [ ] Category flags are correctly validated
- [ ] Closed venues detected and marked REMOVE
- [ ] No production state venues processed

---

**Ready to test!** Start with:
```bash
node scripts/test-single-city.js
```
