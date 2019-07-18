<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>진로체험</title>
<script type='text/javascript'>

//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "schoolGarden_D.asp";
		target = "_self";
		submit();
	}
}
function fncTabChg(type){
	with(document.searchApiForm){
		pageNo.value = "1";
		menuType.value=type;
		method="get";
		action = "schoolGarden.asp";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "schoolGarden.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>진로체험</strong></h3>
<hr>
<%
	menuType = "PS03962"
	If Not Request("menuType") Is Nothing And Request("menuType") <> "" Then
		menuType=Request("menuType")
	End If
%>
<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request("pageNo")%>">
<input type="hidden" name="menuType" value="">
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">
		<a href="javascript:fncTabChg('PS03962');">  <% If menuType = "PS03962" Then %> <strong>토마토 재배부터 판매까지</strong> <% Else  %>토마토 재배부터 판매까지<% End If %> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('PS04127');">  <% If menuType = "PS04127" Then %> <strong>씨앗부터 플라워 카페까지</strong> <% Else  %>씨앗부터 플라워 카페까지<% End If %> </a>
	</td>
</tr>
</table>
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">
	분류
	</td>
	<td align="center">
	<select name="code">
<%
		'apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
		apiKey="nongsaroSampleKey"

		'서비스 명
		serviceName="schoolGarden"

		'오퍼레이션 명
		operationName="cmmCodeInfo"

		'XML 받을 URL 생성
		parameter = "/" & serviceName & "/" & operationName
		parameter = parameter & "?apiKey="&apiKey

		sub_targetURL = "http://api.nongsaro.go.kr/service" & parameter

		'농사로 Open API 통신 시작
		Set sub_xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
		sub_xmlHttp.Open "GET", sub_targetURL, False
		sub_xmlHttp.Send

		Set sub_oStream = CreateObject("ADODB.Stream")
		sub_oStream.Open
		sub_oStream.Position = 0
		sub_oStream.Type = 1
		sub_oStream.Write sub_xmlHttp.ResponseBody
		sub_oStream.Position = 0
		sub_oStream.Type = 2
		sub_oStream.Charset = "utf-8"
		sub_sText = sub_oStream.ReadText
		sub_oStream.Close

		Set sub_xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")
		sub_xmlDOM.async = False
		sub_xmlDOM.LoadXML sub_sText
		'농사 Open API 통신 끝

		Set sub_listItem = sub_xmlDOM.SelectNodes("//items")
		sub_cnt = sub_listItem(0).childNodes.length
		Set sub_items = sub_listItem(0).childNodes
		For i=0 To sub_cnt-1
		   Set sub_itemNode = sub_items.item(i)
			If NOT sub_itemNode Is Nothing Then
				'코드
				If NOT sub_itemNode.SelectSingleNode("code") is Nothing Then
					code = sub_itemNode.SelectSingleNode("code").text
				End If
				'코드명
				If NOT sub_itemNode.SelectSingleNode("codeNm") is Nothing Then
					codeNm = sub_itemNode.SelectSingleNode("codeNm").text
				End If
			End If
%>
			<option value="<%=code%>" <%If code = Request("code") Then Response.Write("selected") Else Response.Write("") End If%>><%=codeNm%></option>
<%
		   Set sub_itemNode = Nothing
		Next
		Response.Write("</select></td></tr>")

%>
</table>
</form>

<!-- =================================================== 메인 카테고리 시작 ================================================================================ -->

<%
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "schoolGarden"
	'오퍼레이션 명
	operationName = "schoolGardenList"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&pageNo=" & Request("pageNo")
	parameter = parameter & "&menuId=" & menuType

	'분류 조건
	If Not Request("code") Is Nothing And Request("code") <> "" Then
		parameter = parameter & "&code=" & Request("code")
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
			<col width="10%"/>
			<col width="50%"/>
			<col width="40%"/>
		</colgroup>
		<tr>
			<th>회기</th>
			<th>제목</th>
			<th>첨부</th>
		</tr>
<%
		For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'키값
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'파일다운로드 URL
				If NOT itemNode.SelectSingleNode("downUrl") is Nothing Then
					downUrl = itemNode.SelectSingleNode("downUrl").text
				End If
				'파일명
				If NOT itemNode.SelectSingleNode("fileName") is Nothing Then
					fileName = itemNode.SelectSingleNode("fileName").text
				End If
				'회기
				If NOT itemNode.SelectSingleNode("tmrd") is Nothing Then
					tmrd = itemNode.SelectSingleNode("tmrd").text
				End If
				'제목
				If NOT itemNode.SelectSingleNode("cntntsSj") is Nothing Then
					cntntsSj = itemNode.SelectSingleNode("cntntsSj").text
				End If

				s_downUrl=Split(downUrl,";")
				s_fileName=Split(fileName,";")

			End If

%>
		<tr>
			<td align="center"><%=tmrd%></td>
			<td><a href="javascript:;move('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
			<td align="center">
<%
			For j=0 To UBound(s_downUrl)
%>
				<a href="<%=s_downUrl(j)%>"><%=s_fileName(j)%></a><br>
<%
			Next
%>
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