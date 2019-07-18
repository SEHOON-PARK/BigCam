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
<title>텃밭가꾸기</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>텃밭가꾸기</strong></h3>
<hr>

<%
//텃밭가꾸기 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="발급받은인증키를삽입하세요";
	//서비스 명
	String serviceName="fildMnfct";
	//오퍼레이션 명
	String operationName="fildMnfctView";

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

	//다운URL
	String downUrl = null;
	//등록일
	String svcDtx = null;
	//조회수
	String cntntsRdcnt = null;
	//작성자
	String updusrEsntlNm = null;
	//다운파일명
	String fileName = null;


	//내용
	String cn = null;

	try{cntntsNo = doc.getElementsByTagName("cntntsNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsNo = "";}
	try{cntntsSj = doc.getElementsByTagName("cntntsSj").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsSj = "";}
	try{downUrl = doc.getElementsByTagName("downUrl").item(0).getFirstChild().getNodeValue();}catch(Exception e){downUrl = "";}
	try{svcDtx = doc.getElementsByTagName("svcDtx").item(0).getFirstChild().getNodeValue();}catch(Exception e){svcDtx = "";}
	try{cntntsRdcnt = doc.getElementsByTagName("cntntsRdcnt").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsRdcnt = "";}
	try{updusrEsntlNm = doc.getElementsByTagName("updusrEsntlNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){updusrEsntlNm = "";}
	try{fileName = doc.getElementsByTagName("fileName").item(0).getFirstChild().getNodeValue();}catch(Exception e){fileName = "";}
	try{cn = doc.getElementsByTagName("cn").item(0).getFirstChild().getNodeValue();}catch(Exception e){cn = "";}


	String[] s_downUrl=downUrl.split(";");
	String[] s_fileName=fileName.split(";");
%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:16%" />
			<col style="width:18%" />
			<col style="width:16%" />
			<col style="width:18%" />
			<col style="width:16%" />
			<col/>
		</colgroup>
		<tr>
			<td>제목</td>
			<td colspan="5"><%=cntntsSj%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=updusrEsntlNm%></td>
			<td>등록일</td>
			<td><%=svcDtx%></td>
			<td>조회수</td>
			<td><%=cntntsRdcnt%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="5">
<%
			for(int j=0; j<s_downUrl.length; j++){
%>
				<a href="<%=s_downUrl[j]%>"><%=s_fileName[j]%></a>&nbsp;
<%
			}
%>
			</td>
		</tr>
		<tr>
			<td colspan="6"><%=cn%></td>
		</tr>

	</table>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='fildMnfct.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>