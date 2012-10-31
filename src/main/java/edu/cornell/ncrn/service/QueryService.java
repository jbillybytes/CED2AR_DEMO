package edu.cornell.ncrn.service;

import java.io.IOException;

import org.basex.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;


@Service
public class QueryService {
	private static final Logger logger = LoggerFactory.getLogger(QueryService.class);

	public QueryService() {

	}

	@Autowired
	ServletContext servletContext;
	
//	@SuppressWarnings("null")
	public String getXML(String xquery) {
		logger.info("Getting response");

		String response = "";
		String styledResponse = "";
		
		String baseUrl = "http://rschweb.ciserrsch.cornell.edu:8080/BaseX73/rest?query=";
		HttpURLConnection uConn = null;
		BufferedReader bd = null;
		StringBuilder sb = null;
		try {
			URL url = new URL(baseUrl + URLEncoder.encode(xquery, "UTF-8"));
			// User and password.
			String user = "admin";
			String pw ="admin";
			// Encode user name and password pair with a base64 implementation.
			String encoded = Base64.encode(user + ":" + pw);
			// Basic access authentication header to connection request.
			
			uConn = (HttpURLConnection) url.openConnection();
			uConn.setRequestProperty("Authorization", "Basic " + encoded);
			uConn.setRequestMethod("GET");
			uConn.setDoOutput(true);
			uConn.setReadTimeout(10000);

			uConn.connect();

			bd = new BufferedReader(new InputStreamReader(
			uConn.getInputStream()));
			sb = new StringBuilder();
			String line = null;
			
			while ((line = bd.readLine()) != null) {
				sb.append(line + "\n");
			}

			response = sb.toString();
		} catch (MalformedURLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// close the connection, set all objects to null
			//uConn.disconnect();
			bd = null;
			sb = null;
			uConn = null;
		}

		// if we were interacting with basex as a server, this is how we'd create a session
//			BaseXClient session;
//			try {
//				session = new BaseXClient("labweb.lab1.ciser.cornell.edu", 1984,
//						"admin", "Ba53X4CED2AR");
//				
//				// create query instance				
//				final BaseXClient.Query query = session.query(xquery);
//
//				// loop through all results
//				while (query.more()) {
//					response += query.next();
//				}
//
//				// print query info
//				//System.out.println(query.info());
//
//				// close query instance
//				query.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}

		
		logger.info("Response complete");
		
		StringReader rd = new StringReader("<xml>" + response + "</xml>");
		StringWriter wrt = new StringWriter();
		TransformerFactory tFac = TransformerFactory.newInstance();
		try {
			//in java, files in the 'WEB-INF/classes' directory can be referred to w/o the full unc path
			final ClassPathResource xsl = new ClassPathResource("xsl/ipums-ddi-xslt.xsl");
			
			Transformer transformer = tFac.newTransformer(new StreamSource(xsl.getFile()));
			transformer.transform(new StreamSource(rd), new StreamResult(wrt));
			
			styledResponse = wrt.toString();
		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return styledResponse;
	}
}
