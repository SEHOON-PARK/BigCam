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
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<%
//Term
if(request.getParameter("faoCode")!=null && !request.getParameter("faoCode").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="thesaurusDtlTerm";

	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&faoCode="+request.getParameter("faoCode");

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
	NodeList languageCodes = null;//언어 코드
	NodeList languageCodeNms = null;//언어코드명
	NodeList termSpells = null;//용어

	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();

	languageCodes = listDoc.getElementsByTagName("languageCode");
	languageCodeNms = listDoc.getElementsByTagName("languageCodeNm");
	termSpells = listDoc.getElementsByTagName("termSpell");

	if(listSize!=0){
%>
<div style="float: left; width: 49%; margin-right: 10px">
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Term</th>
		</tr>

<%
		for(int i=0; i<listSize; i++){
			String languageCodeNm = languageCodeNms.item(i).getFirstChild() == null ? "" : languageCodeNms.item(i).getFirstChild().getNodeValue();
			String languageCode = languageCodes.item(i).getFirstChild() == null ? "" : languageCodes.item(i).getFirstChild().getNodeValue();
			String termSpell = termSpells.item(i).getFirstChild() == null ? "" : termSpells.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><%=termSpell%>(<%=languageCodeNm%>)</td>
		</tr>
<%
		}
%>
	</table>
</div>
<%
	}
}
%>
<div style="float: left; width: 49%">
<%
//Word Tree
if(request.getParameter("faoCode")!=null && !request.getParameter("faoCode").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="thesaurusDtlWordTree";

	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&faoCode="+request.getParameter("faoCode");

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
	NodeList linkAbrs = null;//언어 코드
	NodeList termSpells = null;//용어
	NodeList termCode2s = null;//용어 코드

	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();

	linkAbrs = listDoc.getElementsByTagName("linkAbr");
	termSpells = listDoc.getElementsByTagName("termSpell");
	termCode2s = listDoc.getElementsByTagName("termCode2");

	if(listSize!=0){
%>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Word Tree</th>
		</tr>

<%
		for(int i=0; i<listSize; i++){
			String linkAbr = linkAbrs.item(i).getFirstChild() == null ? "" : linkAbrs.item(i).getFirstChild().getNodeValue();
			String termSpell = termSpells.item(i).getFirstChild() == null ? "" : termSpells.item(i).getFirstChild().getNodeValue();
			String termCode2 = termCode2s.item(i).getFirstChild() == null ? "" : termCode2s.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><%=linkAbr%>&nbsp;&nbsp;<%=termSpell%>(<%=termCode2%>)</td>
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
//Scope Notes
if(request.getParameter("faoCode")!=null && !request.getParameter("faoCode").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="thesaurusDtlScopeNotes";

	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&faoCode="+request.getParameter("faoCode");

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
	NodeList tagDescs = null;
	NodeList tagTexts = null;

	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();

	tagDescs = listDoc.getElementsByTagName("tagDesc");
	tagTexts = listDoc.getElementsByTagName("tagText");

	if(listSize!=0){
%>
	<br>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Scope Notes</th>
		</tr>
<%
		for(int i=0; i<listSize; i++){
			String tagDesc = tagDescs.item(i).getFirstChild() == null ? "" : tagDescs.item(i).getFirstChild().getNodeValue();
			String tagText = tagTexts.item(i).getFirstChild() == null ? "" : tagTexts.item(i).getFirstChild().getNodeValue();
%>
		<tr>
   			<td><strong><%=tagDesc%></strong>&nbsp;&nbsp;<%=tagText%></td>
		</tr>
<%
		}
%>
	</table>
<%
	}
}
%>

</div>
</body>
</html>