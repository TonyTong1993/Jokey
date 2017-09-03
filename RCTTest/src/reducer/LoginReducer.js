/*
import { LOGIN } from '../actions/LoginAction'
const initialState = {loginState:false}
 userInfo = (state=initialState,action)=>{
	switch (action.type) {
		case LOGIN :
			{
				console.log('LOGIN')
			 var newState = Object.assign({},state,{
			 	loginState:true,
			 	userName:action.userName,
			 	pwd:action.pwd,
			 	loginType:action.loginType
			 });
			 return newState;
			}
			 break;
	    default:
			 return state;
			 break;
	}
}

module.exports = userInfo
*/

const movies = (state,action)=>{
	switch (action.type) {
		case 'POST_START':
		{
			return Object.assign({},state,{
				isFetching:action.isFetching
			})
		}
		break;
		case 'POST_SUCCESS':
		{
			return Object.assign({},state,{
				isFetching:action.isFetching,
				payload:action.payload
			})
		}
		break;
		default:
		break;
	}
}

module.exports = movies;