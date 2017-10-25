
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
