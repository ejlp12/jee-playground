<%@page import="java.util.Random"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.*" %>
<html>
<head><title>Hello world from JSP</title></head>
<body>
<%
  InitialContext ctx = new InitialContext();
  DataSource ds = null;
  Connection conn= null;
  Statement stmt = null;

  try {
    ds = (DataSource) ctx.lookup("java:jboss/datasources/ExampleDS");
    conn = ds.getConnection();
    stmt = conn.createStatement();
    stmt.execute("DROP TABLE test");
  } catch (SQLException se) {
%>	  
	  <p>ERROR: Cannot drop table ""test". <%= se.getMessage() %></p>
<% 
  } 
  
  Random random = new Random();
  
  try {
    stmt.execute("CREATE TABLE test (name VARCHAR(255), num INT)");
    for (int i = 0; i < 10000; i++) {
    	stmt.executeUpdate("INSERT INTO test VALUES ('"  + java.util.UUID.randomUUID().toString() + "', " + random.nextInt(10000) + ")");    
    }
%>
    <p>Successfully created table "test" and inserting some data.</p>
<%
  } catch (SQLException se) {
%>
   <p> ERROR: Cannot create table "test" or insert into it. <%= se.getMessage() %></p>
   
<%      
  } finally {
	  try {
		  stmt.close();
		  conn.close();
	  } catch(Throwable t) {
		  
	  }
  }
%>
</body>
</html>