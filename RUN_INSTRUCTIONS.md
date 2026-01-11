# Production Run Instructions

**Date:** January 2026  
**Total Budget:** $100 maximum  
**Estimated Cost:** ~$95 (Phase 2A: $60 + Phase 2B: $35)

---

## 🖥️ Running on Fedora Desktop

### Prevent Sleep & Run in Background

Use the helper script to run with sleep prevention:

```bash
# Make executable (first time only)
chmod +x scripts/run-with-no-sleep.sh

# Run a quick test first (3 cities)
./scripts/run-with-no-sleep.sh test

# Check if running
./scripts/run-with-no-sleep.sh status

# Attach to see progress
./scripts/run-with-no-sleep.sh attach

# Detach: Press Ctrl+B, then D
```

### Full Production Run

```bash
# Phase 2A: Verification
./scripts/run-with-no-sleep.sh verify

# Phase 2B: Discovery (after 2A completes)
./scripts/run-with-no-sleep.sh discover
```

### Manual Alternative (tmux)

```bash
# Start tmux with sleep prevention
tmux new-session -d -s downtown-dry 'systemd-inhibit --what=sleep:idle --mode=block --who="DowntownDry" --why="Running verification" node scripts/verify-non-production-cities.js'

# Attach to monitor
tmux attach -t downtown-dry
```

---

## 🧪 Test Run First (Recommended)

Before the full run, test with 3 cities:

```bash
# Option 1: Use helper script
./scripts/run-with-no-sleep.sh test

# Option 2: Direct command
TEST_MODE=true node scripts/verify-non-production-cities.js
```

This will:
- Process only 3 cities
- Cost ~$1-2
- Complete in ~10-15 minutes
- Verify everything works

---

## 🚀 Quick Start

### Phase 2A: Verification (Run First)

```bash
# Verify all non-production venues (~1,250 venues)
node scripts/verify-non-production-cities.js
```

**What it does:**
- Processes ~500 cities (excludes CA, NY, IN, NE)
- Verifies ~1,250 existing venues
- Detects closures, fixes category flags
- Generates descriptions for KEEP venues

