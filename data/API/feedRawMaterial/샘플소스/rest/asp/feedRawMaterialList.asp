<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>사료 검색</title>
<script type='text/javascript'>
//검색
function fncSearch(){
	with(document.searchApiForm){
		pageNo.value = "1";
		method="get";
		action = "feedRawMaterialList.asp";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "feedRawMaterialList.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>반려동물 집밥원료</strong></h3>
<hr>

<%
sFeedNm = Request("sFeedNm")
upperListSel = Request("upperListSel")
%>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=Request("pageNo")%>">
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<colgroup>
		<col width="20%"/>
		<col width="80%"/>
	</colgroup>
	<tr>
		<td>
<%
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "feedRawMaterial"
	'오퍼레이션 명
	operationName = Array("upperList")

	Set xmlDOMS=Server.CreateObject("Scripting.Dictionary")

	For i=0 To UBound(operationName)
		'XML 받을 URL 생성
		parameter = "/" & serviceName & "/" & operationName(i)
		parameter = parameter & "?apiKey="&apiKey

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

		xmlDOMS.Add operationName(i), sText
	Next

	'검색조건
	For n=0 To UBound(operationName)

	'오퍼레이션명
	operNm = operationName(n)

	sText = xmlDOMS.Item(operNm)

	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")
	xmlDOM.async = False
	xmlDOM.LoadXML sText
	'농사 Open API 통신 끝

	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt = 0 Then
		Response.Write("조회한 정보가 없습니다.")
	Else
		For i=0 To cnt-1
			 Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'코드
				If NOT itemNode.SelectSingleNode("code") is Nothing Then
					code = itemNode.SelectSingleNode("code").text
				End If
				'코드명
				If NOT itemNode.SelectSingleNode("codeNm") is Nothing Then
					codeNm = itemNode.SelectSingleNode("codeNm").text
				End If
			End If

			If operNm ="upperList" Then
				If i=0 Then
%>
				<select id="upperListSel" name="upperListSel">
				<option value="">전체</option>
<%
				End If
%>
			<option value="<%=code%>" <% If upperListSel=code Then Response.Write("selected") Else Response.Write("") End If %>><%=codeNm%></option>
<%

			End if
		 Set itemNode = Nothing
		 Next
	End If
	Response.Write("</select>")
	Next

%>
			<input type="text" name="sFeedNm" value="<%=Request("sFeedNm")%>">
			<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
		</td>
	</tr>
</table>
</form>
<%
If true Then
	'오퍼레이션 명
	operationName = "feedRawMaterialList"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&pageNo=" & Request("pageNo")

	parameter = parameter & "&sFeedNm=" & Server.URLEncode(Request("sFeedNm")) & "&upperFeedClCode=" & Server.URLEncode(Request("upperListSel"))

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
			<tr>
				<th width="4%">출처</th>
				<th width="*">원료</th>
				<th width="4%">원료가격(원/kg)</th>
				<th width="4%">건물(%)</th>
				<th width="4%">수분(%)</th>
				<th width="4%">단백질(%)</th>
				<th width="4%">트립토판(%)</th>
				<th width="4%">칼슘(%)</th>
				<th width="4%">인(%)</th>
				<th width="4%">지방(%)</th>
				<th width="4%">리놀레산(%)</th>
				<th width="4%">리놀렌산(%)</th>
				<th width="4%">회분(%)</th>
				<th width="4%">비타민 A(RE/100g)</th>
				<th width="4%">탄수화물(%)</th>
				<th width="4%">조섬유(%)</th>
				<th width="4%">총식이섬유(%)</th>
				<th width="4%">불용성식이섬유(%)</th>
				<th width="4%">수용성식이섬유(%)</th>
				<th width="4%">나트륨(%)</th>
				<th width="4%">칼륨(%)</td>
		</tr>
	<%
			For i=0 To cnt-4
			   Set itemNode = items.item(i)
				If NOT itemNode Is Nothing Then
					'출처
					If NOT itemNode.SelectSingleNode("originNm") is Nothing Then
						originNm = itemNode.SelectSingleNode("originNm").text
					End If
					'분류명
					If NOT itemNode.SelectSingleNode("feedClCodeNm") is Nothing Then
						feedClCodeNm = itemNode.SelectSingleNode("feedClCodeNm").text
					End If
					'원료
					If NOT itemNode.SelectSingleNode("feedNm") is Nothing Then
						feedNm = itemNode.SelectSingleNode("feedNm").text
					End If
					'원료가격(원/kg)
					If NOT itemNode.SelectSingleNode("mtralPc") is Nothing Then
						mtralPc = itemNode.SelectSingleNode("mtralPc").text
					End If
					'건물(%)
					If NOT itemNode.SelectSingleNode("dryMatter") is Nothing Then
						dryMatter = itemNode.SelectSingleNode("dryMatter").text
					End If

					'수분(%)
					If NOT itemNode.SelectSingleNode("mitrQy") is Nothing Then
						mitrQy = itemNode.SelectSingleNode("mitrQy").text
					End If
					'단백질(%)
					If NOT itemNode.SelectSingleNode("protQy") is Nothing Then
						protQy = itemNode.SelectSingleNode("protQy").text
					End If
					'트립토판(%)
					If NOT itemNode.SelectSingleNode("trypQy") is Nothing Then
						trypQy = itemNode.SelectSingleNode("trypQy").text
					End If
					'칼슘(%)
					If NOT itemNode.SelectSingleNode("clciQy") is Nothing Then
						clciQy = itemNode.SelectSingleNode("clciQy").text
					End If
					'인(%)
					If NOT itemNode.SelectSingleNode("phphQy") is Nothing Then
						phphQy = itemNode.SelectSingleNode("phphQy").text
					End If
					'지방(%)
					If NOT itemNode.SelectSingleNode("fatQy") is Nothing Then
						fatQy = itemNode.SelectSingleNode("fatQy").text
					End If
					'리놀레산(%)
					If NOT itemNode.SelectSingleNode("lnacQy") is Nothing Then
						lnacQy = itemNode.SelectSingleNode("lnacQy").text
					End If
					'리놀렌산(%)
					If NOT itemNode.SelectSingleNode("liacQy") is Nothing Then
						liacQy = itemNode.SelectSingleNode("liacQy").text
					End If
					'회분(%)
					If NOT itemNode.SelectSingleNode("ashsQy") is Nothing Then
						ashsQy = itemNode.SelectSingleNode("ashsQy").text
					End If
					'비타민 A(RE/100g)
					If NOT itemNode.SelectSingleNode("vtmaQy") is Nothing Then
						vtmaQy = itemNode.SelectSingleNode("vtmaQy").text
					End If
					'탄수화물(%)
					If NOT itemNode.SelectSingleNode("crbQy") is Nothing Then
						crbQy = itemNode.SelectSingleNode("crbQy").text
					End If
					'조섬유(%)
					If NOT itemNode.SelectSingleNode("crfbQy") is Nothing Then
						crfbQy = itemNode.SelectSingleNode("crfbQy").text
					End If
					'총식이섬유(%)
					If NOT itemNode.SelectSingleNode("totEdblfibrQy") is Nothing Then
						totEdblfibrQy = itemNode.SelectSingleNode("totEdblfibrQy").text
					End If
					'불용성식이섬유(%)
					If NOT itemNode.SelectSingleNode("inslbltyEdblfibrQy") is Nothing Then
						inslbltyEdblfibrQy = itemNode.SelectSingleNode("inslbltyEdblfibrQy").text
					End If
					'수용성식이섬유(%)
					If NOT itemNode.SelectSingleNode("slwtEdblfibrQy") is Nothing Then
						slwtEdblfibrQy = itemNode.SelectSingleNode("slwtEdblfibrQy").text
					End If
					'나트륨(%)
					If NOT itemNode.SelectSingleNode("naQy") is Nothing Then
						naQy = itemNode.SelectSingleNode("naQy").text
					End If
					'칼륨(%)
					If NOT itemNode.SelectSingleNode("ptssQy") is Nothing Then
						ptssQy = itemNode.SelectSingleNode("ptssQy").text
					End If

				End If

	%>
			<tr>
				<td width="4%"><%=originNm%></td>
				<td width="*"><%=feedClCodeNm%> > <%=feedNm%></td>
				<td width="4%"><%=mtralPc%></td>
				<td width="4%"><%=dryMatter%></td>
				<td width="4%"><%=mitrQy%></td>
				<td width="4%"><%=protQy%></td>
				<td width="4%"><%=trypQy%></td>
				<td width="4%"><%=clciQy%></td>
				<td width="4%"><%=phphQy%></td>
				<td width="4%"><%=fatQy%></td>
				<td width="4%"><%=lnacQy%></td>
				<td width="4%"><%=liacQy%></td>
				<td width="4%"><%=ashsQy%></td>
				<td width="4%"><%=vtmaQy%></td>
				<td width="4%"><%=crbQy%></td>
				<td width="4%"><%=crfbQy%></td>
				<td width="4%"><%=totEdblfibrQy%></td>
				<td width="4%"><%=inslbltyEdblfibrQy%></td>
				<td width="4%"><%=slwtEdblfibrQy%></td>
				<td width="4%"><%=naQy%></td>
				<td width="4%"><%=ptssQy%></td>
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
End If
%>
</body>
</html>
