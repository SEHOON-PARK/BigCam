<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.net.URL"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>식물(계열,생리작용별)</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>식물(계열,생리작용별)</strong></h3><hr>

<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="statInsectLine";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	
	//메인카테고리 서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();
	
	Document mainDoc = null;
	try{
		//xml document
		mainDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}
	
	int size = 0;
	
	NodeList items = null;

	
	NodeList tabs=null;//구분        
	NodeList codes=null;//계열코드   
	NodeList codeNms=null;//계열코드명  
	NodeList cnts=null;//화합물 수    
	NodeList ratios=null;//비율    
	
	items = mainDoc.getElementsByTagName("item");
	size = mainDoc.getElementsByTagName("item").getLength();
	
	tabs = mainDoc.getElementsByTagName("tab");
	codes = mainDoc.getElementsByTagName("code");
	codeNms = mainDoc.getElementsByTagName("codeNm");
	cnts = mainDoc.getElementsByTagName("cnt");
	ratios = mainDoc.getElementsByTagName("ratio");
	
	if(size==0){
%>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
		
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
		<col width="33%" />
		<col width="%" />
		<col width="33%" />
	</colgroup>
      <thead>
         <tr>
			<th scope="col" >계열</th>
			<th scope="col" >화합물 수</th>
			<th scope="col" >비율</th>
         </tr>
       </thead>
       <tbody>
       <%
       
       for(int i=0; i<size; i++){
			String tab = tabs.item(i).getFirstChild() == null ? "" : tabs.item(i).getFirstChild().getNodeValue();
			String code = codes.item(i).getFirstChild() == null ? "" : codes.item(i).getFirstChild().getNodeValue();
			String codeNm = codeNms.item(i).getFirstChild() == null ? "" : codeNms.item(i).getFirstChild().getNodeValue();
			String cnt = cnts.item(i).getFirstChild() == null ? "" :cnts.item(i).getFirstChild().getNodeValue();
			String ratio = ratios.item(i).getFirstChild() == null ? "" : ratios.item(i).getFirstChild().getNodeValue();
			 if (tab.equals("ALL")) {
      	 %>
		<tr>
		    <% if (code.equals("TOTAL")) {  %>
		       <td align="center"><%=code%></td>
		    <% } else {  %>
		    	<td align="center"><%=codeNm%></td>
		    <% } %>
			<td align="center"><%=cnt%></td>
			<td align="center"><%=ratio%></td>
		<tr>
		<% }
		 }%>
	</table>
		<%		
	}
}
%>
</body>
</html>