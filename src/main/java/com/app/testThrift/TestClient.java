package com.app.testThrift;

import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;

/**
 * 客户端
 * @author chengesheng@gmail.com
 * @date 2014-9-4 上午10:15:06
 * @version 1.0.0
 */
public class TestClient {

	public void startClient() {
		TTransport transport;
		try {
			transport = new TSocket("localhost", 1234);
			TProtocol protocol = new TBinaryProtocol(transport);
			Test.Client client = new Test.Client(protocol);
			transport.open();
			client.say(" Hello I am client");
			transport.close();
		} catch (TTransportException e) {
			e.printStackTrace();
		} catch (TException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		TestClient client = new TestClient();
		client.startClient();
	}
}
