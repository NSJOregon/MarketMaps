/* CompanyDB.java
 * Company DB Class adds, removes, changes, and checks whether companies are present
 * From the connection pool gets a connection and changes the SQL table
 * 
 */

package data;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.commons.fileupload.FileItem;

import business.Company;

public class CompanyDB
{
    public static int insert(Company company) throws IOException
    {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;

        String query = 
                "INSERT INTO Company (Name, Latitude, Longitude, Address, City, State, Zipcode, Phonenumber, Email, Description, Owner, Logo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try
        {        
            ps = connection.prepareStatement(query);
                      
            ps.setString(1, company.getName());
            ps.setString(2, company.getLatitude());
            ps.setString(3, company.getLongitude());
            ps.setString(4, company.getAddress());
            ps.setString(5, company.getCity());
            ps.setString(6, company.getState());
            ps.setString(7, company.getZipcode());
            ps.setString(8, company.getPhonenumber());
            ps.setString(9, company.getEmail());
            ps.setString(10, company.getDescription());
            ps.setString(11, company.getOwner());
            ps.setBinaryStream(12, company.getLogo().getInputStream(), (int) company.getLogo().getSize());   
            return ps.executeUpdate();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            return 0;
        }
        finally
        {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public static int update(Company company)
    {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        if(company.getLogo()!=null)
	    {
	        String query = "UPDATE Company SET Latitude = ?, Longitude = ?, Address = ?, City = ?, State = ?, Zipcode = ?, Phonenumber = ?, Email = ?, Description = ?, Owner = ?, Logo = ? WHERE Name = ?";
	     
	              
	        try
	        {
	            ps = connection.prepareStatement(query);
	            ps.setString(1, company.getLatitude());
	            ps.setString(2, company.getLongitude());
	            ps.setString(3, company.getAddress());
	            ps.setString(4, company.getCity());
	            ps.setString(5, company.getState());
	            ps.setString(6, company.getZipcode());
	            ps.setString(7, company.getPhonenumber());
	            ps.setString(8, company.getEmail());
	            ps.setString(9, company.getDescription());
	            ps.setString(10, company.getOwner());
	            ps.setBinaryStream(11, company.getLogo().getInputStream(), (int) company.getLogo().getSize());
	            ps.setString(12, company.getName());            
	            return ps.executeUpdate();
	        }
	        catch(SQLException e)
	        {
	            e.printStackTrace();
	            return 0;
	        } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
	        finally
	        {
	            DBUtil.closePreparedStatement(ps);
	            pool.freeConnection(connection);
	        }
        }
        
        if(company.getLogo()==null)
	    {
	        String query = "UPDATE Company SET Latitude = ?, Longitude = ?, Address = ?, City = ?, State = ?, Zipcode = ?, Phonenumber = ?, Email = ?, Description = ?, Owner = ? WHERE Name = ?";
	     
	              
	        try
	        {
	            ps = connection.prepareStatement(query);
	          
	            ps.setString(1, company.getLatitude());
	            ps.setString(2, company.getLongitude());
	            ps.setString(3, company.getAddress());
	            ps.setString(4, company.getCity());
	            ps.setString(5, company.getState());
	            ps.setString(6, company.getZipcode());
	            ps.setString(7, company.getPhonenumber());
	            ps.setString(8, company.getEmail());
	            ps.setString(9, company.getDescription());
	            ps.setString(10, company.getOwner());
	            ps.setString(11, company.getName());            
	            return ps.executeUpdate();
	        }
	        catch(SQLException e)
	        {
	            e.printStackTrace();
	            return 0;
	        } 
	        finally
	        {
	            DBUtil.closePreparedStatement(ps);
	            pool.freeConnection(connection);
	        }
	    	
        }
        return 0;
    }
    
    public static int delete(String companyName)
    {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        
        String query = "DELETE FROM company " +
                "WHERE Name = ?";
        try
        {
            ps = connection.prepareStatement(query);
            ps.setString(1, companyName);

            return ps.executeUpdate();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            return 0;
        }
        finally
        {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    /*
    public static boolean emailExists(String emailAddress)
    {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = "SELECT EmailAddress FROM User " +
                "WHERE EmailAddress = ?";
        try
        {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            rs = ps.executeQuery();
            return rs.next();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            return false;
        }
        finally
        {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    */
    public static ArrayList<Company> selectCompanies()
    {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = "SELECT * FROM Company";
        try
        {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
     
            
            ArrayList<Company> companyList = new ArrayList<Company>(7);
            
            Company company = null;
            while (rs.next())
            {
            	company = new Company();
            	company.setName(rs.getString("Name"));
               	company.setLatitude(rs.getString("Latitude"));
            	company.setLongitude(rs.getString("Longitude"));
            	company.setAddress(rs.getString("Address"));
            	company.setCity(rs.getString("City"));
            	company.setState(rs.getString("State"));
              	company.setZipcode(rs.getString("Zipcode"));
              	company.setPhonenumber(rs.getString("Phonenumber"));
              	company.setEmail(rs.getString("Email"));
              	company.setDescription(rs.getString("Description"));
              	company.setOwner(rs.getString("Owner"));
                
              
           //   	File image = new File("Logo.jpg");
          //      FileOutputStream fos;
				try {
			//		fos = new FileOutputStream(image);
				 
            //    byte[] buffer = new byte[1024];
                
                InputStream is = rs.getBinaryStream("Logo");
      
                BufferedImage bufimage=ImageIO.read(is);
                company.setImg(bufimage);
                
                //while(is.read(buffer)>0){
               // 	fos.write(buffer);
                	
               // }

                //fos.close();
       //     }
       //     catch (FileNotFoundException e) {
//					// TODO Auto-generated catch block
	//				e.printStackTrace();
				}
				catch (IOException e)
				{}
				
              	companyList.add(company);
            }
            return companyList;
        }
        catch (SQLException e){
            e.printStackTrace();
            return null;
        }        
        finally
        {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
           if(connection!=null)
            pool.freeConnection(connection);
        }
    }


    public static Company selectCompany(String name)
    {
    	   ConnectionPool pool = ConnectionPool.getInstance();
           Connection connection = pool.getConnection();
           PreparedStatement ps = null;
           ResultSet rs = null;
           
           String query = "SELECT * FROM company " +
                          "WHERE Name = ?";
           try
           {
               ps = connection.prepareStatement(query);
               ps.setString(1, name);
               rs = ps.executeQuery();
               Company company = null;
               if (rs.next())
               {
                    company = new Company();
                    company.setName(rs.getString("Name"));
                    company.setLatitude(rs.getString("Latitude"));
                	company.setLongitude(rs.getString("Longitude"));
                	company.setAddress(rs.getString("Address"));
                	company.setCity(rs.getString("City"));
                	company.setState(rs.getString("State"));
                 	company.setZipcode(rs.getString("Zipcode"));
                 	company.setPhonenumber(rs.getString("Phonenumber"));
                 	company.setEmail(rs.getString("Email"));
                 	company.setDescription(rs.getString("Description"));
                 	company.setOwner(rs.getString("Owner"));           
                 	
               
               
               
            		try {
                            InputStream is = rs.getBinaryStream("Logo");
 
                            BufferedImage bufimage=ImageIO.read(is);
                            company.setImg(bufimage);
          				}
           				catch (IOException e)
           				{}
      
               
               		}

                    return company;
           }
           catch (SQLException e){
               e.printStackTrace();
               return null;
           }        
           finally
           {
               DBUtil.closeResultSet(rs);
               DBUtil.closePreparedStatement(ps);
               pool.freeConnection(connection);
           }
   }
    
    
}