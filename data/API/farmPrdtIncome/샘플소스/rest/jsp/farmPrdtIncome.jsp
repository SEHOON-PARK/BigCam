<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.net.URL"%>
<%@page import="java.text.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>농산물 소득 정보</title>
<% 
	DecimalFormat df = new DecimalFormat("###,###"); 
%>
<script type="text/javascript">
	//메인 테크 항목
	function fncMove(sCode){
		with(document.mainApiForm){
			svcCode.value = sCode;
			method="get";
			action = "farmPrdtIncome.jsp";
			target = "_self";
			submit();
		}
	}
	//연도 선택
	function yearMove(cYear){
		if("<%=request.getParameter("svcCode")%>" == "null") {
			yearApiForm.svcCode.value ='0';
		}
		
		with(document.yearApiForm){
			year.value = cYear;
			method="get";
			action = "farmPrdtIncome.jsp";
			target = "_self";
			submit();
		}
	}
	//지역 선택
	function localMove(cLocal){
		if("<%=request.getParameter("svcCode")%>" == "null") {
			localApiForm.svcCode.value ='0';
		}
		if("<%=request.getParameter("year")%>" == "null") {
			localApiForm.year.value = viewForm.yearCombo.value; 
		}
		
		with(document.localApiForm){
			atptCode.value = cLocal;
			method="get";
			action = "farmPrdtIncome.jsp";
			target = "_self";
			submit();
		}
	}
	//상세 보기
	function detailMove(eCode){
		if("<%=request.getParameter("svcCode")%>" == "null") {
			detailApiForm.svcCode.value ='0';
		}
		
		if("<%=request.getParameter("year")%>" == "null") {
			detailApiForm.year.value = viewForm.yearCombo.value; 
		}
		
		
		if("<%=request.getParameter("atptCode")%>" == "null") {
			detailApiForm.atptCode.value = viewForm.atptCode0.value; 
		}
		
		with(document.detailApiForm){
			eqpCode.value = eCode;
			method="get";
			action = "farmPrdtIncome.jsp";
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
<input type="hidden" name="svcCode" value="<%=request.getParameter("svcCode")%>">
</form>

<form name="yearApiForm">
<input type="hidden" name="svcCode" value="<%=request.getParameter("svcCode")%>">
<input type="hidden" name="year" value="<%=request.getParameter("year")%>">
</form>

<form name="localApiForm">
<input type="hidden" name="svcCode" value="<%=request.getParameter("svcCode")%>">
<input type="hidden" name="year" value="<%=request.getParameter("year")%>">
<input type="hidden" name="atptCode" value="<%=request.getParameter("atptCode")%>">
</form>

<form name="detailApiForm">
<input type="hidden" name="svcCode" value="<%=request.getParameter("svcCode")%>">
<input type="hidden" name="year" value="<%=request.getParameter("year")%>">
<input type="hidden" name="atptCode" value="<%=request.getParameter("atptCode")%>">
<input type="hidden" name="eqpCode" value="<%=request.getParameter("eqpCode")%>">
</form>

<hr>
<form name="viewForm">
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<tr>				
		<td align="center"><a href="javascript:fncMove('0');"> <% if( "0".equals(request.getParameter("svcCode")) || request.getParameter("svcCode")==null ){%> <strong>전체</strong>  <% } else { %> 전체 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('FC');"><% if( "FC".equals(request.getParameter("svcCode"))){%> <strong>식량작물</strong>  <% } else { %> 식량작물 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('FG');"><% if( "FG".equals(request.getParameter("svcCode"))){%> <strong>사료녹비작물</strong>  <% } else { %> 사료녹비작물 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('FL');"><% if( "FL".equals(request.getParameter("svcCode"))){%> <strong>화훼</strong>  <% } else { %> 화훼 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('FT');"><% if( "FT".equals(request.getParameter("svcCode"))){%> <strong>과수</strong>  <% } else { %> 과수 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('IC');"><% if( "IC".equals(request.getParameter("svcCode"))){%> <strong>특용작물</strong>  <% } else { %> 특용작물 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('LP');"><% if( "LP".equals(request.getParameter("svcCode"))){%> <strong>축산</strong>  <% } else { %> 축산 <%} %></a></td>
		<td align="center"><a href="javascript:fncMove('VC');"><% if( "VC".equals(request.getParameter("svcCode"))){%> <strong>채소</strong>  <% } else { %> 채소 <%} %></a></td>
	</tr>
</table>

<%
	NodeList items = null;
	NodeList years = null;
	NodeList atptCodes = null;
	NodeList atptNms = null;
	NodeList eqpCodes = null;
	NodeList eqpNms = null;
	
	Document doc = null;
	
	String apiKey="";
	String serviceName="";
	String operationName="";
	String parameter ="";
	URL apiUrl=null;
	int size = 0;
	//============================================== 연도 목록 시작 ===========================================================
	
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	apiKey="발급받은인증키를입력하십시오"; 
	//서비스 명
	serviceName="farmPrdtIncome";
	//오퍼레이션 명
	operationName="farmPrdtIncomeYearList";
	
	//XML 받을 URL 생성
    parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	
	//품목 코드
	String sSvcCode = request.getParameter("svcCode");
	if(request.getParameter("svcCode")==null || request.getParameter("svcCode").equals("")) {
		sSvcCode = "0";
	}

	parameter += "&svcCode="+ sSvcCode;
	
	//서버와 통신
	apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();
	
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	years = doc.getElementsByTagName("year");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
		 년도 선택 : <select  id="yearCombo" onchange="yearMove( this.value);" > 
<%
		for(int i=0; i<size; i++){
			//연도
			String year = years.item(i).getFirstChild() == null ? "" : years.item(i).getFirstChild().getNodeValue();
			if(request.getParameter("year")!=null&&!request.getParameter("year").equals("")){
				if(request.getParameter("year").equals(year)){
%>
				<option value="<%=year%>" selected> <%=year%> </option>
<%		
				}else{
%>
					<option value="<%=year%>" > <%=year%> </option>
<%		
				}
			}else{
%>
				<option value="<%=year%>" > <%=year%> </option>
<%		
			}
		}
%>
		</select>
		</tr>
	</table>
<%
	}
%>

<!-- ============================================== 연도 목록 끝 =========================================================== -->

<!-- ============================================== 지역 목록 시작 =========================================================== -->

<%
	//서비스 명
	serviceName="farmPrdtIncome";
	//오퍼레이션 명
	operationName="farmPrdtIncomeSidoList";
	
	//XML 받을 URL 생성
	parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;

	String sYear = request.getParameter("year");
	if(request.getParameter("year")==null || request.getParameter("year").equals("")) {
		sYear = years.item(0).getFirstChild().getNodeValue();
	}
	
	parameter += "&svcCode="+ sSvcCode;
	parameter += "&year="+ sYear;
	
	//서버와 통신
	apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream2 = apiUrl.openStream();
	
	Document doc2 = null;
	try{
		//xml document
		doc2 = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream2);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream2.close();
	}
	
	items = doc2.getElementsByTagName("item");
	size = doc2.getElementsByTagName("item").getLength();
	atptCodes = doc2.getElementsByTagName("atptCode");
	atptNms = doc2.getElementsByTagName("atptNm");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
<%
		for(int i=0; i<size; i++){
			//지역코드
			String atptCode = atptCodes.item(i).getFirstChild() == null ? "" : atptCodes.item(i).getFirstChild().getNodeValue();
			//지역 코드 명
			String atptNm = atptNms.item(i).getFirstChild() == null ? "" : atptNms.item(i).getFirstChild().getNodeValue();
			if(i%5==0){
				out.print("</tr><tr>");
			}
			if(request.getParameter("atptCode")!=null&&!request.getParameter("atptCode").equals("")){
				if(request.getParameter("atptCode").equals(atptCode)){
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<strong><a href="javascript:localMove('<%=atptCode%>');"><%=atptNm%></a></strong></td>
				<input type="hidden" name="atptCode<%=i%>" value="<%=atptCode%>"  />
<%		
				}else{
%>
					<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:localMove('<%=atptCode%>');"><%=atptNm%></a></td>
					<input type="hidden" name="atptCode<%=i%>" value="<%=atptCode%>"  />
<%		
				}
			}else{
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:localMove('<%=atptCode%>');"><%=atptNm%></a></td>
				<input type="hidden" name="atptCode<%=i%>" value="<%=atptCode%>"  />
<%		
			}
		}
%>
		</tr>
	</table>
<%
}
%>
<!-- ============================================== 카테고리 조회 시작 =========================================================== -->
<%
	//서비스 명
	serviceName="farmPrdtIncome";
	//오퍼레이션 명
	operationName="farmPrdtIncomeList";
	
	//XML 받을 URL 생성
	parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	
	String sAtptCode =request.getParameter("atptCode"); 
	if(request.getParameter("atptCode")==null || request.getParameter("atptCode").equals("")) {
		sAtptCode = atptCodes.item(0).getFirstChild().getNodeValue();
	}
	
	parameter += "&svcCode="+ sSvcCode;
	parameter += "&year="+ sYear;
	parameter += "&atptCode="+ sAtptCode;
	
	//서버와 통신
	apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream3 = apiUrl.openStream();
	
	Document doc3 = null;
	try{
		//xml document
		doc3 = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream3);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream3.close();
	}
	
	items = doc3.getElementsByTagName("item");
	size = doc3.getElementsByTagName("item").getLength();
	eqpCodes = doc3.getElementsByTagName("eqpCode");
	eqpNms = doc3.getElementsByTagName("eqpNm");

	
	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
<%
		for(int i=0; i<size; i++){
			//설비 코드명
			String eqpCode = eqpCodes.item(i).getFirstChild() == null ? "" : eqpCodes.item(i).getFirstChild().getNodeValue();
			//설비 명
			String eqpNm = eqpNms.item(i).getFirstChild() == null ? "" : eqpNms.item(i).getFirstChild().getNodeValue();
			if(i%5==0){
				out.print("</tr><tr>");
			}
			if(request.getParameter("eqpCode")!=null&&!request.getParameter("eqpCode").equals("")){
				if(request.getParameter("eqpCode").equals(eqpCode)){
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<strong><a href="javascript:detailMove('<%=eqpCode%>');"><%=eqpNm%></a></strong></td>
<%		
				}else{
%>
					<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:detailMove('<%=eqpCode%>');"><%=eqpNm%></a></td>
<%		
				}
			}else{
%>
				<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:detailMove('<%=eqpCode%>');"><%=eqpNm%></a></td>
<%		
			}
		}
%>
		</tr>
	</table>
<%
}
%>

