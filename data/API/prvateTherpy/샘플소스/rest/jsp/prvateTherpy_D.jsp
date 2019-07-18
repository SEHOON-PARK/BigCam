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
<title>민간약초</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>민간약초</strong></h3>
<hr>

<%
//민간약초 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="prvateTherpy";
	//오퍼레이션 명
	String operationName="prvateTherpyDtl";

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
	//명칭
	String cntntsSj = null;
	//학명
	String bneNm = null;
	//생약명
	String hbdcNm = null;
	//이용_부위
	String useeRegn = null;
	//형태
	String stle = null;
	//민간_요법
	String prvateTherpy = null;
	//이미지1
	String imgUrl1 = null;
	//이미지2
	String imgUrl2 = null;
	//이미지3
	String imgUrl3 = null;
	//이미지4
	String imgUrl4 = null;
	//이미지5
	String imgUrl5 = null;
	//이미지6
	String imgUrl6 = null;

	try{cntntsNo = doc.getElementsByTagName("cntntsNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsNo = "";}
	try{cntntsSj = doc.getElementsByTagName("cntntsSj").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsSj = "";}
	try{bneNm = doc.getElementsByTagName("bneNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){bneNm = "";}
	try{hbdcNm = doc.getElementsByTagName("hbdcNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){hbdcNm = "";}
	try{useeRegn = doc.getElementsByTagName("useeRegn").item(0).getFirstChild().getNodeValue();}catch(Exception e){useeRegn = "";}
	try{stle = doc.getElementsByTagName("stle").item(0).getFirstChild().getNodeValue();}catch(Exception e){stle = "";}
	try{prvateTherpy = doc.getElementsByTagName("prvateTherpy").item(0).getFirstChild().getNodeValue();}catch(Exception e){prvateTherpy = "";}
	try{imgUrl1 = doc.getElementsByTagName("imgUrl1").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl1 = "";}
	try{imgUrl2 = doc.getElementsByTagName("imgUrl2").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl2 = "";}
	try{imgUrl3 = doc.getElementsByTagName("imgUrl3").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl3 = "";}
	try{imgUrl4 = doc.getElementsByTagName("imgUrl4").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl4 = "";}
	try{imgUrl5 = doc.getElementsByTagName("imgUrl5").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl5 = "";}
	try{imgUrl6 = doc.getElementsByTagName("imgUrl6").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl6 = "";}
%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td colspan="2">
            	<%if(!"".equals(imgUrl1)){ %>
            		<img src="<%=imgUrl1%>" style="max-width:255px; height:auto;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl2)){ %>
            		<img src="<%=imgUrl2%>" style="max-width:255px; height:auto;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl3)){ %>
            		<img src="<%=imgUrl3%>" style="max-width:255px; height:auto;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl4)){ %>
            		<img src="<%=imgUrl4%>" style="max-width:255px; height:auto;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl5)){ %>
            		<img src="<%=imgUrl5%>" style="max-width:255px; height:auto;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl6)){ %>
            		<img src="<%=imgUrl6%>" style="max-width:255px; height:auto;"/>
            	<%}%>
			</td>
		</tr>
		<tr>
			<td>명칭</td>
			<td><%=cntntsSj%></td>
		</tr>
		<tr>
			<td>학명</td>
			<td><%=bneNm%></td>
		</tr>
		<tr>
			<td>생약명</td>
			<td><%=hbdcNm%></td>
		</tr>
		<tr>
			<td>이용부위</td>
			<td><%=useeRegn%></td>
		</tr>
		<tr>
			<td>형태</td>
			<td><%=stle%></td>
		</tr>
		<tr>
			<td>민간요법</td>
			<td><%=prvateTherpy%></td>
		</tr>
	</table>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='prvateTherpyList.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>