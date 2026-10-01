import registry from "@renderer-vue/facades/componentRegistry.ts";

registry.register('img-spring', () => import('./components/ImageSpring.vue'))
registry.register('bg-grid', () => import('./components/BackgroundGrid.vue'))
registry.register('bg-icon', () => import('./components/BackgroundIcon.vue'))
registry.register('text', () => import('./components/Text.vue'))
registry.register('color', () => import('./components/Color.vue'))
registry.register('icon', () => import('./components/Icon.vue'))

