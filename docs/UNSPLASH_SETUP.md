# Unsplash API Setup Guide

## Image Sources Strategy

The script uses a smart multi-source approach:

1. **Unsplash** (preferred) - High-quality city photos
2. **Wikipedia** (fallback) - Often has city images even for small towns
3. **Unsplash Generic** (final fallback) - Professional cityscape images

All sources provide **permanent URLs** with **no API keys exposed**.

### Why This Approach?

✅ **Permanent URLs** - Never expire  
✅ **No API keys in URL** - More secure  
✅ **Works for small towns** - Wikipedia often has images  
✅ **High quality** - Professional photography  
✅ **Free** - No costs involved  

## Quick Setup (2 minutes)

### Step 1: Get Your Free API Key (Optional but Recommended)

**Note:** The script will work with just Wikipedia, but Unsplash provides better quality images and generic fallbacks.

1. Go to https://unsplash.com/developers
2. Click **"Register as a developer"** (it's free!)
3. Sign in with your Unsplash account (or create one)
4. Click **"New Application"**
5. Fill in:
   - **Application name**: DowntownDry (or anything)
   - **Description**: Finding city images for venue directory
   - Accept the API Use and Access Guidelines
6. Click **"Create application"**
7. Copy your **"Access Key"** (starts with something like `abc123...`)

### Step 2: Add to Your .env File

Add this line to your `.env` file:

```bash
UNSPLASH_ACCESS_KEY=your_access_key_here
```

Replace `your_access_key_here` with the key you copied.

**Or skip this step** - the script will use Wikipedia if Unsplash key is not set.

### Step 3: Run the Script

```bash
npm run city-images:featured
```

The script will:
- Try Unsplash first (if key is set)
- Fall back to Wikipedia (works for many cities, including small towns)
- Use generic cityscape images as final fallback (if Unsplash key is set)

## Rate Limits

- **Free tier**: 50 requests/hour
- For 11 cities, this is plenty (takes ~1 minute)
- If you need more, you can wait an hour or upgrade (but free tier is usually enough)

## Troubleshooting

**"No Unsplash API key found"**
- Make sure you added `UNSPLASH_ACCESS_KEY` to your `.env` file
- Restart your terminal/IDE after adding it

**"Error searching Unsplash"**
- Check that your API key is correct
- Make sure you accepted the API guidelines when creating the app
- Check your rate limit (50/hour on free tier)

**"No suitable image found"**
- This shouldn't happen - the script falls back to generic cityscape images
- If you see this, check your API key and rate limits

**"Using generic cityscape"**
- This is normal for smaller towns
- The script uses high-quality generic city/urban images from Unsplash
- These are still permanent URLs and look professional

## Example Output

Once set up, you'll see:

```
🔍 Searching for images: Jupiter, Florida
   ✅ Found image from unsplash
      Photo by: John Doe
```

The generated URLs will look like:
```
https://images.unsplash.com/photo-1234567890?auto=format&fit=crop&w=800&h=400&q=80
```

These are permanent and don't include any API keys! 🎉

TESTING FOR BUILD #2
