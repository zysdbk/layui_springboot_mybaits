<%
if(session.getAttribute("sessionId") == null){
	
	response.sendRedirect("index");
}
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>