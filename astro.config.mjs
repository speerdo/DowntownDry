// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  integrations: [
    tailwind(),
    sitemap({
      // Filter to exclude admin and API routes
      filter: (page) => {
        // Exclude admin page
        if (page.includes('/admin/')) return false;
        
        // Exclude API routes
        if (page.includes('/api/')) return false;
        
        // Include all other pages (state pages are already filtered by is_active in getStaticPaths)
        return true;
      },
      changefreq: 'weekly',
      priority: 0.7,
      lastmod: new Date(),
    })
  ],
  site: 'https://www.downtowndry.bar',
  output: 'static',
  trailingSlash: 'always',
});
