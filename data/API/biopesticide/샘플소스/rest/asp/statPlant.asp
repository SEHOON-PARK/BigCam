<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>식물통계</title>
<script type='text/javascript'>
	//팝업 띄우기
	function fncNextList(seq,cntCode){
		var popupUrl="onccpPoP.asp?lvbNo="+seq+"&cntCode="+cntCode+"&check4=statPlant";
		var popOption="width=800,height=440";
		
		window.open(popupUrl,"nongsaroPop",popOption);
	}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>식물통계</strong></h3><hr>
<%
If true Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스명
	serviceName = "biopesticide"
	'오퍼레이션 명
	operationName = "statPlant"
	
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
	
	For i=0 To cnt-1
		Set itemNode = items.item(i)
		If NOT itemNode Is Nothing Then
			'과 일련 번호
			If NOT itemNode.SelectSingleNode("fmlSeqNo") is Nothing Then
				fmlSeqNo = itemNode.SelectSingleNode("fmlSeqNo").text
			End If
			'과명 명
			If NOT itemNode.SelectSingleNode("fmlNm") is Nothing Then
				fmlNm = itemNode.SelectSingleNode("fmlNm").text
			End If
		End If
%>
		<span id="<%=fmlSeqNo%>">&nbsp;|&nbsp;<a href="#<%=i%><%=fmlSeqNo%>"><%=fmlNm%></a></span>
<%
		Set itemNode = Nothing
	Next

	If cnt = 0 Then
		Response.Write("<h3><font color='red'>조회한 정보가 없습니다.</font></h3>")
	Else
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'과 일련 번호
				If NOT itemNode.SelectSingleNode("fmlSeqNo") is Nothing Then
					fmlSeqNo = itemNode.SelectSingleNode("fmlSeqNo").text
				End If
				'과명 명
				If NOT itemNode.SelectSingleNode("fmlNm") is Nothing Then
					fmlNm = itemNode.SelectSingleNode("fmlNm").text
				End If
				'살균, 살충, 제초
				If NOT itemNode.SelectSingleNode("cntA") is Nothing Then
					cntA = itemNode.SelectSingleNode("cntA").text
				End If
				'살균, 살충
				If NOT itemNode.SelectSingleNode("cntB") is Nothing Then
					cntB = itemNode.SelectSingleNode("cntB").text
				End If
				'살균, 제초
				If NOT itemNode.SelectSingleNode("cntC") is Nothing Then
					cntC = itemNode.SelectSingleNode("cntC").text
				End If
				'살충, 제초
				If NOT itemNode.SelectSingleNode("cntD") is Nothing Then
					cntD = itemNode.SelectSingleNode("cntD").text
				End If
				'살균
				If NOT itemNode.SelectSingleNode("cntE") is Nothing Then
					cntE = itemNode.SelectSingleNode("cntE").text
				End If
				'살충
				If NOT itemNode.SelectSingleNode("cntF") is Nothing Then
					cntF = itemNode.SelectSingleNode("cntF").text
				End If
				'제초
				If NOT itemNode.SelectSingleNode("cntG") is Nothing Then
					cntG = itemNode.SelectSingleNode("cntG").text
				End If
				'살균, 살충, 제초 비율
				If NOT itemNode.SelectSingleNode("ratioA") is Nothing Then
					ratioA = itemNode.SelectSingleNode("ratioA").text
				End If
				'살균, 살충 비율
				If NOT itemNode.SelectSingleNode("ratioB") is Nothing Then
					ratioB = itemNode.SelectSingleNode("ratioB").text
				End If
				'살균, 제초 비율
				If NOT itemNode.SelectSingleNode("ratioC") is Nothing Then
					ratioC = itemNode.SelectSingleNode("ratioC").text
				End If
				'살충, 제초 비율
				If NOT itemNode.SelectSingleNode("ratioD") is Nothing Then
					ratioD = itemNode.SelectSingleNode("ratioD").text
				End If
				'살균 비율
				If NOT itemNode.SelectSingleNode("ratioE") is Nothing Then
					ratioE = itemNode.SelectSingleNode("ratioE").text
				End If
				'살충 비율
				If NOT itemNode.SelectSingleNode("ratioF") is Nothing Then
					ratioF = itemNode.SelectSingleNode("ratioF").text
				End If
				'제초
				If NOT itemNode.SelectSingleNode("ratioG") is Nothing Then
					ratioG = itemNode.SelectSingleNode("ratioG").text
				End If
				'식물수 비율
				If NOT itemNode.SelectSingleNode("cnt") is Nothing Then
					cnt = itemNode.SelectSingleNode("cnt").text
				End If
			End If
			
%>
<hr>
<div id="<%=i%><%=fmlSeqNo%>"></div>
<h3><strong><%=fmlNm%></strong></h3>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<th>식물수</th>
				<th>살균,살충,제초</th>
				<th>살균,살충</th>
				<th>살균,제초</th>
				<th>살충,제초</th>
				<th>살균</th>
				<th>살충</th>
				<th>제초</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td align="center">
					<%if Not cnt=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','1')"><%=cnt%></a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntA=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_A')"><%=cntA%>(<%=ratioA%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntB=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_B')"><%=cntB%>(<%=ratioB%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntC=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_C')"><%=cntC%>(<%=ratioC%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntD=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_D')"><%=cntD%>(<%=ratioD%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntE=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_E')"><%=cntE%>(<%=ratioE%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntF=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_F')"><%=cntF%>(<%=ratioF%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
				<td align="center">
					<%if Not cntG=("0") Then %>
						<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_G')"><%=cntG%>(<%=ratioG%>%)</a>
					<%Else Response.Write("-") End If%>
				</td>
			<tr>
		<tbody>
	</table>
<%
		Set itemNode = Nothing
		Next
	End If
End If
%>
</body>
</html>