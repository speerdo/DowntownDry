# Downtown Dry Soft Launch Checklist (CA/NY/IN/NE)

## ✅ Phase 1: Pre-Launch Fixes - COMPLETED

### Day 1 - Critical SEO/Content

#### Homepage Fixes ✅
- [x] Fix homepage title: "Downtown Dry - Find Alcohol-Free Bars & Sober Venues Nationwide"
- [x] Add meta description (155-160 chars): "Discover alcohol-free bars, mocktail lounges, kava bars & THC venues near you. Your guide to sober nightlife in CA, NY, IN, NE & beyond."
- [x] Add proper H1 above the fold (screen reader accessible)
- [x] Homepage structured data and content updated

#### State Landing Pages (CA, NY, IN, NE) ✅
- [x] California - 150-200 word intro about the state's sober scene
- [x] New York - 150-200 word intro about the state's sober scene
- [x] Indiana - 150-200 word intro about the state's sober scene
- [x] Nebraska - 150-200 word intro about the state's sober scene
- [x] H1: "Alcohol-Free Bars in [State]"
- [x] List of cities with venue counts
- [x] SEO meta descriptions for all states

#### City Landing Pages ✅
Focus cities with custom SEO content:
- **California**: Los Angeles, San Francisco, San Diego
- **New York**: New York City, Brooklyn
- **Indiana**: Indianapolis
- **Nebraska**: Omaha, Lincoln

Each city page has:
- [x] H1: "Alcohol-Free Bars in [City]"
- [x] 150-200 word intro
- [x] Venue listings
- [x] 100-150 word outro section
- [x] SEO meta descriptions

### Technical Setup ✅
- [x] XML sitemap generated (sitemap-index.xml + sitemap-0.xml)
- [x] Sitemap filters to only include soft launch states
- [x] States index page filters to show only CA/NY/IN/NE
- [x] All state/city routes filtered to soft launch states only

## Build Stats

- **Total Pages**: 115
- **States**: 4 (California, Indiana, Nebraska, New York)
- **Cities**: 
  - California: 50+ cities
  - New York: 20+ cities
  - Indiana: 7 cities
  - Nebraska: 1 city (Omaha)
- **Sitemap**: Generated at `/sitemap-index.xml`

## Files Modified

1. `src/pages/index.astro` - Homepage SEO improvements
2. `src/pages/states/index.astro` - Soft launch state filtering
3. `src/pages/states/[state].astro` - State page SEO content
4. `src/pages/states/[state]/[city].astro` - City page SEO content
5. `astro.config.mjs` - Sitemap integration with filtering

## Next Steps (Post-Launch)

### Phase 2: Automated Verification for Other States
- [ ] Set up automated venue verification pipeline
- [ ] Process remaining 46 states
- [ ] Gradually roll out verified state pages
- [ ] Update states index to include new states as they're verified

### Ongoing
- [ ] Monitor search console for indexing
- [ ] Add more city-specific content
- [ ] Collect user feedback
- [ ] Expand venue database
