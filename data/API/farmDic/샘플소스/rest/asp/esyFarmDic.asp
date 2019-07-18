<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>알기쉬운농업용어</title>
<script type='text/javascript'>

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "esyFarmDic.asp";
		target = "_self";
		submit();
	}
}

//검색하기
function dicSearch(cCode){
	with(document.searchApiForm){
		if(keyword.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        id.focus();
	        return false;
	    }else{
			method="get";
			action = "esyFarmDic.asp";
			target = "_self";
			submit();
		}
	}
}

//일치검색 상세보기
function equalDetail(lCode, lNm, wNm, wNo){
	with(document.equalApiForm){
		langCode.value=lCode;
		langNm.value=lNm;
		wordNm.value=wNm;
		wordNo.value=wNo;
		method="get";
		action = "esyFarmDic.asp";
		target = "_self";
		submit();
	}
}

//전방검색 상세보기
function frontDetail(lCode, lNm, wNm, wNo){
	with(document.frontApiForm){
		langCode.value=lCode;
		langNm.value=lNm;
		wordNm.value=wNm;
		wordNo.value=wNo;
		method="get";
		action = "esyFarmDic.asp";
		target = "_self";
		submit();
	}
}

// 시소로스 팝업 띄우기
function fncThesaurusOpen(faoCodeVal){
	var popupUrl="thesaurusPoP.asp?faoCode="+faoCodeVal;
	var popOption="width=800,height=600";

	window.open(popupUrl,"nongsaroPop",popOption);
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>알기쉬운농업용어</strong> | <strong><a href="farmDic.asp">농업용어사전</a></strong></h3>
<hr>
<form name="searchApiForm"><!-- 검색폼 -->
용&nbsp;어 : <input type="text" name="keyword" value="<%
	If Not Request("keyword") Is Nothing And Request("keyword") <> "" Then
		Response.Write(Request("keyword"))
	Else
		Response.Write("")
	End If
%>">
<input type="button" name="confirm" value="검색" onclick="return dicSearch()">
<input type="hidden" name="pageNo">
</form>

<form name="equalApiForm"><!-- 일치항목 선택시 폼 -->
<input type="hidden" name="keyword" value="<%=request("keyword")%>">
<input type="hidden" name="equalSearchType" value="searchEqualWord">
<input type="hidden" name="langCode" value="<%=request("langCode")%>">
<input type="hidden" name="langNm" value="<%=request("langNm")%>">
<input type="hidden" name="wordNm" value="<%=request("wordNm")%>">
<input type="hidden" name="wordNo" value="<%=request("wordNo")%>">
<input type="hidden" name="pageNo" value="<%=request("pageNo")%>">
<input type="hidden" name="wordType" value="B">
</form>

<form name="frontApiForm"><!-- 전방검색항목 선택시 폼 -->
<input type="hidden" name="keyword" value="<%=request("keyword")%>">
<input type="hidden" name="frontSearchType" value="searchFrontMatch">
<input type="hidden" name="langCode" value="<%=request("langCode")%>">
<input type="hidden" name="langNm" value="<%=request("langNm")%>">
<input type="hidden" name="wordNm" value="<%=request("wordNm")%>">
<input type="hidden" name="wordNo" value="<%=request("wordNo")%>">
<input type="hidden" name="pageNo" value="<%=request("pageNo")%>">
<input type="hidden" name="wordType" value="B">
</form>

<!--======================================================== 일치항목 부분 시작 ==================================================================-->

<%
If Not Request("keyword") Is Nothing And Request("keyword") <> "" Then
	Response.Write("<hr><h4>▷검색어 일치항목◁</h4>")

	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "searchEqualWord"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&word="&Server.URLEncode(Request("keyword"))
	parameter = parameter & "&wordType=B"

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

	If cnt = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<table width="100%" border="0">
		<colgroup>
			<col width="25%"/>
			<col width="75%"/>
		</colgroup>
		<tr valign="top">
			<td>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'언어 구분 코드
				If NOT itemNode.SelectSingleNode("langCode") is Nothing Then
					langCode = itemNode.SelectSingleNode("langCode").text
				End If
				'언어 구분 명
				If NOT itemNode.SelectSingleNode("langNm") is Nothing Then
					langNm = itemNode.SelectSingleNode("langNm").text
				End If
				'용어 명
				If NOT itemNode.SelectSingleNode("wordNm") is Nothing Then
					wordNm = itemNode.SelectSingleNode("wordNm").text
				End If
				'농업 용어 번호
				If NOT itemNode.SelectSingleNode("wordNo") is Nothing Then
					wordNo = itemNode.SelectSingleNode("wordNo").text
				End If
				'시소러스 정보
				If NOT itemNode.SelectSingleNode("faoCode") is Nothing Then
					faoCode = itemNode.SelectSingleNode("faoCode").text
				End If
			End If
	%>
			<a href="javascript:equalDetail('<%=langCode%>','<%=langNm%>','<%=wordNm%>','<%=wordNo%>');"><%=wordNm%></a>&nbsp;[<%=langNm%>]
			<% If faoCode <> "" Then %>
			<button type="button" onclick="javascript:fncThesaurusOpen('<%=faoCode%>')">시소러스정보</button>
			<% End If %>
			<br>
	<%
		   Set itemNode = Nothing
		Next
	End If
	Response.Write("</td>")
End If
%>
	<td>
<%
'일치검색 - 해당 단어의 용어 설명
If Not Request("equalSearchType") Is Nothing And Request("equalSearchType") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "detailWord"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&wordNo="&Request("wordNo")
	parameter = parameter & "&wordType=B"

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

    '농업 용어 번호
	Set farmngWordNo = xmlDOM.SelectNodes("//farmngWordNo")
	If Not farmngWordNo(0) Is Nothing Then farmngWordNoText= farmngWordNo(0).Text Else farmngWordNoText = "" End If
	'용어 설명
	Set wordDc = xmlDOM.SelectNodes("//wordDc")
	If Not wordDc(0) Is Nothing Then wordDcText= wordDc(0).Text Else wordDcText = "" End If
%>
	<table width="100%" border="0" rules="rows">
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tr valign="top">
			<td><strong>용어 설명</strong></td>
			<td><%=wordDcText %></td>
		</tr>
		<tr valign="top">
			<td><strong>유사 용어</strong></td>
			<td>
<%
End If
'[일치검색] 해당 단어의 유사 용어
If Not Request("equalSearchType") Is Nothing And Request("equalSearchType") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "detailLikeWordList"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&wordNo="&Request("wordNo")
	parameter = parameter & "&wordNm="&Request("wordNm")
	parameter = parameter & "&wordType=B"

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

	If cnt = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
		For i=0 To cnt-1
		    Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'언어 구분 명
				If NOT itemNode.SelectSingleNode("langNm") is Nothing Then
					langNm = itemNode.SelectSingleNode("langNm").text
				End If
				'용어 명
				If NOT itemNode.SelectSingleNode("wordNm") is Nothing Then
					wordNm = itemNode.SelectSingleNode("wordNm").text
				End If
			End If
			Response.Write("[" & langNm & "]  " & wordNm & "<br>")
		    Set itemNode = Nothing
		Next
		Response.Write("</td></tr></table>")
	End If
End If
%>
<% 	If Not Request("keyword") Is Nothing And Request("keyword") <> "" Then
		Response.Write("</td></tr></table>")
	End If
%>
<!--======================================================== 일치항목 부분 끝 ==================================================================-->
<hr>
<!--======================================================== 전방검색 부분  시작 ==================================================================-->
<%
If Not Request("keyword") Is Nothing And Request("keyword") <> "" Then
	Response.Write("<h4>▷검색어 일치항목◁</h4>")

	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "searchFrontMatch"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&word="&Server.URLEncode(Request("keyword"))
	parameter = parameter & "&pageNo=" & Request("pageNo")
	parameter = parameter & "&wordType=B"

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

	Set frontXmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")
	frontXmlDOM.async = False
	frontXmlDOM.LoadXML sText
	'농사 Open API 통신 끝

	Set listItem = frontXmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt-3 = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<table width="100%" border="0">
		<colgroup>
			<col width="25%"/>
			<col width="75%"/>
		</colgroup>
		<tr valign="top">
			<td>
<%
		For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'언어 구분 코드
				If NOT itemNode.SelectSingleNode("langCode") is Nothing Then
					langCode = itemNode.SelectSingleNode("langCode").text
				End If
				'언어 구분 명
				If NOT itemNode.SelectSingleNode("langNm") is Nothing Then
					langNm = itemNode.SelectSingleNode("langNm").text
				End If
				'용어 명
				If NOT itemNode.SelectSingleNode("wordNm") is Nothing Then
					wordNm = itemNode.SelectSingleNode("wordNm").text
				End If
				'농업 용어 번호
				If NOT itemNode.SelectSingleNode("wordNo") is Nothing Then
					wordNo = itemNode.SelectSingleNode("wordNo").text
				End If
				'시소러스 정보
				If NOT itemNode.SelectSingleNode("faoCode") is Nothing Then
					faoCode = itemNode.SelectSingleNode("faoCode").text
				End If
			End If
	%>
			<a href="javascript:frontDetail('<%=langCode%>','<%=langNm%>','<%=request("keyword")%>','<%=wordNo%>');"><%=wordNm%></a>&nbsp;[<%=langNm%>]
			<% If faoCode <> "" Then %>
			<button type="button" onclick="javascript:fncThesaurusOpen('<%=faoCode%>')">시소러스정보</button>
			<% End If %>
			<br>
	<%
		   Set itemNode = Nothing
		Next
	End If
	Response.Write("</td>")
End If
%>
	<td>
<%
'[전방검색] 해당 단어의 용어 설명
If Not Request("frontSearchType") Is Nothing And Request("frontSearchType") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "detailWord"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&wordNo="&Request("wordNo")
	parameter = parameter & "&wordType=B"

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

    '농업 용어 번호
	Set farmngWordNo = xmlDOM.SelectNodes("//farmngWordNo")
	If Not farmngWordNo(0) Is Nothing Then farmngWordNoText= farmngWordNo(0).Text Else farmngWordNoText = "" End If
	'용어 설명
	Set wordDc = xmlDOM.SelectNodes("//wordDc")
	If Not wordDc(0) Is Nothing Then wordDcText= wordDc(0).Text Else wordDcText = "" End If
%>
	<table width="100%" border="0" rules="rows">
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tr valign="top">
			<td><strong>용어 설명</strong></td>
			<td><%=wordDcText %></td>
		</tr>
		<tr valign="top">
			<td><strong>유사 용어</strong></td>
			<td>
<%
End If

'[전방검색] 해당 단어의 유사 용어
If Not Request("frontSearchType") Is Nothing And Request("frontSearchType") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "detailLikeWordList"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&wordNo="&Request("wordNo")
	parameter = parameter & "&wordNm="&Request("wordNm")
	parameter = parameter & "&wordType=B"

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

	If cnt = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
		For i=0 To cnt-1
		    Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'언어 구분 명
				If NOT itemNode.SelectSingleNode("langNm") is Nothing Then
					langNm = itemNode.SelectSingleNode("langNm").text
				End If
				'용어 명
				If NOT itemNode.SelectSingleNode("wordNm") is Nothing Then
					wordNm = itemNode.SelectSingleNode("wordNm").text
				End If
			End If
			Response.Write("[" & langNm & "]  " & wordNm & "<br>")
		    Set itemNode = Nothing
		Next
		Response.Write("</td></tr></table>")
	End If
End If
%>
<% 	If Not Request("keyword") Is Nothing And Request("keyword") <> "" Then
		Response.Write("</td></tr></table>")
	End If
%>
<!--======================================================== 전방검색 부분 끝 ==================================================================-->
<%
'페이징 처리
If Not Request("keyword") Is Nothing And Request("keyword") <> "" Then
'페이징 처리를 위한 값 받기
	'한 페이지에 제공할 건수
	Set numOfRows = frontXmlDOM.SelectNodes("//numOfRows")
	If Not numOfRows(0) Is Nothing Then numOfRowsText= numOfRows(0).Text Else numOfRowsText = "10" End If
	'조회할 페이지 번호
	Set pageNo = frontXmlDOM.SelectNodes("//pageNo")
	If Not pageNo(0) Is Nothing Then pageNoText= pageNo(0).Text Else pageNoText = "1" End If
	'조회된 총 건수
	Set totalCount = frontXmlDOM.SelectNodes("//totalCount")
	If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "" End If

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
			Response.Write("<a href='javascript:fncGoPage("&prtPageNo&");'>[이전]</a>")
		End If

		i=startPage
		While i<=endPage

			prtPageNo = i
			Response.Write("<a href='javascript:fncGoPage("&prtPageNo&");'>")

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
			Response.Write("<a href='javascript:fncGoPage("&prtPageNo&");'>[다음]</a>")
		End If
	End If
End If
%>
</body>
</html>