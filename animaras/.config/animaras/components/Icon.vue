<script setup lang="ts">
import { computed } from 'vue';
import { useTimelineItem } from '@renderer-vue/composables/useTimelineItem';
import { useSpring } from '@renderer-vue/composables/useSpring';
import { useTimeline } from '@renderer-vue/composables/useTimeline';
import { cn } from '@renderer-vue/utils/cn';
import { Icon } from '@iconify/vue';

const item = useTimelineItem();
const timeline = useTimeline()
const text = item.value.data.text as string;
const scale = useSpring({
    config: { damping: 14, stiffness: 120 },
})

const x = computed(() => item.value.data.x || 0)
const y = computed(() => item.value.data.y || 0)
const name = computed(() => item.value.data.name || 'mdi:help-circle-outline')
const classes = computed(() => cn([
    item.value.data.class,
]))

const style = computed(() => ({
    left: `${timeline.value.data.width / 2 + x.value}px`,
    top: `${timeline.value.data.height / 2 + y.value}px`,
    transform: `translate(-50%, -50%) scale(${scale.value})`,
}))
</script>
<template>
    <div class="flex absolute items-center justify-center" :style data-studio-transform
        :data-studio-item-id="item.data.id">
        <Icon :icon="name" :class="classes">
            {{ text }}
        </Icon>
    </div>
</template>

