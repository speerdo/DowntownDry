# Phase 2 Test Guide

## What Phase 2 Does

**Address-First Verification + AI Analysis**

For each venue:
1. 🔍 **Google Places API** - Find exact venue by address, check if closed
2. 🔎 **10 Google Searches** - Get current info (reviews, menus, hours)
3. 🤖 **Gemini AI** - Analyze all results and make decision
4. ✍️ **Generate Description** - Create compelling 2-3 sentence description
5. 📊 **Classify** - Set boolean flags (kava, mocktails, THC, CBD, etc.)

**Output:** Decision per venue (KEEP, REMOVE, or UNCERTAIN)

---

## Test Mode Settings

**Current configuration (in script):**
```javascript
const TEST_CITY_LIMIT = 1;      // Process 1 city
const TEST_VENUE_LIMIT = 3;     // Process 3 venues per city
```

This will process **3 venues total** from the first city.

**Cost for test run:**
- Google Places: 3 requests × $0.017 = **$0.05**
- Google Search: 30 queries (3 venues × 10) = **FREE** (under 100/day)
- Gemini: 3 calls = **FREE**
- **Total: ~$0.05**

**Time estimate:** 5-10 minutes (with rate limiting)

---

## Run Test

```bash
node scripts/02_primary_verification.js
```

---

## Expected Output

```
🚀 Starting Phase 2: Primary Verification
======================================================================
⚠️  TEST MODE:
   - Limited to 1 cities
   - Limited to 3 venues per city
======================================================================

🏙️  City 1/1: Charlotte, North Carolina
   72 venues to process (3 in test mode)

   [1/3]
   📍 Venue Name
      🔍 Places API: "Venue Name, 123 Main St, Charlotte, NC"
      🔎 Running 10 Google searches...
      🤖 Gemini analyzing...
      ✅ Decision: KEEP (High confidence)

   [2/3]
   ...

💾 Saved: primary_verification_charlotte_north_carolina.json

✅ PHASE 2 COMPLETE
Decisions:
  KEEP:      2
  REMOVE:    1
  UNCERTAIN: 0
```

---

## Review Results

```bash
# View summary
cat data/primary_summary.json

# View city results (first city will be something like Albuquerque)
cat data/primary_verification_*.json | jq '.results[0]'
```

---

## What to Check

1. **Decisions make sense?**
   - Are closed venues marked REMOVE?
   - Are legit NA venues marked KEEP?

2. **Descriptions quality?**
   - 40-80 words?
   - Mentions specific NA offerings?
   - Engaging and not robotic?

3. **Boolean flags correct?**
   - Is_alcohol_free, serves_kava, serves_mocktails, etc.

4. **Any errors?**
   - API failures?
   - Rate limiting issues?

---

## After Test: Full Run

If test looks good, edit the script:

```javascript
const TEST_CITY_LIMIT = null;    // All cities
const TEST_VENUE_LIMIT = null;   // All venues
```

**Full run:**
- 1,526 venues
- ~$26 (Google Places)
- ~$115 (Google Search in fast mode) or $0 (budget mode)
- 2-3 days (fast) or 25-30 days (budget)

---

## Troubleshooting

**"API key not found"**
- Check `.env` has all required keys (see ADDITIONAL_ENV_NEEDED.md)

**"Rate limit exceeded"**
- Normal! Script has built-in delays
- Adjust DELAY values in script if needed

**"Could not parse JSON"**
- Gemini response format issue
- Check `data/primary_verification_*.json` for raw response

**"Places API requires billing"**
- Enable billing in Google Cloud Console
- You'll only be charged $0.05 for the test

---

Ready to test! 🚀

