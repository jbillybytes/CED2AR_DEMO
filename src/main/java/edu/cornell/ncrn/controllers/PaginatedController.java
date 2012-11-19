package edu.cornell.ncrn.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.cornell.ncrn.service.PaginatedService;

@Controller
public class PaginatedController {
	private static final Logger logger = LoggerFactory.getLogger(PaginatedController.class);

	@Autowired
	private PaginatedService paginatedService;

	/**
	 * Handles and retrieves the AJAX query page
	 */
	@RequestMapping(value = "/paginated", method = RequestMethod.GET)
	public String getAjaxAddPage() {
		logger.debug("Received request to show paginated page");

		// This will resolve to /WEB-INF/views/paginated.jsp
		return "paginated";
	}

	/**
	 * Handles request for adding two numbers
	 */
	@RequestMapping(value = "/paginated", method = RequestMethod.POST)
	public @ResponseBody String query(@RequestParam(value="xquery", required=true) String xquery, @RequestParam(value="paginate", required=true) String paginate, @RequestParam(value="page", required=true) String page) {
logger.info(paginate + " | " + page);
		String response = paginatedService.getXML(xquery, paginate.toLowerCase().equals("true"), page);

		return response;
	}
}
