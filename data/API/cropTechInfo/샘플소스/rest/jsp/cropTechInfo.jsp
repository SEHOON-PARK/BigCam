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
<title>작목기술 서비스</title>
<script type="text/javascript">

//메인 카테고리 항목
function mainMove(){
	with(document.searchInsttForm){
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}
//미들 카테고리 항목
function middleMove(mCode){
	with(document.mainApiForm){
		mainCategoryCode.value = mCode;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

//메인 테크 항목
function mainTechMove(sCode, mCode){
	with(document.mainTechApiForm){
		subCategoryCode.value = sCode;
		middleCategoryCode.value = mCode;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

//서브 테크 항목
function subTechMove(mCode){
	with(document.subTechApiForm){
		mainTechCode.value = mCode;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

//동영상 팝업
function fncNongsaroOpenVideo(videoLink){
	var agent = navigator.userAgent.toLowerCase();
	var isLowIe = (agent.indexOf("msie 7") > 0) || (agent.indexOf("msie 8") > 0);

	var dWidth = 1120;
	var dHeight = 505;

	if(isLowIe){
		dWidth = 800;
		dHeight = 440;
		videoLink = videoLink.replace("view01", "view01ie8");
	}

	window.open(videoLink, "nongsaroVideoPop","width=" + dWidth + ",height=" + dHeight);
}
//동영상 목록 조회
function videoListMove(){
	with(document.videoListApiForm){
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}
//동영상 페이지 이동
function vid_fncGoPage(page){
	with(document.videoListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

//기술정보 목록 조회
function techInfoMove(sCode){
	with(document.techInfoListApiForm){
		subTechCode.value = sCode;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}
//기술정보 페이지 이동
function tech_fncGoPage(page){
	with(document.techInfoListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

//품종정보 목록 조회
function varietyList(){
	with(document.varietyListApiForm){
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

//품종정보  페이지 이동
function var_fncGoPage(page){
	with(document.varietyListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}

function fncSearch(){
	with(document.searchInsttForm){
		method="post";
		action = "cropTechInfo.jsp";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>작목기술 서비스</strong></h3>
<hr>

<%
//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
String apiKey="인증키를입력해주세요";
//서비스 명
String serviceName="cropTechInfo";

//기관코드 등록
String insttCode = "";
if(request.getParameter("insttCode")!=null && !request.getParameter("insttCode").equals("")){
	insttCode = request.getParameter("insttCode");
}
//기관코드 등록
String insttName = "";
if(request.getParameter("insttName")!=null && !request.getParameter("insttName").equals("")){
	insttName = new String(request.getParameter("insttName").getBytes("8859_1"), "UTF-8");
}
//작물명 검색
String subCategoryNm = "";
if(request.getParameter("subCategoryNm")!=null && !request.getParameter("subCategoryNm").equals("")){
	subCategoryNm = new String(request.getParameter("subCategoryNm").getBytes("8859_1"), "UTF-8");
}
//제목 검색
String subject = "";
if(request.getParameter("subject")!=null && !request.getParameter("subject").equals("")){
	subject = new String(request.getParameter("subject").getBytes("8859_1"), "UTF-8");
}

%>

<form name="mainApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=request.getParameter("mainCategoryCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="mainTechApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=request.getParameter("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=request.getParameter("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=request.getParameter("subCategoryCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="subTechApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=request.getParameter("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=request.getParameter("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=request.getParameter("subCategoryCode")%>">
<input type="hidden" name="mainTechCode" value="<%=request.getParameter("mainTechCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="videoListApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=request.getParameter("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=request.getParameter("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=request.getParameter("subCategoryCode")%>">
<input type="hidden" name="movieCheck" value="1">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="pageNo">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="techInfoListApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=request.getParameter("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=request.getParameter("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=request.getParameter("subCategoryCode")%>">
<input type="hidden" name="mainTechCode" value="<%=request.getParameter("mainTechCode")%>">
<input type="hidden" name="subTechCode" value="<%=request.getParameter("subTechCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="pageNo">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="varietyListApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=request.getParameter("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=request.getParameter("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=request.getParameter("subCategoryCode")%>">
<input type="hidden" name="mainTechCode" value="<%=request.getParameter("mainTechCode")%>">
<input type="hidden" name="varietyCheck" value="1">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>
<%
//기관 코드
if(true){
	//오퍼레이션 명
	String operationName="insttList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&insttCode="+insttCode;
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);
	
	
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
	codeNms = doc.getElementsByTagName("codeNm");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<form name="searchInsttForm">
	<input type="hidden" name="insttCode" value="<%=insttCode%>">
		기관명&nbsp;
		<select name="insttName" onchange="mainMove();">
		<option value="">선택하세요</option>
<%
		for(int i=0; i<size; i++){
			//코드명
			String codeNm = codeNms.item(i).getFirstChild() == null ? "" : codeNms.item(i).getFirstChild().getNodeValue();
%>
		<option value="<%=codeNm%>" <% if(codeNm.equals(insttName)){out.print("selected");}%> ><%=codeNm%></option>
<% 		} %>
		</select>
		
		작목명&nbsp;
		<input type="text" id="subCategoryNm" name="subCategoryNm" value="<%=subCategoryNm%>">
		제목&nbsp;
		<input type="text" id="subject" name="subject" value="<%=subject%>">
		<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
		
	</form>
<%
	}
}
%>

<%
//대분류 카테고리
if(true){
	//오퍼레이션 명
	String operationName="mainCategoryList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&insttCode="+insttCode;
	parameter += "&insttName="+URLEncoder.encode(insttName);
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);
	
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
	NodeList mainCategoryCodes = null;
	NodeList mainCategoryNms = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	mainCategoryCodes = doc.getElementsByTagName("mainCategoryCode");
	mainCategoryNms = doc.getElementsByTagName("mainCategoryNm");

	if(size==0){ 
%>
	<hr>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		for(int i=0; i<size; i++){
			//대분류 카테고리 코드
			String mainCategoryCode = mainCategoryCodes.item(i).getFirstChild() == null ? "" : mainCategoryCodes.item(i).getFirstChild().getNodeValue();
			//대분류 카테고리 명
			String mainCategoryNm = mainCategoryNms.item(i).getFirstChild() == null ? "" : mainCategoryNms.item(i).getFirstChild().getNodeValue();
%>
				<td width="11%" align="center"><a href="javascript:middleMove('<%=mainCategoryCode%>');"><%=mainCategoryNm%></a></td>
<%		
		}
%>
		<tr>
	</table>
<%
	}
}
%>

<%
//중분류 카테고리
if(request.getParameter("mainCategoryCode")!=null && !request.getParameter("mainCategoryCode").equals("")){
	//오퍼레이션 명
	String operationName="middleCategoryList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&mainCategoryCode="+request.getParameter("mainCategoryCode");
	parameter += "&insttCode="+insttCode;
	parameter += "&insttName="+URLEncoder.encode(insttName);
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);
	
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
	NodeList middleCategoryCodes = null;
	NodeList middleCategoryNms = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	middleCategoryCodes = doc.getElementsByTagName("middleCategoryCode");
	middleCategoryNms = doc.getElementsByTagName("middleCategoryNm");
	
	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" rules="rows" cellSpacing="0" cellPadding="0">
<%
		for(int i=0; i<size; i++){
			//중분류 카테고리 코드
			String middleCategoryCode = middleCategoryCodes.item(i).getFirstChild() == null ? "" : middleCategoryCodes.item(i).getFirstChild().getNodeValue();
			//중분류 카테고리 명
			String middleCategoryNm = middleCategoryNms.item(i).getFirstChild() == null ? "" : middleCategoryNms.item(i).getFirstChild().getNodeValue();
%>
		<tr>
			<td width="15%"><strong><%=middleCategoryNm%></strong></td> 			
 			<td width="85%"><table width="100%" cellSpacing="0" cellPadding="0"><tr>
<%
			//소분류 카테고리		
			String operationName_Sub="subCategoryList";
			String parameter_Sub = "/"+serviceName+"/"+"subCategoryList";
			parameter_Sub += "?apiKey="+ apiKey;
			parameter_Sub += "&middleCategoryCode="+middleCategoryCode;
			parameter_Sub += "&insttCode="+insttCode;
			parameter_Sub += "&insttName="+URLEncoder.encode(insttName);
			//작물명 검색
			parameter_Sub += "&subCategoryNm="+subCategoryNm;
			//제목 검색
			parameter_Sub += "&subject="+URLEncoder.encode(subject); 
			
			//서버와 통신
			URL apiUrl_Sub = new URL("http://api.nongsaro.go.kr/service"+parameter_Sub);
			InputStream apiStream_Sub = apiUrl_Sub.openStream();
			
			Document doc_Sub = null;
			try{
				//xml document
				doc_Sub = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream_Sub);
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				apiStream_Sub.close();
			}
			
			int size_Sub = 0;
			
			NodeList items_Sub = null;
			NodeList subCategoryCodes = null;
			NodeList subCategoryNms = null;
			
			items_Sub = doc_Sub.getElementsByTagName("item");
			size_Sub = doc_Sub.getElementsByTagName("item").getLength();
			subCategoryCodes = doc_Sub.getElementsByTagName("subCategoryCode");
			subCategoryNms = doc_Sub.getElementsByTagName("subCategoryNm");
			
			for(int j=0; j<size_Sub; j++){
				//소분류 카테고리 코드
				String subCategoryCode = subCategoryCodes.item(j).getFirstChild() == null ? "" : subCategoryCodes.item(j).getFirstChild().getNodeValue();
				//소분류 카테고리 명
				String subCategoryNm1 = subCategoryNms.item(j).getFirstChild() == null ? "" : subCategoryNms.item(j).getFirstChild().getNodeValue();
				
				if(j%4==0){
					out.print("</tr><tr>");
				}
%>
					<td width="25%">&nbsp;│&nbsp;<a href="javascript:mainTechMove('<%=subCategoryCode%>', '<%=middleCategoryCode%>');"><%=subCategoryNm1%></a></td>
<%		
			}
			
			if(size_Sub==1){
				out.print("<td width='25%'></td><td width='25%'></td><td width='25%'></td>");
			}else if(size_Sub==2){
				out.print("<td width='25%'></td><td width='25%'>");
			}else if(size_Sub==3){
				out.print("<td width='25%'></td>");
			}
%>
			</tr>
		</table>
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
//대분류 기술코드 조회
if(request.getParameter("subCategoryCode")!=null && !request.getParameter("subCategoryCode").equals("")){
	//오퍼레이션 명
	String operationName="mainTechList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&subCategoryCode="+request.getParameter("subCategoryCode");
	parameter += "&insttName="+URLEncoder.encode(insttName);
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);
	
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
	NodeList mainTechCodes = null;
	NodeList mainTechNms = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	mainTechCodes = doc.getElementsByTagName("mainTechCode");
	mainTechNms = doc.getElementsByTagName("mainTechNm");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<br>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		for(int i=0; i<size; i++){
			//대분류 기술 코드
			String mainTechCode = mainTechCodes.item(i).getFirstChild() == null ? "" : mainTechCodes.item(i).getFirstChild().getNodeValue();
			//대분류 기술 코드 명
			String mainTechNm = mainTechNms.item(i).getFirstChild() == null ? "" : mainTechNms.item(i).getFirstChild().getNodeValue();
			
			if(mainTechCode.equals("movie")){
%>
				<td align="center"><a href="javascript:videoListMove();"><%=mainTechNm%></a></td>
<%		
			}else{
%>
				<td align="center"><a href="javascript:subTechMove('<%=mainTechCode%>');"><%=mainTechNm%></a></td>
<%		
			}
		}
%>
		<tr>
	</table>
<%
	}
}
%>

<%
//동영상 목록 조회
if(request.getParameter("movieCheck")!=null && !request.getParameter("movieCheck").equals("")){
	//오퍼레이션 명
	String operationName="videoList";
	
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&subCategoryCode="+request.getParameter("subCategoryCode");
	parameter += "&pageNo="+request.getParameter("pageNo");
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);

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
	NodeList videoImgs = null;
	NodeList videoLinks = null;
	NodeList videoOriginInstts = null;
	NodeList videoTitles = null;
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	videoImgs = listDoc.getElementsByTagName("videoImg");
	videoLinks = listDoc.getElementsByTagName("videoLink");
	videoOriginInstts = listDoc.getElementsByTagName("videoOriginInstt");
	videoTitles = listDoc.getElementsByTagName("videoTitle");

	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<br>
	<table border="1" cellSpacing="0" summary="" cellPadding="0">
		<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" >동영상</th>
				<th scope="col" >제목</th>
				<th scope="col" >출처</th>
			</tr>
		</thead>
		<tbody>
<%
		for(int i=0; i<listSize; i++){
			//비디오 썸네일 이미지 링크
			String videoImg = videoImgs.item(i).getFirstChild() == null ? "" : videoImgs.item(i).getFirstChild().getNodeValue();
			//비디오 링크
			String videoLink = videoLinks.item(i).getFirstChild() == null ? "" : videoLinks.item(i).getFirstChild().getNodeValue();
			//동영상 출처
			String videoOriginInstt = videoOriginInstts.item(i).getFirstChild() == null ? "" : videoOriginInstts.item(i).getFirstChild().getNodeValue();
			//동영상 제목
			String videoTitle = videoTitles.item(i).getFirstChild() == null ? "" : videoTitles.item(i).getFirstChild().getNodeValue();
%>
		<tr>
		    <td>
		    <a href="#" title="<%=videoTitle %>" onclick="fncNongsaroOpenVideo('<%=videoLink%>');return false;">
		    <img src="<%=videoImg%>" width="128" height="103"></img>
		    </a>
		    </td>
		    <td><%=videoTitle%></td>
		    <td><%=videoOriginInstt %></td>
		</tr>
<%		
		}
%>
	    </tbody>
	</table>
<%
	}
//페이징 처리
	//한 페이지에 제공할 건수
	String numOfRows = "";
	//조회된 총 건수
	String totalCount = "";
	//조회할 페이지 번호
	String pageNo = "";
	try{numOfRows = listDoc.getElementsByTagName("numOfRows").item(0).getFirstChild().getNodeValue();}catch(Exception e){numOfRows = "";}
	try{totalCount = listDoc.getElementsByTagName("totalCount").item(0).getFirstChild().getNodeValue();}catch(Exception e){totalCount = "";}
	try{pageNo = listDoc.getElementsByTagName("pageNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){pageNo = "";}

	int pageGroupSize = 10;
	int pageSize = 0;
	try{
		pageSize = Integer.parseInt(numOfRows);
	}catch(Exception e){
		pageSize = 10;
	}
	int start = 0; 
	try{
		start = Integer.parseInt(pageNo);
	}catch(Exception e){
		start = 1;
	}
	
	int currentPage = 1;
	try{currentPage = Integer.parseInt(pageNo);}catch(Exception e){}

	int startRow = (currentPage - 1) * pageSize + 1;//한 페이지의 시작글 번호 
	int endRow = currentPage * pageSize;//한 페이지의 마지막 글번호           
	int count = Integer.parseInt( totalCount);                                                            
	int number=0;                                                             
		
	number=count-(currentPage-1)*pageSize;//글목록에 표시할 글번호                                                                  
    
	//페이지그룹의 갯수                                                                                                             
	//ex) pageGroupSize가 3일 경우 '[1][2][3]'가 pageGroupCount 개 만큼 있다.                                                       
	int pageGroupCount = count/(pageSize*pageGroupSize)+( count % (pageSize*pageGroupSize) == 0 ? 0 : 1);                           
	//페이지 그룹 번호                                                                                                              
	//ex) pageGroupSize가 3일 경우  '[1][2][3]'의 페이지그룹번호는 1 이고  '[2][3][4]'의 페이지그룹번호는 2 이다.                   
	int numPageGroup = (int) Math.ceil((double)currentPage/pageGroupSize);                                                          


	if(count > 0){
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		int startPage = pageGroupSize*(numPageGroup-1)+1;
		int endPage = startPage + pageGroupSize-1;
		int prtPageNo = 0;
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if(numPageGroup > 1){
			prtPageNo = (numPageGroup-2)*pageGroupSize+1;
			out.println("<a href='javascript:vid_fncGoPage("+prtPageNo+");'>[이전]</a>");
		}
		
		for(int i=startPage; i<=endPage; i++){
			prtPageNo = i;
			out.print("<a href='javascript:vid_fncGoPage("+prtPageNo+");'>");
			if(currentPage == i){
				out.print("<strong>["+i+"]</strong>");
			}else{
				out.print("["+i+"]");
			}
			out.println("</a>");
		}
		
		if(numPageGroup < pageGroupCount){
			prtPageNo = (numPageGroup*pageGroupSize+1);
			out.println("<a href='javascript:vid_fncGoPage("+prtPageNo+");'>[다음]</a>");
		}
	}
//페이징 처리 끝
}
%>

<%
//소분류 기술코드 조회
if(request.getParameter("mainTechCode")!=null && !request.getParameter("mainTechCode").equals("")){
	//오퍼레이션 명
	String operationName="subTechList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&mainCategoryCode="+request.getParameter("mainCategoryCode");
	parameter += "&middleCategoryCode="+request.getParameter("middleCategoryCode");
	parameter += "&subCategoryCode="+request.getParameter("subCategoryCode");
	parameter += "&mainTechCode="+request.getParameter("mainTechCode");
	parameter += "&insttName="+URLEncoder.encode(insttName);
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);
	
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
	NodeList subTechCodes = null;
	NodeList subTechNms = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	subTechCodes = doc.getElementsByTagName("subTechCode");
	subTechNms = doc.getElementsByTagName("subTechNm");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
%>
	<hr>
<%
		for(int i=0; i<size; i++){
			//소분류 기술 코드
			String subTechCode = subTechCodes.item(i).getFirstChild() == null ? "" : subTechCodes.item(i).getFirstChild().getNodeValue();
			//소분류 기술코드 명
			String subTechNm = subTechNms.item(i).getFirstChild() == null ? "" : subTechNms.item(i).getFirstChild().getNodeValue();
			
			if(subTechCode.equals("variety")){
%>
			&nbsp;│&nbsp;<a href="javascript:varietyList();"><%=subTechNm%></a>
<%		
			}else{
%>
			&nbsp;│&nbsp;<a href="javascript:techInfoMove('<%=subTechCode%>');"><%=subTechNm%></a>
<%		
			}
		}
	}
}
%>

<%
//기술정보 목록 조회
if(request.getParameter("subTechCode")!=null && !request.getParameter("subTechCode").equals("")){
	//오퍼레이션 명
	String operationName="techInfoList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&subCategoryCode="+request.getParameter("subCategoryCode");
	parameter += "&subTechCode="+request.getParameter("subTechCode");
	parameter += "&pageNo="+request.getParameter("pageNo");
	parameter += "&insttName="+URLEncoder.encode(insttName);
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);
	
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
	NodeList fileDownUrls = null;
	NodeList regDts = null;
	NodeList techNms = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	fileDownUrls = doc.getElementsByTagName("fileDownUrl");
	regDts = doc.getElementsByTagName("regDt");
	techNms = doc.getElementsByTagName("techNm");

%>
	<hr>
<%	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="70%"/>
			<col width="15%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>제목</th>
			<th>등록일</th>
			<th>첨부</th>
		</tr>
<% 
		for(int i=0; i<size; i++){
			//첨부파일 다운로드 URL
			String fileDownUrl = fileDownUrls.item(i).getFirstChild() == null ? "" : fileDownUrls.item(i).getFirstChild().getNodeValue();
			//등록일자
			String regDt = regDts.item(i).getFirstChild() == null ? "" : regDts.item(i).getFirstChild().getNodeValue();
			//기술정보 제목
			String techNm = techNms.item(i).getFirstChild() == null ? "" : techNms.item(i).getFirstChild().getNodeValue();
%>
			<tr>
				<td><%=techNm%></td>
				<td align="center"><%=regDt %></td>
				<td align="center"><a href="<%=fileDownUrl%>">파일다운</a></td>
			</tr>
<%		
		}
%>
	</table>
<%
	}

//페이징 처리
	//한 페이지에 제공할 건수
	String numOfRows = "";
	//조회된 총 건수
	String totalCount = "";
	//조회할 페이지 번호
	String pageNo = "";
	try{numOfRows = doc.getElementsByTagName("numOfRows").item(0).getFirstChild().getNodeValue();}catch(Exception e){numOfRows = "";}
	try{totalCount = doc.getElementsByTagName("totalCount").item(0).getFirstChild().getNodeValue();}catch(Exception e){totalCount = "";}
	try{pageNo = doc.getElementsByTagName("pageNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){pageNo = "";}
	
	int pageGroupSize = 10;
	int pageSize = 0;
	try{
		pageSize = Integer.parseInt(numOfRows);
	}catch(Exception e){
		pageSize = 10;
	}
	int start = 0; 
	try{
		start = Integer.parseInt(pageNo);
	}catch(Exception e){
		start = 1;
	}
	
	int currentPage = 1;
	try{currentPage = Integer.parseInt(pageNo);}catch(Exception e){}
	
	int startRow = (currentPage - 1) * pageSize + 1;//한 페이지의 시작글 번호 
	int endRow = currentPage * pageSize;//한 페이지의 마지막 글번호           
	int count = Integer.parseInt( totalCount);                                                            
	int number=0;                                                             
	
	number=count-(currentPage-1)*pageSize;//글목록에 표시할 글번호                                                                  
	
	//페이지그룹의 갯수                                                                                                             
	//ex) pageGroupSize가 3일 경우 '[1][2][3]'가 pageGroupCount 개 만큼 있다.                                                       
	int pageGroupCount = count/(pageSize*pageGroupSize)+( count % (pageSize*pageGroupSize) == 0 ? 0 : 1);                           
	//페이지 그룹 번호                                                                                                              
	//ex) pageGroupSize가 3일 경우  '[1][2][3]'의 페이지그룹번호는 1 이고  '[2][3][4]'의 페이지그룹번호는 2 이다.                   
	int numPageGroup = (int) Math.ceil((double)currentPage/pageGroupSize);                                                          
	
	if(count > 0){
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		int startPage = pageGroupSize*(numPageGroup-1)+1;
		int endPage = startPage + pageGroupSize-1;
		int prtPageNo = 0;
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if(numPageGroup > 1){
			prtPageNo = (numPageGroup-2)*pageGroupSize+1;
			out.println("<a href='javascript:tech_fncGoPage("+prtPageNo+");'>[이전]</a>");
		}
		
		for(int i=startPage; i<=endPage; i++){
			prtPageNo = i;
			out.print("<a href='javascript:tech_fncGoPage("+prtPageNo+");'>");
			if(currentPage == i){
				out.print("<strong>["+i+"]</strong>");
			}else{
				out.print("["+i+"]");
			}
			out.println("</a>");
		}
		
		if(numPageGroup < pageGroupCount){
			prtPageNo = (numPageGroup*pageGroupSize+1);
			out.println("<a href='javascript:tech_fncGoPage("+prtPageNo+");'>[다음]</a>");
		}
	}
//페이징 처리 끝
}
%>

<%
//품종정보 목록 조회
if(request.getParameter("varietyCheck")!=null && !request.getParameter("varietyCheck").equals("")){
	//오퍼레이션 명
	String operationName="varietyList";
	
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&subCategoryCode="+request.getParameter("subCategoryCode");
	parameter += "&pageNo="+request.getParameter("pageNo");
	//작물명 검색
	parameter += "&subCategoryNm="+subCategoryNm;
	//제목 검색
	parameter += "&subject="+URLEncoder.encode(subject);

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
	NodeList atchFileLinks = null;
	NodeList atchFileNms = null;
	NodeList cropNms = null;
	NodeList imgFileLinks = null;
	NodeList mainChartrInfos = null;
	NodeList unbrngInsttInfos = null;
	NodeList unbrngYears = null;
	NodeList varietyNms = null;
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	atchFileLinks = listDoc.getElementsByTagName("atchFileLink");
	atchFileNms = listDoc.getElementsByTagName("atchFileNm");
	cropNms = listDoc.getElementsByTagName("cropNm");
	imgFileLinks = listDoc.getElementsByTagName("imgFileLink");
	mainChartrInfos = listDoc.getElementsByTagName("mainChartrInfo");
	unbrngInsttInfos = listDoc.getElementsByTagName("unbrngInsttInfo");
	unbrngYears = listDoc.getElementsByTagName("unbrngYear");
	varietyNms = listDoc.getElementsByTagName("varietyNm");

	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" rules="rows" cellSpacing="0" cellPadding="0">
<%
		for(int i=0; i<listSize; i++){
			//첨부파일 링크
			String atchFileLink = atchFileLinks.item(i).getFirstChild() == null ? "" : atchFileLinks.item(i).getFirstChild().getNodeValue();
			//첨부파일 명
			String atchFileNm = atchFileNms.item(i).getFirstChild() == null ? "" : atchFileNms.item(i).getFirstChild().getNodeValue();
			//작물명
			String cropNm = cropNms.item(i).getFirstChild() == null ? "" : cropNms.item(i).getFirstChild().getNodeValue();
			//썸네일 이미지
			String imgFileLink = imgFileLinks.item(i).getFirstChild() == null ? "" : imgFileLinks.item(i).getFirstChild().getNodeValue();
			//주요특성
			String mainChartrInfo = mainChartrInfos.item(i).getFirstChild() == null ? "" : mainChartrInfos.item(i).getFirstChild().getNodeValue();
			//육성기관
			String unbrngInsttInfo = unbrngInsttInfos.item(i).getFirstChild() == null ? "" : unbrngInsttInfos.item(i).getFirstChild().getNodeValue();
			//육성년도
			String unbrngYear = unbrngYears.item(i).getFirstChild() == null ? "" : unbrngYears.item(i).getFirstChild().getNodeValue();
			//품종명
			String varietyNm = varietyNms.item(i).getFirstChild() == null ? "" : varietyNms.item(i).getFirstChild().getNodeValue();
%>
		<tr>
		    <td width="15%"><img src="<%=imgFileLink%>" width="128" height="103"></img></td>
		    <td width="85%">
		    	<table width="100%" cellSpacing="0" cellPadding="0">
		    		<tr>
		    			<td width="10%"><strong>ㆍ작물명</strong></td>
		    			<td><%=cropNm%></td>
		    			<td width="10%"><strong>ㆍ육성년도</strong></td>
		    			<td><%=unbrngYear%></td>
		    			<td width="10%"><strong>ㆍ육성기관</strong></td>
		    			<td><%=unbrngInsttInfo%></td>
		    		</tr>
		    		<tr>
		    			<td width="10%"><strong>ㆍ품종명</strong></td>
		    			<td colspan="5"><%=varietyNm%></td>
		    		</tr>
		    		<tr>
		    			<td width="10%"><strong>ㆍ주요특성</strong></td>
		    			<td colspan="5"><%=mainChartrInfo%></td>
		    		</tr>
		    		<tr>
		    			<td width="10%"><strong>ㆍ첨부파일</strong></td>
		    			<td colspan="5"><a href="<%=atchFileLink%>"><%=atchFileNm%></a></td>
		    		</tr>
		    	</table>
		    </td>
		</tr>
<%		
		}
%>
	</table>
<%
	}

//페이징 처리
	//한 페이지에 제공할 건수
	String numOfRows = "";
	//조회된 총 건수
	String totalCount = "";
	//조회할 페이지 번호
	String pageNo = "";
	try{numOfRows = listDoc.getElementsByTagName("numOfRows").item(0).getFirstChild().getNodeValue();}catch(Exception e){numOfRows = "";}
	try{totalCount = listDoc.getElementsByTagName("totalCount").item(0).getFirstChild().getNodeValue();}catch(Exception e){totalCount = "";}
	try{pageNo = listDoc.getElementsByTagName("pageNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){pageNo = "";}

	int pageGroupSize = 10;
	int pageSize = 0;
	try{
		pageSize = Integer.parseInt(numOfRows);
	}catch(Exception e){
		pageSize = 10;
	}
	int start = 0; 
	try{
		start = Integer.parseInt(pageNo);
	}catch(Exception e){
		start = 1;
	}
	
	int currentPage = 1;
	try{currentPage = Integer.parseInt(pageNo);}catch(Exception e){}

	int startRow = (currentPage - 1) * pageSize + 1;//한 페이지의 시작글 번호 
	int endRow = currentPage * pageSize;//한 페이지의 마지막 글번호           
	int count = Integer.parseInt( totalCount);                                                            
	int number=0;                                                             

		
	number=count-(currentPage-1)*pageSize;//글목록에 표시할 글번호                                                                  
    
	//페이지그룹의 갯수                                                                                                             
	//ex) pageGroupSize가 3일 경우 '[1][2][3]'가 pageGroupCount 개 만큼 있다.                                                       
	int pageGroupCount = count/(pageSize*pageGroupSize)+( count % (pageSize*pageGroupSize) == 0 ? 0 : 1);                           
	//페이지 그룹 번호                                                                                                              
	//ex) pageGroupSize가 3일 경우  '[1][2][3]'의 페이지그룹번호는 1 이고  '[2][3][4]'의 페이지그룹번호는 2 이다.                   
	int numPageGroup = (int) Math.ceil((double)currentPage/pageGroupSize);                                                          

	if(count > 0){
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		int startPage = pageGroupSize*(numPageGroup-1)+1;
		int endPage = startPage + pageGroupSize-1;
		int prtPageNo = 0;
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if(numPageGroup > 1){
			prtPageNo = (numPageGroup-2)*pageGroupSize+1;
			out.println("<a href='javascript:var_fncGoPage("+prtPageNo+");'>[이전]</a>");
		}
		
		for(int i=startPage; i<=endPage; i++){
			prtPageNo = i;
			out.print("<a href='javascript:var_fncGoPage("+prtPageNo+");'>");
			if(currentPage == i){
				out.print("<strong>["+i+"]</strong>");
			}else{
				out.print("["+i+"]");
			}
			out.println("</a>");
		}
		
		if(numPageGroup < pageGroupCount){
			prtPageNo = (numPageGroup*pageGroupSize+1);
			out.println("<a href='javascript:var_fncGoPage("+prtPageNo+");'>[다음]</a>");
		}
	}
}
//페이징 처리 끝
%>
</body>
</html>