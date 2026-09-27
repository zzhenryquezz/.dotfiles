<script setup lang="ts">
import { computed } from 'vue';
import { useTimelineItem } from '@renderer-vue/composables/useTimelineItem';
import { cn } from '@renderer-vue/utils/cn';

const item = useTimelineItem();

const classes = computed(() => cn([
    'flex',
    'fixed',
    'inset-0',
    item.value.data.class,
]))

const style = computed(() => ({
    backgroundColor: item.value.get('color', '#000'),
}))
</script>
<template>
  <div
    :class="classes"
    :style
    data-studio-transform
    :data-studio-item-id="item.data.id"
  />
</template>
