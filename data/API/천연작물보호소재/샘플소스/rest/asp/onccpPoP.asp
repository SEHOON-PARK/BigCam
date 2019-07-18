<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<%
'화합물 및 참고 문헌리스트
If Not Request("check1") Is Nothing And Request("check1") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "searchPlantReferLtrtre"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&lvbNo=" & Request("lvbNo")
	parameter = parameter & "&referLtrtreCode=" & Request("referLtrtreCode")
	
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
<h3><strong>화합물 및 참고 문헌리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="45%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>참고문헌</th>
		</tr>

<%
	For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'번호
				If NOT itemNode.SelectSingleNode("rnum") is Nothing Then
					rnum = itemNode.SelectSingleNode("rnum").text
				End If
				'화합물 명
				If NOT itemNode.SelectSingleNode("onccpNm") is Nothing Then
					onccpNm = itemNode.SelectSingleNode("onccpNm").text
				End If
				'요소명				
				If NOT itemNode.SelectSingleNode("elmnWrd") is Nothing Then
					elmnWrd = itemNode.SelectSingleNode("elmnWrd").text
				End If
				'참고문헌				
				If NOT itemNode.SelectSingleNode("cnDc") is Nothing Then
					cnDc = itemNode.SelectSingleNode("cnDc").text
				End If				
			End If
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=onccpNm%></td>
   			<td><%=elmnWrd%></td>
   			<td><%=cnDc%></td>
		</tr>
<%
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
End If
%>

<%
'참고 문헌리스트
If Not Request("check2") Is Nothing And Request("check2") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "searchOnccpReferLtrtre"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&onccpNo=" & Request("lvbNo")
	parameter = parameter & "&referLtrtreCode=" & Request("referLtrtreCode")
	
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
<h3><strong>참고 문헌리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="30%"/>
			<col width="65%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>구분</th>
			<th>참고문헌</th>
		</tr>
<%
	For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'번호
				If NOT itemNode.SelectSingleNode("rnum") is Nothing Then
					rnum = itemNode.SelectSingleNode("rnum").text
				End If
				'구분
				If NOT itemNode.SelectSingleNode("codeNm") is Nothing Then
					codeNm = itemNode.SelectSingleNode("codeNm").text
				End If
				'참고문헌				
				If NOT itemNode.SelectSingleNode("cnDc") is Nothing Then
					cnDc = itemNode.SelectSingleNode("cnDc").text
				End If				
			End If
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=codeNm%></td>
   			<td><%=cnDc%></td>
		</tr>
<%
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
End If
%>

<%
'생물자원리스트
If Not Request("check3") Is Nothing And Request("check3") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "searchOnccpLvb"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&onccpNo=" & Request("lvbNo")
	parameter = parameter & "&referLtrtreCode=" & Request("referLtrtreCode")
	
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
<h3><strong>생물자원리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="20%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
		</tr>
<%
	For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'번호
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
			End If
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=fmlNm%></td>
   			<td><%=bneNm%></td>
   			<td><%=yeastNm%></td>
   			<td><%=rm%></td>
		</tr>
<%
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
End If
%>

<%
'생물자원리스트
If Not Request("check4") Is Nothing And Request("check4") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = ""
	
	If Request("check4")="statInsect" Then
		operationName="statInsectLst"
	ElseIf Request("check4")="statMicroorganism" Then
		operationName="statMicroorganismLst"
	Else
		operationName="statPlantLst"
	End If				
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&fmlNo=" & Request("lvbNo")
	parameter = parameter & "&cntCode=" & Request("cntCode")
	
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
<h3><strong>생물자원리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
			<th>화합물수</th>
		</tr>
<%
	For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'번호
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
				'화합물 수				
				If NOT itemNode.SelectSingleNode("cnt") is Nothing Then
					cnt = itemNode.SelectSingleNode("cnt").text
				End If				
			End If
%>
		<tr>
   			<td><%=rnum%></td>
   			<td><%=fmlNm%></td>
   			<td><%=bneNm%></td>
   			<td><%=yeastNm%></td>
   			<td><%=rm%></td>
   			<td><%=cnt%></td>
		</tr>
<%
			Set itemNode = Nothing
		Next
		Response.Write("</table>")
	End If
End If
%>
</body>
</html>