<% @CODEPAGE="65001" language="VBScript" %>
<%
Response.Expires = 0
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma", "no-cache" 
Response.AddHeader "cache-control", "private" 
Response.CacheControl = "no-cache" 
%>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농산물 소득정보</title>
<script type='text/javascript'>
	//메인 테크 항목
	function fncMove(sCode){
		with(document.mainApiForm){
			svcCode.value = sCode;
			method="get";
			action = "farmPrdtIncome.asp";
			target = "_self";
			submit();
		}
	}
	//연도 선택
	function yearMove(cYear){
		if("<%=request("svcCode")%>" == "") {
			yearApiForm.svcCode.value ='0';
		}
		
		with(document.yearApiForm){
			year.value = cYear;
			method="get";
			action = "farmPrdtIncome.asp";
			target = "_self";
			submit();
		}
	}
	//지역 선택
	function localMove(cLocal){
		if("<%=request("svcCode")%>" == "") {
			localApiForm.svcCode.value ='0';
		}
		if("<%=request("year")%>" == "") {
			localApiForm.year.value = viewForm.yearCombo.value; 
		}
		
		with(document.localApiForm){
			atptCode.value = cLocal;
			method="get";
			action = "farmPrdtIncome.asp";
			target = "_self";
			submit();
		}
	}
	//상세 보기
	function detailMove(eCode){
		
		if("<%=request("svcCode")%>" == "") {
			detailApiForm.svcCode.value ='0';
		}
		
		if("<%=request("year")%>" == "") {
			detailApiForm.year.value = viewForm.yearCombo.value; 
		}
		
		if("<%=request("atptCode")%>" == "") {
			detailApiForm.atptCode.value = viewForm.atptCode0.value; 
		}
		
		with(document.detailApiForm){
			eqpCode.value = eCode;
			method="get";
			action = "farmPrdtIncome.asp";
			target = "_self";
			submit();
		}
	}
</script>

</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농산물 소득 정보</strong></h3>

<form name="mainApiForm">
<input type="hidden" name="svcCode" value="<%=request("svcCode")%>">
</form>

<form name="yearApiForm">
<input type="hidden" name="svcCode" value="<%=request("svcCode")%>">
<input type="hidden" name="year" value="<%=request("year")%>">
</form>

<form name="localApiForm">
<input type="hidden" name="svcCode" value="<%=request("svcCode")%>">
<input type="hidden" name="year" value="<%=request("year")%>">
<input type="hidden" name="atptCode" value="<%=request("atptCode")%>">
</form>

<form name="detailApiForm">
<input type="hidden" name="svcCode" value="<%=request("svcCode")%>">
<input type="hidden" name="year" value="<%=request("year")%>">
<input type="hidden" name="atptCode" value="<%=request("atptCode")%>">
<input type="hidden" name="eqpCode" value="<%=request("eqpCode")%>">
</form>

<hr>
<form name="viewForm">
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<tr>				
		<td align="center"><a href="javascript:fncMove('0');"><% If request("svcCode")="0" OR request("svcCode") = "" Then %> <strong>전체</strong>  <% Else %>전체 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('FC');"><% if request("svcCode")="FC" Then %> <strong>식량작물</strong>  <% Else %> 식량작물 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('FG');"><% if request("svcCode")="FG" Then %> <strong>사료녹비작물</strong>  <% Else %> 사료녹비작물 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('FL');"><% if request("svcCode")="FL" Then %> <strong>화훼</strong>  <% Else %> 화훼 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('FT');"><% if request("svcCode")="FT" Then %> <strong>과수</strong>  <% Else %> 과수 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('IC');"><% if request("svcCode")="IC" Then %> <strong>특용작물</strong>  <% Else %> 특용작물 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('LP');"><% if request("svcCode")="LP" Then %> <strong>축산</strong>  <% Else %> 축산 <% End If %></a></td>
		<td align="center"><a href="javascript:fncMove('VC');"><% if request("svcCode")="VC" Then %> <strong>채소</strong>  <% Else %> 채소 <% End If %></a></td>
	</tr>
</table>

<!-- ============================================== 연도 목록 시작 =========================================================== -->

