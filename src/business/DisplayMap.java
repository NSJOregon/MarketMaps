package business;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

//Business and data handling classes
import business.Company;
import data.CompanyDB;
/**
 * This servlet is called upon loading the site and passes an array of all the companies in the database
 * and passes it to the landing page jsp for map display
 */
public class DisplayMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayMap() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// Get array of all companies from database
				ArrayList<Company> companyList = CompanyDB.selectCompanies();
			    // store the company object in the request object
			    request.setAttribute("companyList", companyList);
		
		 String url="/landing.jsp";
		    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		    dispatcher.forward(request, response);   
		
	}

}
