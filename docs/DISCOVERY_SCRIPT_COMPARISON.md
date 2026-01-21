# Discovery Script Comparison: Original vs Optimized

## Key Differences Between Scripts

### 1. **Search Queries** ⚠️ **MAJOR DIFFERENCE**

**Original (`discover-all-cities.js`):**
```javascript
const DISCOVERY_QUERIES = [
  '{city} {state} non-alcoholic bar',
  '{city} {state} mocktail bar',
  '{city} {state} kava bar',
  '{city} {state} alcohol-free restaurant',  // ← EXTRA
  '{city} {state} sober bar',
  '{city} {state} zero proof cocktails',      // ← EXTRA
  '{city} {state} THC lounge',               // ← EXTRA
  '{city} {state} hemp drink bar',           // ← EXTRA
  '{city} {state} Athletic Brewing taproom', // ← EXTRA
];
```
**9 search queries total**

**Optimized (`rediscover-failed-cities-OPTIMIZED.js`):**
```javascript
const DISCOVERY_QUERIES = [
  '{city} {state} non-alcoholic bar',
  '{city} {state} kava bar',
  '{city} {state} mocktail lounge',
  '{city} {state} alcohol-free bar',
  '{city} {state} sober bar',
];
```
**5 search queries total** - Missing 4 queries!

### 2. **Verification Criteria** - **SAME**

Both scripts use identical verification rules:

**Must meet AT LEAST ONE:**
- 100% alcohol-free bar/lounge
- Kava bar (serves kava as primary offering)
- Dedicated mocktail/zero-proof menu (3+ options)
- THC lounge (only if legal in state)
- Sober-friendly venue with prominent NA options

**REJECT if:**
- Generic restaurant without specific NA focus
- Strip club, nightclub, tobacco shop, liquor store
- Permanently closed
- Wrong location

### 3. **API Usage** - **DIFFERENT**

**Original:**
- Uses `Text Search` API (more expensive, $32/1000)
- Searches for each venue individually

**Optimized:**
- Uses `Find Place From Text` API (cheaper, $17/1000)
- Uses batch verification (more efficient)

### 4. **Search Coverage** - **DIFFERENT**

**Original searches for:**
- Non-alcoholic bars
- Mocktail bars
- Kava bars
- **Alcohol-free restaurants** ← Missing in optimized
- Sober bars
- **Zero proof cocktails** ← Missing in optimized
- **THC lounges** ← Missing in optimized
- **Hemp drink bars** ← Missing in optimized
- **Athletic Brewing taprooms** ← Missing in optimized

**Optimized searches for:**
- Non-alcoholic bars
- Kava bars
- Mocktail lounges
- Alcohol-free bars
- Sober bars

## Why Seattle Has So Few Venues

### The Problem:
1. **Missing search queries** - The optimized script is missing 4 search terms that could find more venues
2. **Narrower search scope** - Doesn't search for:
   - Alcohol-free restaurants (could find venues like cafes/restaurants with NA focus)
   - Zero proof cocktails (could find cocktail bars with NA programs)
   - THC lounges (Washington has legal cannabis)
   - Hemp drink bars
   - Athletic Brewing taprooms

### Impact on Seattle:
- Seattle is a major city with a thriving NA scene
- Many venues might be categorized as "restaurants with NA options" rather than "bars"
- Missing THC lounge search is significant (Washington has legal cannabis)
- The 15 candidates found were likely all from the 5 basic queries, but none qualified

## Recommendation

**Add back the missing search queries to the optimized script:**

```javascript
const DISCOVERY_QUERIES = [
  '{city} {state} non-alcoholic bar',
  '{city} {state} kava bar',
  '{city} {state} mocktail lounge',
  '{city} {state} alcohol-free bar',
  '{city} {state} sober bar',
  '{city} {state} alcohol-free restaurant',  // ← ADD BACK
  '{city} {state} zero proof cocktails',      // ← ADD BACK
  '{city} {state} THC lounge',               // ← ADD BACK (if legal)
  '{city} {state} hemp drink bar',           // ← ADD BACK
];
```

This would give better coverage, especially for cities like Seattle where venues might be categorized differently.
