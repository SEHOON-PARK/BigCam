<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>RDA 인테러뱅</title>
<script type='text/javascript'>

//상세보기
function move(dNo){
	with(document.apiForm){
		dataNo.value = dNo;
		method="get";
		action = "rdaInterrobang_D.asp";
		target = "_self";
		submit();
	}
}

//검색
function fncSearch(){
	with(document.searchApiForm){
		if(searchword.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        searchword.focus();
	        return false;
	    }else{
			method="get";
			action = "rdaInterrobang.asp";
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
		action = "rdaInterrobang.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>RDA 인테러뱅</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="dataNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request("pageNo")%>">
<select name="searchtype"> 
	<option value="1" <%If searchtype="1" Then Response.Write("selected") Else Response.Write("") End If%>>제목</option>
	<option value="2" <%If searchtype="2" Then Response.Write("selected") Else Response.Write("") End If%>>내용</option>
	<option value="4" <%If searchtype="3" Then Response.Write("selected") Else Response.Write("") End If%>>작성자</option>
	<option value="3" <%If searchtype="4" Then Response.Write("selected") Else Response.Write("") End If%>>제목+내용</option>
</select> 
<input type="text" name="searchword" value="<%If Request("searchword") Is Nothing Then Response.write("") Else Response.write(Request("searchword")) End If%>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<!-- =================================================== 메인 카테고리 시작 ================================================================================ -->

<%
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "rdaInterrobang"
	'오퍼레이션 명
	operationName = "interrobangList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&searchtype=" & Request("searchtype")
	parameter = parameter & "&searchword=" & Server.URLEncode(Request("searchword"))
	parameter = parameter & "&pageNo=" & Request("pageNo")
	
	'검색 조건
	If Not Request("searchtype") Is Nothing And Request("searchtype") <> "" Then
		parameter = parameter & "&searchtype=" & Request("searchtype")
	End If
	'검색어
	If Not Request("searchword") Is Nothing And Request("searchword") <> "" Then
		parameter = parameter & "&searchword=" & Server.URLEncode(Request("searchword"))
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
			<col width="50%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>제목</th>
			<th>등록일</th>
			<th>첨부</th>
			<th>의견수</th>
			<th>조회수/평점</th>
		</tr>
<%
		For i=0 To cnt-4
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'키값
				If NOT itemNode.SelectSingleNode("dataNo") is Nothing Then
					dataNo = itemNode.SelectSingleNode("dataNo").text
				End If
				'파일다운로드 URL
				If NOT itemNode.SelectSingleNode("downUrl") is Nothing Then
					downUrl = itemNode.SelectSingleNode("downUrl").text
				End If				
				'파일명
				If NOT itemNode.SelectSingleNode("fileName") is Nothing Then
					fileName = itemNode.SelectSingleNode("fileName").text
				End If				
				'조회수
				If NOT itemNode.SelectSingleNode("hitCt") is Nothing Then
					hitCt = itemNode.SelectSingleNode("hitCt").text
				End If				
				'평점
				If NOT itemNode.SelectSingleNode("optGrade") is Nothing Then
					optGrade = itemNode.SelectSingleNode("optGrade").text
				End If				
				'댓글수
				If NOT itemNode.SelectSingleNode("optNum") is Nothing Then
					optNum = itemNode.SelectSingleNode("optNum").text
				End If				
				'등록일
				If NOT itemNode.SelectSingleNode("regDt") is Nothing Then
					regDt = itemNode.SelectSingleNode("regDt").text
				End If				
				'제목
				If NOT itemNode.SelectSingleNode("subject") is Nothing Then
					subject = itemNode.SelectSingleNode("subject").text
				End If				
			
				s_downUrl=Split(downUrl,";")
				s_fileName=Split(fileName,";")
				
			End If
			
%>
		<tr>
			<td><a href="javascript:;move('<%=dataNo%>');"><%=subject%></a></td>
			<td align="center"><%=regDt%></td>
			<td align="center">
<%
			For j=0 To UBound(s_downUrl)
%>
				<a href="<%=s_downUrl(j)%>"><%=s_fileName(j)%></a><br>
<%				
			Next
%>
			</td>
			<td align="center"><%=optNum%></td>
			<td align="center"><%=hitCt%>/<%=optGrade%></td>
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