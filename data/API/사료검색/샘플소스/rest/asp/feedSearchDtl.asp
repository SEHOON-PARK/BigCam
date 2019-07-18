<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>사료 검색</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>사료 검색 상세</strong></h3>
<hr>
<%

'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
apiKey = "발급받은인증키를입력하세요"
'서비스 명
serviceName = "feedSearch"
'오퍼레이션 명
operationName = Array("feedSearchInfoDtl", "feedSearchMineralDtl", "feedSearchNutritiveDtl", "feedSearchDigestDtl", "feedSearchAminoDtl", "feedSearchVitaminDtl", "feedSearchCellDtl", "feedSearchChemDtl")

Set xmlDOMS=Server.CreateObject("Scripting.Dictionary")

For i=0 To UBound(operationName)
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName(i)
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&hsrrlManageNo=" & Request("hsrrlManageNo")

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
	
	xmlDOMS.Add operationName(i), sText
Next


'사료 검색 기본 정보
If true Then
	sText = xmlDOMS.Item("feedSearchInfoDtl")
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	
	Set item = xmlDOM.SelectNodes("//body")
	cnt = item(0).childNodes.length

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
		'사료 관리 번호
		Set hsrrlManageNo = xmlDOM.SelectNodes("//hsrrlManageNo")
		If Not hsrrlManageNo(0) Is Nothing Then hsrrlManageNoText= hsrrlManageNo(0).Text Else hsrrlManageNoText = "" End If
		'년도
		Set year1 = xmlDOM.SelectNodes("//year")
		If Not year1(0) Is Nothing Then yearText= year1(0).Text Else yearText = "" End If
		'한글 명
		Set hsrrlNo = xmlDOM.SelectNodes("//hsrrlNo")
		If Not hsrrlNo(0) Is Nothing Then hsrrlNoText= hsrrlNo(0).Text Else hsrrlNoText = "" End If
		'한글 명
		Set koreanNm = xmlDOM.SelectNodes("//koreanNm")
		If Not koreanNm(0) Is Nothing Then koreanNmText= koreanNm(0).Text Else koreanNmText = "" End If
		'영문 명
		Set engNm = xmlDOM.SelectNodes("//engNm")
		If Not engNm(0) Is Nothing Then engNmText= engNm(0).Text Else engNmText = "" End If
		'사료 품목 코드 명
		Set hsrrlPrdlstCodeNm = xmlDOM.SelectNodes("//hsrrlPrdlstCodeNm")
		If Not hsrrlPrdlstCodeNm(0) Is Nothing Then hsrrlPrdlstCodeNmText= hsrrlPrdlstCodeNm(0).Text Else hsrrlPrdlstCodeNmText = "" End If
		'사료 종류
		Set hsrrlPrdlstCodeLclasNm = xmlDOM.SelectNodes("//hsrrlPrdlstCodeLclasNm")
		If Not hsrrlPrdlstCodeLclasNm(0) Is Nothing Then hsrrlPrdlstCodeLclasNmText= hsrrlPrdlstCodeLclasNm(0).Text Else hsrrlPrdlstCodeLclasNmText = "" End If
%>
	<h4>사료정보</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">한글사료명</th>
				<td><%=koreanNmText%></td>
				<th scope="row">영문사료명</th>
				<td><%=engNmText%></td>
			</tr>
			<tr>
				<th scope="row">사료종류</th>
				<td><%=hsrrlPrdlstCodeNmText%></td>
				<th scope="row">사료구분</th>
				<td><%=hsrrlPrdlstCodeLclasNmText%></td>
			</tr>
			<tr>
				<th scope="row">사료년도</th>
				<td><%=yearText%></td>
				<th scope="row">사료번호</th>
				<td><%=hsrrlNoText%></td>
			</tr>
		</tbody>
	</table>
<%
	End If
End If




'사료 검색 - 일반 조성분
If true Then
	sText = xmlDOMS.Item("feedSearchMineralDtl")
	
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
	<h4>일반조성분 (Chem.corp. %)</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="12%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="9">일반조성분 (Chem.corp. %)</th>
			</tr>
			<tr>
				<th scope="col">구분</th>
				<th scope="col">수분<br />(Moisture)</th>
				<th scope="col">조단백질<br />(CP)</th>
				<th scope="col">조지방<br />(EE)</th>
				<th scope="col">가용무질소물<br />(NFE)</th>
				<th scope="col">조섬유<br />(C.Fib.)</th>
				<th scope="col">조회분<br />(Ash)</th>
				<th scope="col">분석점수</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>

