<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>추천식단</title>
<script type='text/javascript'>
//품종정보 리스트
function mainMove(dCode){
	with(document.mainApiForm){
		dietSeCode.value = dCode;
		method="get";
		action = "recomendDiet.asp";
		target = "_self";
		submit();
	}
}

//추천식단 컨텐츠 상세조회
function detailMove(cNo){
	with(document.detailApiForm){
		cntntsNo.value = cNo;
		method="get";
		action = "recomendDiet.asp";
		target = "_self";
		submit();
	}
}

//추천식단 컨텐츠 상세조회
function tabMove(tNo){
	with(document.tabApiForm){
		tabNo.value = tNo;
		method="get";
		action = "recomendDiet.asp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.mainApiForm){
		pageNo.value = page;
		method="get";
		action = "recomendDiet.asp";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>추천식단</strong></h3><hr>

<form name="mainApiForm">
	<input type="hidden" name="dietSeCode" value="<%=request("dietSeCode")%>">
	<input type="hidden" name="pageNo">
</form>

<form name="detailApiForm">
	<input type="hidden" name="cntntsNo" value="<%=request("cntntsNo")%>">
	<input type="hidden" name="tabNo" value="0">
</form>

<form name="tabApiForm">
	<input type="hidden" name="cntntsNo" value="<%=request("cntntsNo")%>">
	<input type="hidden" name="tabNo" value="<%=request("tabNo")%>">
</form>

<%
'메인 카테고리 리스트
If true Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "recomendDiet"
	'오퍼레이션 명
	operationName = "mainCategoryList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
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
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'식단 구분 코드
				If NOT itemNode.SelectSingleNode("dietSeCode") is Nothing Then
					dietSeCode = itemNode.SelectSingleNode("dietSeCode").text
				End If
				'식단 구분 명
				If NOT itemNode.SelectSingleNode("dietSeName") is Nothing Then
					dietSeName = itemNode.SelectSingleNode("dietSeName").text
				End If
			End If
%>
			<td align="center"><a href="javascript:mainMove('<%=dietSeCode%>');"><%=dietSeName%></a></td>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tr></table>")
	End If
End If
%>

<%
'식단 목록
If Not Request("dietSeCode") Is Nothing And Request("dietSeCode") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "recomendDiet"
	'오퍼레이션 명
	operationName = "recomendDietList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&dietSeCode=" & Request("dietSeCode")
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
<%
		For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'컨텐츠 번호
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'컨텐츠 제목
				If NOT itemNode.SelectSingleNode("cntntsSj") is Nothing Then
					cntntsSj = itemNode.SelectSingleNode("cntntsSj").text
				End If
				'이미지 설명
				If NOT itemNode.SelectSingleNode("rtnImageDc") is Nothing Then
					rtnImageDc = itemNode.SelectSingleNode("rtnImageDc").text
				End If
			End If
%>
		<tr>
			<td width="15%"><img src="<%=rtnImageDc%>" width="128" height="103"></img></td>
			<td width="85%"><a href="javascript:detailMove('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
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

<%
'식단 상세
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "recomendDiet"
	'오퍼레이션 명
	operationName = "recomendDietDtl"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&cntntsNo=" & Request("cntntsNo")
	
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
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'컨텐츠 번호
				If NOT itemNode.SelectSingleNode("cntntsNo") is Nothing Then
					cntntsNo = itemNode.SelectSingleNode("cntntsNo").text
				End If
				'컨텐츠 제목
				If NOT itemNode.SelectSingleNode("cntntsSj") is Nothing Then
					cntntsSj = itemNode.SelectSingleNode("cntntsSj").text
				End If
			End If
%>
			<td align="center"><a href="javascript:tabMove('<%=i%>');"><%=cntntsSj%></a></td>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tr></table>")
	End If
End If
%>

<%
'식단 상세
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "recomendDiet"
	'오퍼레이션 명
	operationName = "recomendDietDtl"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&cntntsNo=" & Request("cntntsNo")
	
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

	idx=int(Request("tabNo"))
	     
	Set listItem = xmlDOM.SelectNodes("//items")
	cnt = listItem(0).childNodes.length
	Set items = listItem(0).childNodes
	
	
	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
		Set itemNode = items.item(idx)
		If NOT itemNode Is Nothing Then
			'이미지 설명
			If NOT itemNode.SelectSingleNode("rtnImageDc") is Nothing Then
				rtnImageDc = itemNode.SelectSingleNode("rtnImageDc").text
			End If
			'음식명
			If NOT itemNode.SelectSingleNode("fdNm") is Nothing Then
				fdNm = itemNode.SelectSingleNode("fdNm").text
			End If
			'식단 내용
			If NOT itemNode.SelectSingleNode("dietCn") is Nothing Then
				dietCn = itemNode.SelectSingleNode("dietCn").text
			End If
			'식단 영양소 정보
			If NOT itemNode.SelectSingleNode("dietNtrsmallInfo") is Nothing Then
				dietNtrsmallInfo = itemNode.SelectSingleNode("dietNtrsmallInfo").text
			End If
			'재료 정보
			If NOT itemNode.SelectSingleNode("matrlInfo") is Nothing Then
				matrlInfo = itemNode.SelectSingleNode("matrlInfo").text
			End If
			'조리 방법 정보
			If NOT itemNode.SelectSingleNode("ckngMthInfo") is Nothing Then
				ckngMthInfo = itemNode.SelectSingleNode("ckngMthInfo").text
			End If
			'섭취량 정보
			If NOT itemNode.SelectSingleNode("ntkQyInfo") is Nothing Then
				ntkQyInfo = itemNode.SelectSingleNode("ntkQyInfo").text
			End If
			'당질 정보
			If NOT itemNode.SelectSingleNode("crbhInfo") is Nothing Then
				crbhInfo = itemNode.SelectSingleNode("crbhInfo").text
			End If
			'지질 정보
			If NOT itemNode.SelectSingleNode("ntrfsInfo") is Nothing Then
				ntrfsInfo = itemNode.SelectSingleNode("ntrfsInfo").text
			End If
			'조섬유 정보
			If NOT itemNode.SelectSingleNode("crfbInfo") is Nothing Then
				crfbInfo = itemNode.SelectSingleNode("crfbInfo").text
			End If
			'철분 정보
			If NOT itemNode.SelectSingleNode("ircnInfo") is Nothing Then
				ircnInfo = itemNode.SelectSingleNode("ircnInfo").text
			End If
			'식염상당량 정보
			If NOT itemNode.SelectSingleNode("frmlasaltEqvlntqyInfo") is Nothing Then
				frmlasaltEqvlntqyInfo = itemNode.SelectSingleNode("frmlasaltEqvlntqyInfo").text
			End If
			'비타민 b 정보
			If NOT itemNode.SelectSingleNode("vtmbInfo") is Nothing Then
				vtmbInfo = itemNode.SelectSingleNode("vtmbInfo").text
			End If
			'열량 정보
			If NOT itemNode.SelectSingleNode("clriInfo") is Nothing Then
				clriInfo = itemNode.SelectSingleNode("clriInfo").text
			End If
			'단백질 정보
			If NOT itemNode.SelectSingleNode("protInfo") is Nothing Then
				protInfo = itemNode.SelectSingleNode("protInfo").text
			End If
			'콜레스테롤 정보
			If NOT itemNode.SelectSingleNode("chlsInfo") is Nothing Then
				chlsInfo = itemNode.SelectSingleNode("chlsInfo").text
			End If
			'칼슘 정보
			If NOT itemNode.SelectSingleNode("clciInfo") is Nothing Then
				clciInfo = itemNode.SelectSingleNode("clciInfo").text
			End If
			'나트륨 정보
			If NOT itemNode.SelectSingleNode("naInfo") is Nothing Then
				naInfo = itemNode.SelectSingleNode("naInfo").text
			End If
			'비타민 a 정보
			If NOT itemNode.SelectSingleNode("vtmaInfo") is Nothing Then
				vtmaInfo = itemNode.SelectSingleNode("vtmaInfo").text
			End If
			'비타민 c 정보
			If NOT itemNode.SelectSingleNode("vtmcInfo") is Nothing Then
				vtmcInfo = itemNode.SelectSingleNode("vtmcInfo").text
			End If
		End If
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
			<td width="15%"><img src="<%=rtnImageDc%>" width="128" height="103"></img></td>
			<td width="85%">
				<strong>식단구성&nbsp;&nbsp;</strong><%=fdNm%><br>
				<strong>식단소개&nbsp;&nbsp;</strong><%=dietCn%><br>
				<strong>영양소&nbsp;&nbsp;</strong><%=dietNtrsmallInfo%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><strong>식단별 조리법</strong></td>
		</tr>
		<tr>
			<td colspan="2">
				<strong>식단구성&nbsp;&nbsp;</strong><%=matrlInfo%><br>
				<strong>식단소개&nbsp;&nbsp;</strong><%=ckngMthInfo%><br>
				<strong>영양소&nbsp;&nbsp;</strong>
			</td>
		<tr>
			<td colspan="2">
				<table width="100%" border="0" rules="rows">
					<tr>
						<td width="25%" align="center"><strong>1회 섭취량</strong></td>
						<td width="25%">
						<% If Not ntkQyInfo="0" And ntkQyInfo <> "" Then %>
						<%=ntkQyInfo%>&nbsp;ml
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>열량</strong></td>
						<td width="25%">
						<% If Not clriInfo="0" And clriInfo <> "" Then %>
						<%=clriInfo%>&nbsp;kcal
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>당질</strong></td>
						<td width="25%">
						<% If Not crbhInfo="0" And crbhInfo <> "" Then %>
						<%=crbhInfo%>&nbsp;g
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>단백질</strong></td>
						<td width="25%">
						<% If Not protInfo="0" And protInfo <> "" Then %>
						<%=protInfo%>&nbsp;g
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>지질</strong></td>
						<td width="25%">
						<% If Not ntrfsInfo="0" And ntrfsInfo <> "" Then %>
						<%=ntrfsInfo%>&nbsp;g
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>콜레스트롤</strong></td>
						<td width="25%">
						<% If Not chlsInfo="0" And chlsInfo <> "" Then %>
						<%=chlsInfo%>&nbsp;mg
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>조섬유</strong></td>
						<td width="25%">
						<% If Not crfbInfo="0" And crfbInfo <> "" Then %>
						<%=crfbInfo%>&nbsp;g
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>칼슘</strong></td>
						<td width="25%">
						<% If Not clciInfo="0" And clciInfo <> "" Then %>
						<%=clciInfo%>&nbsp;mg
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>철분</strong></td>
						<td width="25%">
						<% If Not ircnInfo="0" And ircnInfo <> "" Then %>
						<%=ircnInfo%>&nbsp;mg
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>나트륨</strong></td>
						<td width="25%">
						<% If Not naInfo="0" And naInfo <> "" Then %>
						<%=naInfo%>&nbsp;mg
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>식염상당량</strong></td>
						<td width="25%">
						<% If Not frmlasaltEqvlntqyInfo="0" And frmlasaltEqvlntqyInfo <> "" Then %>
						<%=frmlasaltEqvlntqyInfo%>&nbsp;g
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>비타민A</strong></td>
						<td width="25%">
						<% If Not vtmaInfo="0" And vtmaInfo <> "" Then %>
						<%=vtmaInfo%>&nbsp;㎍RE
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>비타민B</strong></td>
						<td width="25%">
						<% If Not vtmbInfo="0" And vtmbInfo <> "" Then %>
						<%=vtmbInfo%>&nbsp;mg
						<% Else Response.Write("-") End If %>
						</td>
						<td width="25%" align="center"><strong>비타민C</strong></td>
						<td width="25%">
						<% If Not vtmcInfo="0" And vtmcInfo <> "" Then %>
						<%=vtmcInfo%>&nbsp;mg
						<% Else Response.Write("-") End If %>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<%
		   Set itemNode = Nothing
	End If
End If
%>
</body>
</html>