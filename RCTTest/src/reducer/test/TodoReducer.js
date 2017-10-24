import {ADD_TODO_ACTION} from '../../actions/test/TodoAction'
/*
纯函数的概念：只要是同样的输入，必定得到同样的输出，必须遵守以下一些约束：
1.不得改写参数
2.不能调用系统 I/O 的API
3.不能调用Date.now()或者Math.random()等不纯的方法，因为每次会得到不一样的结果
由于 Reducer 是纯函数，就可以保证同样的State，必定得到同样的 View。
但也正因为这一点，Reducer 函数里面不能改变 State，必须返回一个全新的对象，请参考下面的写法。
// State 是一个对象
function reducer(state, action) {
  return Object.assign({}, state, { thingToChange });
  // 或者
  return { ...state, ...newState };
}

// State 是一个数组
function reducer(state, action) {
  return [...state, newItem];
}
*/
export const todos = (state=['welcome to todo app!'],action)=>{
	switch(action.type) {
		case ADD_TODO_ACTION:
		{
			return [...state,action.text];
		}
		break;
		default:
		{
			return state
		}
		break;
	}
}