<!-- ============================================== 카테고리 조회 끝 =========================================================== -->

<!-- ============================================== 작목 상세 목록 시작 =========================================================== -->

<%
	//서비스 명
	serviceName="farmPrdtIncome";
	//오퍼레이션 명
	operationName="farmPrdtIncomeDetailList";
	
	//XML 받을 URL 생성
	parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;

	parameter += "&svcCode="+ sSvcCode;
	parameter += "&year="+ sYear;
	parameter += "&atptCode="+ sAtptCode;
	
	String sEqpCode = request.getParameter("eqpCode");
	if(request.getParameter("eqpCode")==null || request.getParameter("eqpCode").equals("")) {
		sEqpCode = eqpCodes.item(0).getFirstChild().getNodeValue();
	}
	parameter += "&eqpCode="+ sEqpCode;
	
	
	//서버와 통신
	apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream4 = apiUrl.openStream();
	
	Document doc4 = null;
	try{
		//xml document
		doc4 = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream4);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream4.close();
	}
	
	NodeList yearCodes = null;
	NodeList listCodes = null;
	NodeList listNms = null;
	NodeList incomeAnalsRnnms= null;
	NodeList incomeUnits = null;
	NodeList incomeAmounts = null;
	NodeList incomeTotAmounts = null;
	
	items = doc4.getElementsByTagName("item");
	size = doc4.getElementsByTagName("item").getLength();
	
	yearCodes = doc4.getElementsByTagName("yearCode");
	listCodes = doc4.getElementsByTagName("listCode");
	listNms = doc4.getElementsByTagName("listNm");
	incomeAnalsRnnms = doc4.getElementsByTagName("incomeAnalsRnnm");
	incomeUnits = doc4.getElementsByTagName("incomeUnit");
	incomeAmounts = doc4.getElementsByTagName("incomeAmount");
	incomeTotAmounts= doc4.getElementsByTagName("incomeTotAmount");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
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
			<th scope="row" rowspan="2">조<br/>수<br/>입</th>
                    <td colspan="3">
					<%for(int i=0; i<size; i++){ 
						//목록 코드	
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						//목록명
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						//소득 분석 개수
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						//소득 단위
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						//소득 금액 수
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						//소득 총 금액
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
							
						if(listNm.equals("주산물가액") ||listNm.equals("부산물가액") ){
						%>
						 <%=listNm%><br/>
					 <% }
					 }%>
				</td>
				<td align="right">
					<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						if(listNm.equals("주산물가액") ||listNm.equals("부산물가액") ){
							
					%>
							<%=incomeAnalsRnnm%><%=incomeUnit%><br/>
				 	<%   
						}
					}%>
				</td>
				<td align="right">
				 <%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
					if(listNm.equals("주산물가액") ||listNm.equals("부산물가액") ){
					%>
				 	<%=incomeAmount%><br/>
				<%}
				}%>
				</td>
				<td align="right" >
				 <%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm =  incomeAnalsRnnms.item(i).getFirstChild() == null ? "0" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue() ;
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();
					
					if(listNm.equals("주산물가액") ||listNm.equals("부산물가액") ){
					%>
					 <%= incomeTotAmount %><br/>
				<%
					}
				}%>
				</td>
				<td>
				<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						if(listNm.equals("상품화율") ){
						%>
						 <%=listNm%><%= incomeTotAmount %><%=incomeUnit%>
						<br/>
					<%}
				}%>
				</td>
			</tr>
			<%
				String sYearCd = "";
				for(int i=0; i<size; i++){ 
					String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
					sYearCd = yearCode;
					if(listNm.equals("조수입 계") ){
					%>
				<tr>	 
					<td colspan="3">계</td>
					<td></td>
					<td></td>
					<td><%=incomeTotAmount%></td>
					<td></td>
				</tr>
			<%}
			}%>
			<tr>
				<th scope="row" rowspan="<% if(sYearCd.equals("2013")) out.print("6"); else out.print("5"); %>">생<br/>산<br/>비</th>
				<th scope="row" rowspan="4">경<br/>영<br/>비</th>
				<th scope="row" rowspan="2">중<br/>간<br/>재<br/>비</th>
				<td>
				<%for(int i=0; i<size; i++){ 
						String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
						
						if(listNm.equals("종묘비종자") || listNm.equals("종묘비종묘") || listNm.equals("무기질비료비") || listNm.equals("유기질비료비") || listNm.equals("농약비") || listNm.equals("광열동력비") || listNm.equals("수리(水利)비") || listNm.equals("제재료비") || listNm.equals("소농구비") || listNm.equals("대농구상각비") || listNm.equals("영농시설상각비") || listNm.equals("수리(修理)비") || listNm.equals("기타요금") ){
							if(yearCode.equals("2013") && listNm.equals("광열동력비")){
								listNm = "영농광열비";
							}else if(yearCode.equals("2013") && listNm.equals("제재료비")){
								listNm = "기타제재료비";
							}else if(yearCode.equals("2013") && listNm.equals("수리(修理)비")){
								listNm = "수선비";
							}
					%>
						<%=listNm%><br/>
				<%}
				}%>
				</td>
				<td align="right">
					<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						if( listNm.equals("종묘비종자") || listNm.equals("종묘비종묘") || listNm.equals("무기질비료비") || listNm.equals("유기질비료비") || listNm.equals("농약비") || listNm.equals("광열동력비") || listNm.equals("수리(水利)비") || listNm.equals("제재료비") || listNm.equals("소농구비") || listNm.equals("대농구상각비") || listNm.equals("영농시설상각비") || listNm.equals("수리(修理)비") || listNm.equals("기타요금") ){
						
						if(!incomeAnalsRnnm.equals("0")) {
						%>
							<%=incomeAnalsRnnm%> <%=incomeUnit%><br/>
						<%}
						}
					}%>
				</td>
				<td align="right">
					<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
						
						if(  listNm.equals("종묘비종자") || listNm.equals("종묘비종묘") || listNm.equals("무기질비료비") || listNm.equals("유기질비료비") || listNm.equals("농약비") || listNm.equals("광열동력비") || listNm.equals("수리(水利)비") || listNm.equals("제재료비") || listNm.equals("소농구비") || listNm.equals("대농구상각비") || listNm.equals("영농시설상각비") || listNm.equals("수리(修理)비") || listNm.equals("기타요금") ){
						
							if(!incomeAmount.equals("0")) {
						%>
						<%=incomeAmount%><br/>
					<%}
						}
					}%>
				</td>
				<td align="right">
					<%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
					
					
					if( listNm.equals("종묘비종자") || listNm.equals("종묘비종묘") || listNm.equals("무기질비료비") || listNm.equals("유기질비료비") || listNm.equals("농약비") || listNm.equals("광열동력비") || listNm.equals("수리(水利)비") || listNm.equals("제재료비") || listNm.equals("소농구비") || listNm.equals("대농구상각비") || listNm.equals("영농시설상각비") || listNm.equals("수리(修理)비") || listNm.equals("기타요금") ){
						%>
					 <%=incomeTotAmount%><br/>
					<%}
					}%>
				</td>
				<td>
					<%for(int i=0; i<size; i++){ 
						String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						if(listNm.equals("복합")) listNm="복합비료";
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
						
						
						if(listNm.equals("N") || listNm.equals("P") || listNm.equals("K") || listNm.equals("요소") || listNm.equals("유안") || listNm.equals("용성인비") || listNm.equals("염화칼리") || listNm.equals("붕소") || listNm.equals("농용석회") || listNm.equals("복합비료") || listNm.equals("규산질") || listNm.equals("영양제액제") || listNm.equals("영양제수화제") || listNm.equals("살충제분제") || listNm.equals("살충제유제") || listNm.equals("살충제입제") || listNm.equals("살충제수화제") 
								|| listNm.equals("살균제유제") || listNm.equals("살균제분제") || listNm.equals("살균제입제") || listNm.equals("살균제수화제") || listNm.equals("영양제수화제") || listNm.equals("제초제유제") || listNm.equals("제초제입제") || listNm.equals("전기") || listNm.equals("가스")
								|| listNm.equals("유류")|| listNm.equals("비닐")|| listNm.equals("활죽")|| listNm.equals("폿트")|| listNm.equals("비닐끈")
								|| listNm.equals("짚")|| listNm.equals("왕겨")|| listNm.equals("포장상자")|| listNm.equals("보온덮개")
								){
							if(incomeAnalsRnnm.equals("0")){
								
							}else{
						%>
								<%=listNm%>&nbsp;<%=incomeAnalsRnnm%>&nbsp;<%=incomeUnit%><br/>
						<%		
							}
						}
					
					}%>
				</td>
				</tr>
				<%for(int i=0; i<size; i++){ 
							String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
							String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
							String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
							String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
							String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
							String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
							if(listNm.equals("중간재비 계") ){
							%>
					<tr>
						<td>계</td>
						<td></td>
						<td></td>
						<td align="right"><%=incomeTotAmount%></td>
						<td></td>
					</tr>
				<%}
				}%>
				
				
				
				
					<tr>
			<td colspan="2">
				<%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
					
					if(listNm.equals("임차료(농기계.시설)") || listNm.equals("임차료(토지)") || listNm.equals("위탁영농비") || listNm.equals("고용노력비")  ){
					%>
					<%=listNm%><br/>
				<%}
				}%>
			</td>
			<td>
				<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						
						if(listNm.equals("임차료(농기계.시설)") || listNm.equals("임차료(토지)") || listNm.equals("위탁영농비") || listNm.equals("고용노력비")  ){
						  if(!incomeAnalsRnnm.equals("0")) {
						%>
							 <%=incomeAnalsRnnm%> <%=incomeUnit%>
						<br/>
				<%
						}
					}
				}%>
			</td>
			<td>
				<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						
						if(listCode.equals("030100A1") || listCode.equals("030100A2")  ){
							
							if( listNm.equals("남") ) { 
								incomeAmount ="남 "+ incomeAmount ;  
							} else if( listNm.equals("여") ) { 
								incomeAmount ="여 "+ incomeAmount ; 
							}
						%>
						 <%=incomeAmount%> <br/>
					<%}
				}%>
			</td>
			
			<td align="right">
				<%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
					if(listNm.equals("임차료(농기계.시설)") || listNm.equals("임차료(토지)") || listNm.equals("위탁영농비") || listNm.equals("고용노력비") || listNm.equals("남") || listNm.equals("여")  ){
						 if(!incomeTotAmount.equals("0")) {
					%>
					<%=incomeTotAmount%> <br/>
					<%}
					}
				}%>
			</td>
			<td><br/><br/><br/>
				<%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
					
					if(listCode.equals("04030002") || listCode.equals("0403A002")  ){
					%>
					<%=listNm%>&nbsp;<%=incomeAnalsRnnm%>&nbsp;<%=incomeUnit%><br/>
				<%}
				}%>
			</td>
			</tr>
			<%for(int i=0; i<size; i++){ 
					String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
					String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
					String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
					String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
					String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
					String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
					
					if(listCode.equals("030000A0")){
				%>
					<tr valign="top">
						<td colspan="2">계</td>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><%=incomeTotAmount%></td>
						<td>&#160;</td>
					</tr>
			<%}
			}%>
			<tr valign="top">
				<td colspan="3">
					<%for(int i=0; i<size; i++){ 
						String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						
						if(yearCode.equals("2013")){
							if(listCode.equals("030000A0") || listCode.equals("03000009") || listCode.equals("03000010") || listCode.equals("03000011")){
						%>
								<%=listNm%><br/>
						<%	
							}
						}else{
							if(listCode.equals("030000A0")){
								listNm = "자가노력비";
							 %>
								<%=listNm%><br/>
							<%
							}
						}
					}%>
				</td>
				<td>
					<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						
						if(listCode.equals("030000A0") ||  listCode.equals("030000A1") || listCode.equals("030000A2") ){
						
							 if(!incomeAnalsRnnm.equals("0")) {
								 
						%>
						<%=incomeAnalsRnnm%> <%=incomeUnit%>
					<%}
					}
					}%>
				</td>
				<td>
					<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();
						
						if(listCode.equals("030000A0") ||  listCode.equals("030000A1") || listCode.equals("030000A2") ){
							 if(!incomeAmount.equals("0")) {
								 
								 if( listNm.equals("남") ) { 
									 incomeAmount ="남 "+ incomeAmount ;  
								} else if( listNm.equals("여") ) { 
									incomeAmount ="여 "+ incomeAmount ; 
								}
								 
							%>
						<%=incomeAmount%><br/>
					<%}
					}
					}%>
				</td>
				<td align="right">
					<%for(int i=0; i<size; i++){ 
						String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						if(yearCode.equals("2013")){
							if(listCode.equals("030000A0") || listCode.equals("03000009") || listCode.equals("03000010") || listCode.equals("03000011")){
								if(listCode.equals("030000A0")){
									float fIncomeTotAmount = Float.valueOf(incomeAnalsRnnm).floatValue()*13932;
							%>
									<%=incomeTotAmount%>*<br/>
									<%=String.format("%,.1f", fIncomeTotAmount)%>**<br/>
							<%	
									
								}else{
							%>
									<%=incomeTotAmount%><br/>
							<%	
								}
							}
						}else{
							if(listCode.equals("030000A0")){
							 %>
								<%=incomeTotAmount%><br/>
							<%
							}
						}
					}%>
				</td>
				<td>
					<%for(int i=0; i<size; i++){ 
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue();  
						
						if(listCode.equals("0402A001") || listCode.equals("0402A002") ){
					%>
						<%=listNm%> <%=incomeAnalsRnnm%> <%=incomeUnit%> <br/>
					<%}
					}%>
				</td>
			</tr>
				<%
				if(sYearCd.equals("2013")){
					float tot2 = 0;
					float tot3 = 0;
					for(int i=0; i<size; i++){ 
						String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						incomeAnalsRnnm = incomeAnalsRnnm.replace(",", "");
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						incomeAmount = incomeAmount.replace(",", "");
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						incomeTotAmount = incomeTotAmount.replace(",", "");
					
						if(listNm.equals("경영비 계")){
							tot2 += Float.valueOf(incomeTotAmount).floatValue();
							tot3 += Float.valueOf(incomeTotAmount).floatValue();
						}else if(listCode.equals("030000A0")){
							tot2 += Float.valueOf(incomeTotAmount).floatValue();
							tot3 += Float.valueOf(incomeAnalsRnnm).floatValue()*13932;
						}else if(listCode.equals("03000009")){
							tot2 += Float.valueOf(incomeTotAmount).floatValue();
							tot3 += Float.valueOf(incomeTotAmount).floatValue();
						}else if(listCode.equals("03000010")){
							tot2 += Float.valueOf(incomeTotAmount).floatValue();
							tot3 += Float.valueOf(incomeTotAmount).floatValue();
						}else if(listCode.equals("03000011")){
							tot2 += Float.valueOf(incomeTotAmount).floatValue();
							tot3 += Float.valueOf(incomeTotAmount).floatValue();
						}
					}
					%>
					<tr valign="top">
						<td colspan="3">계</td>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><%=String.format("%,.1f", tot2)%>*<br/><%=String.format("%,.1f", tot3)%>**</td>
						<td>&#160;</td>
					</tr>
			<%		
				}
			%>
			<%for(int i=0; i<size; i++){ 
				String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
				String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
				String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
				String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
				String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
				String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
				if(listNm.equals("소득") ){
				%>
					<tr>
						<th scope="row" colspan="4">소 &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;득</th>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><%=incomeTotAmount%></td>
						<td>&#160;</td>
					</tr>
				<%}
				}%>
			<%for(int i=0; i<size; i++){ 
				String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
				String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
				String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
				String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
				String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
				String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
				if(listNm.equals("부가가치") ){%>
				<tr>
					<th scope="row" colspan="4">부 &#160;가 &#160;가 &#160;치 </th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><%=incomeTotAmount%></td>
					<td>&#160;</td>
				</tr>
			<%
				}
			}%>
			<%
				if(sYearCd.equals("2013")){
					float sum1 = 0;
					float sum2 = 0;
					float fTot = 0;
					for(int i=0; i<size; i++){ 
						String yearCode = yearCodes.item(i).getFirstChild() == null ? "" : yearCodes.item(i).getFirstChild().getNodeValue();
						String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
						String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
						String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
						incomeAnalsRnnm = incomeAnalsRnnm.replace(",", "");
						String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
						String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
						incomeAmount = incomeAmount.replace(",", "");
						String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
						incomeTotAmount = incomeTotAmount.replace(",", "");
						
						if(listNm.equals("조수입 계")){
							sum1 += Float.valueOf(incomeTotAmount).floatValue();
						}else if(listNm.equals("중간재비 계")){
							sum2 += Float.valueOf(incomeTotAmount).floatValue();
						}
					}
					
					fTot = ((sum1-sum2)/sum1)*100;
					
					%>
				<tr>
					<th scope="row" colspan="4">부 &#160;가 &#160;가&#160;치&#160;율(%)</th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><%= fTot %></td>
					<td>&#160;</td>
				</tr>
			<%		
				}
			%>
			<%for(int i=0; i<size; i++){ 
				String listCode = listCodes.item(i).getFirstChild() == null ? "" : listCodes.item(i).getFirstChild().getNodeValue();
				String listNm = listNms.item(i).getFirstChild() == null ? "" : listNms.item(i).getFirstChild().getNodeValue();
				String incomeAnalsRnnm = incomeAnalsRnnms.item(i).getFirstChild() == null ? "" : incomeAnalsRnnms.item(i).getFirstChild().getNodeValue();
				String incomeUnit = incomeUnits.item(i).getFirstChild() == null ? "" : incomeUnits.item(i).getFirstChild().getNodeValue();
				String incomeAmount = incomeAmounts.item(i).getFirstChild() == null ? "" : incomeAmounts.item(i).getFirstChild().getNodeValue();
				String incomeTotAmount = incomeTotAmounts.item(i).getFirstChild() == null ? "" : incomeTotAmounts.item(i).getFirstChild().getNodeValue(); 
				
				if(listNm.equals("소득율(%)") ){
				  
				%>
				<tr>
					<th scope="row" colspan="4">소 &#160;득 &#160;률(%)</th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><%=incomeTotAmount%>
					</td>
					<td>&#160;</td>
				</tr>
			<%}
			}%>
			
			
		</tbody>
	</table>
<%
	}
%>
<!-- ============================================== 작목 상세 목록 끝 =========================================================== -->
<p>주) * 는 조사지역의 농촌노임을 적용하여 산출한 자가노동비 및 생산비임<br/>
    ** 는 5인~29인 규모 제조업 평균임금(단가 : 13,932/1시간)을 적용해서 산출한 자가노동비 및 생산비임 
</p>


</form>
</body>
</html>