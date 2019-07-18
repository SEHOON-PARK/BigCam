<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농업기술 동영상</title>
<script type='text/javascript'>

//기관 카테고리
function mainMove(){
	with(document.searchInsttForm){
		method="post";
		action = "agriTechVideo.asp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.listApiForm){
		subCategoryCode.value = document.getElementById("subCombo")[document.getElementById("subCombo").selectedIndex].value;
		pageNo.value = page;
		method="post";
		action = "agriTechVideo.asp";
		target = "_self";
		submit();
	}
}

//카테고리 이동
function fncNextPage(cCode){
	with(document.apiForm){
		categoryCode.value = cCode;
		method="post";
		action = "agriTechVideo.asp";
		target = "_self";
		submit();
	}
}

//상세 리스트 조회
function listMove(){
	with(document.listApiForm){
		subCategoryCode.value = document.getElementById("subCombo")[document.getElementById("subCombo").selectedIndex].value;
		method="post";
		action = "agriTechVideo.asp";
		target = "_self";
		submit();
	}
}

//비디오 팝업
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
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농업기술 동영상</strong></h3>
<hr>

<%
'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
apiKey = "발급받은인증키"

'서비스 명
serviceName = "agriTechVideo"

'기관코드
insttCode = ""
If Not Request("insttCode") Is Nothing And Request("insttCode") <> "" Then
	insttCode = Request("insttCode")
End If

'기관명
insttName = ""
If Not Request("insttName") Is Nothing And Request("insttName") <> "" Then
	insttName = Request("insttName")
End If
%>

<form name="apiForm">
<input type="hidden" name="categoryCode" value="<%=request("categoryCode")%>">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
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
			<option value="<%=codeNm%>" <%If codeNm = insttName Then Response.Write("selected") Else Response.Write("") End If%>><%=codeNm%></option>
<%
		   Set itemNode = Nothing
		Next
	Response.Write("</select></form>")
	End If
End If
%>



