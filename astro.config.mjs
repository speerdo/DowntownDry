// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  integrations: [
    tailwind(),
    sitemap({
      // Filter to only include soft launch states
      filter: (page) => {
        // Include all non-state pages
        if (!page.includes('/states/')) return true;
        
        // For state pages, only include soft launch states
        const softLaunchStates = ['california', 'new-york', 'indiana', 'nebraska'];
        const stateMatch = page.match(/\/states\/([^/]+)/);
        if (stateMatch) {
          return softLaunchStates.includes(stateMatch[1]);
        }
        return true;
      },
      changefreq: 'weekly',
      priority: 0.7,
      lastmod: new Date(),
    })
  ],
  site: 'https://downtowndry.bar',
  output: 'static',
});
