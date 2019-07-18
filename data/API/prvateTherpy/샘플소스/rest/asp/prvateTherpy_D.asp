<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>민간약초</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>민간약초</strong></h3>
<hr>

<%
'민간약초 상세 조회
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "prvateTherpy"
	'오퍼레이션 명
	operationName = "prvateTherpyDtl"

	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
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

	Set item = xmlDOM.SelectNodes("//body")
	cnt = item(0).childNodes.length

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
		'키값
		Set cntntsNo = xmlDOM.SelectNodes("//cntntsNo")
		If Not cntntsNo(0) Is Nothing Then cntntsNoText= cntntsNo(0).Text Else cntntsNoText = "" End If
		'명
		Set cntntsSj = xmlDOM.SelectNodes("//cntntsSj")
		If Not cntntsSj(0) Is Nothing Then cntntsSjText= cntntsSj(0).Text Else cntntsSjText = "" End If
		'학명
		Set bneNm = xmlDOM.SelectNodes("//bneNm")
		If Not bneNm(0) Is Nothing Then bneNmText= bneNm(0).Text Else bneNmText = "" End If
		'생약명
		Set hbdcNm = xmlDOM.SelectNodes("//hbdcNm")
		If Not hbdcNm(0) Is Nothing Then hbdcNmText= hbdcNm(0).Text Else hbdcNmText = "" End If
		'이용_부위
		Set useeRegn = xmlDOM.SelectNodes("//useeRegn")
		If Not useeRegn(0) Is Nothing Then useeRegnText= useeRegn(0).Text Else useeRegnText = "" End If
		'형태
		Set stle = xmlDOM.SelectNodes("//stle")
		If Not stle(0) Is Nothing Then stleText= stle(0).Text Else stleText = "" End If
		'민간_요법
		Set prvateTherpy = xmlDOM.SelectNodes("//prvateTherpy")
		If Not prvateTherpy(0) Is Nothing Then prvateTherpyText= prvateTherpy(0).Text Else prvateTherpyText = "" End If
		'이미지1
		Set imgUrl1 = xmlDOM.SelectNodes("//imgUrl1")
		If Not imgUrl1(0) Is Nothing Then imgUrl1Text= imgUrl1(0).Text Else imgUrl1Text = "" End If
		'이미지2
		Set imgUrl2 = xmlDOM.SelectNodes("//imgUrl2")
		If Not imgUrl2(0) Is Nothing Then imgUrl2Text= imgUrl2(0).Text Else imgUrl2Text = "" End If
		'이미지3
		Set imgUrl3 = xmlDOM.SelectNodes("//imgUrl3")
		If Not imgUrl3(0) Is Nothing Then imgUrl3Text= imgUrl3(0).Text Else imgUrl3Text = "" End If
		'이미지4
		Set imgUrl4 = xmlDOM.SelectNodes("//imgUrl4")
		If Not imgUrl4(0) Is Nothing Then imgUrl4Text= imgUrl4(0).Text Else imgUrl4Text = "" End If
		'이미지5
		Set imgUrl5 = xmlDOM.SelectNodes("//imgUrl5")
		If Not imgUrl5(0) Is Nothing Then imgUrl5Text= imgUrl5(0).Text Else imgUrl5Text = "" End If
		'이미지6
		Set imgUrl6 = xmlDOM.SelectNodes("//imgUrl6")
		If Not imgUrl6(0) Is Nothing Then imgUrl6Text= imgUrl6(0).Text Else imgUrl6Text = "" End If

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td colspan="2">
			<% 
				If imgUrl1Text <> "" Then 
			%>
            			<img src="<%=imgUrl1Text%>" style="max-width:255px; height:auto;"/>
			<% 
				End If 
			%>
			<% 
				If imgUrl2Text <> "" Then 
			%>
            			<img src="<%=imgUrl2Text%>" style="max-width:255px; height:auto;"/>
			<% 
				End If 
			%>
			<% 
				If imgUrl3Text <> "" Then 
			%>
            			<img src="<%=imgUrl3Text%>" style="max-width:255px; height:auto;"/>
			<% 
				End If 
			%>
			<% 
				If imgUrl4Text <> "" Then 
			%>
            			<img src="<%=imgUrl4Text%>" style="max-width:255px; height:auto;"/>
			<% 
				End If 
			%>
			<% 
				If imgUrl5Text <> "" Then 
			%>
            			<img src="<%=imgUrl5Text%>" style="max-width:255px; height:auto;"/>
			<% 
				End If 
			%>
			<% 
				If imgUrl6Text <> "" Then 
			%>
            			<img src="<%=imgUrl6Text%>" style="max-width:255px; height:auto;"/>
			<% 
				End If 
			%>
			</td>
		</tr>
		<tr>
			<td>명칭</td>
			<td><%=cntntsSjText%></td>
		</tr>
		<tr>
			<td>학명</td>
			<td><%=bneNmText%></td>
		</tr>
		<tr>
			<td>생약명</td>
			<td><%=hbdcNmText%></td>
		</tr>
		<tr>
			<td>이용부위</td>
			<td><%=useeRegnText%></td>
		</tr>
		<tr>
			<td>형태</td>
			<td><%=stleText%></td>
		</tr>
		<tr>
			<td>민간요법</td>
			<td><%=prvateTherpyText%></td>
		</tr>
	</table>
<%
	End If
End If
%>
<input type="button" onclick="javascript:location.href='prvateTherpyList.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>