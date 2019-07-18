<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>현장기술지원</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>현장기술지원</strong></h3>
<hr>

<%
'현장기술지원 상세 조회
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "sptTchnlgySport"
	'오퍼레이션 명
	operationName = "sptTchnlgySportView"

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
		'제목
		Set cntntsSj = xmlDOM.SelectNodes("//cntntsSj")
		If Not cntntsSj(0) Is Nothing Then cntntsSjText= cntntsSj(0).Text Else cntntsSjText = "" End If
		'장소
		Set placeInfo = xmlDOM.SelectNodes("//placeInfo")
		If Not placeInfo(0) Is Nothing Then placeInfoText= placeInfo(0).Text Else placeInfoText = "" End If
		'기술지원일
		Set regDt = xmlDOM.SelectNodes("//regDt")
		If Not regDt(0) Is Nothing Then regDtText= regDt(0).Text Else regDtText = "" End If
		'조회수
		Set rdcnt = xmlDOM.SelectNodes("//rdcnt")
		If Not rdcnt(0) Is Nothing Then rdcntText= rdcnt(0).Text Else rdcntText = "" End If
		'작성자
		Set wrterNm = xmlDOM.SelectNodes("//wrterNm")
		If Not wrterNm(0) Is Nothing Then wrterNmText= wrterNm(0).Text Else wrterNmText = "" End If
		'품목
		Set prdlstCodeNm = xmlDOM.SelectNodes("//prdlstCodeNm")
		If Not prdlstCodeNm(0) Is Nothing Then prdlstCodeNmText= prdlstCodeNm(0).Text Else prdlstCodeNmText = "" End If
		'내용
		Set cn = xmlDOM.SelectNodes("//cn")
		If Not cn(0) Is Nothing Then cnText= cn(0).Text Else cnText = "" End If

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
			<col width="20%">
			<col width="*">
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td>제목</td>
			<td colspan="5"><%=cntntsSjText%></td>
		</tr>
		<tr>
			<td>품목</td>
			<td colspan="5"><%=prdlstCodeNmText%></td>
		</tr>
		<tr>
			<td>장소</td>
			<td colspan="5"><%=placeInfoText%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=wrterNmText%></td>
			<td>기술지원일</td>
			<td><%=regDtText%></td>
			<td>조회수</td>
			<td><%=rdcntText%></td>
		</tr>
		<tr>
			<td colspan="6"><%=cnText%></td>
		</tr>
	</table>
<%
	End If
End If
%>
<input type="button" onclick="javascript:location.href='sptTchnlgySport.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>