<%
'메인 카테고리
	'오퍼레이션 명
	operationName = "mainCategoryList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&insttCode=" & insttCode
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp1 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp1.Open "GET", targetURL, False   
	xmlHttp1.Send    
	
	Set oStream1 = CreateObject("ADODB.Stream")   
	oStream1.Open   
	oStream1.Position = 0   
	oStream1.Type = 1   
	oStream1.Write xmlHttp1.ResponseBody   
	oStream1.Position = 0   
	oStream1.Type = 2   
	oStream1.Charset = "utf-8"   
	sText = oStream1.ReadText   
	oStream1.Close   
	
	Set xmlDOM1 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM1.async = False    
	xmlDOM1.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem1 = xmlDOM1.SelectNodes("//items")
	cnt = listItem1(0).childNodes.length
	Set items1 = listItem1(0).childNodes

	If cnt = 0 Then
		Response.Write("<hr><h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		For i=0 To cnt-1
		   Set itemNode = items1.item(i)
			If NOT itemNode Is Nothing Then
				'메인 카테고리 명
				If NOT itemNode.SelectSingleNode("categoryNm") is Nothing Then
					categoryNm = itemNode.SelectSingleNode("categoryNm").text
				End If
				'메인 카테고리 분류 코드
				If NOT itemNode.SelectSingleNode("categoryCode") is Nothing Then
					categoryCode = itemNode.SelectSingleNode("categoryCode").text
				End If
			End If
%>
			<td><a href="javascript:fncNextPage('<%=categoryCode%>');"><%=categoryNm%></a></td>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tr></table>")
	End If
%>

<%
'메인 카테고리 -> 서브 카테고리
If cnt > 0 Then
	'오퍼레이션 명
	operationName = "subCategoryList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&insttCode="&insttCode
	parameter = parameter & "&insttName=" & Server.URLEncode(insttName)
	
	sCategoryCode = Request("categoryCode")
	If Request("categoryCode") Is Nothing OR Request("categoryCode")="" Then
		Set subItemNode = items1.item(0)
			sCategoryCode = subItemNode.SelectSingleNode("categoryCode").text
		Set subItemNode = Nothing
	End If
	parameter = parameter & "&categoryCode=" & sCategoryCode
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp2 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp2.Open "GET", targetURL, False   
	xmlHttp2.Send    
	
	
	Set oStream2 = CreateObject("ADODB.Stream")   
	oStream2.Open   
	oStream2.Position = 0   
	oStream2.Type = 1   
	oStream2.Write xmlHttp2.ResponseBody   
	oStream2.Position = 0   
	oStream2.Type = 2   
	oStream2.Charset = "utf-8"   
	sText = oStream2.ReadText   
	oStream2.Close   
	
	Set xmlDOM2 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM2.async = False    
	xmlDOM2.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem2 = xmlDOM2.SelectNodes("//items")
	cnt = listItem2(0).childNodes.length
	Set items2 = listItem2(0).childNodes

	If cnt = 0 Then
		Response.Write("<hr><h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
<form name="listApiForm">
<input type="hidden" name="categoryCode" value="<%=request("categoryCode") %>">
<input type="hidden" name="subCategoryCode" value="<%=request("subCategoryCode") %>">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<%=insttName%>">
<input type="hidden" name="insttCode" value="<%=insttCode%>">
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
		 상세 분류&nbsp;<select  id="subCombo" onchange="listMove(this.value);" > 
<%
		For i=0 To cnt-1
		   Set itemNode = items2.item(i)
			If NOT itemNode Is Nothing Then
				'서브 카테고리 명
				If NOT itemNode.SelectSingleNode("categoryNm") is Nothing Then
					categoryNm = itemNode.SelectSingleNode("categoryNm").text
				End If
				'서브 카테고리 분류 코드
				If NOT itemNode.SelectSingleNode("categoryCode") is Nothing Then
					categoryCode = itemNode.SelectSingleNode("categoryCode").text
				End If
			End If			
%>
			<option value="<%=categoryCode%>" <%If categoryCode = Request("subCategoryCode") Then Response.Write("selected") Else Response.Write("") End If%>> <%=categoryNm%> </option>
<%
		   Set itemNode = Nothing
		Next
%>
		</select>
			동영상 제목&nbsp;<input type="text" name="videoTitle" value="<%If Request("videoTitle") Is Nothing Then Response.write("") Else Response.write(Request("videoTitle")) End If%>">
			<td align="right">
				<input type="button" name="search" value="조회" onclick="return listMove();"/>
			</td>
		</tr>
	</table>
</form>
<hr>
<%
	End If
%>

<%
If cnt > 0 Then
'메인 카테고리 -> 서브 카테고리 -> 품목 리스트
	'오퍼레이션 명
	operationName = "videoList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&pageNo=" & Request("pageNo")
	
	sSubCategoryCode = Request("subCategoryCode")
	If Request("subCategoryCode") Is Nothing OR Request("subCategoryCode")="" Then
		Set subItemNode = items2.item(0)
			sSubCategoryCode = subItemNode.SelectSingleNode("categoryCode").text
		Set subItemNode = Nothing
	End If
	parameter = parameter & "&categoryCode=" & sSubCategoryCode
	
	If Not Request("videoTitle") Is Nothing And Request("videoTitle") <> "" Then
		parameter = parameter & "&videoTitle=" & Server.URLEncode(Request("videoTitle"))
	End If

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp3 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp3.Open "GET", targetURL, False   
	xmlHttp3.Send    
	
	Set oStream3 = CreateObject("ADODB.Stream")   
	oStream3.Open   
	oStream3.Position = 0   
	oStream3.Type = 1   
	oStream3.Write xmlHttp3.ResponseBody   
	oStream3.Position = 0   
	oStream3.Type = 2   
	oStream3.Charset = "utf-8"   
	sText = oStream3.ReadText   
	oStream3.Close   
	
	Set xmlDOM3 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM3.async = False    
	xmlDOM3.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem3 = xmlDOM3.SelectNodes("//items")
	cnt = listItem3(0).childNodes.length
	Set items3 = listItem3(0).childNodes
	
'페이징 처리를 위한 값 받기
	'한 페이지에 제공할 건수
	Set numOfRows = xmlDOM3.SelectNodes("//numOfRows")
	If Not numOfRows(0) Is Nothing Then numOfRowsText= numOfRows(0).Text Else numOfRowsText = "10" End If
	'조회할 페이지 번호
	Set pageNo = xmlDOM3.SelectNodes("//pageNo")
	If Not pageNo(0) Is Nothing Then pageNoText= pageNo(0).Text Else pageNoText = "1" End If
	'조회된 총 건수
	Set totalCount = xmlDOM3.SelectNodes("//totalCount")
	If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "" End If
	
	If cnt = 3 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
%>
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
		   Set itemNode = items3.item(i)
			If NOT itemNode Is Nothing Then
				'동영상 이미지
				If NOT itemNode.SelectSingleNode("videoImg") is Nothing Then
					videoImg = itemNode.SelectSingleNode("videoImg").text
				End If
				'동영상 링크
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
		Response.Write("</tbody></table><br>")
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
End If
%>
</body>
</html>