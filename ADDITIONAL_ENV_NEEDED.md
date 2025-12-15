# Setup: Add 3 Environment Variables

## What You Need to Add

Add these to your `.env` file:

```bash
GEMINI_API_KEY=your_key_here
GOOGLE_SEARCH_API_KEY=your_key_here
GOOGLE_SEARCH_ENGINE_ID=your_id_here
```

---

## 1. Gemini API (FREE)

**Get it:** https://aistudio.google.com/app/apikey

1. Click "Create API key"
2. Copy the key
3. Add to `.env`

---

## 2. Google Custom Search (100/day FREE)

### Get API Key

**URL:** https://console.cloud.google.com/apis/credentials

1. Click "+ CREATE CREDENTIALS" → "API key"
2. Copy the key

### Enable the API

**URL:** https://console.cloud.google.com/apis/library/customsearch.googleapis.com

1. Click "ENABLE"

### Create Search Engine

**URL:** https://programmablesearchengine.google.com/

1. Click "Add"
2. Name: "DowntownDry Search"
3. Search: "Search the entire web"
4. Click "Create"
5. Copy the "Search engine ID"

---

## ✅ Verify Places API

Your `PUBLIC_GOOGLE_MAPS_API_KEY` should work for Places API. Just verify:

**URL:** https://console.cloud.google.com/google/maps-apis

1. Check "Places API (New)" is ENABLED
2. Enable billing if not already (required for Places - $0.017/request)

---

## Test

```bash
npm install
node scripts/01_extract_venues.js
```

Should see: `✅ Found XXX unverified venues`

---

**Cost:** $0 for Gemini + Custom Search (free tiers) | ~$26 for Places API
