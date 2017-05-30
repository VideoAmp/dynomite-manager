//package com.netflix.dynomitemanager;
//
//import org.eclipse.jetty.server.Server;
//import org.eclipse.jetty.webapp.WebAppContext;
//
//import java.net.URL;
//import java.security.ProtectionDomain;
//
//public class Runner {
//	public static void main(String[] args) throws Exception {
//		System.out.println("ASDFASFASFASFASF");
//		final int port = Integer.parseInt(System.getProperty("port", "8080"));
//		final String home = System.getProperty("home", "");
//		Server server = new Server(port);
//		ProtectionDomain domain = Runner.class.getProtectionDomain();
//		URL location = domain.getCodeSource().getLocation();
//		WebAppContext webapp = new WebAppContext("src/main/webapp", "/");
//		webapp.setWar(location.toExternalForm());
//		server.setHandler(webapp);
//		server.start();
//		server.join();
//		new JettyRunner();
//	}
//}