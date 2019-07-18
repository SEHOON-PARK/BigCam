<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.net.URL"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>반려동물 집밥원료</title>
<script type="text/javascript">
//검색
function fncSearch(){
	with(document.searchApiForm){
		if(sFeedNm.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        sFeedNm.focus();
	        return false;
	    }else{
	    	pageNo.value = "1";
			method="get";
			action = "feedRawMaterialList.jsp";
			target = "_self";
			submit();
		}
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "feedRawMaterialList.jsp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>반려동물 집밥원료</strong></h3>
<hr>
<%
String upperListSel = request.getParameter("upperListSel")==null?"":request.getParameter("upperListSel");
%>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">


<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	String serviceName="feedRawMaterial";

	//오퍼레이션 명
	String operationName="upperList";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);

	InputStream apiStream = apiUrl.openStream();

	Document doc = null;

	try {
		//xml document
		doc = DocumentBuilderFactory.newInstance()
				.newDocumentBuilder().parse(apiStream);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		apiStream.close();
	}

	int size = 0;
	String resultCode="";
	String resultMsg="";
	NodeList items = null;
	NodeList codes = null;
	NodeList codeNms = null;

	//물주기 검색 조건
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	codes = doc.getElementsByTagName("code");
	codeNms = doc.getElementsByTagName("codeNm");

	try{resultCode = doc.getElementsByTagName("resultCode").item(0).getFirstChild().getNodeValue();}catch(Exception e){resultCode = "";}
	try{resultMsg = doc.getElementsByTagName("resultMsg").item(0).getFirstChild().getNodeValue();}catch(Exception e){resultMsg = "";}

	if(resultCode.equals("00")){
		for(int i=0; i<size; i++){
			//코드
			String code = codes.item(i).getFirstChild() == null ? "" : codes.item(i).getFirstChild().getNodeValue();
			//코드명
			String codeNm = codeNms.item(i).getFirstChild() == null ? "" : codeNms.item(i).getFirstChild().getNodeValue();
			if(i == 0){
%>
			<select id="upperListSel" name="upperListSel">
			<option value="">전체</option>
<%
			}
%>
			<option value="<%=code%>" <%=upperListSel.equals(code)?"selected":""%>><%=codeNm%></option>
<%
		}
	}else{
		out.print("조회한 정보가 없습니다.");
	}
	out.print("</select>");

%>

<input type="text" name="sFeedNm" value="<%=request.getParameter("sFeedNm")==null?"":request.getParameter("sFeedNm")%>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<%
	//오퍼레이션 명
	operationName="feedRawMaterialList";

	//XML 받을 URL 생성
	parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");

	//검색 조건
	if(request.getParameter("upperListSel")!=null&&!request.getParameter("upperListSel").equals("")){
		parameter += "&upperFeedClCode="+ request.getParameter("upperListSel");
	}
	//검색어
	if(request.getParameter("sFeedNm")!=null&&!request.getParameter("sFeedNm").equals("")){
		parameter += "&sFeedNm="+ URLEncoder.encode(request.getParameter("sFeedNm"));
	}

	//서버와 통신
	apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);

	apiStream = apiUrl.openStream();

	doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	size = 0;

	items = null;
	NodeList feedSeqNos = null;
	NodeList upperFeedClCodes = null;
	NodeList feedClCodes = null;
	NodeList feedClCodeNms = null;
	NodeList feedNms = null;
	NodeList originNms = null;
	NodeList dryMatters = null;
	NodeList mtralPcs = null;
	NodeList mitrQys = null;
	NodeList protQys = null;
	NodeList trypQys = null;
	NodeList clciQys = null;
	NodeList phphQys = null;
	NodeList fatQys = null;
	NodeList lnacQys = null;
	NodeList liacQys = null;
	NodeList ashsQys = null;
	NodeList vtmaQys = null;
	NodeList crbQys = null;
	NodeList crfbQys = null;
	NodeList totEdblfibrQys = null;
	NodeList inslbltyEdblfibrQys = null;
	NodeList slwtEdblfibrQys = null;
	NodeList naQys = null;
	NodeList ptssQys = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();


	feedClCodeNms = doc.getElementsByTagName("feedClCodeNm");
	feedNms = doc.getElementsByTagName("feedNm");
	originNms = doc.getElementsByTagName("originNm");
	dryMatters = doc.getElementsByTagName("dryMatter");
	mtralPcs = doc.getElementsByTagName("mtralPc");
	mitrQys = doc.getElementsByTagName("mitrQy");
	protQys = doc.getElementsByTagName("protQy");
	trypQys = doc.getElementsByTagName("trypQy");
	clciQys = doc.getElementsByTagName("clciQy");
	phphQys = doc.getElementsByTagName("phphQy");
	fatQys = doc.getElementsByTagName("fatQy");
	lnacQys = doc.getElementsByTagName("lnacQy");
	liacQys = doc.getElementsByTagName("liacQy");
	ashsQys = doc.getElementsByTagName("ashsQy");
	vtmaQys = doc.getElementsByTagName("vtmaQy");
	crbQys = doc.getElementsByTagName("crbQy");
	crfbQys = doc.getElementsByTagName("crfbQy");
	totEdblfibrQys = doc.getElementsByTagName("totEdblfibrQy");
	inslbltyEdblfibrQys = doc.getElementsByTagName("inslbltyEdblfibrQy");
	slwtEdblfibrQys = doc.getElementsByTagName("slwtEdblfibrQy");
	naQys = doc.getElementsByTagName("naQy");
	ptssQys = doc.getElementsByTagName("ptssQy");


	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{ %>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="4%"/>
			<col width="*"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
			<col width="4%"/>
		</colgroup>
		<tr>
			<th>출처</th>
			<th>원료</th>
			<th>원료가격(원/kg)</th>
			<th>건물(%)</th>
			<th>수분(%)</th>
			<th>단백질(%)</th>
			<th>트립토판(%)</th>
			<th>칼슘(%)</th>
			<th>인(%)</th>
			<th>지방(%)</th>
			<th>리놀레산(%)</th>
			<th>리놀렌산(%)</th>
			<th>회분(%)</th>
			<th>비타민 A(RE/100g)</th>
			<th>탄수화물(%)</th>
			<th>조섬유(%)</th>
			<th>총식이섬유(%)</th>
			<th>불용성식이섬유(%)</th>
			<th>수용성식이섬유(%)</th>
			<th>나트륨(%)</th>
			<th>칼륨(%)</th>
		</tr>
<%
		for(int i=0; i<size; i++){
			String originNm = originNms.item(i).getFirstChild() == null ? "" : originNms.item(i).getFirstChild().getNodeValue();
			String feedClCodeNm = feedClCodeNms.item(i).getFirstChild() == null ? "" : feedClCodeNms.item(i).getFirstChild().getNodeValue();
			String feedNm = feedNms.item(i).getFirstChild() == null ? "" : feedNms.item(i).getFirstChild().getNodeValue();
			String mtralPc = mtralPcs.item(i).getFirstChild() == null ? "" : mtralPcs.item(i).getFirstChild().getNodeValue();
			String dryMatter = dryMatters.item(i).getFirstChild() == null ? "" : dryMatters.item(i).getFirstChild().getNodeValue();
			String mitrQy = mitrQys.item(i).getFirstChild() == null ? "" : mitrQys.item(i).getFirstChild().getNodeValue();
			String protQy = protQys.item(i).getFirstChild() == null ? "" : protQys.item(i).getFirstChild().getNodeValue();
			String trypQy = trypQys.item(i).getFirstChild() == null ? "" : trypQys.item(i).getFirstChild().getNodeValue();
			String clciQy = clciQys.item(i).getFirstChild() == null ? "" : clciQys.item(i).getFirstChild().getNodeValue();
			String phphQy = phphQys.item(i).getFirstChild() == null ? "" : phphQys.item(i).getFirstChild().getNodeValue();
			String fatQy = fatQys.item(i).getFirstChild() == null ? "" : fatQys.item(i).getFirstChild().getNodeValue();
			String lnacQy = lnacQys.item(i).getFirstChild() == null ? "" : lnacQys.item(i).getFirstChild().getNodeValue();
			String liacQy = liacQys.item(i).getFirstChild() == null ? "" : liacQys.item(i).getFirstChild().getNodeValue();
			String ashsQy = ashsQys.item(i).getFirstChild() == null ? "" : ashsQys.item(i).getFirstChild().getNodeValue();
			String vtmaQy = vtmaQys.item(i).getFirstChild() == null ? "" : vtmaQys.item(i).getFirstChild().getNodeValue();
			String crbQy = crbQys.item(i).getFirstChild() == null ? "" : crbQys.item(i).getFirstChild().getNodeValue();
			String crfbQy = crfbQys.item(i).getFirstChild() == null ? "" : crfbQys.item(i).getFirstChild().getNodeValue();
			String totEdblfibrQy = totEdblfibrQys.item(i).getFirstChild() == null ? "" : totEdblfibrQys.item(i).getFirstChild().getNodeValue();
			String inslbltyEdblfibrQy = inslbltyEdblfibrQys.item(i).getFirstChild() == null ? "" : inslbltyEdblfibrQys.item(i).getFirstChild().getNodeValue();
			String slwtEdblfibrQy = slwtEdblfibrQys.item(i).getFirstChild() == null ? "" : slwtEdblfibrQys.item(i).getFirstChild().getNodeValue();
			String naQy = naQys.item(i).getFirstChild() == null ? "" : naQys.item(i).getFirstChild().getNodeValue();
			String ptssQy = ptssQys.item(i).getFirstChild() == null ? "" : ptssQys.item(i).getFirstChild().getNodeValue();

%>
		<tr>
			<td align="center"><%=originNm%></td>
			<td align="center"><%=feedClCodeNm%> > <%=feedNm%></td>
			<td align="center"><%if(!"".equals(mtralPc)){out.print(String.format("%,d",Integer.parseInt(mtralPc)));} %></td>
			<td align="center"><%if(!"".equals(dryMatter)){out.print(String.format("%,.2f",Double.parseDouble(dryMatter)));}%></td>
			<td align="center"><%if(!"".equals(mitrQy)){out.print(String.format("%,.2f",Double.parseDouble(mitrQy)));}%></td>
			<td align="center"><%if(!"".equals(protQy)){out.print(String.format("%,.2f",Double.parseDouble(protQy)));}%></td>
			<td align="center"><%if(!"".equals(trypQy)){out.print(String.format("%,.2f",Double.parseDouble(trypQy)));}%></td>
			<td align="center"><%if(!"".equals(clciQy)){out.print(String.format("%,.2f",Double.parseDouble(clciQy)));}%></td>
			<td align="center"><%if(!"".equals(phphQy)){out.print(String.format("%,.2f",Double.parseDouble(phphQy)));}%></td>
			<td align="center"><%if(!"".equals(fatQy)){out.print(String.format("%,.2f",Double.parseDouble(fatQy)));}%></td>
			<td align="center"><%if(!"".equals(lnacQy)){out.print(String.format("%,.2f",Double.parseDouble(lnacQy)));}%></td>
			<td align="center"><%if(!"".equals(liacQy)){out.print(String.format("%,.2f",Double.parseDouble(liacQy)));}%></td>
			<td align="center"><%if(!"".equals(ashsQy)){out.print(String.format("%,.2f",Double.parseDouble(ashsQy)));}%></td>
			<td align="center"><%if(!"".equals(vtmaQy)){out.print(String.format("%,.2f",Double.parseDouble(vtmaQy)));}%></td>
			<td align="center"><%if(!"".equals(crbQy)){out.print(String.format("%,.2f",Double.parseDouble(crbQy)));}%></td>
			<td align="center"><%if(!"".equals(crfbQy)){out.print(String.format("%,.2f",Double.parseDouble(crfbQy)));}%></td>
			<td align="center"><%if(!"".equals(totEdblfibrQy)){out.print(String.format("%,.2f",Double.parseDouble(totEdblfibrQy)));}%></td>
			<td align="center"><%if(!"".equals(inslbltyEdblfibrQy)){out.print(String.format("%,.2f",Double.parseDouble(inslbltyEdblfibrQy)));}%></td>
			<td align="center"><%if(!"".equals(slwtEdblfibrQy)){out.print(String.format("%,.2f",Double.parseDouble(slwtEdblfibrQy)));}%></td>
			<td align="center"><%if(!"".equals(naQy)){out.print(String.format("%,.2f",Double.parseDouble(naQy)));}%></td>
			<td align="center"><%if(!"".equals(ptssQy)){out.print(String.format("%,.2f",Double.parseDouble(ptssQy)));}%></td>
		</tr>
<%
		}
%>
	</table>
<%
	}
