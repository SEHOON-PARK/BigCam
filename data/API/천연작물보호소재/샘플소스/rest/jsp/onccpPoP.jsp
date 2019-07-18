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
<title>화합물 및 참고 문헌리스트</title>
</head>
<body>
<%
if(request.getParameter("check1")!=null && !request.getParameter("check1").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchPlantReferLtrtre";
	
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&lvbNo="+request.getParameter("lvbNo");
	parameter += "&referLtrtreCode="+request.getParameter("referLtrtreCode");

	//리스트 서버와 통신
	URL listApiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream listApiStream = listApiUrl.openStream();
	
	Document listDoc = null;
	try{
		//xml document
		listDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(listApiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		listApiStream.close();
	}
	
	int listSize = 0;
	
	NodeList listItems = null;
	NodeList rnums = null;//번호
	NodeList onccpNms = null;//화합물명
	NodeList elmnWrds = null;//요소명
	NodeList cnDcs = null;//참고문헌
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	
	rnums = listDoc.getElementsByTagName("rnum");
	onccpNms = listDoc.getElementsByTagName("onccpNm");
	elmnWrds = listDoc.getElementsByTagName("elmnWrd");
	cnDcs = listDoc.getElementsByTagName("cnDc");

	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 및 참고 문헌리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="45%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>참고문헌</th>
		</tr>
		
<%
		for(int i=0; i<listSize; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue();
			String onccpNm = onccpNms.item(i).getFirstChild() == null ? "" : onccpNms.item(i).getFirstChild().getNodeValue();
			String elmnWrd = elmnWrds.item(i).getFirstChild() == null ? "" : elmnWrds.item(i).getFirstChild().getNodeValue();
			String cnDc = cnDcs.item(i).getFirstChild() == null ? "" : cnDcs.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=onccpNm%></td>
   			<td><%=elmnWrd%></td>
   			<td><%=cnDc%></td>
		</tr>
<%		
		}
%>
	</table>
<%
	}
}
%>


<%
if(request.getParameter("check2")!=null && !request.getParameter("check2").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchOnccpReferLtrtre";
	
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&onccpNo="+request.getParameter("lvbNo");
	parameter += "&referLtrtreCode="+request.getParameter("referLtrtreCode");

	//리스트 서버와 통신
	URL listApiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream listApiStream = listApiUrl.openStream();
	
	Document listDoc = null;
	try{
		//xml document
		listDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(listApiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		listApiStream.close();
	}
	
	int listSize = 0;
	
	NodeList listItems = null;
	NodeList rnums = null;//번호
	NodeList codeNms = null;//구분
	NodeList cnDcs = null;//참고문헌
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	
	rnums = listDoc.getElementsByTagName("rnum");
	codeNms = listDoc.getElementsByTagName("codeNm");
	cnDcs = listDoc.getElementsByTagName("cnDc");

	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>참고 문헌리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="30%"/>
			<col width="65%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>구분</th>
			<th>참고문헌</th>
		</tr>
		
<%
		for(int i=0; i<listSize; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue();
			String codeNm = codeNms.item(i).getFirstChild() == null ? "" : codeNms.item(i).getFirstChild().getNodeValue();
			String cnDc = cnDcs.item(i).getFirstChild() == null ? "" : cnDcs.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=codeNm%></td>
   			<td><%=cnDc%></td>
		</tr>
<%		
		}
%>
	</table>
<%
	}
}
%>

