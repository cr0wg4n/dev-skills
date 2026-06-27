<template>
	<li class="todo-item" :class="{ done: x.done }">
		<!-- POOR PERFORMANCE PRACTICE: expensiveLabel() is a method, recomputed on every render with no caching -->
		<span class="label" @click="a">{{ expensiveLabel() }}</span>
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
	mounted() {
		// POOR PERFORMANCE PRACTICE: document-level listeners registered per item, never removed on unmount
		// with 500 items: 1500 listeners leak into the document and stack on every re-mount
		document.addEventListener('click', this.onDocClick)
		document.addEventListener('keydown', this.onKeyDown)
		document.addEventListener('mousemove', this.onDocMouseMove)
	},
	methods: {
		a() {
			this.$emit('flip', this.x)
		},
		b() {
			this.$emit('erase', this.x)
		},
		// POOR PERFORMANCE PRACTICE: string reversed 100 times (odd = net reversed), called every render, no memoization
		// 500 items × 100 iterations = 50 000 string ops per render cycle
		expensiveLabel() {
			let label = this.x.text
			for (let i = 0; i < 100; i++) {
				label = label.split('').reverse().join('')
			}
			return (this.x.done ? '✓ ' : '') + label
		},
		onDocClick() {
			// POOR PERFORMANCE PRACTICE: fires for every click on the page, once per todo item alive in the list
		},
		onKeyDown() {
			// POOR PERFORMANCE PRACTICE: fires for every keypress, once per todo item, 500+ handlers per keypress
		},
		onDocMouseMove() {
			// POOR PERFORMANCE PRACTICE: mousemove fires ~60x/sec × 500 items = 30 000 handler calls/sec
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
