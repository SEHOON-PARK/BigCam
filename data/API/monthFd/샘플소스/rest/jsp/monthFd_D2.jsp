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
<title>이달의음식</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>

<%
//레시피 상세조회
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="발급받은인증키를삽입하세요";
	//서비스 명
	String serviceName="monthFd";
	//오퍼레이션 명
	String operationName="monthNewFdDtl";

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


	//음식명
	String fdNm = null;
	//재료정보
	String matrlInfo = null;
	//조리방법정보
	String ckngMthInfo = null;
	//단체급식적용정보
	String grpMlsvApplcInfo = null;
	//조리기기 도구정보
	String ckngmhrlsUntInfo = null;
	//비고정보
	String rmInfo = null;
	//인분명
	String phphmntNm = null;
	//에너지량
	String energyQy = null;
	//탄수화물량
	String crbQy = null;
	//지질량
	String ntrfsQy = null;
	//단백질량
	String protQy = null;
	//식이섬유량
	String edblfibrQy = null;
	//비타민A량
	String vtmaQy = null;
	//비타민E량
	String vteQy = null;
	//비타민C량
	String vtcQy = null;
	//티아민량
	String thiaQy = null;
	//리보플라빈량
	String niboplaQy = null;
	//칼슘량
	String clciQy = null;
	//나트륨량
	String naQy = null;
	//칼륨량
	String ptssQy = null;
	//철량
	String irnQy = null;
	//이미지구분코드
	String rtnImgSeCode = null;
	//이미지 경로
	String rtnFileCours = null;
	//이미지 물리명
	String rtnStreFileNm = null;
	//이미지 설명
	String rtnImageDc = null;

	try{fdNm = doc.getElementsByTagName("fdNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){fdNm = "";}
	try{matrlInfo = doc.getElementsByTagName("matrlInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){matrlInfo = "";}
	try{ckngMthInfo = doc.getElementsByTagName("ckngMthInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){ckngMthInfo = "";}
	try{grpMlsvApplcInfo = doc.getElementsByTagName("grpMlsvApplcInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){grpMlsvApplcInfo = "";}
	try{ckngmhrlsUntInfo = doc.getElementsByTagName("ckngmhrlsUntInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){ckngmhrlsUntInfo = "";}
	try{rmInfo = doc.getElementsByTagName("rmInfo").item(0).getFirstChild().getNodeValue();}catch(Exception e){rmInfo = "";}
	try{phphmntNm = doc.getElementsByTagName("phphmntNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){phphmntNm = "";}
	try{energyQy = doc.getElementsByTagName("energyQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){energyQy = "";}
	try{crbQy = doc.getElementsByTagName("crbQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){crbQy = "";}
	try{ntrfsQy = doc.getElementsByTagName("ntrfsQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){ntrfsQy = "";}
	try{protQy = doc.getElementsByTagName("protQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){protQy = "";}
	try{edblfibrQy = doc.getElementsByTagName("edblfibrQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){edblfibrQy = "";}
	try{vtmaQy = doc.getElementsByTagName("vtmaQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){vtmaQy = "";}
	try{vteQy = doc.getElementsByTagName("vteQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){vteQy = "";}
	try{vtcQy = doc.getElementsByTagName("vtcQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){vtcQy = "";}
	try{thiaQy = doc.getElementsByTagName("thiaQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){thiaQy = "";}
	try{niboplaQy = doc.getElementsByTagName("niboplaQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){niboplaQy = "";}
	try{clciQy = doc.getElementsByTagName("clciQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){clciQy = "";}
	try{naQy = doc.getElementsByTagName("naQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){naQy = "";}
	try{ptssQy = doc.getElementsByTagName("ptssQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){ptssQy = "";}
	try{irnQy = doc.getElementsByTagName("irnQy").item(0).getFirstChild().getNodeValue();}catch(Exception e){irnQy = "";}
	try{rtnImgSeCode = doc.getElementsByTagName("rtnImgSeCode").item(0).getFirstChild().getNodeValue();}catch(Exception e){rtnImgSeCode = "";}
	try{rtnFileCours = doc.getElementsByTagName("rtnFileCours").item(0).getFirstChild().getNodeValue();}catch(Exception e){rtnFileCours = "";}
	try{rtnStreFileNm = doc.getElementsByTagName("rtnStreFileNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){rtnStreFileNm = "";}
	try{rtnImageDc = doc.getElementsByTagName("rtnImageDc").item(0).getFirstChild().getNodeValue();}catch(Exception e){rtnImageDc = "";}

	%>

	<div>
	<ul>
	<%
	String[] rtnStreFileNmArr = rtnStreFileNm.split("\\|");
	String[] rtnFileCoursArr = rtnFileCours.split("\\|");
	String[] rtnImgSeCodeArr= rtnImgSeCode.split("\\|");
	for(int i=0; i<rtnStreFileNmArr.length; i++){
		if("209006".equals(rtnImgSeCodeArr[i]) || "209007".equals(rtnImgSeCodeArr[i])){
			String imgUrl = "http://www.nongsaro.go.kr/"+ rtnFileCoursArr[i] +"/"+ rtnStreFileNmArr[i];
			%>
			<li style="width: 33%;display: inline-block;"><a href="#">
			<img src="<%=imgUrl%>" alt=""  title="" style="width: 249px;height: 198px;"/>
			</a></li>
			<%
		}
	}

%>
	</ul>
	</div>
	<!-- //이미지 갤러리 영역 -->
	<div>
		<!-- 내용 -->
		<h2><%=fdNm%></h2>
		<table border="1" cellSpacing="0" cellPadding="0">
			<caption>레시피내용</caption>
			<colgroup>
				<col style="width:20%" />
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<td class="txt-c">재료</td>
					<td><%=matrlInfo.replaceAll("\n", "<br/>")%></td>
				</tr>
				<tr>
					<td class="txt-c">만드는 법</td>
					<td><%=ckngMthInfo.replaceAll("\n", "<br/>")%></td>
				</tr>
				<tr>
					<td class="txt-c">단체급식 적용법</td>
					<td><%=grpMlsvApplcInfo.replaceAll("\n", "<br/>")%></td>
				</tr>
		</table>
		<!--// 내용 -->
	</div>
	<h2>영양성분 - <%=fdNm%>(<%=phphmntNm%>)</h2>
		<table border="1" cellSpacing="0" cellPadding="0">
			<caption>영양성분 상세표</caption>
			<colgroup>
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="row">에너지<br />(kcal)</th>
					<th scope="row">탄수화물<br />(g)</th>
					<th scope="row">지질<br />(g)</th>
					<th scope="row">단백질<br />(g)</th>
					<th scope="row">식이섬유<br />(g)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt-c"> <%=energyQy%></td>
					<td class="txt-c"> <%=crbQy%></td>
					<td class="txt-c"> <%=ntrfsQy%></td>
					<td class="txt-c"> <%=protQy%></td>
					<td class="txt-c"> <%=edblfibrQy%></td>
				</tr>
			</tbody>
		</table>

		<table border="1" cellSpacing="0" cellPadding="0">
			<caption>영양성분 상세표</caption>
			<colgroup>
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="row">비타민A<br />(ug RE)</th>
					<th scope="row">비타민E<br />(mg)</th>
					<th scope="row">비타민C<br />(mg)</th>
					<th scope="row">티아민<br />(mg)</th>
					<th scope="row">리보플라빈<br />(mg)</th>
					<th scope="row">칼슘<br />(mg)</th>
					<th scope="row">나트륨<br />(mg)</th>
					<th scope="row">칼륨<br />(mg)</th>
					<th scope="row">철<br />(mg)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt-c"> <%=vtmaQy%></td>
					<td class="txt-c"> <%=vteQy%></td>
					<td class="txt-c"> <%=vtcQy%></td>
					<td class="txt-c"> <%=thiaQy%></td>
					<td class="txt-c"> <%=niboplaQy%></td>
					<td class="txt-c"> <%=clciQy%></td>
					<td class="txt-c"> <%=naQy%></td>
					<td class="txt-c"> <%=ptssQy%></td>
					<td class="txt-c"> <%=irnQy%></td>
				</tr>
			</tbody>
		</table>
	<%if(!"".equals(ckngmhrlsUntInfo)){ %>
	<span>조리기기 및 도구</span><br />
	<p>
		<%=ckngmhrlsUntInfo.replaceAll("\n", "<br/>")%>
	</p>
	<%} %>

<%} %>

<br>
<input type="button" onclick="javascript:location.href='monthFd.jsp'" value="처음화면으로"/>&nbsp;
</body>
</html>