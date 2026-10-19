<script setup lang="ts">
const glyphs = {
  menu: '\ue3dc',
  collections_bookmark: '\ue17b',
  library_add: '\ue375',
  add: '\ue047',
  save: '\ue550',
  refresh: '\ue514',
  search: '\ue567',
  settings: '\ue57f',
  more_vert: '\ue404',
  bookmark_add: '\ue0f2',
  bookmark_added: '\ue0f3',
  manage_accounts: '\ue3c6',
  tune: '\ue683',
} as const

// Code points from Flutter's Icons class; Google's web font uses a different map.
defineProps<{ name: keyof typeof glyphs }>()
</script>

<template>
  <span class="guide-icon" aria-hidden="true">{{ glyphs[name] }}</span>
</template>
