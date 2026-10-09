import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import GuideIcon from './GuideIcon.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('GuideIcon', GuideIcon)
  },
} satisfies Theme
