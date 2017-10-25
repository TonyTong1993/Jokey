

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
