package com.app.testThrift;

import org.apache.thrift.TException;

/**
 * 接口实现类
 * @author chengesheng@gmail.com
 * @date 2014-9-4 上午10:07:50
 * @version 1.0.0
 */
public class TestImpl implements Test.Iface {

	public void say(String word) throws TException {
		System.out.println("I am server, I want to say: " + word);
	}
}
