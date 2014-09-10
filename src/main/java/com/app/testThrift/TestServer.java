package com.app.testThrift;

import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TBinaryProtocol.Factory;
import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TThreadPoolServer;
import org.apache.thrift.server.TThreadPoolServer.Args;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TTransportException;

import com.app.testThrift.Test.Processor;

/**
 * 服务端
 * @author chengesheng@gmail.com
 * @date 2014-9-4 上午10:08:29
 * @version 1.0.0
 */
public class TestServer {

	public void startServer() {
		try {

			TServerSocket serverTransport = new TServerSocket(1234);

			Test.Processor<Test.Iface> process = new Processor<Test.Iface>(new TestImpl());

			Factory portFactory = new TBinaryProtocol.Factory(true, true);

			Args args = new Args(serverTransport);
			args.processor(process);
			args.protocolFactory(portFactory);

			TServer server = new TThreadPoolServer(args);
			server.serve();
		} catch (TTransportException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		TestServer server = new TestServer();
		server.startServer();
	}
}
