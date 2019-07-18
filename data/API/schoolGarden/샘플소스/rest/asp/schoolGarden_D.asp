<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>진로체험</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>진로체험</strong></h3>
<hr>

<%
'인테러뱅 상세 조회
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "schoolGarden"
	'오퍼레이션 명
	operationName = "schoolGardenDtl"

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
		'제목
		Set cntntsSj = xmlDOM.SelectNodes("//cntntsSj")
		If Not cntntsSj(0) Is Nothing Then cntntsSjText= cntntsSj(0).Text Else cntntsSjText = "" End If
		'활동목적
		Set actGoalDtl = xmlDOM.SelectNodes("//actGoalDtl")
		If Not actGoalDtl(0) Is Nothing Then actGoalDtlText= actGoalDtl(0).Text Else actGoalDtlText = "" End If
		'원예활동
		Set gardnactDtl = xmlDOM.SelectNodes("//gardnactDtl")
		If Not gardnactDtl(0) Is Nothing Then gardnactDtlText= gardnactDtl(0).Text Else gardnactDtlText = "" End If
		'관련동영상
		Set linkUrl = xmlDOM.SelectNodes("//linkUrl")
		If Not linkUrl(0) Is Nothing Then linkUrlText= linkUrl(0).Text Else linkUrlText = "" End If
		'내용
		Set cn = xmlDOM.SelectNodes("//cn")
		If Not cn(0) Is Nothing Then cnText= cn(0).Text Else cnText = "" End If
		'파일 다운로드 URL
		Set downUrl = xmlDOM.SelectNodes("//downUrl")
		If Not downUrl(0) Is Nothing Then downUrlText= downUrl(0).Text Else downUrlText = "" End If
		'파일명
		Set fileName = xmlDOM.SelectNodes("//fileName")
		If Not fileName(0) Is Nothing Then fileNameText= fileName(0).Text Else fileNameText = "" End If

		s_downUrl=Split(downUrlText,";")
		s_fileName=Split(fileNameText,";")

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td colspan="2"><%=cntntsSjText%></td>
		</tr>
		<tr>
			<td>확동목적</td>
			<td><%=actGoalDtlText%></td>
		</tr>
		<tr>
			<td>원예활동</td>
			<td><%=gardnactDtlText%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
<%
			For j=0 To UBound(s_downUrl)
%>
				<a href="<%=s_downUrl(j)%>"><%=s_fileName(j)%></a><br>
<%
			Next
%>
			</td>
		</tr>
		<tr>
			<td>관련동영상</td>
			<td><a target="_blank" href="<%=linkUrlText%>"><%=linkUrlText%></a></td>
		</tr>
	</table>
	<%=cnText%>
<%
	End If
End If
%>
<input type="button" onclick="javascript:location.href='schoolGarden.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>