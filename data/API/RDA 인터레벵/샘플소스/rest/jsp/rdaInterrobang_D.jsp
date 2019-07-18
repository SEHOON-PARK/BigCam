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
<title>RDA 인테러뱅</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>RDA 인테러뱅</strong></h3>
<hr>

<%
//인테러뱅 상세조회
if(request.getParameter("dataNo")!=null && !request.getParameter("dataNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="발급받은인증키를삽입하세요";
	//서비스 명
	String serviceName="rdaInterrobang";
	//오퍼레이션 명
	String operationName="interrobangView";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&dataNo="+ request.getParameter("dataNo");
	
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
	
	//요약
	String contList = null;
	//목차
	String content = null;
	//키값
	String dataNo = null;
	//파일 다운로드 URL
	String downUrl = null;
	//파일명
	String fileName = null;
	//조회수
	String hitCt = null;
	//평점
	String optGrade = null;
	//댓글수
	String optNum = null;
	//등록일
	String regDt = null;
	//평가회원 수
	String scoreCnt = null;
	//제목
	String subject = null;
	//글쓴이 이메일
	String writerEmail = null;
	//글쓴이
	String writerNm = null;

	try{contList = doc.getElementsByTagName("contList").item(0).getFirstChild().getNodeValue();}catch(Exception e){contList = "";}
	try{content = doc.getElementsByTagName("content").item(0).getFirstChild().getNodeValue();}catch(Exception e){content = "";}
	try{dataNo = doc.getElementsByTagName("dataNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){dataNo = "";}
	try{downUrl = doc.getElementsByTagName("downUrl").item(0).getFirstChild().getNodeValue();}catch(Exception e){downUrl = "";}
	try{fileName = doc.getElementsByTagName("fileName").item(0).getFirstChild().getNodeValue();}catch(Exception e){fileName = "";}
	try{hitCt = doc.getElementsByTagName("hitCt").item(0).getFirstChild().getNodeValue();}catch(Exception e){hitCt = "";}
	try{optGrade = doc.getElementsByTagName("optGrade").item(0).getFirstChild().getNodeValue();}catch(Exception e){optGrade = "";}
	try{optNum = doc.getElementsByTagName("optNum").item(0).getFirstChild().getNodeValue();}catch(Exception e){optNum = "";}
	try{regDt = doc.getElementsByTagName("regDt").item(0).getFirstChild().getNodeValue();}catch(Exception e){regDt = "";}
	try{scoreCnt = doc.getElementsByTagName("scoreCnt").item(0).getFirstChild().getNodeValue();}catch(Exception e){scoreCnt = "";}
	try{subject = doc.getElementsByTagName("subject").item(0).getFirstChild().getNodeValue();}catch(Exception e){subject = "";}
	try{writerEmail = doc.getElementsByTagName("writerEmail").item(0).getFirstChild().getNodeValue();}catch(Exception e){writerEmail = "";}
	try{writerNm = doc.getElementsByTagName("writerNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){writerNm = "";}
	
	String[] s_downUrl=downUrl.split(";");
	String[] s_fileName=fileName.split(";");

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td>제목</td>
			<td><%=subject%></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=regDt%>&nbsp;<%=writerNm%>&nbsp;(<%=writerEmail%>)</td>
		</tr>
		<tr>
			<td>평점</td>
			<td><%=optGrade%>점/5점만점(rda.go.kr회원<%=scoreCnt%>분이평가한점수입니다.)</td>
		</tr>
		<tr>
			<td>요약</td>
			<td><%=contList%></td>
		</tr>
		<tr>
			<td>목차</td>
			<td><%=content%></td>
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
		</tr>
	</table>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='rdaInterrobang.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>