**Expected Results:**
- ~400-500 venues KEEP (with descriptions)
- ~700-800 venues REMOVE (closed or don't qualify)
- ~50-100 venues UNCERTAIN

**Cost:** ~$60 | **Time:** ~5 days (Gemini rate limited)

---

### Phase 2B: Discovery (Run After 2A)

```bash
# Discover missing venues in ALL cities
node scripts/discover-all-cities.js
```

**What it does:**
- Searches all 588 cities (including production states)
- Finds venues we're missing
- Verifies new candidates meet criteria

**Expected Results:**
- ~100-200 new venues discovered
- Focus on kava bars, mocktail bars, THC lounges

**Cost:** ~$35 | **Time:** ~3-5 days

---

## 📊 Cost Breakdown

### Phase 2A: Verification

| API | Calls | Free Tier | Paid | Cost |
|-----|-------|-----------|------|------|
| Google Places | 1,250 | 10,000/mo | 0 | $0 |
| Google Search | 12,500 | 500 (5 days) | 12,000 | $60 |
| Gemini | 1,250 | 1,250 (5 days) | 0 | $0 |
| **TOTAL** | | | | **~$60** |

### Phase 2B: Discovery

| API | Calls | Free Tier | Paid | Cost |
|-----|-------|-----------|------|------|
| Google Places | ~1,500 | 8,750 remaining | 0 | $0 |
| Google Search | ~7,000 | 300 (3 days) | 6,700 | $33.50 |
| Gemini | ~2,000 | 750 (3 days) | 0* | $0 |
| **TOTAL** | | | | **~$35** |

*Gemini may take longer due to 250/day limit

### Combined Total: ~$95 ✅ Under $100

---

## ⚙️ Configuration Options

### verify-non-production-cities.js

```javascript
const TEST_MODE = false;        // Set true for testing
const RESUME_MODE = true;       // Skip processed cities
const MAX_BUDGET_DOLLARS = 100; // Stop at this cost
const COST_MODE = 'balanced';   // 'budget', 'balanced', 'fast'
```

### discover-all-cities.js

```javascript
const TEST_MODE = false;        // Set true for testing
const RESUME_MODE = true;       // Skip processed cities  
const MAX_BUDGET_DOLLARS = 40;  // Budget for discovery phase
```

---

## 📁 Output Files

### Phase 2A: Verification

```
data/
├── verification_results/
│   ├── verification_addison_texas.json
│   ├── verification_portland_maine.json
│   └── ... (one per city)
└── non_production_verification_summary.json
```

### Phase 2B: Discovery

```
data/
├── discovery_results/
│   ├── discovery_addison_texas.json
│   ├── discovery_portland_maine.json
│   └── ... (one per city)
└── discovery_summary.json
```

---

## 🔄 Resume After Interruption

Both scripts support **RESUME_MODE**. If interrupted:

1. Results are saved per-city
2. Re-run the same command
3. Processed cities are skipped automatically
4. Cost tracking continues from saved state

---

## 📋 Monitoring Progress

### During Run

```bash
# Watch the terminal for:
# - Progress updates every 10 cities
# - Cost tracking
# - Budget warnings
```

### After Run

```bash
# Check verification results
cat data/non_production_verification_summary.json | jq '.overall_decisions'

# Check discovery results  
cat data/discovery_summary.json | jq '.stats'

# View cost
cat data/non_production_verification_summary.json | jq '.cost_tracking'
```

---

## ⚠️ Safety Features

1. **Budget Limit** - Stops automatically at $100
2. **Resume Mode** - Can restart without re-processing
3. **Per-City Saves** - Progress saved after each city
4. **THC Legality** - Only flags THC in legal states
5. **Rate Limiting** - Respects API limits automatically

---

## 🎯 Expected Outcomes

| Metric | Phase 2A | Phase 2B | Total |
|--------|----------|----------|-------|
| Venues Processed | ~1,250 | - | ~1,250 |
| Venues KEEP | ~400-500 | - | ~400-500 |
| Venues REMOVE | ~700-800 | - | ~700-800 |
| NEW Venues Found | - | ~100-200 | ~100-200 |
| **Final Database** | | | **~600-700 quality venues** |

---

## 📞 Commands Reference

```bash
# Test single city
npm run test:city

# Phase 2A: Full verification
npm run verify:nonprod

# Phase 2B: Full discovery  
npm run discover:all

# Discovery on single city
npm run discover:city "Portland" "Maine"
```

---

## ✅ Pre-Flight Checklist

Before running production:

- [ ] `.env` has all API keys (GEMINI_API_KEY, GOOGLE_SEARCH_API_KEY, etc.)
- [ ] `data/processing_queue.json` exists (run `npm run extract` if not)
- [ ] Budget limit set appropriately ($100 default)
- [ ] TEST_MODE = false in scripts
- [ ] Terminal can run for 5+ days (use tmux/screen)

---

---

## 🗄️ Phase 3: Apply Results to Database

After verification and discovery complete, apply the results:

### Preview Changes (Dry Run)

```bash
node scripts/apply-verification-results.js --dry-run
# or
npm run apply:dry-run
```

This shows what WOULD happen without making changes.

### Apply Changes (Live)

```bash
node scripts/apply-verification-results.js --apply
# or
npm run apply:live
```

**Safety Features:**
- Requires typing "APPLY" to confirm
- Creates backup of affected venues
- Detailed logging of all changes
- Soft-delete (doesn't permanently remove)

### What It Does

| Action | Description |
|--------|-------------|
| **UPDATE** | KEEP venues get descriptions, fixed flags |
| **REMOVE** | REMOVE venues get `data_complete = false` |
| **ADD** | New discovered venues inserted |

---

## Phase 4: Data Enrichment

After the CRUD operations, enrich venues with missing phone, website, and image_url.

### Enrichment Script Options

```bash
# Preview what would be enriched
npm run enrich:dry-run

# Auto mode - fills phone, website, uses first Google photo
npm run enrich:auto

# Review mode - generates HTML for manual image selection
npm run enrich:review
```

### Additional Flags

```bash
# Process only specific state
node scripts/enrich-venue-data.js --auto --state=Texas

# Limit to N venues (for testing)
node scripts/enrich-venue-data.js --dry-run --limit=10

# Only venues missing images
node scripts/enrich-venue-data.js --review --missing-images

# Only venues missing phone/website
node scripts/enrich-venue-data.js --auto --missing-contact
```

### Image Review Workflow

1. Run review mode: `npm run enrich:review`
2. Open: `data/image_review/index.html` in browser
3. Click each venue, select best photo
4. Click "Export All Selections" for SQL file
5. Run SQL in Supabase to apply image selections

### Cost Estimates

| API Call | Cost | Notes |
|----------|------|-------|
| Place Details | $0.003/call | Phone, website, photos |
| Place Photo | $0.007/call | Only counted when URL generated |
| **Per Venue** | ~$0.01 | Average with 1 photo |

For 400 new venues: **~$4-6**

---

## 📞 Complete Command Reference

```bash
# Testing
npm run test:city                    # Test single city
./scripts/run-with-no-sleep.sh test  # Test 3 cities with sleep prevention

# Phase 2A: Verification
npm run verify:nonprod               # Direct run
./scripts/run-with-no-sleep.sh verify # With sleep prevention

# Phase 2B: Discovery
npm run discover:all                 # Direct run
./scripts/run-with-no-sleep.sh discover # With sleep prevention

# Phase 3: Database Updates
npm run apply:dry-run                # Preview changes
npm run apply:live                   # Apply changes

# Phase 4: Data Enrichment
npm run enrich:dry-run               # Preview enrichment
npm run enrich:auto                  # Auto-enrich (first photo)
npm run enrich:review                # Generate image review HTML

# Monitoring
./scripts/run-with-no-sleep.sh status  # Check if running
./scripts/run-with-no-sleep.sh attach  # View progress
./scripts/run-with-no-sleep.sh stop    # Stop running script
```

---

## 🚀 Complete Workflow

```bash
# 1. Test (optional)
./scripts/run-with-no-sleep.sh test

# 2. Phase 2A: Verification
./scripts/run-with-no-sleep.sh verify

# 3. Phase 2B: Discovery
./scripts/run-with-no-sleep.sh discover

# 4. Phase 3: Apply CRUD
npm run apply:dry-run    # Review first!
npm run apply:live       # Apply changes

# 5. Phase 4: Enrich missing data
npm run enrich:dry-run   # Preview
npm run enrich:auto      # Auto-fill phone/website/images
# OR for manual image selection:
npm run enrich:review    # Generate review HTML
# Open data/image_review/index.html and select images
```
