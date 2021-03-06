/*
This servlet checks to see if a company should be added or deleted based on the post 
This servlet created a Company bean and stores it to the mysql database as well as 
taking user input to delete the company from the database
*/

package business;

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

//Business and data handling classes
import business.Company;
import data.CompanyDB;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class EditCompanyInfoServlet extends HttpServlet
{    

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
                          throws ServletException, IOException
    {
				
		String editCompanyName =request.getParameter("name");
		String editCompany= request.getParameter("editCompany");
		Company currentCompany = CompanyDB.selectCompany(editCompanyName);
		// store the company object in the request object that should be edited
	    request.setAttribute("currentCompany", currentCompany);
		
        //initialize helper variables
	    Company company = new Company();
	    Boolean updateCompany=false;
	    String addCompanyName="";
	    String addCompanyCity="";
	    String addCompanyState="";
	    String addCompanyDescription="";
	    FileItem addCompanyLogo=null;    
	    String url="";
	    String message="";
	
	    // Create a factory for disk-based file items
        FileItemFactory factory = new DiskFileItemFactory();
         // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // Parse the request
        List<FileItem> items;
	
	
        try {			
		items = upload.parseRequest(request);	
		
		// Process the uploaded items in form
        // We don't know what the strings are in this field so we need an iterator to go through them 
    	Iterator<FileItem> iter = items.iterator();
    
    	while (iter.hasNext()) {
                    	
        	FileItem item = (FileItem) iter.next();
            
        	// If items in form is not a field, it will be our uploaded image file
            if (!item.isFormField()&&item.getSize()!=0) {
            	addCompanyLogo=item;
            }
            
            // If the item is a field, figure out which it is and add it to the company field 
            if(item.isFormField())
            {
            	if (item.getFieldName().equals("name")) {
                    addCompanyName = item.getString();
                    System.out.println("This is the name of the company:" + addCompanyName);
                }
            	else if(item.getFieldName().equals("city"))
            	{
                    addCompanyCity = item.getString();
                    System.out.println("This is the name of the city:" + addCompanyCity);
            	}
            	else if(item.getFieldName().equals("state"))
            	{
                    addCompanyState = item.getString();
                    System.out.println("This is the name of the state:" + addCompanyState);
            	}
            	else if(item.getFieldName().equals("description"))
            	{
                    addCompanyDescription = item.getString();
                    System.out.println("The description is:" + addCompanyDescription);
            	}
            	else if(item.getFieldName().equals("updateCompany"))
            	{
                    // If add company field exists add company  
            		updateCompany=true;	
            	}
            	
            	
             }
         }
  		
		 } catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		 }	
		
	
        //If we have a company to edit then dispatch to JSP company info
        if(editCompany!=null && editCompany.equals("Edit")){
	    	url="/edit_company.jsp";
	    	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
	    	dispatcher.forward(request, response);              	        
	    }
        
        //if we are updating a company and any fields are blank then error message
        if(updateCompany==true && (addCompanyCity.length()==0||addCompanyState.length()==0||addCompanyDescription.length()==0))
        {
               	message="Please complete all fields.";
               	url="/edit_company.jsp";
               	Company reviseDataCompany = CompanyDB.selectCompany(addCompanyName);
               	request.setAttribute("currentCompany", reviseDataCompany);
               	System.out.println("Made it");
        }
        //If we are not displaying a company to edit and we are updating information,
        //create company object and store to DB
        else
	    {
	
        	company.setName(addCompanyName);
        	company.setCity(addCompanyCity);
	        company.setState(addCompanyState);
            company.setDescription(addCompanyDescription);
        	company.setLogo(addCompanyLogo);
		        
	        CompanyDB.update(company);	
	    
	        message="";
	        // Get array of all companies from database
			ArrayList<Company> companyList = CompanyDB.selectCompanies();
		    // store the company object in the request object
		    request.setAttribute("companyList", companyList);
		    url="/index.jsp";
		    
        }

         
        request.setAttribute("message", message);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);              	        
 	
 }//post Method
	
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	 doPost(request, response);
    //All get requests get forwarded to POST
 }

	
	
}//class
