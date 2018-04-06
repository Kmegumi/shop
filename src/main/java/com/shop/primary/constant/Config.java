package com.shop.primary.constant;

import java.util.ResourceBundle;

/**
 * 静态常量
 */
public class Config {


	public String get(String key) {
		return bundle.getString(key);
	}

	private static Config config;
	private static ResourceBundle bundle = ResourceBundle.getBundle("config");

	public static Config getConfig() {
		if (config != null) {
			return config;
		} else {
			config = new Config();
			bundle = ResourceBundle.getBundle("config");
			return config;
		}
	}
	
}