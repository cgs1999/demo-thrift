namespace java com.duoduo.demo.thrift

service  HelloWorldService {
	string sayHello(1:string username)
}