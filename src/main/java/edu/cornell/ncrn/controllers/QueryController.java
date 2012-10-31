package edu.cornell.ncrn.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.cornell.ncrn.service.QueryService;

@Controller
public class QueryController {
	private static final Logger logger = LoggerFactory.getLogger(QueryController.class);

	@Autowired
	private QueryService queryService;

	/**
	 * Handles and retrieves the AJAX query page
	 */
	@RequestMapping(value = "/query", method = RequestMethod.GET)
	public String getAjaxAddPage() {
		logger.debug("Received request to show query page");

		// This will resolve to /WEB-INF/views/query.jsp
		return "query";
	}

	/**
	 * Handles request for adding two numbers
	 */
	@RequestMapping(value = "/query", method = RequestMethod.POST)
	public @ResponseBody String query(@RequestParam(value="xquery", required=true) String xquery) {

		String response = queryService.getXML(xquery);

		return response;
	}
}
