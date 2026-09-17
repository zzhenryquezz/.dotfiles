import registry from "@renderer/facades/componentRegistry.ts";

registry.register('image-scale-up', () => import('./components/ImageScaleUp.vue'))
