/**
 * The first thing to know about are types. The available types in Thrift are:
 *
 *  bool        Boolean, one byte
 *  byte        Signed byte
 *  i16         Signed 16-bit integer
 *  i32         Signed 32-bit integer
 *  i64         Signed 64-bit integer
 *  double      64-bit floating point value
 *  string      String
 *  binary      Blob (byte array)
 *  map<t1,t2>  Map from one type to another
 *  list<t1>    Ordered list of one type
 *  set<t1>     Set of unique elements of one type
 *
 * Did you also notice that Thrift supports C style comments?
 */

namespace cpp gen.pmt
namespace java gen.rmi


enum RetCode {
    Success = 0,
    UnknowError,
    Failed
}

struct Response {
    1:RetCode ret_code,
    2:string ret_msg
}

struct FileScahma{
    1:string filePath,
    2:i64 totalSize,
    3:i64 offset,
    4:i32 bufferSize,
    5:binary data
}

//配方简要信息
struct RecipeBrief {
    1:string appKey,
    2:string appVersion,
    3:string filePath,
    4:i64 fileSize
}

struct NodeSelfCfg{
    1:string ipPort,
    2:string nodePath,
    3:string selfStatePath,
    4:string stateChangePath
}

struct ManagerIpInfo{
    1:string oldIp,
    2:string newIp,
    3:bool isDmNode
}

struct NodeVersion{  
	1:string nodeVersion,
    2:string nodeType
}


service NodeService  
{  
    //业务接口
    //版本协商
    NodeVersion getNodeVersion(),
    bool isSupportDM(1:string dmVersion),
    
    //升级
    Response nmUpdate(1:FileScahma fileScahma), //延迟10s node才开始升级
    
    //获取node环境信息(json格式的net+sshport)  
    string getNodeEnvInfo(),
    
    //配方信息
    list<RecipeBrief> getAllRecipe(),   
    
    //获取App配置: map<appkey, keyValue> 
    map<string, string> getAllAppConfig(),

 
    //通用文件上传接口
    //Response uploadFile(1:string fileName, 2:binary writeBuffer),
    //binary downloadFile(1:string fileName),

    //Response uploadBigFile(1:FileScahma fileScahma),
    binary downloadBigFile(1:string filePath, 2:i64 offset, 3:i32 bufSize),    
        
    //设置node的自身配置项修改
    bool setNodeSelfCfg(1:NodeSelfCfg nodeSelfCfg),
    
    //全局配置(全局配置同一走thrift接口)
    Response setGlobalCfg(1:string keyvalue),
    
    //ssh协议
    bool setSshKey(1:binary secretKey),
    bool openSsh(),
    bool closeSsh(),   

	//文件类型的配置项上传(appName传入app名称，FileScahma中的filePath传入路径+文件名)
	string uploadCfgFile(1:string appName, 2:FileScahma fileScahma),

	//修改设置管理IP接口
	bool setManagerIp(1:ManagerIpInfo ipInfo),

	//获取文件大小
    i64 getFileSize(1:string filePath),

	//nm卸载
	void nmUninstall(),
	
	//物理机器重启
	void reboot(),

	//获取某个app的状态(true是正常，false是异常,appName是app的key值）
	bool GetAppStatus(1:string appName)
}

