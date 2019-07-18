<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>이달의음식</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>이달의음식</strong></h3>
<hr>

<%
'이달의음식 상세 조회
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "monthFd"
	'오퍼레이션 명
	operationName = "monthFdmtDtl"

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
		'식재료명
		Set fdmtNm = xmlDOM.SelectNodes("//fdmtNm")
		If Not fdmtNm(0) Is Nothing Then fdmtNmText= fdmtNm(0).Text Else fdmtNmText = "" End If
		'식재료유래
		Set ctvtIndcDtl = xmlDOM.SelectNodes("//ctvtIndcDtl")
		If Not ctvtIndcDtl(0) Is Nothing Then ctvtIndcDtlText= ctvtIndcDtl(0).Text Else ctvtIndcDtlText = "" End If
		'품종특성 구입요령
		Set prchCheatDtl = xmlDOM.SelectNodes("//prchCheatDtl")
		If Not prchCheatDtl(0) Is Nothing Then prchCheatDtlText= prchCheatDtl(0).Text Else prchCheatDtlText = "" End If
		'보관방법 손질법
		Set cstdyMthDtl = xmlDOM.SelectNodes("//cstdyMthDtl")
		If Not cstdyMthDtl(0) Is Nothing Then cstdyMthDtlText= cstdyMthDtl(0).Text Else cstdyMthDtlText = "" End If
		'기타정보
		Set etcInfoDtl = xmlDOM.SelectNodes("//etcInfoDtl")
		If Not etcInfoDtl(0) Is Nothing Then etcInfoDtlText= etcInfoDtl(0).Text Else etcInfoDtlText = "" End If
		'섭취방법
		Set ntkMthDtl = xmlDOM.SelectNodes("//ntkMthDtl")
		If Not ntkMthDtl(0) Is Nothing Then ntkMthDtlText= ntkMthDtl(0).Text Else ntkMthDtlText = "" End If
		'영양성분효능
		Set ntrIrdntEfcyDtl = xmlDOM.SelectNodes("//ntrIrdntEfcyDtl")
		If Not ntrIrdntEfcyDtl(0) Is Nothing Then ntrIrdntEfcyDtlText= ntrIrdntEfcyDtl(0).Text Else ntrIrdntEfcyDtlText = "" End If
		'관련연구정보
		Set rltRsrchInfoDtl = xmlDOM.SelectNodes("//rltRsrchInfoDtl")
		If Not rltRsrchInfoDtl(0) Is Nothing Then rltRsrchInfoDtlText= rltRsrchInfoDtl(0).Text Else rltRsrchInfoDtlText = "" End If
		'소비량
		Set cnsmpqyDtl = xmlDOM.SelectNodes("//cnsmpqyDtl")
		If Not cnsmpqyDtl(0) Is Nothing Then cnsmpqyDtlText= cnsmpqyDtl(0).Text Else cnsmpqyDtlText = "" End If
		'이미지구분코드
		Set rtnImgSeCode = xmlDOM.SelectNodes("//rtnImgSeCode")
		If Not rtnImgSeCode(0) Is Nothing Then rtnImgSeCodeText= rtnImgSeCode(0).Text Else rtnImgSeCodeText = "" End If
		'이미지 경로
		Set rtnFileCours = xmlDOM.SelectNodes("//rtnFileCours")
		If Not rtnFileCours(0) Is Nothing Then rtnFileCoursText= rtnFileCours(0).Text Else rtnFileCoursText = "" End If
		'이미지 물리명
		Set rtnStreFileNm = xmlDOM.SelectNodes("//rtnStreFileNm")
		If Not rtnStreFileNm(0) Is Nothing Then rtnStreFileNmText= rtnStreFileNm(0).Text Else rtnStreFileNmText = "" End If
		'이미지 설명
		Set rtnImageDc = xmlDOM.SelectNodes("//rtnImageDc")
		If Not rtnImageDc(0) Is Nothing Then rtnImageDcText= rtnImageDc(0).Text Else rtnImageDcText = "" End If

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="10%">
			<col width="*">
		</colgroup>
		<tr>
			<td>식재료유래</td>
			<td><%=ctvtIndcDtlText%></td>
		</tr>
		<tr>
			<td>품종특성구입요령</td>
			<td><%=prchCheatDtlText%></td>
		</tr>
		<tr>
			<td>보관법손질법</td>
			<td><%=cstdyMthDtlText%></td>
		</tr>
		<tr>
			<td>기타정보</td>
			<td><%=etcInfoDtlText%></td>
		</tr>
	</table>

	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="10%">
			<col width="*">
		</colgroup>
		<tr>
			<td>섭취방법</td>
			<td><%=ntkMthDtlText%></td>
		</tr>
		<tr>
			<td>영양성분효능</td>
			<td><%=ntrIrdntEfcyDtlText%></td>
		</tr>
		<tr>
			<td>관련연구정보</td>
			<td><%=rltRsrchInfoDtlText%></td>
		</tr>
		<tr>
			<td>소비량</td>
			<td><%=cnsmpqyDtlText%></td>
		</tr>
	</table>
	<div>
	<ul>
<%

	rtnStreFileNmArr = split(rtnStreFileNmText,"|")
	rtnFileCoursArr = split(rtnFileCoursText,"|")
	rtnImgSeCodeArr= split(rtnImgSeCodeText,"|")
	for i=0 to UBound(rtnStreFileNmArr)
		imgCnt = -1

		for k=0 to UBound(rtnImgSeCodeArr)
			If rtnImgSeCodeArr(k) = "209002" OR rtnImgSeCodeArr(k) = "209006"  Then
				imgCnt = k
			End If
		next

		If imgCnt > -1 Then
			imgUrl = "http://www.nongsaro.go.kr/" & rtnFileCoursArr(imgCnt) & "/" & rtnStreFileNmArr(imgCnt)
%>
		<li>
			<li style="width: 33%;display: inline-block;">
			<img src="<%=imgUrl%>" alt=""  title="" style="width: 249px;height: 198px;"/>
			</li>
		</li>
<%
		End If
	next

	End If
End If
%>
</ul>
</div>
<input type="button" onclick="javascript:location.href='monthFd.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>