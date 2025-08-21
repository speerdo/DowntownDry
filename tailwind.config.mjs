/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f7f8f4',
          100: '#eef0e8',
          200: '#dde1d2',
          300: '#c6cdb4',
          400: '#a8b390',
          500: '#8a9a6f',
          600: '#6f7f56',
          700: '#505A28', // Main brand color
          800: '#434c22',
          900: '#38401e',
        },
        secondary: {
          50: '#fefcf8',
          100: '#fdf8f0',
          200: '#fbeede',
          300: '#f7e0c4',
          400: '#f1cd9f',
          500: '#D9AA55', // Golden accent
          600: '#c4941f',
          700: '#a47c1a',
          800: '#86651a',
          900: '#6e531a',
        },
        accent: {
          50: '#fef9f6',
          100: '#fdf2ec',
          200: '#fae1d0',
          300: '#f6cab0',
          400: '#f0a882',
          500: '#D98555', // Orange accent
          600: '#c66a3a',
          700: '#a5552f',
          800: '#85462a',
          900: '#6d3c26',
        },
        neutral: {
          50: '#F2EADF', // Light cream background
          100: '#ede4d8',
          200: '#ddd1c2',
          300: '#c8b8a5',
          400: '#b09a82',
          500: '#967d63',
          600: '#7d6651',
          700: '#665344',
          800: '#54453a',
          900: '#1D200F', // Dark forest green
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        serif: ['Playfair Display', 'serif'],
        heading: ['new-spirit', 'Figtree', 'sans-serif'],
      },
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-conic':
          'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
      },
    },
  },
  plugins: [],
};
