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
<title>진로체험</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>진로체험</strong></h3>
<hr>

<%
//인테러뱅 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="schoolGarden";
	//오퍼레이션 명
	String operationName="schoolGardenDtl";

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

	//제목
	String cntntsSj = null;
	//내용
	String cn = null;
	//관련동영상
	String linkUrl = null;
	//활동목적
	String actGoalDtl = null;
	//원예활동
	String gardnactDtl = null;
	//파일 다운로드 URL
	String downUrl = null;
	//파일명
	String fileName = null;

	try{cntntsSj = doc.getElementsByTagName("cntntsSj").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsSj = "";}
	try{cn = doc.getElementsByTagName("cn").item(0).getFirstChild().getNodeValue();}catch(Exception e){cn = "";}
	try{linkUrl = doc.getElementsByTagName("linkUrl").item(0).getFirstChild().getNodeValue();}catch(Exception e){linkUrl = "";}
	try{actGoalDtl = doc.getElementsByTagName("actGoalDtl").item(0).getFirstChild().getNodeValue();}catch(Exception e){actGoalDtl = "";}
	try{gardnactDtl = doc.getElementsByTagName("gardnactDtl").item(0).getFirstChild().getNodeValue();}catch(Exception e){gardnactDtl = "";}
	try{downUrl = doc.getElementsByTagName("downUrl").item(0).getFirstChild().getNodeValue();}catch(Exception e){downUrl = "";}
	try{fileName = doc.getElementsByTagName("fileName").item(0).getFirstChild().getNodeValue();}catch(Exception e){fileName = "";}

	String[] s_downUrl=downUrl.split(";");
	String[] s_fileName=fileName.split(";");

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<th colspan="2"><%=cntntsSj%></th>
		</tr>
		<tr>
			<td>활동목적</td>
			<td><%=actGoalDtl%></td>
		</tr>
		<tr>
			<td>원예활동</td>
			<td><%=gardnactDtl%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
<%
			for(int j=0; j<s_downUrl.length; j++){
%>
				<a href="<%=s_downUrl[j]%>"><%=s_fileName[j]%></a>&nbsp;
<%
			}
%>
			</td>
		<tr>
			<td>관련동영상</td>
			<td><a target="_blank" href="<%=linkUrl%>"><%=linkUrl%></a></td>
		</tr>
		</tr>
	</table>
	<%=cn%>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='schoolGarden.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>