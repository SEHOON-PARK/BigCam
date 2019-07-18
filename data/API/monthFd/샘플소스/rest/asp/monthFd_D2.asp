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
	operationName = "monthNewFdDtl"

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
		'음식명
		Set fdNm = xmlDOM.SelectNodes("//fdNm")
		If Not fdNm(0) Is Nothing Then fdNmText= fdNm(0).Text Else fdNmText = "" End If
		'재료정보
		Set matrlInfo = xmlDOM.SelectNodes("//matrlInfo")
		If Not matrlInfo(0) Is Nothing Then matrlInfoText= matrlInfo(0).Text Else matrlInfoText = "" End If
		'조리방법정보
		Set ckngMthInfo = xmlDOM.SelectNodes("//ckngMthInfo")
		If Not ckngMthInfo(0) Is Nothing Then ckngMthInfoText= ckngMthInfo(0).Text Else ckngMthInfoText = "" End If
		'단체급식적용정보
		Set grpMlsvApplcInfo = xmlDOM.SelectNodes("//grpMlsvApplcInfo")
		If Not grpMlsvApplcInfo(0) Is Nothing Then grpMlsvApplcInfoText= grpMlsvApplcInfo(0).Text Else grpMlsvApplcInfoText = "" End If
		'조리기기 도구정보
		Set ckngmhrlsUntInfo = xmlDOM.SelectNodes("//ckngmhrlsUntInfo")
		If Not ckngmhrlsUntInfo(0) Is Nothing Then ckngmhrlsUntInfoText= ckngmhrlsUntInfo(0).Text Else ckngmhrlsUntInfoText = "" End If
		'비고정보
		Set rmInfo = xmlDOM.SelectNodes("//rmInfo")
		If Not rmInfo(0) Is Nothing Then rmInfoText= rmInfo(0).Text Else rmInfoText = "" End If
		'인분명
		Set phphmntNm = xmlDOM.SelectNodes("//phphmntNm")
		If Not phphmntNm(0) Is Nothing Then phphmntNmText= phphmntNm(0).Text Else phphmntNmText = "" End If
		'에너지량
		Set energyQy = xmlDOM.SelectNodes("//energyQy")
		If Not energyQy(0) Is Nothing Then energyQyText= energyQy(0).Text Else energyQyText = "" End If
		'탄수화물량
		Set crbQy = xmlDOM.SelectNodes("//crbQy")
		If Not crbQy(0) Is Nothing Then crbQyText= crbQy(0).Text Else crbQyText = "" End If
		'지질량
		Set ntrfsQy = xmlDOM.SelectNodes("//ntrfsQy")
		If Not ntrfsQy(0) Is Nothing Then ntrfsQyText= ntrfsQy(0).Text Else ntrfsQyText = "" End If


		'단백질량
		Set protQy = xmlDOM.SelectNodes("//protQy")
		If Not protQy(0) Is Nothing Then protQyText= protQy(0).Text Else protQyText = "" End If
		'식이섬유량
		Set edblfibrQy = xmlDOM.SelectNodes("//edblfibrQy")
		If Not edblfibrQy(0) Is Nothing Then edblfibrQyText= edblfibrQy(0).Text Else edblfibrQyText = "" End If
		'비타민A량
		Set vtmaQy = xmlDOM.SelectNodes("//vtmaQy")
		If Not vtmaQy(0) Is Nothing Then vtmaQyText= vtmaQy(0).Text Else vtmaQyText = "" End If
		'비타민E량
		Set vteQy = xmlDOM.SelectNodes("//vteQy")
		If Not vteQy(0) Is Nothing Then vteQyText= vteQy(0).Text Else vteQyText = "" End If
		'비타민C량
		Set vtcQy = xmlDOM.SelectNodes("//vtcQy")
		If Not vtcQy(0) Is Nothing Then vtcQyText= vtcQy(0).Text Else vtcQyText = "" End If
		'티아민량
		Set thiaQy = xmlDOM.SelectNodes("//thiaQy")
		If Not thiaQy(0) Is Nothing Then thiaQyText= thiaQy(0).Text Else thiaQyText = "" End If
		'리보플라빈량
		Set niboplaQy = xmlDOM.SelectNodes("//niboplaQy")
		If Not niboplaQy(0) Is Nothing Then niboplaQyText= niboplaQy(0).Text Else niboplaQyText = "" End If
		'칼슘량
		Set clciQy = xmlDOM.SelectNodes("//clciQy")
		If Not clciQy(0) Is Nothing Then clciQyText= clciQy(0).Text Else clciQyText = "" End If
		'나트륨량
		Set naQy = xmlDOM.SelectNodes("//naQy")
		If Not naQy(0) Is Nothing Then naQyText= naQy(0).Text Else naQyText = "" End If
		'칼륨량
		Set ptssQy = xmlDOM.SelectNodes("//ptssQy")
		If Not ptssQy(0) Is Nothing Then ptssQyText= ptssQy(0).Text Else ptssQyText = "" End If
		'철량
		Set irnQy = xmlDOM.SelectNodes("//irnQy")
		If Not irnQy(0) Is Nothing Then irnQyText= irnQy(0).Text Else irnQyText = "" End If
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

		rtnStreFileNmArr = split(rtnStreFileNmText,"|")
		rtnFileCoursArr = split(rtnFileCoursText,"|")
		rtnImgSeCodeArr= split(rtnImgSeCodeText,"|")

		for i=0 to UBound(rtnStreFileNmArr)
			If rtnImgSeCodeArr(i) = "209006" OR rtnImgSeCodeArr(i) = "209007"  Then
				imgUrl = "http://www.nongsaro.go.kr/" & rtnFileCoursArr(i) & "/" & rtnStreFileNmArr(i)