<%
	'검색조건 - 서비스 코드
	sSvcCode = Request("svcCode")
	sYear = Request("year")
	sAtptCode = Request("atptCode")
	sEqpCode = Request("eqpCode")

	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	apiKey = "발급받은인증키를입력해주세요"
	'서비스 명 
	serviceName = "farmPrdtIncome"
	'오퍼레이션 명
	operationName = "farmPrdtIncomeYearList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	
	If Request("svcCode") Is Nothing OR Request("svcCode")="" Then
		sSvcCode = "0"
	End If

	parameter = parameter & "&svcCode=" & sSvcCode
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp1 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp1.Open "GET", targetURL, False   
	xmlHttp1.Send    
	
	Set oStream1 = CreateObject("ADODB.Stream")   
	oStream1.Open   
	oStream1.Position = 0   
	oStream1.Type = 1   
	oStream1.Write xmlHttp1.ResponseBody   
	oStream1.Position = 0   
	oStream1.Type = 2   
	oStream1.Charset = "utf-8"   
	sText = oStream1.ReadText   
	oStream1.Close   
	
	
	Set xmlDOM1 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM1.async = False    
	xmlDOM1.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem1 = xmlDOM1.SelectNodes("//items")
	cnt = listItem1(0).childNodes.length
	Set items1 = listItem1(0).childNodes
	
	If sYear = "" OR sYear = null Then
		Set itemNode = items1.item(0)
		sYear= itemNode.SelectSingleNode("year").text
	End If
	
	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
		 년도 선택 : <select  id="yearCombo" onchange="yearMove( this.value);" > 
<%
		For i=0 To cnt-1
			Set itemNode = items1.item(i)
			If NOT itemNode Is Nothing Then
				'년도
				If NOT itemNode.SelectSingleNode("year") is Nothing Then
					years = itemNode.SelectSingleNode("year").text
				End If
			End If

			If sYear=years Then
%>
					<option value="<%=years%>" selected> <%=years%> </option>
<%
			Else
%>
				<option value="<%=years%>" > <%=years%> </option>
<%
			End If
			Set itemNode = Nothing
		Next
		Response.Write("</select></tr></table>")
	End If
%>

<!-- ============================================== 연도 목록 끝 =========================================================== -->


<!-- ============================================== 지역 목록 시작 =========================================================== -->

<%
	'서비스 명 
	serviceName = "farmPrdtIncome"
	'오퍼레이션 명
	operationName = "farmPrdtIncomeSidoList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&svcCode=" & sSvcCode
	
	If Request("year") Is Nothing OR Request("year")="" Then
		Set itemNode = items1.item(0)
		sYear = itemNode.SelectSingleNode("year").text
		Set itemNode = Nothing
	End If	

	parameter = parameter & "&year=" & sYear

	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp2 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp2.Open "GET", targetURL, False   
	xmlHttp2.Send    
	
	Set oStream2 = CreateObject("ADODB.Stream")   
	oStream2.Open   
	oStream2.Position = 0   
	oStream2.Type = 1   
	oStream2.Write xmlHttp2.ResponseBody   
	oStream2.Position = 0   
	oStream2.Type = 2   
	oStream2.Charset = "utf-8"   
	sText = oStream2.ReadText   
	oStream2.Close   
	
	Set xmlDOM2 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM2.async = False    
	xmlDOM2.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem2 = xmlDOM2.SelectNodes("//items")
	cnt = listItem2(0).childNodes.length
	Set items2 = listItem2(0).childNodes
	
	If sAtptCode = "" OR sAtptCode = null Then
		Set itemNode = items2.item(0)
		sAtptCode= itemNode.SelectSingleNode("atptCode").text
	End If
	
	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
