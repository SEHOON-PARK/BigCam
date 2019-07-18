<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>개열별,생리작용별</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>개열별,생리작용별</strong></h3><hr>
<%
If true Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "statLine"
	
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
	
	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="33%" />
			<col width="*" />
			<col width="33%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" >계열</th>
				<th scope="col" >화합물 수</th>
				<th scope="col" >비율</th>
			</tr>
		</thead>
		<tbody>
<%	
	
		For i=0 To cnt-1
		   Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'구분
				If NOT itemNode.SelectSingleNode("tab") is Nothing Then
					tab = itemNode.SelectSingleNode("tab").text
				End If
				'계열코드
				If NOT itemNode.SelectSingleNode("code") is Nothing Then
					code = itemNode.SelectSingleNode("code").text
				End If
				'계열코드명				
				If NOT itemNode.SelectSingleNode("codeNm") is Nothing Then
					codeNm = itemNode.SelectSingleNode("codeNm").text
				End If
				'화합물 수			
				If NOT itemNode.SelectSingleNode("cnt") is Nothing Then
					cnt = itemNode.SelectSingleNode("cnt").text
				End If
				'비율				
				If NOT itemNode.SelectSingleNode("ratio") is Nothing Then
					ratio = itemNode.SelectSingleNode("ratio").text
				End If				
			End If
			
			If tab="ALL" Then
%>
			<tr>
				<% If code="TOTAL" Then %>
				   <td align="center"><%=code%></td>
				<% Else %>
					<td align="center"><%=codeNm%></td>
				<% End If %>
				<td align="center"><%=cnt%></td>
				<td align="center"><%=ratio%></td>
			<tr>
<%
			End If	
			Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If
%>
</body>
</html>