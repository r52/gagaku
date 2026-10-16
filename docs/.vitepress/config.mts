import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Gagaku',
  description: 'A quick-start guide to reading with MangaDex, Web Sources, and your local library.',
  base: '/gagaku/',
  lang: 'en-US',
  cleanUrls: false,
  lastUpdated: true,
  themeConfig: {
    siteTitle: 'Gagaku Guide',
    nav: [
      { text: 'Guide', link: '/' },
      { text: 'Download', link: 'https://github.com/r52/gagaku/releases' },
    ],
    sidebar: [
      {
        text: 'Get started',
        items: [
          { text: 'Quick start', link: '/' },
          { text: 'Web Sources', link: '/web-sources' },
          { text: 'MangaDex', link: '/mangadex' },
          { text: 'Local Library', link: '/local-library' },
        ],
      },
      {
        text: 'Use Gagaku',
        items: [
          { text: 'Reading & favorites', link: '/reading' },
          { text: 'Troubleshooting', link: '/troubleshooting' },
        ],
      },
      {
        text: 'Configure Gagaku',
        items: [
          { text: 'App settings', link: '/app-settings' },
          { text: 'Web Sources settings', link: '/web-source-settings' },
        ],
      },
    ],
    search: { provider: 'local' },
    outline: [2, 3],
    socialLinks: [{ icon: 'github', link: 'https://github.com/r52/gagaku' }],
    editLink: {
      pattern: 'https://github.com/r52/gagaku/edit/main/docs/:path',
      text: 'Suggest a change to this guide',
    },
    footer: {
      message:
        'Gagaku is free software, licensed under MIT. · <a href="/gagaku/fonts/NOTICE.txt">Material Icons by Google (CC BY 4.0)</a>',
    },
  },
})