<%	
	
		For i=0 To cnt-1
		   Set itemNode = items2.item(i)
			If NOT itemNode Is Nothing Then
				'지역 코드				
				If NOT itemNode.SelectSingleNode("atptCode") is Nothing Then
					atptCode = itemNode.SelectSingleNode("atptCode").text
				End If
				'지역 코드 명
				If NOT itemNode.SelectSingleNode("atptNm") is Nothing Then
					atptNm = itemNode.SelectSingleNode("atptNm").text
				End If				
			End If
			
			If i mod 4=0 Then
				Response.Write("</tr><tr>")
			End if

			If sAtptCode = atptCode  Then
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<strong><a href="javascript:localMove('<%=atptCode%>');"><%=atptNm%></a></strong></td>
				<input type="hidden" name="atptCode<%=i%>" value="<%=atptCode%>"  />
<%
			Else
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:localMove('<%=atptCode%>');"><%=atptNm%></a></td>
				<input type="hidden" name="atptCode<%=i%>" value="<%=atptCode%>"  />
<%
			End If
		   Set itemNode = Nothing
		Next
	Response.Write("</tr></table>")
	End If
%>

<!-- ============================================== 지역 목록 끝 =========================================================== -->

<!-- ============================================== 메인카테고리 조회 시작 =========================================================== -->

<%
	'서비스 명 
	serviceName = "farmPrdtIncome"
	'오퍼레이션 명
	operationName = "farmPrdtIncomeList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&svcCode=" & sSvcCode
	parameter = parameter & "&year=" & sYear
	
	If Request("atptCode") Is Nothing OR Request("atptCode")="" Then
		Set itemNode = items2.item(0)
		sAtptCode = itemNode.SelectSingleNode("atptCode").text
		Set itemNode = Nothing
	End If	
	
	parameter = parameter & "&atptCode=" & sAtptCode
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp3 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp3.Open "GET", targetURL, False   
	xmlHttp3.Send    
	
	Set oStream3 = CreateObject("ADODB.Stream")   
	oStream3.Open   
	oStream3.Position = 0   
	oStream3.Type = 1   
	oStream3.Write xmlHttp3.ResponseBody   
	oStream3.Position = 0   
	oStream3.Type = 2   
	oStream3.Charset = "utf-8"   
	sText = oStream3.ReadText   
	oStream3.Close   
	
	Set xmlDOM3 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM3.async = False    
	xmlDOM3.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem3 = xmlDOM3.SelectNodes("//items")
	cnt = listItem3(0).childNodes.length
	Set items3 = listItem3(0).childNodes
	
	If sEqpCode = "" OR sEqpCode = null Then
		Set itemNode = items3.item(0)
		sEqpCode= itemNode.SelectSingleNode("eqpCode").text
	End If	
	
	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
<%	
		For i=0 To cnt-1
		   Set itemNode = items3.item(i)
			If NOT itemNode Is Nothing Then
				'설비 코드 명
				If NOT itemNode.SelectSingleNode("eqpCode") is Nothing Then
					eqpCode = itemNode.SelectSingleNode("eqpCode").text
				End If
				'설비 명
				If NOT itemNode.SelectSingleNode("eqpNm") is Nothing Then
					eqpNm = itemNode.SelectSingleNode("eqpNm").text
				End If				
			End If
			
			If i mod 4=0 Then
				Response.Write("</tr><tr>")
			End if

			If sEqpCode = eqpCode Then
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<strong><a href="javascript:detailMove('<%=eqpCode%>');"><%=eqpNm%></a></strong></td>
<%
			Else
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:detailMove('<%=eqpCode%>');"><%=eqpNm%></a></td>
<%
			End If
		   Set itemNode = Nothing
		Next
	Response.Write("</tr></table>")
	End If
%>

<!-- ============================================== 메인카테고리 조회 끝 =========================================================== -->

