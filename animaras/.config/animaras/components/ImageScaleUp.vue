<script setup lang="ts">
import { computed } from 'vue';
import { useTimelineItem } from '@renderer/composables/useTimelineItem';
import { useSpring } from '@renderer/composables/useSpring';
import { useTimeline } from '@renderer/composables/useTimeline';

const item = useTimelineItem();
const timeline = useTimeline()
const src = item.value.data.src as string;
const scale = useSpring({
    config: { damping: 14, stiffness: 120 },
})

const x = computed(() => item.value.data.x || 0)
const y = computed(() => item.value.data.y || 0)
const width = computed(() => item.value.data.width || 100)
const height = computed(() => item.value.data.height || 100)

const style = computed(() => ({
    left: `${timeline.value.data.width / 2 + x.value}px`,
    top: `${timeline.value.data.height / 2 + y.value}px`,
    width: width.value + 'px',
    height: height.value + 'px',
    transform: `translate(-50%, -50%) scale(${scale.value})`,
}))
</script>
<template>
    <div class="flex absolute size-100 items-center justify-center" :style>
        <img v-if="src" :src="src" class="size-full object-contain" />
        <div v-else class="flex flex-col items-center justify-center text-center gap-4 text-danger">
            <span>No image source provided</span>
        </div>
    </div>
</template>
