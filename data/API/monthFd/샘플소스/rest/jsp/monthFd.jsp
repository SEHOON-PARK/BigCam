<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.Calendar"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이달의 음식</title>
<script type="text/javascript">

//조회
function mainMove(){
	with(document.searchYearForm){
		method="post";
		action = "monthFd.jsp";
		target = "_self";
		submit();
	}
}
//식재료 상세보기
function move1(dNo){
	with(document.searchYearForm){
		cntntsNo.value = dNo;
		method="get";
		action = "monthFd_D1.jsp";
		target = "_self";
		submit();
	}
}
//레시피 상세보기
function move2(dNo){
	with(document.searchYearForm){
		cntntsNo.value = dNo;
		method="get";
		action = "monthFd_D2.jsp";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>이달의 음식</strong></h3><hr>
<%
//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
String apiKey="발급받은인증키를삽입하세요";

//서비스 명
String serviceName="monthFd";
Calendar aCalendar = Calendar.getInstance();

//선택년도
String thisYear = "";
if(request.getParameter("thisYear")!=null && !request.getParameter("thisYear").equals("")){
	thisYear = request.getParameter("thisYear");
}else{
	aCalendar = Calendar.getInstance();
	thisYear = String.valueOf(aCalendar.get(Calendar.YEAR));
}
//선택월
String thisMonth = "";
if(request.getParameter("thisMonth")!=null && !request.getParameter("thisMonth").equals("")){
	thisMonth = request.getParameter("thisMonth");
}else{
	aCalendar = Calendar.getInstance();
	int month = aCalendar.get(Calendar.MONTH) + 1;
	thisMonth = String.format("%02d", month);
}

//기관 코드
if(true){
	//오퍼레이션 명
	String operationName="monthFdYearLst";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;

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

	int size = 0;

	NodeList items = null;
	NodeList codeNms = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	codeNms = doc.getElementsByTagName("year");

	if(size==0){
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<form name="searchYearForm">
	<input type="hidden" name="cntntsNo"/>
		연도&nbsp;
		<select name="thisYear" onchange="mainMove();">
<%
		for(int i=0; i<size; i++){
			//코드명
			String codeNm = codeNms.item(i).getFirstChild() == null ? "" : codeNms.item(i).getFirstChild().getNodeValue();
%>
		<option value="<%=codeNm%>" <% if(codeNm.equals(thisYear)){out.print("selected");}%> ><%=codeNm%></option>
<% 		} %>
		</select>
		월&nbsp;
		<select name="thisMonth" onchange="mainMove();">
			<option value="01" <%=thisMonth.equals("01")?"selected":""%>>1월</option>
			<option value="02" <%=thisMonth.equals("02")?"selected":""%>>2월</option>
			<option value="03" <%=thisMonth.equals("03")?"selected":""%>>3월</option>
			<option value="04" <%=thisMonth.equals("04")?"selected":""%>>4월</option>
			<option value="05" <%=thisMonth.equals("05")?"selected":""%>>5월</option>
			<option value="06" <%=thisMonth.equals("06")?"selected":""%>>6월</option>
			<option value="07" <%=thisMonth.equals("07")?"selected":""%>>7월</option>
			<option value="08" <%=thisMonth.equals("08")?"selected":""%>>8월</option>
			<option value="09" <%=thisMonth.equals("09")?"selected":""%>>9월</option>
			<option value="10" <%=thisMonth.equals("10")?"selected":""%>>10월</option>
			<option value="11" <%=thisMonth.equals("11")?"selected":""%>>11월</option>
			<option value="12" <%=thisMonth.equals("12")?"selected":""%>>12월</option>
		</select>
	</form>
<%
	}
}
%>

<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	//오퍼레이션 명
	String operationName="monthFdmtLst";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&thisYear="+thisYear;
	parameter += "&thisMonth="+thisMonth;


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

	int size = 0;

	NodeList items = null;
	NodeList cntntsNos = null;
	NodeList rtnImgSeCodes = null;
	NodeList rtnFileCourss = null;
	NodeList rtnStreFileNms = null;
	NodeList fdmtNms = null;


	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	rtnImgSeCodes = doc.getElementsByTagName("rtnImgSeCode");
	rtnFileCourss = doc.getElementsByTagName("rtnFileCours");
	rtnStreFileNms = doc.getElementsByTagName("rtnStreFileNm");
	fdmtNms = doc.getElementsByTagName("fdmtNm");


	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{ %>
	<hr>
	<h3><%=thisMonth%>월의 식재료</h3>
	<div>
	<ul>

<%
		for(int i=0; i<size; i++){
			//키값
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			//파일구분코드
			String rtnImgSeCode = rtnImgSeCodes.item(i).getFirstChild() == null ? "" : rtnImgSeCodes.item(i).getFirstChild().getNodeValue();
			//파일경로
			String rtnFileCours = rtnFileCourss.item(i).getFirstChild() == null ? "" : rtnFileCourss.item(i).getFirstChild().getNodeValue();
			//파일명
			String rtnStreFileNm = rtnStreFileNms.item(i).getFirstChild() == null ? "" : rtnStreFileNms.item(i).getFirstChild().getNodeValue();
			//파일제목
			String fdmtNm = fdmtNms.item(i).getFirstChild() == null ? "" : fdmtNms.item(i).getFirstChild().getNodeValue();

			int imgCnt =-1;
			String[] rtnImgSeCodeArr= rtnImgSeCode.split("\\|");
			for(int k=0; k < rtnImgSeCodeArr.length; k++){
				if("209006".equals(rtnImgSeCodeArr[k])){
					imgCnt = k;
				}
			}
			String imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
			if(imgCnt > -1){
				String[] rtnFileCoursArr = rtnFileCours.split("\\|");
				String[] rtnStreFileNmArr = rtnStreFileNm.split("\\|");
				imgUrl = "http://www.nongsaro.go.kr/"+ rtnFileCoursArr[imgCnt] +"/"+ rtnStreFileNmArr[imgCnt];
			}
				%>
				<li style="width: 32%;display: inline-block;"><a href="#" onclick="javascript:move1('<%=cntntsNo%>');">
				<img src="<%=imgUrl%>" alt="<%=fdmtNm%>"  title="<%=fdmtNm%>" style="width: 249px;height: 198px;"/>
				</a>
				<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><%=fdmtNm%></p>
				</li>
				<%
		}
%>
	</ul>
	</div>
<%
	}

	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	//오퍼레이션 명
	operationName="monthNewFdLst";

	//XML 받을 URL 생성
	parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&thisYear="+thisYear;
	parameter += "&thisMonth="+thisMonth;


	//서버와 통신
	apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);

	apiStream = apiUrl.openStream();

	doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	size = 0;

	items = null;
	cntntsNos = null;
	rtnImgSeCodes = null;
	rtnFileCourss = null;
	rtnStreFileNms = null;
	NodeList fdNms = null;
	NodeList fdSeCodes = null;


	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	rtnImgSeCodes = doc.getElementsByTagName("rtnImgSeCode");
	rtnFileCourss = doc.getElementsByTagName("rtnFileCours");
	rtnStreFileNms = doc.getElementsByTagName("rtnStreFileNm");
	fdNms = doc.getElementsByTagName("fdNm");
	fdSeCodes = doc.getElementsByTagName("fdSeCode");


	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{ %>
	<hr>
	<h3><%=thisMonth%>월의 레시피</h3>
	<div>
	<ul>
<%
		for(int i=0; i<size; i++){
			//키값
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			//파일구분코드
			String rtnImgSeCode = rtnImgSeCodes.item(i).getFirstChild() == null ? "" : rtnImgSeCodes.item(i).getFirstChild().getNodeValue();
			//파일경로
			String rtnFileCours = rtnFileCourss.item(i).getFirstChild() == null ? "" : rtnFileCourss.item(i).getFirstChild().getNodeValue();
			//파일명
			String rtnStreFileNm = rtnStreFileNms.item(i).getFirstChild() == null ? "" : rtnStreFileNms.item(i).getFirstChild().getNodeValue();
			//파일제목
			String fdNm = fdNms.item(i).getFirstChild() == null ? "" : fdNms.item(i).getFirstChild().getNodeValue();
			//레시피구분
			String fdSeCode = fdSeCodes.item(i).getFirstChild() == null ? "" : fdSeCodes.item(i).getFirstChild().getNodeValue();

			if("290001".equals(fdSeCode)){
				int imgCnt =-1;
				String[] rtnImgSeCodeArr= rtnImgSeCode.split("\\|");
				for(int k=0; k < rtnImgSeCodeArr.length; k++){
					if("209006".equals(rtnImgSeCodeArr[k])){
						imgCnt = k;
					}
				}
				String imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
				if(imgCnt > -1){
					String[] rtnFileCoursArr = rtnFileCours.split("\\|");
					String[] rtnStreFileNmArr = rtnStreFileNm.split("\\|");
					imgUrl = "http://www.nongsaro.go.kr/"+ rtnFileCoursArr[imgCnt] +"/"+ rtnStreFileNmArr[imgCnt];
				}
					%>
					<li style="width: 32%;display: inline-block;"><a href="#" onclick="javascript:move2('<%=cntntsNo%>');">
					<img src="<%=imgUrl%>" alt="<%=fdNm%>"  title="<%=fdNm%>" style="width: 249px;height: 198px;"/>
					</a>
					<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><%=fdNm%></p>
					</li>
					<%
			}
		}
%>
	</ul>
	</div>
	<hr>
	<h3><%=thisMonth%>월의 상차림</h3>
	<div>
	<ul>
<%

	for(int i=0; i<size; i++){
		//키값
		String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
		//파일구분코드
		String rtnImgSeCode = rtnImgSeCodes.item(i).getFirstChild() == null ? "" : rtnImgSeCodes.item(i).getFirstChild().getNodeValue();
		//파일경로
		String rtnFileCours = rtnFileCourss.item(i).getFirstChild() == null ? "" : rtnFileCourss.item(i).getFirstChild().getNodeValue();
		//파일명
		String rtnStreFileNm = rtnStreFileNms.item(i).getFirstChild() == null ? "" : rtnStreFileNms.item(i).getFirstChild().getNodeValue();
		//파일제목
		String fdNm = fdNms.item(i).getFirstChild() == null ? "" : fdNms.item(i).getFirstChild().getNodeValue();
		//레시피구분
		String fdSeCode = fdSeCodes.item(i).getFirstChild() == null ? "" : fdSeCodes.item(i).getFirstChild().getNodeValue();

		if("290002".equals(fdSeCode) || "290003".equals(fdSeCode)){
			int imgCnt =-1;
			String[] rtnImgSeCodeArr= rtnImgSeCode.split("\\|");
			for(int k=0; k < rtnImgSeCodeArr.length; k++){
				if("209006".equals(rtnImgSeCodeArr[k])){
					imgCnt = k;
				}
			}
			String imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
			if(imgCnt > -1){
				String[] rtnFileCoursArr = rtnFileCours.split("\\|");
				String[] rtnStreFileNmArr = rtnStreFileNm.split("\\|");
				imgUrl = "http://www.nongsaro.go.kr/"+ rtnFileCoursArr[imgCnt] +"/"+ rtnStreFileNmArr[imgCnt];
			}
				%>
				<li style="width: 32%;display: inline-block;">
				<img src="<%=imgUrl%>" alt="<%=fdNm%>"  title="<%=fdNm%>" style="width: 249px;height: 198px;"/>
				<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><%=fdNm%></p>
				</li>
				<%
		}
	}
}
%>
	</ul>
	</div>
<br>
</body>
</html>