<%
if(request.getParameter("check3")!=null && !request.getParameter("check3").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchOnccpLvb";
	
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&onccpNo="+request.getParameter("lvbNo");
	parameter += "&referLtrtreCode="+request.getParameter("referLtrtreCode");

	//리스트 서버와 통신
	URL listApiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream listApiStream = listApiUrl.openStream();
	
	Document listDoc = null;
	try{
		//xml document
		listDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(listApiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		listApiStream.close();
	}
	
	int listSize = 0;
	
	NodeList listItems = null;
	NodeList rnums = null;//번호
	NodeList fmlNms = null;//과명
	NodeList bneNms = null;//학명
	NodeList yeastNms = null;//국명
	NodeList rms = null;//비고
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	
	rnums = listDoc.getElementsByTagName("rnum");
	fmlNms = listDoc.getElementsByTagName("fmlNm");
	bneNms = listDoc.getElementsByTagName("bneNm");
	yeastNms = listDoc.getElementsByTagName("yeastNm");
	rms = listDoc.getElementsByTagName("rm");


	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>생물자원리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="20%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
		</tr>
		
<%
		for(int i=0; i<listSize; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue();
			String fmlNm = fmlNms.item(i).getFirstChild() == null ? "" : fmlNms.item(i).getFirstChild().getNodeValue();
			String bneNm = bneNms.item(i).getFirstChild() == null ? "" : bneNms.item(i).getFirstChild().getNodeValue();
			String yeastNm = yeastNms.item(i).getFirstChild() == null ? "" : yeastNms.item(i).getFirstChild().getNodeValue();
			String rm = rms.item(i).getFirstChild() == null ? "" : rms.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=fmlNm%></td>
   			<td><%=bneNm%></td>
   			<td><%=yeastNm%></td>
   			<td><%=rm%></td>
		</tr>
<%		
		}
%>
	</table>
<%
	}
}
%>

<%
if(request.getParameter("check4")!=null && !request.getParameter("check4").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="";
	
 	if(request.getParameter("check4").equals("statInsect")){
		serviceAction="statInsectLst";
	}else if(request.getParameter("check4").equals("statMicroorganism")){
		serviceAction="statMicroorganismLst";
	}else if(request.getParameter("check4").equals("statPlant")){
		serviceAction="statPlantLst";
	}

	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&fmlNo="+request.getParameter("lvbNo");
	parameter += "&cntCode="+request.getParameter("cntCode");
	
	System.out.println(parameter);

	//리스트 서버와 통신
	URL listApiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream listApiStream = listApiUrl.openStream();
	
	Document listDoc = null;
	try{
		//xml document
		listDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(listApiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		listApiStream.close();
	}
	
	int listSize = 0;
	
	NodeList listItems = null;
	NodeList rnums = null;//번호
	NodeList fmlNms = null;//과명
	NodeList bneNms = null;//학명
	NodeList yeastNms = null;//국명
	NodeList rms = null;//비고
	NodeList cnts = null;//화합물수
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	
	rnums = listDoc.getElementsByTagName("rnum");
	fmlNms = listDoc.getElementsByTagName("fmlNm");
	bneNms = listDoc.getElementsByTagName("bneNm");
	yeastNms = listDoc.getElementsByTagName("yeastNm");
	rms = listDoc.getElementsByTagName("rm");
	cnts = listDoc.getElementsByTagName("cnt");


	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>생물자원리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
			<th>화합물수</th>
		</tr>
		
<%
		for(int i=0; i<listSize; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue();
			String fmlNm = fmlNms.item(i).getFirstChild() == null ? "" : fmlNms.item(i).getFirstChild().getNodeValue();
			String bneNm = bneNms.item(i).getFirstChild() == null ? "" : bneNms.item(i).getFirstChild().getNodeValue();
			String yeastNm = yeastNms.item(i).getFirstChild() == null ? "" : yeastNms.item(i).getFirstChild().getNodeValue();
			String rm = rms.item(i).getFirstChild() == null ? "" : rms.item(i).getFirstChild().getNodeValue();
			String cnt = cnts.item(i).getFirstChild() == null ? "" : cnts.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=fmlNm%></td>
   			<td><%=bneNm%></td>
   			<td><%=yeastNm%></td>
   			<td><%=rm%></td>
   			<td><%=cnt%></td>
		</tr>
<%		
		}
%>
	</table>
<%
	}
}
%>
</body>
</html>