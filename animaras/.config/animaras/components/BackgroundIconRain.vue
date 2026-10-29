<script setup lang="ts">
import { computed } from 'vue'
import { useTimelineItem } from '@renderer-vue/composables/useTimelineItem'
import { useTimeline } from '@renderer-vue/composables/useTimeline'
import { useFrame } from '@renderer-vue/composables/useFrame'
import { Icon } from '@iconify/vue';
import { cn } from '@renderer-vue/utils/cn';

const item = useTimelineItem()
const timeline = useTimeline()
const frame = useFrame()
const width = timeline.value.data.width
const height = timeline.value.data.height

const icon = computed(() => item.value.data.icon || 'mdi:star')
const size = computed(() => item.value.data.size || 42)
const gap = computed(() => item.value.data.gap || 68)

const interval = computed(() => size.value + gap.value)
const cols = computed(() => Math.ceil(width / interval.value) + 8)
const rows = computed(() => Math.ceil(height / interval.value) + 8)
const speed = 1
const offset = computed(() => frame.value * speed % interval.value)

const classes = cn(
    'text-white/25',
    item.value.data.class,
)

</script>

<template>
  <div class="absolute top-0 left-0 size-full overflow-hidden">
    <div
      v-for="column in cols"
      :key="column"
      :style="{
        '--size': size + 'px',
        '--gap': gap + 'px',
        '--offset': offset + 'px',
        left: `calc(${column - 4} * var(--size) + ${column - 4} * var(--gap))`,
        top: `calc(-2 * var(--size) - 2 * var(--gap) + var(--offset))`,
      }"
      class="flex flex-col gap-(--gap) w-(--size) absolute"
    >
      <div
        v-for="row in rows"
        :key="row"
        class="flex gap-(--gap)"
      >
        <Icon
          :icon="icon"
          :class="classes"
          class="w-(--size) h-(--size)"
        />
      </div>
    </div>
  </div>
</template>
