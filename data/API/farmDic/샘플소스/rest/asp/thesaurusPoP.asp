<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<%
'Term
If Not Request("faoCode") Is Nothing And Request("faoCode") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "thesaurusDtlTerm"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&faoCode=" & Request("faoCode")
	
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

	If cnt <> 0 Then 
%>
<div style="float: left; width: 49%; margin-right: 10px">
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Term</th>
		</tr>
		
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("languageCodeNm") is Nothing Then
					languageCodeNm = itemNode.SelectSingleNode("languageCodeNm").text
				End If
				If NOT itemNode.SelectSingleNode("languageCode") is Nothing Then
					languageCode = itemNode.SelectSingleNode("languageCode").text
				End If
				If NOT itemNode.SelectSingleNode("termSpell") is Nothing Then
					termSpell = itemNode.SelectSingleNode("termSpell").text
				End If
			End If
%>
		<tr>
   			<td><%=termSpell%>(<%=languageCodeNm%>)</td>
		</tr>
<%		
		   Set itemNode = Nothing
		Next
	End If
%>
	</table>
</div>
<%
End If
%>
<div style="float: left; width: 49%">
<%
'Word Tree
If Not Request("faoCode") Is Nothing And Request("faoCode") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "thesaurusDtlWordTree"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&faoCode=" & Request("faoCode")
	
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

	If cnt <> 0 Then 
%>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Word Tree</th>
		</tr>
		
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("linkAbr") is Nothing Then
					linkAbr = itemNode.SelectSingleNode("linkAbr").text
				End If
				If NOT itemNode.SelectSingleNode("termSpell") is Nothing Then
					termSpell = itemNode.SelectSingleNode("termSpell").text
				End If
				If NOT itemNode.SelectSingleNode("termCode2") is Nothing Then
					termCode2 = itemNode.SelectSingleNode("termCode2").text
				End If
			End If
%>
		<tr>
   			<td><%=linkAbr%>&nbsp;&nbsp;<%=termSpell%>(<%=termCode2%>)</td>
		</tr>
<%		
		   Set itemNode = Nothing
		Next
	End If
%>
	</table>
<%
End If
%>

<%
'Scope Notes
If Not Request("faoCode") Is Nothing And Request("faoCode") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "farmDic"
	'오퍼레이션 명
	operationName = "thesaurusDtlScopeNotes"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&faoCode=" & Request("faoCode")
	
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

	If cnt <> 0 Then 
%>
	<br>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Scope Notes</th>
		</tr>
		
<%
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("tagDesc") is Nothing Then
					tagDesc = itemNode.SelectSingleNode("tagDesc").text
				End If
				If NOT itemNode.SelectSingleNode("tagText") is Nothing Then
					tagText = itemNode.SelectSingleNode("tagText").text
				End If
			End If
%>
		<tr>
   			<td><strong><%=tagDesc%></strong>&nbsp;&nbsp;<%=tagText%></td>
		</tr>
<%		
		   Set itemNode = Nothing
		Next
	End If
%>
	</table>
<%
End If
%>

</div>
</body>
</html>