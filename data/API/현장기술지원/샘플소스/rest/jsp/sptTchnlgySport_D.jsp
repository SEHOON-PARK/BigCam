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
<title>현장기술지원</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>현장기술지원</strong></h3>
<hr>

<%
//현장기술지원 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="sptTchnlgySport";
	//오퍼레이션 명
	String operationName="sptTchnlgySportView";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&cntntsNo="+ request.getParameter("cntntsNo");

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	Document doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	//키값
	String cntntsNo = null;
	//제목
	String cntntsSj = null;
	//장소
	String placeInfo = null;
	//기술지원일
	String regDt = null;
	//조회수
	String rdcnt = null;
	//작성자
	String wrterNm = null;
	//품목
	String prdlstCodeNm = null;
	//내용
	String cn = null;

	try{cntntsNo = doc.getElementsByTagName("cntntsNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsNo = "";}
	try{cntntsSj = doc.getElementsByTagName("cntntsSj").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsSj = "";}
	try{placeInfo = doc.getElementsByTagName("placeInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){placeInfo = "";}
	try{regDt = doc.getElementsByTagName("regDt").item(0).getFirstChild().getNodeValue();}catch(Exception e){regDt = "";}
	try{rdcnt = doc.getElementsByTagName("rdcnt").item(0).getFirstChild().getNodeValue();}catch(Exception e){rdcnt = "";}
	try{wrterNm = doc.getElementsByTagName("wrterNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){wrterNm = "";}
	try{prdlstCodeNm = doc.getElementsByTagName("prdlstCodeNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){prdlstCodeNm = "";}
	try{cn = doc.getElementsByTagName("cn").item(0).getFirstChild().getNodeValue();}catch(Exception e){cn = "";}
%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
			<col width="20%">
			<col width="*">
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td>제목</td>
			<td colspan="5"><%=cntntsSj%></td>
		</tr>
		<tr>
			<td>품목</td>
			<td colspan="5"><%=prdlstCodeNm%></td>
		</tr>
		<tr>
			<td>장소</td>
			<td colspan="5"><%=placeInfo%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=wrterNm%></td>
			<td>기술지원일</td>
			<td><%=regDt%></td>
			<td>조회수</td>
			<td><%=rdcnt%></td>
		</tr>
		<tr>
			<td colspan="6"><%=cn%></td>
		</tr>

	</table>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='sptTchnlgySport.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>