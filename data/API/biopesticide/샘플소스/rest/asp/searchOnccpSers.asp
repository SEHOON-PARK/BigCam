<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>화합물 검색</title>
<script type='text/javascript'>

//검색
function fncSearch(){
	with(document.searchApiForm){
		pageNo.value = "1";
		method="get";
		action = "searchOnccpSers.asp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "searchOnccpSers.asp";
		target = "_self";
		submit();
	}
}

//화합물 검색
function fncViewSub2(lNo){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		method="get";
		action = "searchOnccpSers.asp";
		target = "_self";
		submit();
	}
}

//팝업 띄우기
function fncListOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.asp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check1=1";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

//참고문헌 팝업 띄우기
function fncViewSubOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.asp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check2=2";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

//생물자원 팝업 띄우기
function fncViewOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.asp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check3=3";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 검색</strong></h3><hr>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=Request("pageNo")%>">
<input type="hidden" name="lvbSeqNo">
<table width="100%" cellSpacing="0" cellPadding="0">
	<tr>
		<td width="85%">
			화합물명&nbsp;<input type="text" name="onccpNm" value="<%If Request("onccpNm") Is Nothing Then Response.write("") Else Response.write(Request("onccpNm")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
			Elements&nbsp;<input type="text" name="elmnWrd" value="<%If Request("elmnWrd") Is Nothing Then Response.write("") Else Response.write(Request("elmnWrd")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
			계열&nbsp;<select name="intltshSe">
				<option value="">선택하세요</option>
<%				'계열 리스트 출력
				If true Then
					'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
					apiKey = "발급받은인증키를삽입하세요"
					'서비스 명
					serviceName = "biopesticide"
					'오퍼레이션 명
					operationName = "searchOnccpSers"
					
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
					Set items = listItem(0).childNodes
				
					For i=0 To cnt-4
					   Set itemNode = items.item(i)
						If NOT itemNode Is Nothing Then
							'계열 코드
							If NOT itemNode.SelectSingleNode("code") is Nothing Then
								code = itemNode.SelectSingleNode("code").text
							End If
							'계열 명
							If NOT itemNode.SelectSingleNode("codeNm") is Nothing Then
								codeNm = itemNode.SelectSingleNode("codeNm").text
							End If				
						End If
%>
						<option value="<%=code%>"<%If Request("intltshSe")=code Then Response.Write("selected") Else Response.Write("") End If%>><%=codeNm%></option>
<%
						Set itemNode = Nothing
					Next
				End If
%>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	    <td width="15%" align="right">
			<input type="button" name="search" value="조회" onclick="fncSearch();"/>
	    </td>
	</tr>
	<tr>		
		<td colspan="2">
			기타작용기작&nbsp;<input type="text" name="rm" value="<%If Request("rm") Is Nothing Then Response.write("") Else Response.write(Request("rm")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
			참고문헌&nbsp;<input type="text" name="sText" value="<%If Request("sText") Is Nothing Then Response.write("") Else Response.write(Request("sText")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
			살균&nbsp;<input type="checkbox" name="antBactrlYn" value="Y" <%If Request("antBactrlYn")="Y" Then Response.Write("checked") Else Response.Write("") End If%>>&nbsp;&nbsp;&nbsp;&nbsp;
			살충&nbsp;<input type="checkbox" name="insccideYn" value="Y" <%If Request("insccideYn")="Y" Then Response.Write("checked") Else Response.Write("") End If%>>&nbsp;&nbsp;&nbsp;&nbsp;
			제초&nbsp;<input type="checkbox" name="weedngYn" value="Y" <%If Request("weedngYn")="Y" Then Response.Write("checked") Else Response.Write("") End If%>>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	</tr>			
</table>
</form>