<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'일반 조성분 구분 코드 명
				If NOT itemNode.SelectSingleNode("gnrlmakemntSeNm") is Nothing Then
					gnrlmakemntSeNm = itemNode.SelectSingleNode("gnrlmakemntSeNm").text
				End If
				'수분
				If NOT itemNode.SelectSingleNode("mitrValue") is Nothing Then
					mitrValue = itemNode.SelectSingleNode("mitrValue").text
				End If
				'조단백질
				If NOT itemNode.SelectSingleNode("takprotValue") is Nothing Then
					takprotValue = itemNode.SelectSingleNode("takprotValue").text
				End If
				'조지방
				If NOT itemNode.SelectSingleNode("cuftValue") is Nothing Then
					cuftValue = itemNode.SelectSingleNode("cuftValue").text
				End If
				'가용무기질소물
				If NOT itemNode.SelectSingleNode("usefulRdshNtrgwaterValue") is Nothing Then
					usefulRdshNtrgwaterValue = itemNode.SelectSingleNode("usefulRdshNtrgwaterValue").text
				End If
				'조섬유
				If NOT itemNode.SelectSingleNode("crfbValue") is Nothing Then
					crfbValue = itemNode.SelectSingleNode("crfbValue").text
				End If
				'조회분
				If NOT itemNode.SelectSingleNode("inqiremntValue") is Nothing Then
					inqiremntValue = itemNode.SelectSingleNode("inqiremntValue").text
				End If
				'분석점수
				If NOT itemNode.SelectSingleNode("analsScoreValue") is Nothing Then
					analsScoreValue = itemNode.SelectSingleNode("analsScoreValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
			
%>
			<tr>
				<th scope="row"><%=gnrlmakemntSeNm%></th>
				<td><%=mitrValue%></td>
				<td><%=takprotValue%></td>
				<td><%=cuftValue%></td>
				<td><%=usefulRdshNtrgwaterValue%></td>
				<td><%=crfbValue%></td>
				<td><%=inqiremntValue%></td>
				<% If i = 0 Then %>
				<td rowspan="3"><%=analsScoreValue%></td>
				<td rowspan="3"><%=sRm%></td>
				<% End If %>
			</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If

'사료 검색 - 영양가
If true Then
	sText = xmlDOMS.Item("feedSearchNutritiveDtl")
	
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
	<h4>영양가 (Nutritive value)</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="2">구분</th>
				<th scope="col">TDN<br />(%)</th>
				<th scope="col">DE<br />(Mcal/kg)</th>
				<th scope="col">GE<br />(Mcal/kg)</th>
				<th scope="col">ME<br />(Mcal/kg)</th>
				<th scope="col">NE<br />(Mcal/kg)</th>
				<th scope="col">Nem<br />(Mcal/kg)</th>
				<th scope="col">Neg<br />(Mcal/kg)</th>
				<th scope="col">Neℓ<br />(Mcal/kg)</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'영양가 축종 명
				If NOT itemNode.SelectSingleNode("ntrtmpyKdlsNm") is Nothing Then
					ntrtmpyKdlsNm = itemNode.SelectSingleNode("ntrtmpyKdlsNm").text
				End If
				'영양가 구분 명
				If NOT itemNode.SelectSingleNode("ntrtmpySeNm") is Nothing Then
					ntrtmpySeNm = itemNode.SelectSingleNode("ntrtmpySeNm").text
				End If
				'TDN
				If NOT itemNode.SelectSingleNode("tdngValue") is Nothing Then
					tdngValue = itemNode.SelectSingleNode("tdngValue").text
				End If
				'DE
				If NOT itemNode.SelectSingleNode("deValue") is Nothing Then
					deValue = itemNode.SelectSingleNode("deValue").text
				End If
				'ME
				If NOT itemNode.SelectSingleNode("methylValue") is Nothing Then
					methylValue = itemNode.SelectSingleNode("methylValue").text
				End If
				'TME
				If NOT itemNode.SelectSingleNode("trmreValue") is Nothing Then
					trmreValue = itemNode.SelectSingleNode("trmreValue").text
				End If
				'NEM
				If NOT itemNode.SelectSingleNode("nemValue") is Nothing Then
					nemValue = itemNode.SelectSingleNode("nemValue").text
				End If
				'NEG
				If NOT itemNode.SelectSingleNode("negValue") is Nothing Then
					negValue = itemNode.SelectSingleNode("negValue").text
				End If
				'NEL
				If NOT itemNode.SelectSingleNode("nelValue") is Nothing Then
					nelValue = itemNode.SelectSingleNode("nelValue").text
				End If
				'GE
				If NOT itemNode.SelectSingleNode("geValue") is Nothing Then
					geValue = itemNode.SelectSingleNode("geValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
			
%>
		<tr>
			<% If (i+1) mod 2 > 0 Then %>
			<th scope="row" rowspan="2"><%=ntrtmpySeNm%></th>
			<% End If %>
			<th scope="row"><%=ntrtmpyKdlsNm%></th>
			<td><%=tdngValue%></td>
			<td><%=deValue%></td>
			<td><%=geValue%></td>
			<td><%=methylValue%></td>
			<td><%=trmreValue%></td>
			<td><%=nemValue%></td>
			<td><%=negValue%></td>
			<td><%=nelValue%></td>
			<% If (i+1) mod 2 > 0 Then %>
			<th scope="row" rowspan="2"><%=sRm%></th>
			<% End If %>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If

'사료 검색 - 소화율
If true Then
	sText = xmlDOMS.Item("feedSearchDigestDtl")
	
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
	<h4>소화율 (Dig.coef.)</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<thead>
			<tr>
			<th colspan="2">구분</th>
			<th width="12%">건물<br>(DM)</th>
			<th width="12%">조단백질<br>(CP)</th>
			<th width="12%">조지방<br>(EE)</th>
			<th width="13%">가용무질소물<br>(NFE)</th>
			<th width="12%">조섬유<br>(C.Fib.)</th>
			<th width="12%">분석점수</th>
			<th width="12%">비고</th></tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'소화율 축종 명
				If NOT itemNode.SelectSingleNode("frexrtKdlsNm") is Nothing Then
					frexrtKdlsNm = itemNode.SelectSingleNode("frexrtKdlsNm").text
				End If
				'소화율 구분 명
				If NOT itemNode.SelectSingleNode("frexrtSeNm") is Nothing Then
					frexrtSeNm = itemNode.SelectSingleNode("frexrtSeNm").text
				End If
				'건조 물질
				If NOT itemNode.SelectSingleNode("dryMttrValue") is Nothing Then
					dryMttrValue = itemNode.SelectSingleNode("dryMttrValue").text
				End If
				'단백질
				If NOT itemNode.SelectSingleNode("protValue") is Nothing Then
					protValue = itemNode.SelectSingleNode("protValue").text
				End If
				'지방
				If NOT itemNode.SelectSingleNode("lcltyValue") is Nothing Then
					lcltyValue = itemNode.SelectSingleNode("lcltyValue").text
				End If
				'가용무질소물
				If NOT itemNode.SelectSingleNode("usefulRdshNtrgwaterValue") is Nothing Then
					usefulRdshNtrgwaterValue = itemNode.SelectSingleNode("usefulRdshNtrgwaterValue").text
				End If
				'섬유
				If NOT itemNode.SelectSingleNode("fberValue") is Nothing Then
					fberValue = itemNode.SelectSingleNode("fberValue").text
				End If
				'분석 점수
				If NOT itemNode.SelectSingleNode("analsScoreValue") is Nothing Then
					analsScoreValue = itemNode.SelectSingleNode("analsScoreValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
			
%>
		<tr>
			<% If (i+1) mod 2 > 0 Then %>
			<th scope="row" rowspan="2"><%=frexrtSeNm%></th>
			<% End If %>
			<th scope="row"><%=frexrtKdlsNm%></th>
			<td><%=dryMttrValue%></td>
			<td><%=protValue%></td>
			<td><%=lcltyValue%></td>
			<td><%=usefulRdshNtrgwaterValue%></td>
			<td><%=fberValue%></td>
			<% If (i+1) mod 2 > 0 Then %>
			<th scope="row" rowspan="2"><%=analsScoreValue%></th>
			<th scope="row" rowspan="2"><%=sRm%></th>
			<% End If %>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If

'사료 검색 - 무기질
If true Then
	sText = xmlDOMS.Item("feedSearchChemDtl")
	
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
	<h4>무기질</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">건물<br>DM(%)</th>
			<th width="11%">칼슘<br>Ca(%)</th>
			<th width="11%">인<br>P(%)</th>
			<th width="11%">칼륨<br>K(%)</th>
			<th width="11%">나트륨<br>Na(%)</th>
			<th width="11%">마그네슘<br>Mg(%)</th>
			<th width="11%">염소<br>Cl(%)</th	>
			<th width="11%">요황<br>S(%)</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'무기물 구분 명
				If NOT itemNode.SelectSingleNode("inorganicMatterSeNm") is Nothing Then
					inorganicMatterSeNm = itemNode.SelectSingleNode("inorganicMatterSeNm").text
				End If
				'건조물질
				If NOT itemNode.SelectSingleNode("dryMttrValue") is Nothing Then
					dryMttrValue = itemNode.SelectSingleNode("dryMttrValue").text
				End If
				'칼슘
				If NOT itemNode.SelectSingleNode("clciValue") is Nothing Then
					clciValue = itemNode.SelectSingleNode("clciValue").text
				End If
				'인
				If NOT itemNode.SelectSingleNode("phphValue") is Nothing Then
					phphValue = itemNode.SelectSingleNode("phphValue").text
				End If
				'칼륨
				If NOT itemNode.SelectSingleNode("ptssValue") is Nothing Then
					ptssValue = itemNode.SelectSingleNode("ptssValue").text
				End If
				'나트륨
				If NOT itemNode.SelectSingleNode("naValue") is Nothing Then
					naValue = itemNode.SelectSingleNode("naValue").text
				End If
				'마그네슘
				If NOT itemNode.SelectSingleNode("mgnValue") is Nothing Then
					mgnValue = itemNode.SelectSingleNode("mgnValue").text
				End If
				'염소
				If NOT itemNode.SelectSingleNode("gtValue") is Nothing Then
					gtValue = itemNode.SelectSingleNode("gtValue").text
				End If
				'황
				If NOT itemNode.SelectSingleNode("sulfurValue") is Nothing Then
					sulfurValue = itemNode.SelectSingleNode("sulfurValue").text
				End If
			End If
			
%>
		<tr>
			<th scope="row"><%=inorganicMatterSeNm%></th>
			<td><%=dryMttrValue%></td>
			<td><%=clciValue%></td>
			<td><%=phphValue%></td>
			<td><%=ptssValue%></td>
			<td><%=naValue%></td>
			<td><%=mgnValue%></td>
			<td><%=gtValue%></td>
			<td><%=sulfurValue%></td>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">철<br>Fe(Mg/Kg)</th>
			<th width="11%">망간<br>Mn(Mg/Kg)</th>
			<th width="11%">코발트<br>Co(Mg/Kg)</th>
			<th width="11%">아연<br>Zn(Mg/Kg)</th>
			<th width="11%">구리<br>Cu(Mg/Kg)</th>
			<th width="11%">불소<br>F(%)</th>
			<th width="11%">분석점수</th>
			<th width="11%">비고</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'무기물 구분 명
				If NOT itemNode.SelectSingleNode("inorganicMatterSeNm") is Nothing Then
					inorganicMatterSeNm = itemNode.SelectSingleNode("inorganicMatterSeNm").text
				End If
				'철
				If NOT itemNode.SelectSingleNode("seasnValue") is Nothing Then
					seasnValue = itemNode.SelectSingleNode("seasnValue").text
				End If
				'망간
				If NOT itemNode.SelectSingleNode("mangValue") is Nothing Then
					mangValue = itemNode.SelectSingleNode("mangValue").text
				End If
				'코발트
				If NOT itemNode.SelectSingleNode("cbltValue") is Nothing Then
					cbltValue = itemNode.SelectSingleNode("cbltValue").text
				End If
				'아연
				If NOT itemNode.SelectSingleNode("zincValue") is Nothing Then
					zincValue = itemNode.SelectSingleNode("zincValue").text
				End If
				'구리
				If NOT itemNode.SelectSingleNode("copprValue") is Nothing Then
					copprValue = itemNode.SelectSingleNode("copprValue").text
				End If
				'불소
				If NOT itemNode.SelectSingleNode("flrnValue") is Nothing Then
					flrnValue = itemNode.SelectSingleNode("flrnValue").text
				End If
				'분석점수
				If NOT itemNode.SelectSingleNode("analsScoreValue") is Nothing Then
					analsScoreValue = itemNode.SelectSingleNode("analsScoreValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
%>
		<tr>
			<th scope="row"><%=inorganicMatterSeNm%></th>
			<td><%=seasnValue%></td>
			<td><%=mangValue%></td>
			<td><%=cbltValue%></td>
			<td><%=zincValue%></td>
			<td><%=copprValue%></td>
			<td><%=flrnValue%></td>
			<% If i < 1 Then %>
			<th scope="row" rowspan="3"><%=analsScoreValue%></th>
			<th scope="row" rowspan="3"><%=sRm%></th>
			<% End if %>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If


'사료 검색 - 아미노산
If true Then
	sText = xmlDOMS.Item("feedSearchAminoDtl")
	
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
	<h4>아미노산</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">조단백질<br>CP(%)</th>
			<th width="11%">시스틴<br>Cystine</th>
			<th width="11%">메치오닌</th>
			<th width="12%">아스파라틱산<br>Aspartic acid</th>
			<th width="11%">트레오닌<br>Threonine</th>
			<th width="11%">써린<br>Serine</th>
			<th width="11%">글루타믹산<br>Glutamic acid</th>
			<th width="11%">프롤린<br>Proline</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'아미노산 구분 코드
				If NOT itemNode.SelectSingleNode("aminoAcdSeCodeNm") is Nothing Then
					aminoAcdSeCodeNm = itemNode.SelectSingleNode("aminoAcdSeCodeNm").text
				End If
				'조단백질
				If NOT itemNode.SelectSingleNode("takprotValue") is Nothing Then
					takprotValue = itemNode.SelectSingleNode("takprotValue").text
				End If
				'시스틴
				If NOT itemNode.SelectSingleNode("cystineValue") is Nothing Then
					cystineValue = itemNode.SelectSingleNode("cystineValue").text
				End If
				'메치오닌
				If NOT itemNode.SelectSingleNode("mthnValue") is Nothing Then
					mthnValue = itemNode.SelectSingleNode("mthnValue").text
				End If
				'아스파라틱산
				If NOT itemNode.SelectSingleNode("asparticAcdValue") is Nothing Then
					asparticAcdValue = itemNode.SelectSingleNode("asparticAcdValue").text
				End If
				'트레오닌
				If NOT itemNode.SelectSingleNode("thrnValue") is Nothing Then
					thrnValue = itemNode.SelectSingleNode("thrnValue").text
				End If
				'써린
				If NOT itemNode.SelectSingleNode("serineValue") is Nothing Then
					serineValue = itemNode.SelectSingleNode("serineValue").text
				End If
				'글루타믹산
				If NOT itemNode.SelectSingleNode("glutamicAcdValue") is Nothing Then
					glutamicAcdValue = itemNode.SelectSingleNode("glutamicAcdValue").text
				End If
				'프롤린
				If NOT itemNode.SelectSingleNode("prliValue") is Nothing Then
					prliValue = itemNode.SelectSingleNode("prliValue").text
				End If
			End If
			
%>
			<tr>
				<th scope="row"><%=aminoAcdSeCodeNm%></th>
				<td><%=takprotValue%></td>
				<td><%=cystineValue%></td>
				<td><%=mthnValue%></td>
				<td><%=asparticAcdValue%></td>
				<td><%=thrnValue%></td>
				<td><%=serineValue%></td>
				<td><%=glutamicAcdValue%></td>
				<td><%=prliValue%></td>
			</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">글라이신<br>Glycine</th>
			<th width="11%">알라닌<br>Alanine</th>
			<th width="11%">바린<br>Valine</th>
			<th width="12%">이소-리우신<br>Iso-leucine</th>
			<th width="11%">리우신<br>Leucine</th>
			<th width="11%">티로신<br>Tyrosine</th>
			<th width="11%">페닐알라닌<br>Phenylalanine</th>
			<th width="11%">라이신<br>Lysine</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'아미노산 구분 코드
				If NOT itemNode.SelectSingleNode("aminoAcdSeCodeNm") is Nothing Then
					aminoAcdSeCodeNm = itemNode.SelectSingleNode("aminoAcdSeCodeNm").text
				End If
				'글라이신
				If NOT itemNode.SelectSingleNode("artclysnValue") is Nothing Then
					artclysnValue = itemNode.SelectSingleNode("artclysnValue").text
				End If
				'알리닌
				If NOT itemNode.SelectSingleNode("alnnValue") is Nothing Then
					alnnValue = itemNode.SelectSingleNode("alnnValue").text
				End If
				'바린
				If NOT itemNode.SelectSingleNode("valineValue") is Nothing Then
					valineValue = itemNode.SelectSingleNode("valineValue").text
				End If
				'이소-리우신
				If NOT itemNode.SelectSingleNode("isoliritnwValue") is Nothing Then
					isoliritnwValue = itemNode.SelectSingleNode("isoliritnwValue").text
				End If
				'리우신
				If NOT itemNode.SelectSingleNode("liritnwValue") is Nothing Then
					liritnwValue = itemNode.SelectSingleNode("liritnwValue").text
				End If
				'티로신
				If NOT itemNode.SelectSingleNode("tyrsValue") is Nothing Then
					tyrsValue = itemNode.SelectSingleNode("tyrsValue").text
				End If
				'페닐알라닌
				If NOT itemNode.SelectSingleNode("phnyValue") is Nothing Then
					phnyValue = itemNode.SelectSingleNode("phnyValue").text
				End If
				'라이신
				If NOT itemNode.SelectSingleNode("lysnValue") is Nothing Then
					lysnValue = itemNode.SelectSingleNode("lysnValue").text
				End If
			End If
%>
		<tr>
			<th scope="row"><%=aminoAcdSeCodeNm%></th>
			<td><%=artclysnValue%></td>
			<td><%=alnnValue%></td>
			<td><%=valineValue%></td>
			<td><%=isoliritnwValue%></td>
			<td><%=liritnwValue%></td>
			<td><%=tyrsValue%></td>
			<td><%=phnyValue%></td>
			<td><%=lysnValue%></td>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">히스티딘<br>Fe(Mg/Kg)</th>
			<th width="11%">암모니아<br>Mn(Mg/Kg)</th>
			<th width="11%">아르기닌<br>Co(Mg/Kg)</th>
			<th width="12%">트립토판<br>Zn(Mg/Kg)</th>
			<th width="11%"></th>
			<th width="11%"></th>
			<th width="11%">분석점수</th>
			<th width="11%">비고</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'아미노산 구분 명
				If NOT itemNode.SelectSingleNode("aminoAcdSeCodeNm") is Nothing Then
					aminoAcdSeCodeNm = itemNode.SelectSingleNode("aminoAcdSeCodeNm").text
				End If
				'히스타딘
				If NOT itemNode.SelectSingleNode("hstdValue") is Nothing Then
					hstdValue = itemNode.SelectSingleNode("hstdValue").text
				End If
				'암모니아
				If NOT itemNode.SelectSingleNode("nh3Value") is Nothing Then
					nh3Value = itemNode.SelectSingleNode("nh3Value").text
				End If
				'아르기닌
				If NOT itemNode.SelectSingleNode("argnValue") is Nothing Then
					argnValue = itemNode.SelectSingleNode("argnValue").text
				End If
				'트립토판
				If NOT itemNode.SelectSingleNode("trypValue") is Nothing Then
					trypValue = itemNode.SelectSingleNode("trypValue").text
				End If
				'분석점수
				If NOT itemNode.SelectSingleNode("analsScoreValue") is Nothing Then
					analsScoreValue = itemNode.SelectSingleNode("analsScoreValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
%>
		<tr>
			<th scope="row"><%=aminoAcdSeCodeNm%></th>
			<td><%=hstdValue%></td>
			<td><%=nh3Value%></td>
			<td><%=argnValue%></td>
			<td><%=trypValue%></td>
			<td></td>
			<td></td>
			<% If i < 1 Then %>
			<th scope="row" rowspan="2"><%=analsScoreValue%></th>
			<th scope="row" rowspan="2"><%=sRm%></th>
			<% End if %>
		</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If


'사료 검색 - 비타민
If true Then
	sText = xmlDOMS.Item("feedSearchVitaminDtl")
	
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
	<h4>비타민</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">건물<br>DM(%)</th>
			<th width="11%">캐로틴<br>Carotin<br>(mg/kg)</th>
			<th width="11%">비타민A<br>VitaminA<br>(mg/kg)</th>
			<th width="11%">비타민E<br>ETocopherol<br>(mg/kg)</th>
			<th width="11%">비타민B1<br>Thiamine<br>(mg/kg)</th>
			<th width="11%">비타민B2<br>Riboflavin<br>(mg/kg)</th>
			<th width="11%">판토텐산<br>Pantothenic<br>acid (mg/kg)</th>
			<th width="11%">나이아신<br>Niacin<br>(mg/kg)</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'비타민 구분 명
				If NOT itemNode.SelectSingleNode("vtmnSeCodeNm") is Nothing Then
					vtmnSeCodeNm = itemNode.SelectSingleNode("vtmnSeCodeNm").text
				End If
				'건조물질
				If NOT itemNode.SelectSingleNode("dryMttrValue") is Nothing Then
					dryMttrValue = itemNode.SelectSingleNode("dryMttrValue").text
				End If
				'카로틴
				If NOT itemNode.SelectSingleNode("catnValue") is Nothing Then
					catnValue = itemNode.SelectSingleNode("catnValue").text
				End If
				'비타민A
				If NOT itemNode.SelectSingleNode("vtmaValue") is Nothing Then
					vtmaValue = itemNode.SelectSingleNode("vtmaValue").text
				End If
				'비타민E
				If NOT itemNode.SelectSingleNode("vteValue") is Nothing Then
					vteValue = itemNode.SelectSingleNode("vteValue").text
				End If
				'비타민B1
				If NOT itemNode.SelectSingleNode("vtb1Value") is Nothing Then
					vtb1Value = itemNode.SelectSingleNode("vtb1Value").text
				End If
				'비타민B2
				If NOT itemNode.SelectSingleNode("vtb2Value") is Nothing Then
					vtb2Value = itemNode.SelectSingleNode("vtb2Value").text
				End If
				'판토텐산
				If NOT itemNode.SelectSingleNode("pnacValue") is Nothing Then
					pnacValue = itemNode.SelectSingleNode("pnacValue").text
				End If
				'나이아신
				If NOT itemNode.SelectSingleNode("nacnValue") is Nothing Then
					nacnValue = itemNode.SelectSingleNode("nacnValue").text
				End If
			End If
%>
			<tr>
				<th scope="row"><%=vtmnSeCodeNm%></th>
				<td><%=dryMttrValue%></td>
				<td><%=catnValue%></td>
				<td><%=vtmaValue%></td>
				<td><%=vteValue%></td>
				<td><%=vtb1Value%></td>
				<td><%=vtb2Value%></td>
				<td><%=pnacValue%></td>
				<td><%=nacnValue%></td>
			</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">비타민B6<br>Pyridoxine<br>(mg/kg)</th>
			<th width="11%">바이오틴<br>Biotin<br>(mg/kg)</th>
			<th width="11%">엽산<br>Folic<br>(mg/kg)</th>
			<th width="11%">콜린<br>Choline<br>(mg/kg)</th>
			<th width="11%">비타민B12<br>VitaminB12<br>(mg/kg)</th>
			<th width="11%"></th>
			<th width="11%">분석점수</th><th width="11%">비고</th>
		</tr>
		</thead>
		<tbody>	
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'비타민 구분 명
				If NOT itemNode.SelectSingleNode("vtmnSeCodeNm") is Nothing Then
					vtmnSeCodeNm = itemNode.SelectSingleNode("vtmnSeCodeNm").text
				End If
				'비타민B6
				If NOT itemNode.SelectSingleNode("vtb6Value") is Nothing Then
					vtb6Value = itemNode.SelectSingleNode("vtb6Value").text
				End If
				'바이오틴
				If NOT itemNode.SelectSingleNode("biotinValue") is Nothing Then
					biotinValue = itemNode.SelectSingleNode("biotinValue").text
				End If
				'엽산
				If NOT itemNode.SelectSingleNode("flacValue") is Nothing Then
					flacValue = itemNode.SelectSingleNode("flacValue").text
				End If
				'콜린
				If NOT itemNode.SelectSingleNode("cholineValue") is Nothing Then
					cholineValue = itemNode.SelectSingleNode("cholineValue").text
				End If
				'비타민B12
				If NOT itemNode.SelectSingleNode("vtb12Value") is Nothing Then
					vtb12Value = itemNode.SelectSingleNode("vtb12Value").text
				End If
				'분석 점수
				If NOT itemNode.SelectSingleNode("analsScoreValue") is Nothing Then
					analsScoreValue = itemNode.SelectSingleNode("analsScoreValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
%>
			<tr>
				<th scope="row"><%=vtmnSeCodeNm%></th>
				<td><%=vtb6Value%></td>
				<td><%=biotinValue%></td>
				<td><%=flacValue%></td>
				<td><%=cholineValue%></td>
				<td><%=vtb12Value%></td>
				<td></td>
				<% If i < 1 Then %>
				<th scope="row" rowspan="3"><%=analsScoreValue%></th>
				<th scope="row" rowspan="3"><%=sRm%></th>
				<% End if %>
			</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If

'사료 검색 - 세포막
If true Then
	sText = xmlDOMS.Item("feedSearchCellDtl")
	
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
	<h4>세포막</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<thead>
		<tr>
			<th>구분</th>
			<th width="17%">건물<br>DM(%)</th>
			<th width="17%">NDF</th>
			<th width="17%">ADF</th>
			<th width="17%">헤미셀룰로오스<br>Hemicellulose</th>
			<th width="17%">리기닌<br>Lignin</th>
		</tr>
		</thead>
		<tbody>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'세포 박막 구분 코드 명
				If NOT itemNode.SelectSingleNode("cellThnflmSeCodeNm") is Nothing Then
					cellThnflmSeCodeNm = itemNode.SelectSingleNode("cellThnflmSeCodeNm").text
				End If
				'건조 물질
				If NOT itemNode.SelectSingleNode("dryMttrValue") is Nothing Then
					dryMttrValue = itemNode.SelectSingleNode("dryMttrValue").text
				End If
				'NDF
				If NOT itemNode.SelectSingleNode("ndfValue") is Nothing Then
					ndfValue = itemNode.SelectSingleNode("ndfValue").text
				End If
				'ADF
				If NOT itemNode.SelectSingleNode("adfValue") is Nothing Then
					adfValue = itemNode.SelectSingleNode("adfValue").text
				End If
				'헤미셀룰로오스
				If NOT itemNode.SelectSingleNode("hemicelluloseValue") is Nothing Then
					hemicelluloseValue = itemNode.SelectSingleNode("hemicelluloseValue").text
				End If
				'리기닌
				If NOT itemNode.SelectSingleNode("ligninValue") is Nothing Then
					ligninValue = itemNode.SelectSingleNode("ligninValue").text
				End If
			End If
%>
			<tr>
				<th scope="row"><%=cellThnflmSeCodeNm%></th>
				<td><%=dryMttrValue%></td>
				<td><%=ndfValue%></td>
				<td><%=adfValue%></td>
				<td><%=hemicelluloseValue%></td>
				<td><%=ligninValue%></td>
			</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="17%">셀룰로오스<br>Cellulose</th>
			<th width="17%">실리카<br>Silica</th>
			<th width="17%">NFC</th>
			<th width="17%">분석점수</th>
			<th width="17%">비고</th>
		</tr>
		</thead>
<%
		For i=0 To cnt-1
			Set itemNode = items.item(i)
			If NOT itemNode Is Nothing Then
				'세포 박막 구분 코드 명
				If NOT itemNode.SelectSingleNode("cellThnflmSeCodeNm") is Nothing Then
					cellThnflmSeCodeNm = itemNode.SelectSingleNode("cellThnflmSeCodeNm").text
				End If
				'셀룰로오스
				If NOT itemNode.SelectSingleNode("celluloseValue") is Nothing Then
					celluloseValue = itemNode.SelectSingleNode("celluloseValue").text
				End If
				'실리카
				If NOT itemNode.SelectSingleNode("silictarValue") is Nothing Then
					silictarValue = itemNode.SelectSingleNode("silictarValue").text
				End If
				'NFC
				If NOT itemNode.SelectSingleNode("nfcValue") is Nothing Then
					nfcValue = itemNode.SelectSingleNode("nfcValue").text
				End If
				'분석 점수
				If NOT itemNode.SelectSingleNode("analsScoreValue") is Nothing Then
					analsScoreValue = itemNode.SelectSingleNode("analsScoreValue").text
				End If
				'비고
				If NOT itemNode.SelectSingleNode("sRm") is Nothing Then
					sRm = itemNode.SelectSingleNode("sRm").text
				End If
			End If
%>
			<tr>
				<th scope="row"><%=cellThnflmSeCodeNm%></th>
				<td><%=celluloseValue%></td>
				<td><%=silictarValue%></td>
				<td><%=nfcValue%></td>
				<% If i < 1 Then %>
				<th scope="row" rowspan="3"><%=analsScoreValue%></th>
				<th scope="row" rowspan="3"><%=sRm%></th>
				<% End If %>
			</tr>
<%
		   Set itemNode = Nothing
		Next
		Response.Write("</tbody></table>")
	End If
End If
%>
<br>
<input type="button" onclick="javascript:location.href='feedSearchList.asp'" value="목록"/>
</body>
</html>