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
<title>농가맛집</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농가맛집</strong></h3>
<hr>

<%
//농가맛집 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="frmhsTasteHos";
	//오퍼레이션 명
	String operationName="frmhsTasteHosDtl";

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
	//지역명
	String adstrdNm = null;
	//슬로건
	String slogan = null;
	//개요
	String smm = null;
	//전화번호
	String telno = null;
	//주소
	String locplc = null;
	//운영방법
	String operMth = null;
	//쉬는날
	String restde = null;
	//영업시간
	String bsnTime = null;
	//취급메뉴
	String trtmntMenu = null;
	//체험프로그램
	String exprnProgrm = null;
	//좌석형태
	String seatStle = null;
	//홈페이지 주소
	String url = null;
	//주변 관광/볼거리
	String trrsrt = null;
	//내용
	String cn = null;


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

	try{cntntsNo = doc.getElementsByTagName("cntntsNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsNo = "";}
	try{cntntsSj = doc.getElementsByTagName("cntntsSj").item(0).getFirstChild().getNodeValue();}catch(Exception e){cntntsSj = "";}
	try{adstrdNm = doc.getElementsByTagName("adstrdNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){adstrdNm = "";}
	try{slogan = doc.getElementsByTagName("slogan").item(0).getFirstChild().getNodeValue();}catch(Exception e){slogan = "";}
	try{smm = doc.getElementsByTagName("smm").item(0).getFirstChild().getNodeValue();}catch(Exception e){smm = "";}
	try{telno = doc.getElementsByTagName("telno").item(0).getFirstChild().getNodeValue();}catch(Exception e){telno = "";}
	try{locplc = doc.getElementsByTagName("locplc").item(0).getFirstChild().getNodeValue();}catch(Exception e){locplc = "";}
	try{operMth = doc.getElementsByTagName("operMth").item(0).getFirstChild().getNodeValue();}catch(Exception e){operMth = "";}
	try{restde = doc.getElementsByTagName("restde").item(0).getFirstChild().getNodeValue();}catch(Exception e){restde = "";}
	try{bsnTime = doc.getElementsByTagName("bsnTime").item(0).getFirstChild().getNodeValue();}catch(Exception e){bsnTime = "";}
	try{trtmntMenu = doc.getElementsByTagName("trtmntMenu").item(0).getFirstChild().getNodeValue();}catch(Exception e){trtmntMenu = "";}
	try{seatStle = doc.getElementsByTagName("seatStle").item(0).getFirstChild().getNodeValue();}catch(Exception e){seatStle = "";}
	try{exprnProgrm = doc.getElementsByTagName("exprnProgrm").item(0).getFirstChild().getNodeValue();}catch(Exception e){exprnProgrm = "";}
	try{url = doc.getElementsByTagName("url").item(0).getFirstChild().getNodeValue();}catch(Exception e){url = "";}
	try{trrsrt = doc.getElementsByTagName("trrsrt").item(0).getFirstChild().getNodeValue();}catch(Exception e){trrsrt = "";}
	try{cn = doc.getElementsByTagName("cn").item(0).getFirstChild().getNodeValue();}catch(Exception e){cn = "";}
	try{imgUrl1 = doc.getElementsByTagName("imgUrl1").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl1 = "";}
	try{imgUrl2 = doc.getElementsByTagName("imgUrl2").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl2 = "";}
	try{imgUrl3 = doc.getElementsByTagName("imgUrl3").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl3 = "";}
	try{imgUrl4 = doc.getElementsByTagName("imgUrl4").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl4 = "";}
	try{imgUrl5 = doc.getElementsByTagName("imgUrl5").item(0).getFirstChild().getNodeValue();}catch(Exception e){imgUrl5 = "";}
%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td colspan="2">
            	<%if(!"".equals(imgUrl1)){ %>
            		<img src="<%=imgUrl1%>" style="width:255px; height:178px;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl2)){ %>
            		<img src="<%=imgUrl2%>" style="width:255px; height:178px;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl3)){ %>
            		<img src="<%=imgUrl3%>" style="width:255px; height:178px;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl4)){ %>
            		<img src="<%=imgUrl4%>" style="width:255px; height:178px;"/>
            	<%}%>
            	<%if(!"".equals(imgUrl5)){ %>
            		<img src="<%=imgUrl5%>" style="width:255px; height:178px;"/>
            	<%}%>
			</td>
		</tr>
		<tr>
			<td>명칭</td>
			<td><%=cntntsSj%>

			<%if(!"".equals(slogan)){ %>
				| <%=slogan%>
			<% } %>
			</td>
		</tr>
		<tr>
			<td>지역</td>
			<td><%=adstrdNm%></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><%=locplc%></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=telno%></td>
		</tr>
		<tr>
			<td>운영방법</td>
			<td><%=operMth%></td>
		</tr>
		<tr>
			<td>쉬는날</td>
			<td><%=restde%></td>
		</tr>
		<tr>
			<td>영업시간</td>
			<td><%=bsnTime%></td>
		</tr>
		<tr>
			<td>좌석형태</td>
			<td><%=seatStle%></td>
		</tr>
		<tr>
			<td>홈페이지 주소</td>
			<td><%=url%></td>
		</tr>
		<tr>
			<td>개요</td>
			<td><%=smm%></td>
		</tr>
		<tr>
			<td>취급메뉴</td>
			<td><%=trtmntMenu%></td>
		</tr>
		<tr>
			<td>체험프로그램</td>
			<td><%=exprnProgrm%></td>
		</tr>
		<tr>
			<td>주변 관광/볼거리</td>
			<td><%=trrsrt%></td>
		</tr>
	</table>
<%
}
%>
<br>
<input type="button" onclick="javascript:location.href='frmhsTasteHosList.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>