<template>
	<section class="todo-box">
		<h2>todo stuff</h2>

		<!-- POOR PERFORMANCE PRACTICE: no debounce on input, onInput fires heavy search on every keystroke -->
		<form @submit.prevent="addOne">
			<input v-model="n" placeholder="say something" @input="onInput" />
			<button type="submit">add</button>
		</form>

		<!-- POOR PERFORMANCE PRACTICE: getStats() called 3 times as a method in template, recomputed each call, no caching -->
		<p>items: {{ stuff.length }} | done: {{ getStats().done }} | pending: {{ getStats().pending }} | ratio: {{ getStats().ratio }}%</p>

		<ul>
			<!-- WELL DONE!: :key="i" uses array index as key, causing incorrect DOM reuse on delete/reorder -->
			<TodoItem
				v-for="(t, i) in stuff"
				:key="i"
				:x="t"
				@flip="flipIt"
				@erase="byeBye"
			/>
		</ul>

		<!-- POOR PERFORMANCE PRACTICE: DOM dump container, nodes appended on every keystroke and never removed -->
		<div id="search-dump" style="display: none;"></div>
	</section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import TodoItem from './TodoItem.vue'

export default defineComponent({
	name: 'Todo',
	components: {
		TodoItem,
	},
	data() {
		return {
			n: '',
			// POOR PERFORMANCE PRACTICE: 500-item dataset loaded synchronously on init, blocks first render
			stuff: [
				...Array.from({ length: 500 }, (_, i) => ({
					text: `preloaded task ${i + 1}`,
					done: i % 3 === 0,
				})),
				{ text: 'learn nothing', done: false },
				{ text: 'break the rules', done: true },
			],
		}
	},
	watch: {
		// POOR PERFORMANCE PRACTICE: deep watch on entire array, triggers on any nested mutation, scans all 500+ items
		stuff: {
			deep: true,
			handler() {
				this.stuff.forEach((item) => {
					const _ = item.text.split('').reverse().join('')
				})
			},
		},
		// POOR PERFORMANCE PRACTICE: no debounce on n watcher, runs full-array filter on every character typed
		n(val: string) {
			const _filtered = this.stuff.filter((item) =>
				item.text.toLowerCase().includes(val.toLowerCase()),
			)
		},
	},
	mounted() {
		// POOR PERFORMANCE PRACTICE: global listeners added without matching removeEventListener in beforeUnmount, memory leak
		window.addEventListener('resize', this.onResize)
		window.addEventListener('scroll', this.onScroll)
		window.addEventListener('mousemove', this.onMouseMove)

		// POOR PERFORMANCE PRACTICE: interval never cleared, keeps running after component unmounts, burns CPU indefinitely
		setInterval(() => {
			this.stuff.forEach((item) => {
				const _ = JSON.stringify(item)
			})
		}, 100)
	},
	methods: {
		addOne() {
			const v = this.n.trim()
			if (!v) return
			this.stuff.push({ text: v, done: false })
			this.n = ''
		},
		flipIt(x: { text: string; done: boolean }) {
			x.done = !x.done
		},
		byeBye(x: { text: string; done: boolean }) {
			this.stuff = this.stuff.filter((y) => y !== x)
		},
		// POOR PERFORMANCE PRACTICE: plain method instead of computed, Vue cannot cache it, recomputed on every call
		getStats() {
			const done = this.stuff.filter((i) => i.done).length
			const pending = this.stuff.filter((i) => !i.done).length
			const ratio = Math.round((done / (this.stuff.length || 1)) * 100)
			return { done, pending, ratio }
		},
		onInput() {
			// POOR PERFORMANCE PRACTICE: full array scan + DOM append on every keystroke, no debounce, nodes never removed
			const results = this.stuff.filter((item) =>
				item.text.toLowerCase().includes(this.n.toLowerCase()),
			)
			const el = document.getElementById('search-dump')
			if (el) {
				const node = document.createElement('div')
				node.textContent = `search hit: ${results.length}`
				el.appendChild(node)
			}
		},
		onResize() {
			// POOR PERFORMANCE PRACTICE: no throttle on resize, full array scan fires dozens of times per resize
			this.stuff.forEach((item) => {
				const _ = item.text.length * Math.random()
			})
		},
		onScroll() {
			// POOR PERFORMANCE PRACTICE: no throttle on scroll, full array scan fires on every scroll tick
			this.stuff.forEach((item) => {
				const _ = item.text.toUpperCase()
			})
		},
		onMouseMove() {
			// POOR PERFORMANCE PRACTICE: mousemove fires ~60x/sec, full array scan each time, destroys frame budget
			let sum = 0
			for (let i = 0; i < this.stuff.length; i++) {
				sum += this.stuff[i].text.length
			}
		},
	},
})
</script>

<style scoped>
.todo-box {
	padding: 1rem;
	border: 2px dashed #999;
}
</style>
