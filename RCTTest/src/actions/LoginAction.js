export const LOGIN = 'LOGIN'

export const LOGIN_TYPE_NORMAL = 'normal'

export const LOGIN_TYPE_THIRD = 'third'

export const LOGOUT = 'LOGOUT'

export const REGISTER = 'REGISTER'

/*
export const loginAction = (loginType,userName,pwd)=>{
	return {
		type:LOGIN,
		loginType,
		userName,
		pwd
	}
}
*/
export const GetMovies = (url)=>(dispatch,getState)=>{
		dispatch({
					type:'POST_START',
					isFetching:true
				})
		return fetch(url)
		.then(response=> response.json())
		.then(json=>{
			dispatch({
						type:'POST_SUCCESS',
						isFetching:false,
						payload:json
				})
		})
}

/*
export const FetchPosts = (dispatch,url) => new Promise(
	(resolve,reject)=> {
		dispatch({type:'POST_START'});
		return fetch(url).then(response=>{
			'type':'POST_SUCCESS',
			 payload:response.json()
		}).then(error=>{
			'type':'POST_FAILURE',
		})
})

*/