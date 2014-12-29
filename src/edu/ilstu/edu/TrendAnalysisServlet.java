package edu.ilstu.edu;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.nio.charset.StandardCharsets;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.FileTime;

/**
 * Servlet implementation class TrendAnalysisServlet
 */
@WebServlet("/TrendAnalysisServlet")
public class TrendAnalysisServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Connection con = null;
	private Statement stmt = null;
//	private PreparedStatement preparedStatement = null;
	private ResultSet res = null;
	private static int count = 1;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrendAnalysisServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

		
		 String hiveHostName = "127.0.0.1"; //change this ip address if required
		 String hiveForwardedPort = "2200"; //this is the port number, which is configured to forward to Sandbox's 10000 port

		 try {
	         String driverName = "org.apache.hive.jdbc.HiveDriver";
	         Class.forName(driverName);
	         } 
		 
		 catch (ClassNotFoundException e) {
	           // TODO Auto-generated catch block
	           e.printStackTrace();
	           System.exit(1);
	         }
		 try
		 {
			 String subCategory1= request.getParameter("subCategory1");
			 String subCategory2= request.getParameter("subCategory2");
			 String startDate= request.getParameter("startDate");
			 String endDate= request.getParameter("endDate");
			 
			 con = DriverManager.getConnection("jdbc:hive2://"+hiveHostName + ":" +hiveForwardedPort + "/wiki", "hue", "");
	         stmt = con.createStatement();
	        
			 runQuery(subCategory1, startDate, endDate, response);
			 runQuery(subCategory2, startDate, endDate, response);
			
			 PrintWriter out = response.getWriter();

			 //out.println(subCategory1+" "+subCategory1+" "+startDate+" "+endDate);
			 forward(request, response, "/graph.jsp");
	        
		 }
		 catch(SQLException e)
		 {
			e.printStackTrace(); 
		 }
		 
	        
	}
	
	protected void runQuery(String subCategory,String startDate,String endDate, HttpServletResponse response ) throws SQLException, IOException
	{
		// String sql = " select * from wiki.wikitable limit 5";
		String sql = "SELECT SUM(hits),searchdate FROM wiki.wikitable WHERE term LIKE '%"+ subCategory+"%'AND ( searchdate BETWEEN '"+startDate+"' AND '"+endDate+"' ) GROUP BY searchdate";
	     res = stmt.executeQuery(sql); 
	     StringBuilder FileOne = new StringBuilder();
	     String lineSeparator = System.getProperty("line.separator", "\r\n");
	     FileOne.append("date,hits");
	     FileOne.append(lineSeparator);
         while(res.next())
         {
//        	int hits = res.getInt(2);
//         	String date = res.getString(1);
        	int hits = res.getInt(1);
        	String date = res.getString(2);
        	FileOne.append(date+","+hits);
        	FileOne.append(lineSeparator);
        	
         }	
         
         String fileData = FileOne.toString();
         writeToFile(fileData);
         
	}
	
	protected void writeToFile(String fileData) throws IOException
	{
		String path = "C:\\Users\\abhishek0066\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\TrendAnalysisTool";
		Path sourceDirectoryPath = Paths.get(path);
		
		Path filePath = sourceDirectoryPath.resolve("Summary"+count+".csv");

		byte[] finalData = fileData.getBytes(StandardCharsets.UTF_8);

		Files.write(filePath, finalData);

		System.out.println("Summary file:  " + filePath);
		count++;
		
	}
	
	private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException
	{
		ServletContext context = request.getServletContext();

		RequestDispatcher dispatcher = context.getRequestDispatcher(path);

		dispatcher.forward(request, response);
	}
	

	}


