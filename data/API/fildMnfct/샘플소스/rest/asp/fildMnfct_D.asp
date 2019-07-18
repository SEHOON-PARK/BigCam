<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>텃밭가꾸기</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>텃밭가꾸기</strong></h3>
<hr>

<%
'텃밭가꾸기 상세 조회
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "fildMnfct"
	'오퍼레이션 명
	operationName = "fildMnfctView"

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
		'다운URL
		Set downUrl = xmlDOM.SelectNodes("//downUrl")
		If Not downUrl(0) Is Nothing Then downUrlText= downUrl(0).Text Else downUrlText = "" End If
		'등록일
		Set svcDtx = xmlDOM.SelectNodes("//svcDtx")
		If Not svcDtx(0) Is Nothing Then svcDtxText= svcDtx(0).Text Else svcDtxText = "" End If
		'조회수
		Set cntntsRdcnt = xmlDOM.SelectNodes("//cntntsRdcnt")
		If Not cntntsRdcnt(0) Is Nothing Then cntntsRdcntText= cntntsRdcnt(0).Text Else cntntsRdcntText = "" End If
		'작성자
		Set updusrEsntlNm = xmlDOM.SelectNodes("//updusrEsntlNm")
		If Not updusrEsntlNm(0) Is Nothing Then updusrEsntlNmText= updusrEsntlNm(0).Text Else updusrEsntlNmText = "" End If
		'다운파일명
		Set fileName = xmlDOM.SelectNodes("//fileName")
		If Not fileName(0) Is Nothing Then fileNameText= fileName(0).Text Else fileNameText = "" End If
		'내용
		Set cn = xmlDOM.SelectNodes("//cn")
		If Not cn(0) Is Nothing Then cnText= cn(0).Text Else cnText = "" End If

		s_downUrl=Split(downUrlText,";")
		s_fileName=Split(fileNameText,";")

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:16%" />
			<col style="width:18%" />
			<col style="width:16%" />
			<col style="width:18%" />
			<col style="width:16%" />
			<col/>
		</colgroup>
		<tr>
			<td>제목</td>
			<td colspan="5"><%=cntntsSjText%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=updusrEsntlNmText%></td>
			<td>등록일</td>
			<td><%=svcDtxText%></td>
			<td>조회수</td>
			<td><%=cntntsRdcntText%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="5">
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
			<td colspan="6"><%=cnText%></td>
		</tr>
	</table>
<%
	End If
End If
%>
<input type="button" onclick="javascript:location.href='fildMnfct.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>