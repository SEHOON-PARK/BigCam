<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>민간약초</title>
<script type='text/javascript'>

//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "prvateTherpy_D.asp";
		target = "_self";
		submit();
	}
}

//검색
function fncSearch(){
	with(document.searchApiForm){
		if(sText.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        sText.focus();
	        return false;
	    }else{
	    	pageNo.value = "1";
			method="get";
			action = "prvateTherpyList.asp";
			target = "_self";
			submit();
		}
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "prvateTherpyList.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>민간약초</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request("pageNo")%>">
<select name="sType">
	<option value="sCntntsSj" <%If request("sType")="sCntntsSj" Then Response.Write("selected") Else Response.Write("") End If%>>명칭</option>
	<option value="sBneNm" <%If request("sType")="sBneNm" Then Response.Write("selected") Else Response.Write("") End If%>>학명</option>
	<option value="sHbdcNm" <%If request("sType")="sHbdcNm" Then Response.Write("selected") Else Response.Write("") End If%>>생약명</option>
</select>
<input type="text" name="sText" value="<%If Request("sText") Is Nothing Then Response.write("") Else Response.write(Request("sText")) End If%>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<!-- =================================================== 메인 카테고리 시작 ================================================================================ -->

<%
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "prvateTherpy"
	'오퍼레이션 명
	operationName = "prvateTherpyList"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&sType=" & Request("sType")
	parameter = parameter & "&sText=" & Server.URLEncode(Request("sText"))
	parameter = parameter & "&pageNo=" & Request("pageNo")

	'검색 조건
	If Not Request("sType") Is Nothing And Request("sType") <> "" Then
		parameter = parameter & "&sType=" & Request("sType")
	End If
	'검색어
	If Not Request("sText") Is Nothing And Request("sText") <> "" Then
		parameter = parameter & "&sText=" & Server.URLEncode(Request("sText"))
	End If

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
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
		</colgroup>
		<tr>
			<th>이미지</th>
			<th>명칭</th>
			<th>학명</th>
			<th>생약명</th>
		</tr>
<%
		For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'키값
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'명칭
				If NOT itemNode.SelectSingleNode("cntntsSj") is Nothing Then
					cntntsSj = itemNode.SelectSingleNode("cntntsSj").text
				End If
				'학명
				If NOT itemNode.SelectSingleNode("bneNm") is Nothing Then
					bneNm = itemNode.SelectSingleNode("bneNm").text
				End If
				'생약명
				If NOT itemNode.SelectSingleNode("hbdcNm") is Nothing Then
					hbdcNm = itemNode.SelectSingleNode("hbdcNm").text
				End If
				'썸네일 이미지
				If NOT itemNode.SelectSingleNode("thumbImgUrl") is Nothing Then
					thumbImgUrl = itemNode.SelectSingleNode("thumbImgUrl").text
				End If
				'원본 이미지
				If NOT itemNode.SelectSingleNode("imgUrl") is Nothing Then
					imgUrl = itemNode.SelectSingleNode("imgUrl").text
				End If
			End If

%>
		<tr>
			<td align="center"><img src="<%=imgUrl%>" alt="<%=cntntsSj%>" style="max-width:250px; height:auto;" /></td>
			<td align="center"><a href="javascript:;move('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
			<td align="center"><%=bneNm%></td>
			<td align="center"><%=hbdcNm%></td>
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
	'페이징처리 끝
%>
</body>
</html>