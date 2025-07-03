import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    author: z.string(),
    publishDate: z.date(),
    category: z.enum([
      'recipes',
      'wellness',
      'city-guide',
      'community',
      'lifestyle',
      'delta-thc',
      'tips',
      'advice',
    ]),
    tags: z.array(z.string()).optional(),
    image: z.string(),
    readTime: z.string(),
    featured: z.boolean().default(false),
  }),
});

export const collections = {
  blog,
};
