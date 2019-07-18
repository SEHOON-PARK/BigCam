<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농가맛집</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농가맛집</strong></h3>
<hr>

<%
'농가맛집 상세 조회
If Not Request("cntntsNo") Is Nothing And Request("cntntsNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "nongsaroSampleKey"
	'서비스 명
	serviceName = "frmhsTasteHos"
	'오퍼레이션 명
	operationName = "frmhsTasteHosDtl"

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
		'명칭
		Set cntntsSj = xmlDOM.SelectNodes("//cntntsSj")
		If Not cntntsSj(0) Is Nothing Then cntntsSjText= cntntsSj(0).Text Else cntntsSjText = "" End If
		'지역명
		Set adstrdNm = xmlDOM.SelectNodes("//adstrdNm")
		If Not adstrdNm(0) Is Nothing Then adstrdNmText= adstrdNm(0).Text Else adstrdNmText = "" End If
		'슬로건
		Set slogan = xmlDOM.SelectNodes("//slogan")
		If Not slogan(0) Is Nothing Then sloganText= slogan(0).Text Else sloganText = "" End If
		'개요
		Set smm = xmlDOM.SelectNodes("//smm")
		If Not smm(0) Is Nothing Then smmText= smm(0).Text Else smmText = "" End If
		'전화번호
		Set telno = xmlDOM.SelectNodes("//telno")
		If Not telno(0) Is Nothing Then telnoText= telno(0).Text Else telnoText = "" End If
		'주소
		Set locplc = xmlDOM.SelectNodes("//locplc")
		If Not locplc(0) Is Nothing Then locplcText= locplc(0).Text Else locplcText = "" End If
		'운영방법
		Set locplc = xmlDOM.SelectNodes("//locplc")
		If Not locplc(0) Is Nothing Then locplcText= locplc(0).Text Else locplcText = "" End If
		'쉬는날
		Set restde = xmlDOM.SelectNodes("//restde")
		If Not restde(0) Is Nothing Then restdeText= restde(0).Text Else restdeText = "" End If
		'영업시간
		Set bsnTime = xmlDOM.SelectNodes("//bsnTime")
		If Not bsnTime(0) Is Nothing Then bsnTimeText= bsnTime(0).Text Else bsnTimeText = "" End If
		'취급메뉴
		Set trtmntMenu = xmlDOM.SelectNodes("//trtmntMenu")
		If Not trtmntMenu(0) Is Nothing Then trtmntMenuText= trtmntMenu(0).Text Else trtmntMenuText = "" End If
		'체험프로그램
		Set exprnProgrm = xmlDOM.SelectNodes("//exprnProgrm")
		If Not exprnProgrm(0) Is Nothing Then exprnProgrmText= exprnProgrm(0).Text Else exprnProgrmText = "" End If
		'좌석형태
		Set seatStle = xmlDOM.SelectNodes("//seatStle")
		If Not seatStle(0) Is Nothing Then seatStleText= seatStle(0).Text Else seatStleText = "" End If
		'홈페이지 주소
		Set url = xmlDOM.SelectNodes("//url")
		If Not url(0) Is Nothing Then urlText= url(0).Text Else urlText = "" End If
		'주변 관광/볼거리
		Set trrsrt = xmlDOM.SelectNodes("//trrsrt")
		If Not trrsrt(0) Is Nothing Then trrsrtText= trrsrt(0).Text Else trrsrtText = "" End If
		'내용
		Set cn = xmlDOM.SelectNodes("//cn")
		If Not cn(0) Is Nothing Then cnText= cn(0).Text Else cnText = "" End If
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
            			<img src="<%=imgUrl1Text%>" style="width:255px; height:178px;"/>
			<%
				End If
			%>
			<%
				If imgUrl2Text <> "" Then
			%>
            			<img src="<%=imgUrl2Text%>" style="width:255px; height:178px;"/>
			<%
				End If
			%>
			<%
				If imgUrl3Text <> "" Then
			%>
            			<img src="<%=imgUrl3Text%>" style="width:255px; height:178px;"/>
			<%
				End If
			%>
			<%
				If imgUrl4Text <> "" Then
			%>
            			<img src="<%=imgUrl4Text%>" style="width:255px; height:178px;"/>
			<%
				End If
			%>
			<%
				If imgUrl5Text <> "" Then
			%>
            			<img src="<%=imgUrl5Text%>" style="width:255px; height:178px;"/>
			<%
				End If
			%>
			</td>
		</tr>
		<tr>
			<td>명칭</td>
			<td><%=cntntsSjText%>
			<%
				If sloganText <> "" Then
			%>
			 | <%=sloganText%>
			<%
				End If
			%>
			</td>
		</tr>
		<tr>
			<td>지역</td>
			<td><%=adstrdNmText%></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><%=locplcText%></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=telnoText%></td>
		</tr>
		<tr>
			<td>운영방법</td>
			<td><%=operMthText%></td>
		</tr>
		<tr>
			<td>쉬는날</td>
			<td><%=restdeText%></td>
		</tr>
		<tr>
			<td>영업시간</td>
			<td><%=bsnTimeText%></td>
		</tr>
		<tr>
			<td>좌석형태</td>
			<td><%=seatStleText%></td>
		</tr>
		<tr>
			<td>홈페이지 주소</td>
			<td><%=urlText%></td>
		</tr>
		<tr>
			<td>개요</td>
			<td><%=smmText%></td>
		</tr>
		<tr>
			<td>취급메뉴</td>
			<td><%=trtmntMenuText%></td>
		</tr>
		<tr>
			<td>체험프로그램</td>
			<td><%=exprnProgrmText%></td>
		</tr>
		<tr>
			<td>주변 관광/볼거리</td>
			<td><%=trrsrtText%></td>
		</tr>
	</table>
<%
	End If
End If
%>
<input type="button" onclick="javascript:location.href='frmhsTasteHosList.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>