//페이징 처리
	//한 페이지에 제공할 건수
	String numOfRows = "";
	//조회된 총 건수
	String totalCount = "";
	//조회할 페이지 번호
	String pageNo = "";
	try{numOfRows = doc.getElementsByTagName("numOfRows").item(0).getFirstChild().getNodeValue();}catch(Exception e){numOfRows = "";}
	try{totalCount = doc.getElementsByTagName("totalCount").item(0).getFirstChild().getNodeValue();}catch(Exception e){totalCount = "";}
	try{pageNo = doc.getElementsByTagName("pageNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){pageNo = "";}

	int pageGroupSize = 10;
	int pageSize = 0;
	try{
		pageSize = Integer.parseInt(numOfRows);
	}catch(Exception e){
		pageSize = 10;
	}
	int start = 0;
	try{
		start = Integer.parseInt(pageNo);
	}catch(Exception e){
		start = 1;
	}

	int currentPage = 1;
	try{currentPage = Integer.parseInt(pageNo);}catch(Exception e){}

	int startRow = (currentPage - 1) * pageSize + 1;//한 페이지의 시작글 번호
	int endRow = currentPage * pageSize;//한 페이지의 마지막 글번호
	int count = Integer.parseInt(totalCount);
	int number=0;

	number=count-(currentPage-1)*pageSize;//글목록에 표시할 글번호

	//페이지그룹의 갯수
	//ex) pageGroupSize가 3일 경우 '[1][2][3]'가 pageGroupCount 개 만큼 있다.
	int pageGroupCount = count/(pageSize*pageGroupSize)+( count % (pageSize*pageGroupSize) == 0 ? 0 : 1);
	//페이지 그룹 번호
	//ex) pageGroupSize가 3일 경우  '[1][2][3]'의 페이지그룹번호는 1 이고  '[2][3][4]'의 페이지그룹번호는 2 이다.
	int numPageGroup = (int) Math.ceil((double)currentPage/pageGroupSize);


	if(count > 0){
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		int startPage = pageGroupSize*(numPageGroup-1)+1;
		int endPage = startPage + pageGroupSize-1;
		int prtPageNo = 0;

		if(endPage > pageCount){
			endPage = pageCount;
		}

		if(numPageGroup > 1){
			prtPageNo = (numPageGroup-2)*pageGroupSize+1;
			out.println("<a href='javascript:fncGoPage("+prtPageNo+");'>[이전]</a>");
		}

		for(int i=startPage; i<=endPage; i++){
			prtPageNo = i;
			out.print("<a href='javascript:fncGoPage("+prtPageNo+");'>");
			if(currentPage == i){
				out.print("<strong>["+i+"]</strong>");
			}else{
				out.print("["+i+"]");
			}
			out.println("</a>");
		}

		if(numPageGroup < pageGroupCount){
			prtPageNo = (numPageGroup*pageGroupSize+1);
			out.println("<a href='javascript:fncGoPage("+prtPageNo+");'>[다음]</a>");
		}
	}
	//페이징 처리 끝
%>
<br>
</body>
</html>