<%
	'서비스 명 
	serviceName = "farmPrdtIncome"
	'오퍼레이션 명
	operationName = "farmPrdtIncomeDetailList"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey=" & apiKey
	parameter = parameter & "&svcCode=" & sSvcCode
	parameter = parameter & "&year=" & sYear
	parameter = parameter & "&atptCode=" & sAtptCode
	
	If Request("eqpCode") Is Nothing OR Request("eqpCode")="" Then
		Set itemNode = items3.item(0)
		sEqpCode = itemNode.SelectSingleNode("eqpCode").text
		Set itemNode = Nothing
	End If	
	
	parameter = parameter & "&eqpCode=" & sEqpCode
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp4 = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp4.Open "GET", targetURL, False   
	xmlHttp4.Send    
	
	Set oStream4 = CreateObject("ADODB.Stream")   
	oStream4.Open   
	oStream4.Position = 0   
	oStream4.Type = 1   
	oStream4.Write xmlHttp4.ResponseBody   
	oStream4.Position = 0   
	oStream4.Type = 2   
	oStream4.Charset = "utf-8"   
	sText = oStream4.ReadText   
	oStream4.Close   
	
	Set xmlDOM4 = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM4.async = False    
	xmlDOM4.LoadXML sText   
	'농사 Open API 통신 끝
	     
	Set listItem4 = xmlDOM4.SelectNodes("//items")
	cnt4 = listItem4(0).childNodes.length
	Set items4 = listItem4(0).childNodes
	
	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
