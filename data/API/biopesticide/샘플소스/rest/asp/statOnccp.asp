<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>화합물 통계</title>
<script type='text/javascript'>

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "statOnccp.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 통계</strong></h3><hr>

<%
'종합 통계
If true Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "statOnccp"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	
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

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
		'살균, 살충, 제초
		Set cntA = xmlDOM.SelectNodes("//cntA")
		If Not cntA(0) Is Nothing Then cntAText= cntA(0).Text Else cntAText = "" End If
		'살균, 살충
		Set cntB = xmlDOM.SelectNodes("//cntB")
		If Not cntB(0) Is Nothing Then cntBText= cntB(0).Text Else cntBText = "" End If
		'살균, 제초
		Set cntC = xmlDOM.SelectNodes("//cntC")
		If Not cntC(0) Is Nothing Then cntCText= cntC(0).Text Else cntCText = "" End If
		'살충, 제초
		Set cntD = xmlDOM.SelectNodes("//cntD")
		If Not cntD(0) Is Nothing Then cntDText= cntD(0).Text Else cntDText = "" End If
		'살균
		Set cntE = xmlDOM.SelectNodes("//cntE")
		If Not cntE(0) Is Nothing Then cntEText= cntE(0).Text Else cntEText = "" End If
		'살충
		Set cntF = xmlDOM.SelectNodes("//cntF")
		If Not cntF(0) Is Nothing Then cntFText= cntF(0).Text Else cntFText = "" End If
		'제초
		Set cntG = xmlDOM.SelectNodes("//cntG")
		If Not cntG(0) Is Nothing Then cntGText= cntG(0).Text Else cntGText = "" End If
%>
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<colgroup>
		<col width="*" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
		<col width="14%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" >살균.살충.제초</th>
			<th scope="col" >살균.살충</th>
			<th scope="col" >살균.제초</th>
			<th scope="col" >살충.제초</th>
			<th scope="col" >살균</th>
			<th scope="col" >살충</th>
			<th scope="col" >제초</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><%=cntAText%></td>
			<td><%=cntBText%></td>
			<td><%=cntCText%></td>
			<td><%=cntDText%></td>
			<td><%=cntEText%></td>
			<td><%=cntFText%></td>
			<td><%=cntGText%></td>
		</tr>
	</tbody>
</table>
<%
	End If
End If
%>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=Request("pageNo")%>">
</form>
<h3><strong>화합물 리스트</strong></h3><hr>
<%
'화합물 리스트
If true Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "searchOnccp"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&pageNo=" & Request("pageNo")
	
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
	'조회된 총 건수
	Set pageNo = xmlDOM.SelectNodes("//pageNo")
	If Not pageNo(0) Is Nothing Then pageNoText= pageNo(0).Text Else pageNoText = "1" End If
	'조회할 페이지 번호
	Set totalCount = xmlDOM.SelectNodes("//totalCount")
	If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "" End If

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<colgroup>
		<col width="5%" />
		<col width="*" />
		<col width="100px" />
		<col width="100px" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" >No</th>
			<th scope="col" >화합물명</th>
			<th scope="col" >Elements</th>
			<th scope="col" >계열</th>
			<th scope="col" >살균</th>
			<th scope="col" >살충</th>
			<th scope="col" >제초</th>
			<th scope="col" >기타작용기작</th>
		</tr>
	</thead>
<%
		For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'유기화합물 명
				If NOT itemNode.SelectSingleNode("onccpNm") is Nothing Then
					onccpNm = itemNode.SelectSingleNode("onccpNm").text
				End If
				'순번
				If NOT itemNode.SelectSingleNode("rnum") is Nothing Then
					rnum = itemNode.SelectSingleNode("rnum").text
				End If				
				'요소 단어
				If NOT itemNode.SelectSingleNode("elmnWrd") is Nothing Then
					elmnWrd = itemNode.SelectSingleNode("elmnWrd").text
				End If				
				'계열 구분
				If NOT itemNode.SelectSingleNode("intltshSe") is Nothing Then
					intltshSe = itemNode.SelectSingleNode("intltshSe").text
				End If				
				'향균 여부
				If NOT itemNode.SelectSingleNode("antBactrlYn") is Nothing Then
					antBactrlYn = itemNode.SelectSingleNode("antBactrlYn").text
				End If				
				'살충 여부
				If NOT itemNode.SelectSingleNode("insccideYn") is Nothing Then
					insccideYn = itemNode.SelectSingleNode("insccideYn").text
				End If				
				'제초 여부
				If NOT itemNode.SelectSingleNode("weedngYn") is Nothing Then
					weedngYn = itemNode.SelectSingleNode("weedngYn").text
				End If				
				'유기화합물 일련 번호
				If NOT itemNode.SelectSingleNode("onccpSeqNo") is Nothing Then
					onccpSeqNo = itemNode.SelectSingleNode("onccpSeqNo").text
				End If				
				'비고
				If NOT itemNode.SelectSingleNode("rm") is Nothing Then
					rm = itemNode.SelectSingleNode("rm").text
				End If				
				'참고 문헌 수
				If NOT itemNode.SelectSingleNode("referltrtreCnt") is Nothing Then
					referltrtreCnt = itemNode.SelectSingleNode("referltrtreCnt").text
				End If				
				'생물 자원 수
				If NOT itemNode.SelectSingleNode("lvbCnt") is Nothing Then
					lvbCnt = itemNode.SelectSingleNode("lvbCnt").text
				End If				
			End If
%>

		<tr>
			<td align="center"><%=rnum%></td>
			<td ><%=onccpNm%></td>
			<td align="center"><%=elmnWrd%></td>
			<td align="center"></td>
			<td align="center">
			<%if antBactrlYn=("Y") Then %>
				<%=antBactrlYn%>
			<%End If%>
			</td>
			<td align="center">
			<%if insccideYn=("Y") Then %>
				<%=insccideYn%>
			<%End If%>
			</td>
			<td align="center">
			<%if weedngYn=("Y") Then %>
				<%=weedngYn%>
			<%End If%>
			</td>
			<td><%=rm%></td>
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