%>
				<li>
					<li style="width: 33%;display: inline-block;">
					<img src="<%=imgUrl%>" alt=""  title="" style="width: 249px;height: 198px;"/>
					</li>
				</li>
<%
			End If
		next
%>
	<h2><%=fdNmText%></h2>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:10%;">
			<col>
		</colgroup>
		<tr>
			<td>재료</td>
			<td><%=matrlInfoText%></td>
		</tr>
		<tr>
			<td>만드는 법</td>
			<td><%=ckngMthInfoText%></td>
		</tr>
		<tr>
			<td>단체급식 적용법</td>
			<td><%=grpMlsvApplcInfoText%></td>
		</tr>
	</table>
	<h2>영양성분 - <%=fdNmText%>(<%=phphmntNmText%>)</h2>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="row">에너지<br />(kcal)</th>
				<th scope="row">탄수화물<br />(g)</th>
				<th scope="row">지질<br />(g)</th>
				<th scope="row">단백질<br />(g)</th>
				<th scope="row">식이섬유<br />(g)</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="txt-c"> <%=energyQyText%></td>
				<td class="txt-c"> <%=crbQyText%></td>
				<td class="txt-c"> <%=ntrfsQyText%></td>
				<td class="txt-c"> <%=protQyText%></td>
				<td class="txt-c"> <%=edblfibrQyText%></td>
			</tr>
		</tbody>
	</table>
	<table border="1" cellSpacing="0" cellPadding="0">
		<caption>영양성분 상세표</caption>
		<colgroup>
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
			<col style="width:11%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="row">비타민A<br />(ug RE)</th>
				<th scope="row">비타민E<br />(mg)</th>
				<th scope="row">비타민C<br />(mg)</th>
				<th scope="row">티아민<br />(mg)</th>
				<th scope="row">리보플라빈<br />(mg)</th>
				<th scope="row">칼슘<br />(mg)</th>
				<th scope="row">나트륨<br />(mg)</th>
				<th scope="row">칼륨<br />(mg)</th>
				<th scope="row">철<br />(mg)</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="txt-c"> <%=vtmaQyText%></td>
				<td class="txt-c"> <%=vteQyText%></td>
				<td class="txt-c"> <%=vtcQyText%></td>
				<td class="txt-c"> <%=thiaQyText%></td>
				<td class="txt-c"> <%=niboplaQyText%></td>
				<td class="txt-c"> <%=clciQyText%></td>
				<td class="txt-c"> <%=naQyText%></td>
				<td class="txt-c"> <%=ptssQyText%></td>
				<td class="txt-c"> <%=irnQyText%></td>
			</tr>
		</tbody>
	</table>

<%

	If ckngmhrlsUntInfoText = "" Then
	else
		Response.Write("<span>조리기기 및 도구</span><br/><p>")
		Response.Write(ckngmhrlsUntInfoText)
		Response.Write("</p>")
	End If

%>

<%
	End If
End If
%>

<input type="button" onclick="javascript:location.href='monthFd.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>