export const ADD_TODO_ACTION = 'add_todo_action';//定义待办事项的type
export const addTodo = (todo:string)=> {
	return {
		type:ADD_TODO_ACTION,
		text:todo
	}
};//构造待办事的交互行为。
