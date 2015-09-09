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
		// store the company object in the request object
	    request.setAttribute("currentCompany", currentCompany);
		
	    if(editCompany!=null && editCompany.equals("Edit")){
	    	String url="/edit_company.jsp";
	    	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
	    	dispatcher.forward(request, response);              	        
	    }
	    
		String deleteCompany=new String("");
		//Get name of company to delete from Database
		deleteCompany =request.getParameter("removeCompany");
		String deleteCompanyName=request.getParameter("name");

		//If delete field exists, we want to delete company
		if(deleteCompany!=null)
		{
			CompanyDB.delete(deleteCompanyName);		
		}
		
		
		//Create company fields for listing all items in index of all companies
	    
	    Company company = new Company();
	    Boolean updateCompany=false;
	    String addCompanyName="";
	    String addCompanyCity="";
	    String addCompanyState="";
	    String addCompanyDescription="";
	    FileItem addCompanyLogo=null;    
	    
	
	    // Create a factory for disk-based file items
        FileItemFactory factory = new DiskFileItemFactory();
         // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // Parse the request
        List<FileItem> items;
	
	
        try {			
		items = upload.parseRequest(request);	
		
		// Process the uploaded items in form
        // We don't know what the strings are in this field so we need an interator to go through them 
    	Iterator<FileItem> iter = items.iterator();
    
    	while (iter.hasNext()) {
                    	
        	FileItem item = (FileItem) iter.next();
            
        	// If items in form is not a field, it will be our uploaded image file
            if (!item.isFormField()) {
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
		
        
        
        	if(updateCompany==true){

	        	company.setName(addCompanyName);
	        	company.setCity(addCompanyCity);
		        company.setState(addCompanyState);
	            company.setDescription(addCompanyDescription);
		        if(addCompanyLogo.getSize()!=0){
//		        if(addCompanyLogo!=null){
		        company.setLogo(addCompanyLogo);
	        }
	        
	        CompanyDB.update(company);	
    
	        
	        // Get array of all companies from database
			ArrayList<Company> companyList = CompanyDB.selectCompanies();
		    // store the company object in the request object
		    request.setAttribute("companyList", companyList);
		    String url="/index.jsp";
		    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		    dispatcher.forward(request, response);              	        
		
        
        }
             
        
        
	       
		
		}//post Method
	
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	 doPost(request, response);
    //All get requests get forwarded to POST
 }

	
	
}//class
