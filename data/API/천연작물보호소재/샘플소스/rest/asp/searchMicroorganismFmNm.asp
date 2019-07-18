<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>미생물 검색</title>
<script type='text/javascript'>
//검색
function fncSearch(){
	with(document.searchApiForm){
		pageNo.value = "1";
		method="get";
		action = "searchMicroorganismFmNm.asp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "searchMicroorganismFmNm.asp";
		target = "_self";
		submit();
	}
}

//화합물 검색
function fncViewSub2(lNo, fNm, bNm){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		cFmlNm.value = fNm;
		cBneNm.value = bNm;
		method="get";
		action = "searchMicroorganismFmNm.asp";
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

//서브 팝업 띄우기
function fncViewSubOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.asp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check2=2";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>미생물 검색</strong></h3><hr>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=Request("pageNo")%>">
<input type="hidden" name="lvbSeqNo">
<input type="hidden" name="cFmlNm">
<input type="hidden" name="cBneNm">
<table width="100%" cellSpacing="0" cellPadding="0">
	<tr>
		<td width="85%">
			과명&nbsp;<select name="fmlNm">
				<option value="">선택하세요</option>
				<option value="Bacteria" <%If Request("fmlNm")="Bacteria" Then Response.Write("selected") Else Response.Write("") End If%>>Bacteria</option>
				<option value="Fungi" <%If Request("fmlNm")="Fungi" Then Response.Write("selected") Else Response.Write("") End If%>>Fungi</option>
				<option value="Mushroom" <%If Request("fmlNm")="Mushroom" Then Response.Write("selected") Else Response.Write("") End If%>>Mushroom</option>
				<option value="Yeast" <%If Request("fmlNm")="Yeast" Then Response.Write("selected") Else Response.Write("") End If%>>Yeast</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			학명&nbsp;<input type="text" name="bneNm" value="<%If Request("bneNm") Is Nothing Then Response.write("") Else Response.write(Request("bneNm")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
			국명&nbsp;<input type="text" name="yeastNm" value="<%If Request("yeastNm") Is Nothing Then Response.write("") Else Response.write(Request("yeastNm")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
			비고&nbsp;<input type="text" name="rm" value="<%If Request("rm") Is Nothing Then Response.write("") Else Response.write(Request("rm")) End If%>">&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	    <td width="15%" align="right">
			<input type="button" name="search" value="조회" onclick="fncSearch();"/>
	    </td>
	</tr>
	<tr>		
		<td>
			살균&nbsp;<input type="checkbox" name="antBactrlYn" value="Y" <%If Request("antBactrlYn")="Y" Then Response.Write("checked") Else Response.Write("") End If%>>&nbsp;&nbsp;&nbsp;&nbsp;
			살충&nbsp;<input type="checkbox" name="insccideYn" value="Y" <%If Request("insccideYn")="Y" Then Response.Write("checked") Else Response.Write("") End If%>>&nbsp;&nbsp;&nbsp;&nbsp;
			제초&nbsp;<input type="checkbox" name="weedngYn" value="Y" <%If Request("weedngYn")="Y" Then Response.Write("checked") Else Response.Write("") End If%>>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	</tr>			
</table>
</form>


<%
'메인 리스트
If true Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "searchMicroorganism"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&pageNo=" & Request("pageNo")
	
	'과명 검색
	If Not Request("fmlNm") Is Nothing And Request("fmlNm") <> "" Then
		parameter = parameter & "&fmlNm=" & Server.URLEncode(Request("fmlNm"))
	End If
	'학명 검색
	If Not Request("bneNm") Is Nothing And Request("bneNm") <> "" Then
		parameter = parameter & "&bneNm=" & Server.URLEncode(Request("bneNm"))
	End If
	'국명 검색
	If Not Request("yeastNm") Is Nothing And Request("yeastNm") <> "" Then
		parameter = parameter & "&yeastNm=" & Server.URLEncode(Request("yeastNm"))
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
	'제초 여부 검색
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
	'한 페이지에 제공 할 건수
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
			<col width="20%"/>
			<col width="35%"/>
			<col width="10%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>화합물</th>
		</tr>
<%	
	
	For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'생물 일련번호
				If NOT itemNode.SelectSingleNode("lvbSeqNo") is Nothing Then
					lvbSeqNo = itemNode.SelectSingleNode("lvbSeqNo").text
				End If
				'순번
				If NOT itemNode.SelectSingleNode("rnum") is Nothing Then
					rnum = itemNode.SelectSingleNode("rnum").text
				End If
				'과명			
				If NOT itemNode.SelectSingleNode("fmlNm") is Nothing Then
					fmlNm = itemNode.SelectSingleNode("fmlNm").text
				End If
				'학명				
				If NOT itemNode.SelectSingleNode("bneNm") is Nothing Then
					bneNm = itemNode.SelectSingleNode("bneNm").text
				End If
				'국명				
				If NOT itemNode.SelectSingleNode("yeastNm") is Nothing Then
					yeastNm = itemNode.SelectSingleNode("yeastNm").text
				End If
				'비고				
				If NOT itemNode.SelectSingleNode("rm") is Nothing Then
					rm = itemNode.SelectSingleNode("rm").text
				End If
				'살균여부				
				If NOT itemNode.SelectSingleNode("antBactrlYn") is Nothing Then
					antBactrlYn = itemNode.SelectSingleNode("antBactrlYn").text
				End If
				'살충여부				
				If NOT itemNode.SelectSingleNode("insccideYn") is Nothing Then
					insccideYn = itemNode.SelectSingleNode("insccideYn").text
				End If
				'제초여부				
				If NOT itemNode.SelectSingleNode("weedngYn") is Nothing Then
					weedngYn = itemNode.SelectSingleNode("weedngYn").text
				End If
				'화합물 건수				
				If NOT itemNode.SelectSingleNode("mapngCnt") is Nothing Then
					mapngCnt = itemNode.SelectSingleNode("mapngCnt").text
				End If				
			End If
%>
		<tr>
			<td align="center"><%=rnum%></td>
			<td align="center"><%=fmlNm%></td>
			<td align="center"><%=bneNm%></td>
			<td align="center"><%=yeastNm%></td>
			<td align="center"><%=rm%></td>
			<td align="center">
			<%if antBactrlYn=("Y") Then %>
				<a href="#" onclick="fncListOpen('<%=lvbSeqNo%>','106001')"><%=antBactrlYn%></a>
			<%End If%>
			</td>
			<td align="center">
			<%if insccideYn=("Y") Then %>
				<a href="#" onclick="fncListOpen('<%=lvbSeqNo%>','106002')"><%=insccideYn%></a>
			<%End If%>
			</td>
			<td align="center">
			<%if weedngYn=("Y") Then %>
				<a href="#" onclick="fncListOpen('<%=lvbSeqNo%>','106003')"><%=weedngYn%></a>
			<%End If%>
			</td>
			<td align="center"><a href="javascript:fncViewSub2('<%=lvbSeqNo%>', '<%=fmlNm%>', '<%=bneNm%>')"><%=mapngCnt%></a></td>

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
'화합물 클릭 시 서브리스트 출력
If Not Request("lvbSeqNo") Is Nothing And Request("lvbSeqNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "searchPlantOnccp"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&lvbNo=" & Request("lvbSeqNo")
	parameter = parameter & "&fmlNm=" & Request("fmlNm")
	parameter = parameter & "&bneNm=" & Request("bneNm")
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
	
	If cnt = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<h3><strong>화합물 리스트 (학명 : (<%=request("cBneNm") %>), 과명 : <%=request("cFmlNm") %>)</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="15%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
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
		</tr>
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'순번
				If NOT itemNode.SelectSingleNode("rnum") is Nothing Then
					rnum = itemNode.SelectSingleNode("rnum").text
				End If
				'유기화합물_일련_번호
				If NOT itemNode.SelectSingleNode("onccpSeqNo") is Nothing Then
					onccpSeqNo = itemNode.SelectSingleNode("onccpSeqNo").text
				End If	
				'유기화합물_명			
				If NOT itemNode.SelectSingleNode("onccpNm") is Nothing Then
					onccpNm = itemNode.SelectSingleNode("onccpNm").text
				End If			
				'요소(要素)_단어	
				If NOT itemNode.SelectSingleNode("elmnWrd") is Nothing Then
					elmnWrd = itemNode.SelectSingleNode("elmnWrd").text
				End If	
				'계열_구분_코드명			
				If NOT itemNode.SelectSingleNode("intltshSeCodeNm") is Nothing Then
					intltshSeCodeNm = itemNode.SelectSingleNode("intltshSeCodeNm").text
				End If	
				'비고			
				If NOT itemNode.SelectSingleNode("rm") is Nothing Then
					rm = itemNode.SelectSingleNode("rm").text
				End If	
				'설균여부			
				If NOT itemNode.SelectSingleNode("antBactrlYn") is Nothing Then
					antBactrlYn = itemNode.SelectSingleNode("antBactrlYn").text
				End If	
				'살충여부		
				If NOT itemNode.SelectSingleNode("insccideYn") is Nothing Then
					insccideYn = itemNode.SelectSingleNode("insccideYn").text
				End If	
				'제초여부			
				If NOT itemNode.SelectSingleNode("weedngYn") is Nothing Then
					weedngYn = itemNode.SelectSingleNode("weedngYn").text
				End If			
				'참고문헌 수	
				If NOT itemNode.SelectSingleNode("referltrtreCnt") is Nothing Then
					referltrtreCnt = itemNode.SelectSingleNode("referltrtreCnt").text
				End If				
			End If
			
%>
		<tr>
		    <td><%=rnum%></td>
   			<td><%=onccpNm%></td>
   			<td><%=elmnWrd%></td>
   			<td><%=intltshSeCodeNm%></td>
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
   			<td><%=rm%></td>
   			<td>
   			<%if Not referltrtreCnt=("0") Then %>
   				<%=referltrtreCnt%>
			<%End If%>
   			</td>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
End If
%>
<br>
<div style="TEXT-ALIGN: right"><input type="button" onclick="javascript:location.href='searchMicroorganismFmNm.asp'" value="초기화면"/></div>
</body>
</html>