<%
'메인 리스트 출력
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
	
	'화합물 검색
	If Not Request("onccpNm") Is Nothing And Request("onccpNm") <> "" Then
		parameter = parameter & "&onccpNm=" & Server.URLEncode(Request("onccpNm"))
	End If
	'요소 검색
	If Not Request("elmnWrd") Is Nothing And Request("elmnWrd") <> "" Then
		parameter = parameter & "&elmnWrd=" & Server.URLEncode(Request("elmnWrd"))
	End If
	'계열 검색
	If Not Request("intltshSe") Is Nothing And Request("intltshSe") <> "" Then
		parameter = parameter & "&intltshSe=" & Request("intltshSe")
	End If
	'비고 검색
	If Not Request("rm") Is Nothing And Request("rm") <> "" Then
		parameter = parameter & "&rm=" & Server.URLEncode(Request("rm"))
	End If
	'살균 여부 검색
	If Not Request("antBactrlYn") Is Nothing And Request("antBactrlYn") <> "" Then
		parameter = parameter & "&antBactrlYn=" & Request("antBactrlYn")
	End If
	'살충 여부 검색
	If Not Request("insccideYn") Is Nothing And Request("insccideYn") <> "" Then
		parameter = parameter & "&insccideYn=" & Request("insccideYn")
	End If
	'제초 검색
	If Not Request("weedngYn") Is Nothing And Request("weedngYn") <> "" Then
		parameter = parameter & "&weedngYn=" & Request("weedngYn")
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
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>계열</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>기타</th>
			<th>참고문헌</th>
			<th>생물자원</th>
		</tr>
<%	
	
	For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'화합물 명
				If NOT itemNode.SelectSingleNode("onccpNm") is Nothing Then
					onccpNm = itemNode.SelectSingleNode("onccpNm").text
				End If
				'순번
				If NOT itemNode.SelectSingleNode("rnum") is Nothing Then
					rnum = itemNode.SelectSingleNode("rnum").text
				End If
				'요소				
				If NOT itemNode.SelectSingleNode("elmnWrd") is Nothing Then
					elmnWrd = itemNode.SelectSingleNode("elmnWrd").text
				End If
				'계열
				If NOT itemNode.SelectSingleNode("intltshSe") is Nothing Then
					intltshSe = itemNode.SelectSingleNode("intltshSe").text
				End If
				'향균				
				If NOT itemNode.SelectSingleNode("antBactrlYn") is Nothing Then
					antBactrlYn = itemNode.SelectSingleNode("antBactrlYn").text
				End If
				'살충				
				If NOT itemNode.SelectSingleNode("insccideYn") is Nothing Then
					insccideYn = itemNode.SelectSingleNode("insccideYn").text
				End If
				'제초				
				If NOT itemNode.SelectSingleNode("weedngYn") is Nothing Then
					weedngYn = itemNode.SelectSingleNode("weedngYn").text
				End If
				'기타				
				If NOT itemNode.SelectSingleNode("rm") is Nothing Then
					rm = itemNode.SelectSingleNode("rm").text
				End If
				'참고문헌				
				If NOT itemNode.SelectSingleNode("referltrtreCnt") is Nothing Then
					referltrtreCnt = itemNode.SelectSingleNode("referltrtreCnt").text
				End If
				'생물자원				
				If NOT itemNode.SelectSingleNode("lvbCnt") is Nothing Then
					lvbCnt = itemNode.SelectSingleNode("lvbCnt").text
				End If
				'화합물 코드				
				If NOT itemNode.SelectSingleNode("onccpSeqNo") is Nothing Then
					onccpSeqNo = itemNode.SelectSingleNode("onccpSeqNo").text
				End If				
			End If
%>
		<tr>
			<td align="center"><%=rnum%></td>
			<td align="center"><%=onccpNm%></td>
			<td align="center"><%=elmnWrd%></td>
			<td align="center"><%=intltshSe%></td>
			<td align="center">
			<%if antBactrlYn=("Y") Then %>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','106001')"><%=antBactrlYn%></a>
			<%End If%>
			</td>
			<td align="center">
			<%if insccideYn=("Y") Then %>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','106002')"><%=insccideYn%></a>
			<%End If%>
			</td>
			<td align="center">
			<%if weedngYn=("Y") Then %>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','106003')"><%=weedngYn%></a>
			<%End If%>
			</td>
			<td align="center"><%=rm%></td>
			<td align="center"><a href="javascript:fncViewSubOpen('<%=onccpSeqNo%>','')"><%=referltrtreCnt%></a></td>
			<td align="center">
			<%if Not lvbCnt=("0") Then %>
				<a href="#" onclick="fncViewOpen('<%=onccpSeqNo%>')"><%=lvbCnt%></a>
			<%End If%>
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
End If
%>
<br>
<div style="TEXT-ALIGN: right"><input type="button" onclick="javascript:location.href='searchOnccpSers.asp'" value="초기화면"/></div>
</body>
</html>