%>
	<hr>
	<table width="100%" class="grid topLine" border="1" cellSpacing="0" summary="" cellPadding="0"><!-- border=1  스타일 지웠을 경우를 데이터 정렬 -->
		 <caption>농수산물 소득정보 리스트</caption>
			<colgroup>
				<col width="5%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="15%" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="4">비목별</th>
				<th scope="col">수량(Kg)</th>
				<th scope="col">단가(원)</th>
				<th scope="col">금액(원)</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>
		  <tr>
			<th scope="row" rowspan="2">조수입</th>
                    <td colspan="3">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				'목록 코드
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				'목록 명
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				'소득 분석 개수
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				'소득 단위
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				'소득 금액 수
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				'소득 총 금액
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "주산물가액" OR listNm = "부산물가액" Then
				Response.Write(listNm & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "주산물가액" OR listNm = "부산물가액" Then
				Response.Write(incomeAnalsRnnm & incomeUnit & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "주산물가액" OR listNm = "부산물가액" Then
				Response.Write(incomeAmount & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "주산물가액" OR listNm = "부산물가액" Then
				Response.Write(incomeTotAmount & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "상품화율" Then
				Response.Write(listNm & incomeTotAmount & incomeUnit)
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
			</tr>
<%	
		sYearCd = ""
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("yearCode") is Nothing Then
					yearCode = itemNode.SelectSingleNode("yearCode").text
				End If
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If

			sYearCd = yearCode

			If listNm = "조수입 계" Then
%>				<tr>	 
					<td colspan="3">계</td>
					<td></td>
					<td></td>
					<td><%=incomeTotAmount%></td>
					<td></td>
				</tr>
<%
			End If
			Set itemNode = Nothing
		Next
%>
			<tr>
				<th scope="row" rowspan="<% If sYearCd ="2013" Then Response.Write("6") Else Response.Write("5") End If %>">생<br/>산<br/>비</th>
				<th scope="row" rowspan="4">경<br/>영<br/>비 </th>
				<th scope="row" rowspan="2">중<br/>간<br/>재<br/>비</th>
				<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("yearCode") is Nothing Then
					yearCode = itemNode.SelectSingleNode("yearCode").text
				End If
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "종묘비종자" OR listNm = "종묘비종묘" OR listNm = "무기질비료비" OR listNm = "유기질비료비" OR listNm = "농약비" OR listNm = "광열동력비" OR listNm = "수리(水利)비" OR listNm = "제재료비" OR listNm = "소농구비" OR listNm = "대농구상각비" OR listNm = "영농시설상각비" OR listNm = "수리(修理)비" OR listNm = "기타요금" Then
				If yearCode = "2013" And listCode = "03010104" Then
					listNm = "영농광열비"
				ElseIf yearCode = "2013" And listCode = "03010131" Then
					listNm = "기타제재료비"
				ElseIf yearCode = "2013" And listCode = "03010119" Then
					listNm = "수선비"
				End If
				Response.Write(listNm & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "종묘비종자" OR listNm = "종묘비종묘" OR listNm = "무기질비료비" OR listNm = "유기질비료비" OR listNm = "농약비" OR listNm = "광열동력비" OR listNm = "수리(水利)비" OR listNm = "제재료비" OR listNm = "소농구비" OR listNm = "대농구상각비" OR listNm = "영농시설상각비" OR listNm = "수리(修理)비" OR listNm = "기타요금" Then
				If Not incomeAnalsRnnm = "0" Then
					Response.Write(incomeAnalsRnnm & incomeUnit & "<br/>")
				End If
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "종묘비종자" OR listNm = "종묘비종묘" OR listNm = "무기질비료비" OR listNm = "유기질비료비" OR listNm = "농약비" OR listNm = "광열동력비" OR listNm = "수리(水利)비" OR listNm = "제재료비" OR listNm = "소농구비" OR listNm = "대농구상각비" OR listNm = "영농시설상각비" OR listNm = "수리(修理)비" OR listNm = "기타요금" Then
				If Not incomeAmount = "0" Then
					Response.Write(incomeAmount & "<br/>")
				End If
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "종묘비종자" OR listNm = "종묘비종묘" OR listNm = "무기질비료비" OR listNm = "유기질비료비" OR listNm = "농약비" OR listNm = "광열동력비" OR listNm = "수리(水利)비" OR listNm = "제재료비" OR listNm = "소농구비" OR listNm = "대농구상각비" OR listNm = "영농시설상각비" OR listNm = "수리(修理)비" OR listNm = "기타요금" Then
				Response.Write(incomeTotAmount & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
					If listNm = "복합" Then listNm = "복합비료" End If
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "N" OR listNm = "P" OR listNm = "K" OR listNm = "요소" OR listNm = "유안" OR listNm = "용성인비" OR listNm = "염화칼리" OR listNm = "붕소" OR listNm = "농용석회" OR listNm = "복합비료" OR listNm = "규산질" OR listNm = "영양제액제" OR listNm = "영양제수화제" OR listNm = "살충제유제" OR listNm = "살충제입제" OR listNm = "살충제수화제" OR listNm = "살균제유제" OR listNm = "살균제분제" OR listNm = "살균제입제" OR listNm = "살균제수화제" OR listNm = "영양제수화제" OR listNm = "제초제유제" OR listNm = "제초제입제" OR listNm = "전기" OR listNm = "가스" OR listNm = "유류" OR listNm = "비닐" OR listNm = "활죽" OR listNm = "폿트" OR listNm = "비닐끈" OR listNm = "짚" OR listNm = "왕겨" OR listNm = "포장상자" OR listNm = "보온덮개" Then
				If incomeAnalsRnnm = "0" Then

				Else 
					Response.Write(listNm & " " & incomeAnalsRnnm & " " & incomeUnit & "<br/>")
				End If
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
			</tr>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "중간재비 계" Then
%>
				<tr>
					<td>계</td>
					<td></td>
					<td></td>
					<td align="right"><%=incomeTotAmount%></td>
					<td></td>
				</tr>
<%
			End If
			Set itemNode = Nothing
		Next
%>
				<tr>
			<td colspan="2">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "임차료(농기계.시설)" OR listNm = "임차료(토지)" OR listNm = "위탁영농비" OR listNm = "고용노력비" Then
				Response.Write(listNm & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
			</td>
			<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "임차료(농기계.시설)" OR listNm = "임차료(토지)" OR listNm = "위탁영농비" OR listNm = "고용노력비" Then
				If Not incomeAnalsRnnm = "0" Then
					Response.Write(incomeAnalsRnnm & incomeUnit & "<br/>")
				End If
			End If
			Set itemNode = Nothing
		Next
%>
			</td>
			<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listCode = "030100A1" OR listCode = "030100A2" Then
				If listNm = "남" Then
					Response.Write("남" & incomeAmount & "<br/>")
				ElseIf listNm = "여" Then
					Response.Write("여" & incomeAmount & "<br/>")
				End If
			End If
			Set itemNode = Nothing
		Next
%>
			</td>
			<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "임차료(농기계.시설)" OR listNm = "임차료(토지)" OR listNm = "위탁영농비" OR listNm = "고용노력비" OR listNm = "남" OR listNm = "여" Then
				If Not incomeTotAmount = "0" Then
					Response.Write(incomeTotAmount & "<br/>")
				End If
			End If
			Set itemNode = Nothing
		Next
%>
			</td>
			<td><br/><br/><br/>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listCode = "04030002" OR listCode = "0403A002" Then
				Response.Write(listNm & " " & incomeAnalsRnnm & " " & incomeUnit & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
			</td>
			</tr>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "경영비 계" Then
%>
					<tr valign="top">
						<td colspan="2">계</td>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><%=incomeTotAmount%></td>
						<td>&#160;</td>
					</tr>
<%
			End If
			Set itemNode = Nothing
		Next
%>
			<tr valign="top">
				<td colspan="3">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("yearCode") is Nothing Then
					yearCode = itemNode.SelectSingleNode("yearCode").text
				End If
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If yearCode = "2013" Then
				If listCode = "030000A0" Or listCode = "03000009" Or listCode = "03000010" Or listCode = "03000011" Then
				Response.Write(listNm+"<br/>")
				Else
				End If
			Else
				If listCode = "030000A0" Then
					listNm = "자가노력비"
					Response.Write(listNm)
				End If
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listCode = "030000A0"  OR listCode = "030000A1" OR listCode = "030000A2" Then
				If NOT incomeAnalsRnnm = "0" Then
					Response.Write(incomeAnalsRnnm & incomeUnit)
				End If
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listCode = "030000A0" OR listCode = "030000A1" OR listCode = "030000A2" Then
				If NOT incomeAmount = "0" Then
					If listNm = "남" Then
						Response.Write("남" & incomeAmount & "<br/>")
					ElseIf listNm = "여" Then
						Response.Write("여" & incomeAmount & "<br/>")
					End If
				End If
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
				<td align="right">
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("yearCode") is Nothing Then
					yearCode = itemNode.SelectSingleNode("yearCode").text
				End If
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If yearCode = "2013" Then 	
				If listCode = "030000A0" Or listCode = "03000009" Or listCode = "03000010" Or listCode = "03000011" Then
					If listCode = "030000A0" Then
						Response.Write(incomeTotAmount & "*<br/>")
						Response.Write(incomeAnalsRnnm*13932 & "**<br/>")
					Else
						Response.Write(incomeTotAmount & "<br/>")
					End If
				Else

				End If
			Else
				If listCode = "030000A0" Then
					Response.Write(incomeTotAmount & "<br/>")
				End If
			End If

			Set itemNode = Nothing
		Next
%>
				</td>
				<td>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listCode = "0402A001" OR listCode = "0402A002" Then
				Response.Write(listNm & incomeAnalsRnnm & incomeUnit & "<br/>")
			End If
			Set itemNode = Nothing
		Next
%>
				</td>
			</tr>
<%	
		If 	sYearCd = "2013" Then
			tot2 = 0
			tot3 = 0
			For i=0 To cnt4-1
				Set itemNode = items4.item(i)
				If NOT itemNode Is Nothing Then
					If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
						listCode = itemNode.SelectSingleNode("listCode").text
					End If
					If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
						listNm = itemNode.SelectSingleNode("listNm").text
					End If
					If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
						incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
						incomeAnalsRnnm =  Replace(incomeAnalsRnnm, ",", "")
					End If
					If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
						incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
					End If
					If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
						incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
						incomeAmount =  Replace(incomeAmount, ",", "")
					End If
					If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
						incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
						incomeTotAmount =  Replace(incomeTotAmount, ",", "")
					End If
				End If
				If listNm = "경영비 계" Then
					tot2 = tot2 + incomeTotAmount
					tot3 = tot3 + incomeTotAmount
				ElseIf listCode = "030000A0" Then
					tot2 = tot2 + incomeTotAmount
					tot3 = tot3 + incomeAnalsRnnm * 13932
				ElseIf listCode = "03000009" Then
					tot2 = tot2 + incomeTotAmount
					tot3 = tot3 + incomeTotAmount
				ElseIf listCode = "03000010" Then
					tot2 = tot2 + incomeTotAmount
					tot3 = tot3 + incomeTotAmount
				ElseIf listCode = "03000011" Then
					tot2 = tot2 + incomeTotAmount
					tot3 = tot3 + incomeTotAmount
				End If
				Set itemNode = Nothing
			Next
%>
			<tr valign="top">
				<td colspan="3">계</td>
				<td>&#160;</td>
				<td>&#160;</td>
				<td align="right"><%=tot2%>*<br/><%=tot3%>**</td>
				<td>&#160;</td>
			</tr>
<%
		End If
%>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "소득" Then
%>
					<tr>
						<th scope="row" colspan="4">소 &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;득</th>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><%=incomeTotAmount%></td>
						<td>&#160;</td>
					</tr>
<%
			End If
			Set itemNode = Nothing
		Next
%>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "부가가치" Then
%>
				<tr>
					<th scope="row" colspan="4">부 &#160;가 &#160;가 &#160;치 </th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><%=incomeTotAmount%></td>
					<td>&#160;</td>
				</tr>
<%
			End If
			Set itemNode = Nothing
		Next
%>
<%	
		If 	sYearCd = "2013" Then
			tot2 = 0
			tot3 = 0
			fTot = 0
			For i=0 To cnt4-1
				Set itemNode = items4.item(i)
				If NOT itemNode Is Nothing Then
					If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
						listCode = itemNode.SelectSingleNode("listCode").text
					End If
					If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
						listNm = itemNode.SelectSingleNode("listNm").text
					End If
					If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
						incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
						incomeAnalsRnnm =  Replace(incomeAnalsRnnm, ",", "")
					End If
					If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
						incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
					End If
					If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
						incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
						incomeAmount =  Replace(incomeAmount, ",", "")
					End If
					If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
						incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
						incomeTotAmount =  Replace(incomeTotAmount, ",", "")
					End If
				End If
				If listNm = "조수입 계" Then
					sum1 = sum1 + incomeTotAmount
				ElseIf listNm = "중간재비 계" Then
					sum2 = sum2 + incomeTotAmount
				End If
				Set itemNode = Nothing
			Next
			
			fTot = ((sum1-sum2)/sum1)*100

%>
			<tr>
				<th scope="row" colspan="4">부 &#160;가 &#160;가&#160;치&#160;율(%)</th>
				<td>&#160;</td>
				<td>&#160;</td>
				<td align="right"><%= formatnumber(fTot,1) %></td>
				<td>&#160;</td>
			</tr>
<%
		End If
%>
<%	
		For i=0 To cnt4-1
			Set itemNode = items4.item(i)
			If NOT itemNode Is Nothing Then
				If NOT itemNode.SelectSingleNode("listCode") is Nothing Then
					listCode = itemNode.SelectSingleNode("listCode").text
				End If
				If NOT itemNode.SelectSingleNode("listNm") is Nothing Then
					listNm = itemNode.SelectSingleNode("listNm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAnalsRnnm") is Nothing Then
					incomeAnalsRnnm = itemNode.SelectSingleNode("incomeAnalsRnnm").text
				End If
				If NOT itemNode.SelectSingleNode("incomeUnit") is Nothing Then
					incomeUnit = itemNode.SelectSingleNode("incomeUnit").text
				End If
				If NOT itemNode.SelectSingleNode("incomeAmount") is Nothing Then
					incomeAmount = itemNode.SelectSingleNode("incomeAmount").text
				End If
				If NOT itemNode.SelectSingleNode("incomeTotAmount") is Nothing Then
					incomeTotAmount = itemNode.SelectSingleNode("incomeTotAmount").text
				End If
			End If
			If listNm = "소득율(%)" Then
%>
				<tr>
					<th scope="row" colspan="4">소 &#160;득 &#160;률(%)</th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><%=incomeTotAmount%></td>
					<td>&#160;</td>
				</tr>
<%
			End If
			Set itemNode = Nothing
		Next
%>
		</tbody>
	</table>
<%
	End If
%>
<p>주) * 는 조사지역의 농촌노임을 적용하여 산출한 자가노동비 및 생산비임<br/>
    ** 는 5인~29인 규모 제조업 평균임금(단가 : 13,932/1시간)을 적용해서 산출한 자가노동비 및 생산비임 
</p>
</form>
</body>
</html>