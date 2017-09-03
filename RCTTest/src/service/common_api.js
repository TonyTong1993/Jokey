
/*
{
	"h_model": "iPhone 7",
	"h_ch": "appstore",
	"h_ts": 1499651355292,
	"h_av": "3.6.2",
	"tab": "rec",
	"h_did": "d290abf3c0a8710b37553e3744de3c3719b3a687",
	"filter": "all",
	"h_m": 30212123,
	"h_os": "10.300000",
	"h_nt": 1,
	"token": "T3KaNtfK1OltwZMuEot9GGeTg2CXwQZSkNeEtUXRxc6RYbCk=",
	"h_dt": 1,
	"direction": "down"
}
*/
const service_file  = 'http://tbfile.ixiaochuan.cn';//文件资源服务器 
/*
头像路径:/account/avatar/id/xxxx/sz/filename 
图片内容路径:/img/view/id/xxxxxx/sz/filename
*/
const avatar_path = '/account/avatar/id/';//头像路由

const image_path = '/img/view/id/';//图片路由

/*合成图片全路由 */
const getImagePath = ( path : string ,imageID : number,filename : string ) => {
   return service_file + path + imageID + '/sz' + filename;
}

module.exports = {
	service_file,
	avatar_path,
	image_path,
	getImagePath,
}