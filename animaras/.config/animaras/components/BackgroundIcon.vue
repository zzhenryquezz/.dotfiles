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

const icon = computed(() => item.value.data.icon || 'mdi:star')
const durationInSeconds = computed(
    () => item.value.data.to || 3,
)
const size = computed(() => item.value.data.size || 46)
const gap = computed(() => item.value.data.gap || 46)
const rotate = computed(() => item.value.data.rotate ?? true)
const rotationDurationInSeconds = computed(
    () => item.value.data.rotationDurationInSeconds || 6,
)

const interval = computed(() => size.value + gap.value)

const fps = computed(() => timeline.value.data.fps)

const durationInFrames = computed(() =>
    Math.max(1, Math.round(durationInSeconds.value * fps.value)),
)

const offset = computed(() =>
    ((frame.value % durationInFrames.value) / durationInFrames.value)
    * interval.value,
)

const columnCount = computed(() =>
    Math.ceil(timeline.value.data.width / interval.value) + 4,
)

const rowCount = computed(() =>
    Math.ceil(timeline.value.data.height / interval.value) + 4,
)

const rotationDurationInFrames = computed(() =>
    Math.max(
        1,
        Math.round(rotationDurationInSeconds.value * fps.value),
    ),
)

const rotation = computed(() =>
    rotate.value
        ? ((frame.value % rotationDurationInFrames.value)
            / rotationDurationInFrames.value) * 360
        : 0,
)

const classes = cn(
    'absolute text-white/25',
    item.value.data.class,
)
</script>

<template>
  <div class="absolute top-0 left-0 size-full overflow-hidden">
    <template
      v-for="row in rowCount"
      :key="row"
    >
      <div
        v-for="column in columnCount"
        :key="`${row}-${column}`"
        :class="classes"
        :style="{
          top: `${(row - 1) * interval}px`,
          left: `${-interval + column * interval + offset}px`,
          width: `${size}px`,
          height: `${size}px`,
          fontSize: `${size * 0.8}px`,
        }"
      >
        <Icon
          :icon="icon"
          :style="{
            transform: rotate
              ? `rotate(${rotation}deg)`
              : undefined,
          }"
        />
      </div>
    </template>
  </div>
</template>
```
