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
				});
		})
		.then(error=>
			dispatch({
				'type':'POST_FAILURE',
				 isFetching:false
			})
		);
}


export const FetchPosts = (dispatch,url) => new Promise(
	(resolve,reject)=> {
		dispatch({
			type:'POST_START',
			isFetching:true
		});
		return fetch(url)
		.then(response=>response.json()
		.then(json=>dispatch(
			{
				'type':'POST_SUCCESS',
				 payload:json,
				 isFetching:false
			}
		)))
		.then(error=>dispatch(
			{
				'type':'POST_FAILURE',
				 isFetching:false
			}
		))
});
