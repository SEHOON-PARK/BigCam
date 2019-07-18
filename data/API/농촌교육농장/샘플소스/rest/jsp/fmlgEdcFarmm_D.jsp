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
<title>농촌교육농장</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농촌교육농장</strong></h3>
<hr>

<%
//농촌교육농장 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="fmlgEdcFarmm";
	//오퍼레이션 명
	String operationName="fmlgEdcFarmmDtl";

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
	//소재지
	String locplc = null;
	//주체
	String thema = null;
	//지정연도
	String appnYear = null;
	//홈페이지주소
	String url = null;
	//연락처
	String telno = null;
	//내용
	String cn = null;
	//품질인증연도
	String crtfcYearInfo = null;

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
	try{locplc = doc.getElementsByTagName("locplc").item(0).getFirstChild().getNodeValue();}catch(Exception e){locplc = "";}
	try{thema = doc.getElementsByTagName("thema").item(0).getFirstChild().getNodeValue();}catch(Exception e){thema = "";}
	try{appnYear = doc.getElementsByTagName("appnYear").item(0).getFirstChild().getNodeValue();}catch(Exception e){appnYear = "";}
	try{url = doc.getElementsByTagName("url").item(0).getFirstChild().getNodeValue();}catch(Exception e){url = "";}
	try{telno = doc.getElementsByTagName("telno").item(0).getFirstChild().getNodeValue();}catch(Exception e){telno = "";}
	try{crtfcYearInfo = doc.getElementsByTagName("crtfcYearInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){crtfcYearInfo = "";}
	try{cn = doc.getElementsByTagName("cn").item(0).getFirstChild().getNodeValue();}catch(Exception e){cn = "";}
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
			<td>제목</td>
			<td><%=cntntsSj%></td>
		</tr>
		<tr>
			<td>소재지</td>
			<td><%=locplc%></td>
		</tr>
		<tr>
			<td>주제</td>
			<td><%=thema%></td>
		</tr>
		<tr>
			<td>지정연도</td>
			<td><%=appnYear%></td>
		</tr>
		<tr>
			<td>홈페이지주소</td>
			<td><%=url%></td>
		</tr>
		<tr>
			<td>연락처</td>
			<td><%=telno%></td>
		</tr>
		<tr>
			<td>품질인증연도</td>
			<td><%=crtfcYearInfo%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=cn%></td>
		</tr>
	</table>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='fmlgEdcFarmmList.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>