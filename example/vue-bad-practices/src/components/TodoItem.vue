<template>
	<li class="todo-item" :class="{ done: x.done }">
		<span class="label" @click="a">{{ x.done ? '✓ ' : '' }}{{ x.text }}</span>
		<button type="button" @click="b">x</button>
	</li>
</template>

<script lang="ts">
import { defineComponent, type PropType } from 'vue'

export default defineComponent({
	name: 'todoitem',
	props: {
		x: {
			type: Object as PropType<{ text: string; done: boolean }>,
			required: true,
		},
	},
	emits: ['flip', 'erase'],
	methods: {
		a() {
			this.$emit('flip', this.x)
		},
		b() {
			this.$emit('erase', this.x)
		},
	},
})
</script>

<style scoped>
.todo-item {
	display: flex;
	gap: 0.5rem;
	align-items: center;
}

.done {
	text-decoration: line-through;
}
</style>
