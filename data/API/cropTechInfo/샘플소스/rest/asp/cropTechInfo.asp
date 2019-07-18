<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>작목기술 서비스</title>
<script type="text/javascript">

//메인 카테고리 항목
function mainMove(){
	with(document.searchInsttForm){
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}

//비디오 페이지 이동
function fncMoiveGoPage(page){
	with(document.videoListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}
//기술정보 페이지 이동
function fncSubtechGoPage(page){
	with(document.techInfoListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}
//품목정보 페이지 이동
function fncVarietyGoPage(page){
	with(document.varietyListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}

//미들 카테고리 항목
function middleMove(mCode){
	with(document.mainApiForm){
		mainCategoryCode.value = mCode;
		method="post";
		action = "cropTechInfo.asp";
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
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}

//서브 테크 항목
function subTechMove(mCode){
	with(document.subTechApiForm){
		mainTechCode.value = mCode;
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}

//동영상리스트
function videoListMove(){
	with(document.videoListApiForm){
		method="post";
		action = "cropTechInfo.asp";
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

//기술정보 목록 조회
function techInfoMove(sCode){
	with(document.techInfoListApiForm){
		subTechCode.value = sCode;
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}
//품종정보 목록 조회
function varietyList(){
	with(document.varietyListApiForm){
		method="post";
		action = "cropTechInfo.asp";
		target = "_self";
		submit();
	}
}

function fncSearch(){
	with(document.searchInsttForm){
		method="post";
		action = "cropTechInfo.asp";
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
'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
apiKey = "인증키를등록해주세요"

'서비스 명
serviceName = "cropTechInfo"

'기관코드 등록
insttCode = ""
If Not Request("insttCode") Is Nothing And Request("insttCode") <> "" Then
	insttCode = Request("insttCode")
End If

'기관명
insttName = ""
If Not Request("insttName") Is Nothing And Request("insttName") <> "" Then
	insttName = Request("insttName")
End If

'작물명 검색
subCategoryNm = ""
If Not Request("subCategoryNm") Is Nothing And Request("subCategoryNm") <> "" Then
	subCategoryNm = Request("subCategoryNm")
End If

'제목 검색
subject = ""
If Not Request("subject") Is Nothing And Request("subject") <> "" Then
	subject = Request("subject")
End If

%>

<form name="mainApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=Request("mainCategoryCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="mainTechApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=Request("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=Request("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=Request("subCategoryCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="subTechApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=Request("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=Request("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=Request("subCategoryCode")%>">
<input type="hidden" name="mainTechCode" value="<%=Request("mainTechCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="videoListApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=Request("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=Request("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=Request("subCategoryCode")%>">
<input type="hidden" name="movieCheck" value="1">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="pageNo">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="techInfoListApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=Request("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=Request("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=Request("subCategoryCode")%>">
<input type="hidden" name="mainTechCode" value="<%=Request("mainTechCode")%>">
<input type="hidden" name="subTechCode" value="<%=Request("subTechCode")%>">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<form name="varietyListApiForm">
<input type="hidden" name="mainCategoryCode" value="<%=Request("mainCategoryCode")%>">
<input type="hidden" name="middleCategoryCode" value="<%=Request("middleCategoryCode")%>">
<input type="hidden" name="subCategoryCode" value="<%=Request("subCategoryCode")%>">
<input type="hidden" name="mainTechCode" value="<%=Request("mainTechCode")%>">
<input type="hidden" name="varietyCheck" value="1">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
<input type="hidden" name="subCategoryNm" value="<%=subCategoryNm%>">
<input type="hidden" name="subject" value="<%=subject%>">
</form>

<%

'기관 코드
If true Then
	'오퍼레이션 명
	operationName = "insttList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&insttCode="&insttCode
	'작물명검색
	parameter = parameter & "&subCategoryNm="&subCategoryNm
	'제목 검색
	parameter = parameter & "&subject="&subject
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt=0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<form name="searchInsttForm">
	<input type="hidden" name="insttCode" value="<%=insttCode%>">
		기관명&nbsp;
		<select name="insttName" onchange="mainMove();">
		<option value="">선택하세요</option>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'기관명
				If NOT itemNode.SelectSingleNode("codeNm") is Nothing Then
					codeNm = itemNode.SelectSingleNode("codeNm").text
				End If
			End If
%>
			<option value="<%=codeNm%>" <%If codeNm = Request("insttName") Then Response.Write("selected") Else Response.Write("") End If%>><%=codeNm%></option>
<%
		   Set itemNode = Nothing
		Next
%>
	</select>
	작목명&nbsp;
	<input type="text" id="subCategoryNm" name="subCategoryNm" value="<%=subCategoryNm%>">
	제목&nbsp;
	<input type="text" id="subject" name="subject" value="<%=subject%>">
	<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
<%

	Response.Write("</form>")
	End If
End If
%>

<%
'대분류 카테고리
If true Then
	'오퍼레이션 명
	operationName = "mainCategoryList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&insttCode="&insttCode
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt=0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'대분류 카테고리 명
				If NOT itemNode.SelectSingleNode("mainCategoryNm") is Nothing Then
					mainCategoryNm = itemNode.SelectSingleNode("mainCategoryNm").text
				End If
				'대분류 카테고리 코드
				If NOT itemNode.SelectSingleNode("mainCategoryCode") is Nothing Then
					mainCategoryCode = itemNode.SelectSingleNode("mainCategoryCode").text
				End If
			End If
%>
			<td width="11%" align="center"><a href="javascript:middleMove('<%=mainCategoryCode%>');"><%=mainCategoryNm%></a></td>
<%
		   Set itemNode = Nothing
		Next
	Response.Write("</tr></table>")
	End If
End If
%>

<%
'중분류 카테고리
If Not Request("mainCategoryCode") Is Nothing And Request("mainCategoryCode") <> "" Then
	'오퍼레이션 명
	operationName = "middleCategoryList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&mainCategoryCode=" & Request("mainCategoryCode")
	parameter = parameter & "&insttCode="&insttCode
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt=0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<table width="100%" rules="rows" cellSpacing="0" cellPadding="0">
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'중분류 카테고리 명
				If NOT itemNode.SelectSingleNode("middleCategoryNm") is Nothing Then
					middleCategoryNm = itemNode.SelectSingleNode("middleCategoryNm").text
				End If
				'중분류 카테고리 코드
				If NOT itemNode.SelectSingleNode("middleCategoryCode") is Nothing Then
					middleCategoryCode = itemNode.SelectSingleNode("middleCategoryCode").text
				End If
			End If
%>
		<tr>
			<td width="15%"><strong><%=middleCategoryNm%></strong></td> 			
 			<td width="85%"><table width="100%"><tr>
<%
		'소분류 카테고리
			'오퍼레이션 명
			operationName_Sub = "subCategoryList"
	
			'XML 받을 URL 생성
			parameter_Sub = "/" & serviceName & "/" & operationName_Sub
			parameter_Sub = parameter_Sub & "?apiKey=" & apiKey
			parameter_Sub = parameter_Sub & "&middleCategoryCode=" & middleCategoryCode
			parameter_Sub = parameter_Sub & "&insttCode=" & insttCode
			parameter_Sub = parameter_Sub & "&insttName=" & Server.URLEncode(insttName)
			'작물명검색
			parameter_Sub = parameter_Sub & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
			'제목 검색
			parameter_Sub = parameter_Sub & "&subject="&Server.URLEncode(subject)
			
			targetURL = "http://api.nongsaro.go.kr/service" & parameter_Sub
			
			'농사로 Open API 통신 시작
			Set xmlHttp_Sub = Server.CreateObject("Microsoft.XMLHTTP")    
			xmlHttp_Sub.Open "GET", targetURL, False   
			xmlHttp_Sub.Send    
			
			Set oStream_Sub = CreateObject("ADODB.Stream")
			oStream_Sub.Open   
			oStream_Sub.Position = 0   
			oStream_Sub.Type = 1   
			oStream_Sub.Write xmlHttp_Sub.ResponseBody   
			oStream_Sub.Position = 0   
			oStream_Sub.Type = 2   
			oStream_Sub.Charset = "utf-8"   
			sText = oStream_Sub.ReadText   
			oStream_Sub.Close   
			
			Set xmlDOM_Sub = server.CreateObject("MSXML.DOMDOCUMENT")   
			xmlDOM_Sub.async = False    
			xmlDOM_Sub.LoadXML sText   
			'농사 Open API 통신 끝
			     
			Set listItem = xmlDOM_Sub.SelectNodes("//items")
			cnt_Sub = listItem(0).childNodes.length
			Set items_Sub = listItem(0).childNodes
			
			For j=0 To cnt_Sub-1
				Set itemNode = items_Sub.item(j)
				If NOT itemNode Is Nothing Then
					'소분류 카테고리 명
					If NOT itemNode.SelectSingleNode("subCategoryNm") is Nothing Then
						subCategoryNm1 = itemNode.SelectSingleNode("subCategoryNm").text
					End If
					'소분류 카테고리 코드
					If NOT itemNode.SelectSingleNode("subCategoryCode") is Nothing Then
						subCategoryCode = itemNode.SelectSingleNode("subCategoryCode").text
					End If
				End If
				
				If j mod 4=0 Then
					Response.Write("</tr><tr>")
				End if
				
%>
				<td width="25%">&nbsp;│&nbsp;<a href="javascript:mainTechMove('<%=subCategoryCode%>', '<%=middleCategoryCode%>');"><%=subCategoryNm1%></a></td>
<%
			   Set itemNode = Nothing
			Next
			
			If Cint(cnt_Sub)=1 Then
				Response.Write("<td width='25%'></td><td width='25%'></td><td width='25%'></td>")
			End If
			If Cint(cnt_Sub)=2 Then
				Response.Write("<td width='25%'></td><td width='25%'></td>")
			End If			
			If Cint(cnt_Sub)=3 Then
				Response.Write("<td width='25%'></td>")
			End If
			
			Response.Write("</tr></table></tr>")
			
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
End If
%>

<%
'대분류 기술 코드
If Not Request("subCategoryCode") Is Nothing And Request("subCategoryCode") <> "" Then
	'오퍼레이션 명
	operationName = "mainTechList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&subCategoryCode=" & Request("subCategoryCode")
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt=0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'대분류 기술 명
				If NOT itemNode.SelectSingleNode("mainTechNm") is Nothing Then
					mainTechNm = itemNode.SelectSingleNode("mainTechNm").text
				End If
				'대분류 기술 코드 명
				If NOT itemNode.SelectSingleNode("mainTechCode") is Nothing Then
					mainTechCode = itemNode.SelectSingleNode("mainTechCode").text
				End If
			End If
			
			If mainTechCode="movie" Then
%>
				<td align="center"><a href="javascript:videoListMove();"><%=mainTechNm%></a></td>
<%
			Else
				
%>
				<td align="center"><a href="javascript:subTechMove('<%=mainTechCode%>');"><%=mainTechNm%></a></td>
<%
			End if
			Set itemNode = Nothing
		Next
		Response.Write("</tr></table>")
	End If
End If
%>

<%
'동영상 목록 조회
If Not Request("movieCheck") Is Nothing And Request("movieCheck") <> "" Then
	'오퍼레이션 명
	operationName = "videoList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&subCategoryCode=" & Request("subCategoryCode")
	parameter = parameter & "&pageNo=" & Request("pageNo")
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes
	
'페이징 처리를 위한 값 받기
	'한 페이지에 제공할 건수
	Set numOfRows = xmlDOM.SelectNodes("//numOfRows")
	If Not numOfRows(0) Is Nothing Then numOfRowsText= numOfRows(0).Text Else numOfRowsText = "10" End If
	'조회할 페이지 번호
	Set pageNo = xmlDOM.SelectNodes("//pageNo")
	If Not pageNo(0) Is Nothing Then pageNoText= pageNo(0).Text Else pageNoText = "1" End If
	'조회된 총 건수
	Set totalCount = xmlDOM.SelectNodes("//totalCount")
	If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "" End If
	
	If cnt-3 = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<table border="1" cellSpacing="0" cellPadding="0">
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
		For i=0 To cnt-4
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'비디오 썸네일 이미지 링크
				If NOT itemNode.SelectSingleNode("videoImg") is Nothing Then
					videoImg = itemNode.SelectSingleNode("videoImg").text
				End If
				'비디오 링크
				If NOT itemNode.SelectSingleNode("videoLink") is Nothing Then
					videoLink = itemNode.SelectSingleNode("videoLink").text
				End If
				'동영상 출처
				If NOT itemNode.SelectSingleNode("videoOriginInstt") is Nothing Then
					videoOriginInstt = itemNode.SelectSingleNode("videoOriginInstt").text
				End If
				'동영상 제목
				If NOT itemNode.SelectSingleNode("videoTitle") is Nothing Then
					videoTitle = itemNode.SelectSingleNode("videoTitle").text
				End If
			End If
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
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
	
	'페이징 처리
	function ceil(x)

        dim temp
        temp = Round(x)
        if temp < x then
            temp = temp + 1
        end if
        ceil = temp
    end function

	pageGroupSize = 10
	pageSize = Int(numOfRowsText)


	start = Int(pageNoText)
	
	currentPage = Int(pageNoText)

	startRow = (currentPage - 1) * pageSize + 1
	endRow = currentPage * pageSize
	count = Int(totalCountText)
	number=0                                                    
		
	number=count-(currentPage-1)*pageSize    
	
	pageGroupCount = count/(pageSize*pageGroupSize)

	numPageGroup = Int(ceil(currentPage/pageGroupSize))

	If count > 0 Then
		pageCount = Int(count / pageSize)


		If (count Mod pageSize) = 0 Then
			pageCount = pageCount + 0
		Else
			pageCount = pageCount + 1
		End If

		startPage = pageGroupSize*(numPageGroup-1)+1
		endPage = startPage + pageGroupSize-1
		prtPageNo = 0
		
		If endPage > pageCount Then
			endPage = pageCount
		End If

		If numPageGroup > 1 Then
			prtPageNo = (numPageGroup-2)*pageGroupSize+1
			Response.Write("<a href='javascript:fncMoiveGoPage("&prtPageNo&");'>[이전]</a>")
		End If

		i=startPage
		While i<=endPage

			prtPageNo = i
			Response.Write("<a href='javascript:fncMoiveGoPage("&prtPageNo&");'>")

			If currentPage = i Then
				Response.Write("<strong>["&i&"]</strong>")
			Else
				Response.Write("["&i&"]")
			End If

			Response.Write("</a>")

			i = i+1
		Wend

		If numPageGroup < pageGroupCount Then
			prtPageNo = (numPageGroup*pageGroupSize+1)
			Response.Write("<a href='javascript:fncMoiveGoPage("&prtPageNo&");'>[다음]</a>")
		End If
	End If
	'페이징처리 끝
End If
%>

<%
'소분류 기술코드 조회
If Not Request("mainTechCode") Is Nothing And Request("mainTechCode") <> "" Then
	'오퍼레이션 명
	operationName = "subTechList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&mainCategoryCode=" & Request("mainCategoryCode")
	parameter = parameter & "&middleCategoryCode=" & Request("middleCategoryCode")
	parameter = parameter & "&subCategoryCode=" & Request("subCategoryCode")
	parameter = parameter & "&mainTechCode=" & Request("mainTechCode")
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt=0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'소분류 기술 코드 명
				If NOT itemNode.SelectSingleNode("subTechNm") is Nothing Then
					subTechNm = itemNode.SelectSingleNode("subTechNm").text
				End If
				'소분류 기술 코드
				If NOT itemNode.SelectSingleNode("subTechCode") is Nothing Then
					subTechCode = itemNode.SelectSingleNode("subTechCode").text
				End If
			End If
				
			If subTechCode="variety" Then
%>
				&nbsp;│&nbsp;<a href="javascript:varietyList();"><%=subTechNm%></a>
<%
			Else
%>
				&nbsp;│&nbsp;<a href="javascript:techInfoMove('<%=subTechCode%>');"><%=subTechNm%></a>
<%
			End If
			Set itemNode = Nothing
		Next
	End If
End If
%>

<%
'기술 정보 목록 조회
If Not Request("subTechCode") Is Nothing And Request("subTechCode") <> "" Then
	'오퍼레이션 명
	operationName = "techInfoList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&subCategoryCode=" & Request("subCategoryCode")
	parameter = parameter & "&subTechCode=" & Request("subTechCode")
	parameter = parameter & "&pageNo=" & Request("pageNo")
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes
	
'페이징 처리를 위한 값 받기
	'한 페이지에 제공할 건수
	Set numOfRows = xmlDOM.SelectNodes("//numOfRows")
	If Not numOfRows(0) Is Nothing Then numOfRowsText= numOfRows(0).Text Else numOfRowsText = "10" End If
	'조회된 페이지 번호
	Set pageNo = xmlDOM.SelectNodes("//pageNo")
	If Not pageNo(0) Is Nothing Then pageNoText= pageNo(0).Text Else pageNoText = "1" End If
	'조회된 총 건수
	Set totalCount = xmlDOM.SelectNodes("//totalCount")
	If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "" End If
	
	If cnt=0 Then
			Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
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
		For i=0 To cnt-4
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'첨부파일 다운로드 URL
				If NOT itemNode.SelectSingleNode("fileDownUrl") is Nothing Then
					fileDownUrl = itemNode.SelectSingleNode("fileDownUrl").text
				End If
				'등록일자
				If NOT itemNode.SelectSingleNode("regDt") is Nothing Then
					regDt = itemNode.SelectSingleNode("regDt").text
				End If
				'기술정보제목
				If NOT itemNode.SelectSingleNode("techNm") is Nothing Then
					techNm = itemNode.SelectSingleNode("techNm").text
				End If
			End If
%>
			<tr>
				<td><%=techNm%></td>
				<td align="center"><%=regDt %></td>
				<td align="center"><a href="<%=fileDownUrl%>">파일다운로드</a></td>
			</tr>
<%
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
	
	'페이징 처리
	function ceil(x)

        dim temp
        temp = Round(x)
        if temp < x then
            temp = temp + 1
        end if
        ceil = temp
    end function


	pageGroupSize = 10
	pageSize = Int(numOfRowsText)


	start = Int(pageNoText)
	
	currentPage = Int(pageNoText)

	startRow = (currentPage - 1) * pageSize + 1
	endRow = currentPage * pageSize
	count = Int(totalCountText)
	number=0                                                    
		
	number=count-(currentPage-1)*pageSize    
	
	pageGroupCount = count/(pageSize*pageGroupSize)

	numPageGroup = Int(ceil(currentPage/pageGroupSize))

	If count > 0 Then
		pageCount = Int(count / pageSize)


		If (count Mod pageSize) = 0 Then
			pageCount = pageCount + 0
		Else
			pageCount = pageCount + 1
		End If

		startPage = pageGroupSize*(numPageGroup-1)+1
		endPage = startPage + pageGroupSize-1
		prtPageNo = 0
		
		If endPage > pageCount Then
			endPage = pageCount
		End If

		If numPageGroup > 1 Then
			prtPageNo = (numPageGroup-2)*pageGroupSize+1
			Response.Write("<a href='javascript:fncSubtechGoPage("&prtPageNo&");'>[이전]</a>")
		End If

		i=startPage
		While i<=endPage

			prtPageNo = i
			Response.Write("<a href='javascript:fncSubtechGoPage("&prtPageNo&");'>")

			If currentPage = i Then
				Response.Write("<strong>["&i&"]</strong>")
			Else
				Response.Write("["&i&"]")
			End If

			Response.Write("</a>")

			i = i+1
		Wend

		If numPageGroup < pageGroupCount Then
			prtPageNo = (numPageGroup*pageGroupSize+1)
			Response.Write("<a href='javascript:fncSubtechGoPage("&prtPageNo&");'>[다음]</a>")
		End If
	End If
	'페이징처리 끝
End If
%>

<%
'품목정보 목록 조회
If Not Request("varietyCheck") Is Nothing And Request("varietyCheck") <> "" Then
	'오퍼레이션 명
	operationName = "varietyList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&subCategoryCode=" & Request("subCategoryCode")
	parameter = parameter & "&pageNo=" & Request("pageNo")
	'작물명검색
	parameter = parameter & "&subCategoryNm="&Server.URLEncode(subCategoryNm)
	'제목 검색
	parameter = parameter & "&subject="&Server.URLEncode(subject)

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes
	
'페이징 처리를 위한 값 받기
	'한 페이지에 제공할 건수
	Set numOfRows = xmlDOM.SelectNodes("//numOfRows")
	If Not numOfRows(0) Is Nothing Then numOfRowsText= numOfRows(0).Text Else numOfRowsText = "10" End If
	'조회할 페이지 번호
	Set pageNo = xmlDOM.SelectNodes("//pageNo")
	If Not pageNo(0) Is Nothing Then pageNoText= pageNo(0).Text Else pageNoText = "1" End If
	'조회된 총 건수
	Set totalCount = xmlDOM.SelectNodes("//totalCount")
	If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "" End If
	
	If cnt=0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<table width="100%" rules="rows" cellSpacing="0" cellPadding="0">
<%
		For i=0 To cnt-4
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'첨부파일 링크
				If NOT itemNode.SelectSingleNode("atchFileLink") is Nothing Then
					atchFileLink = itemNode.SelectSingleNode("atchFileLink").text
				End If
				'첨부파일 명
				If NOT itemNode.SelectSingleNode("atchFileNm") is Nothing Then
					atchFileNm = itemNode.SelectSingleNode("atchFileNm").text
				End If
				'작물명
				If NOT itemNode.SelectSingleNode("cropNm") is Nothing Then
					cropNm = itemNode.SelectSingleNode("cropNm").text
				End If
				'썸네일 이미지
				If NOT itemNode.SelectSingleNode("imgFileLink") is Nothing Then
					imgFileLink = itemNode.SelectSingleNode("imgFileLink").text
				End If
				'주요특성
				If NOT itemNode.SelectSingleNode("mainChartrInfo") is Nothing Then
					mainChartrInfo = itemNode.SelectSingleNode("mainChartrInfo").text
				End If
				'육성기관
				If NOT itemNode.SelectSingleNode("unbrngInsttInfo") is Nothing Then
					unbrngInsttInfo = itemNode.SelectSingleNode("unbrngInsttInfo").text
				End If
				'육성년도
				If NOT itemNode.SelectSingleNode("unbrngYear") is Nothing Then
					unbrngYear = itemNode.SelectSingleNode("unbrngYear").text
				End If
				'품종명
				If NOT itemNode.SelectSingleNode("varietyNm") is Nothing Then
					varietyNm = itemNode.SelectSingleNode("varietyNm").text
				End If
			End If
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
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
	
	'페이징 처리
	function ceil(x)

        dim temp
        temp = Round(x)
        if temp < x then
            temp = temp + 1
        end if
        ceil = temp
    end function

	pageGroupSize = 10
	pageSize = Int(numOfRowsText)

	start = Int(pageNoText)
	
	currentPage = Int(pageNoText)

	startRow = (currentPage - 1) * pageSize + 1
	endRow = currentPage * pageSize
	count = Int(totalCountText)
	number=0                                                    
		
	number=count-(currentPage-1)*pageSize    
	
	pageGroupCount = count/(pageSize*pageGroupSize)

	numPageGroup = Int(ceil(currentPage/pageGroupSize))

	If count > 0 Then
		pageCount = Int(count / pageSize)


		If (count Mod pageSize) = 0 Then
			pageCount = pageCount + 0
		Else
			pageCount = pageCount + 1
		End If

		startPage = pageGroupSize*(numPageGroup-1)+1
		endPage = startPage + pageGroupSize-1
		prtPageNo = 0
		
		If endPage > pageCount Then
			endPage = pageCount
		End If

		If numPageGroup > 1 Then
			prtPageNo = (numPageGroup-2)*pageGroupSize+1
			Response.Write("<a href='javascript:fncVarietyGoPage("&prtPageNo&");'>[이전]</a>")
		End If

		i=startPage
		While i<=endPage

			prtPageNo = i
			Response.Write("<a href='javascript:fncVarietyGoPage("&prtPageNo&");'>")

			If currentPage = i Then
				Response.Write("<strong>["&i&"]</strong>")
			Else
				Response.Write("["&i&"]")
			End If

			Response.Write("</a>")

			i = i+1
		Wend

		If numPageGroup < pageGroupCount Then
			prtPageNo = (numPageGroup*pageGroupSize+1)
			Response.Write("<a href='javascript:fncVarietyGoPage("&prtPageNo&");'>[다음]</a>")
		End If
	End If
	'페이징처리 끝
End If
%>
</body>
</html>