<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.*" %>
<html>
<head><title>Hello world from JSP</title></head>
<body>
<%
  InitialContext ctx;
  DataSource ds = null;
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;

  try {
    ctx = new InitialContext();
    ds = (DataSource) ctx.lookup("java:jboss/datasources/ExampleDS");
    conn = ds.getConnection();
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM test");

    while(rs.next()) {
%>
    <p>Name: <%= rs.getString("Name") %>, Num: <%= rs.getString("num") %></p>
<%    
    }
  }
  catch (SQLException se) {
%>
    <p>ERROR: Cannot getting data from table "test". <%= se.getMessage() %></p>
    <p> Please try to access <a href="setup.jsp">setup page</a> first.
<%      
  } catch (NamingException ne) {
%>  
    <%= ne.getMessage() %>
<%
  } finally {
	  try { rs.close(); } catch(Throwable t) {}
	  try { stmt.close(); } catch(Throwable t) {}
	  try { conn.close(); } catch(Throwable t) {}
  }
%>
</body>
</html>