<template>
	<section class="todo-box">
		<h2>todo stuff</h2>

		<form @submit.prevent="addOne">
			<input v-model="n" placeholder="say something" />
			<button type="submit">add</button>
		</form>

		<p>items: {{ stuff.length }}</p>

		<ul>
			<TodoItem
				v-for="(t, i) in stuff"
				:key="i"
				:x="t"
				@flip="flipIt"
				@erase="byeBye"
			/>
		</ul>
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
			stuff: [
				{ text: 'learn nothing', done: false },
				{ text: 'break the rules', done: true },
			],
		}
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
	},
})
</script>

<style scoped>
.todo-box {
	padding: 1rem;
	border: 2px dashed #999;
}
</style>
