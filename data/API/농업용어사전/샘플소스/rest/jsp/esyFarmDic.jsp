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
<title>알기쉬운농업용어</title>
<script type="text/javascript">
//검색하기
function dicSearch(cCode){
	with(document.searchApiForm){
		if(keyword.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        keyword.focus();
	        return false;
	    }else{
			method="get";
			action = "esyFarmDic.jsp";
			target = "_self";
			submit();
		}
	}
}

//일치검색 상세보기
function equalDetail(lCode, lNm, wNm, wNo){
	with(document.equalApiForm){
		langCode.value=lCode;
		langNm.value=lNm;
		wordNm.value=wNm;
		wordNo.value=wNo;
		method="get";
		action = "esyFarmDic.jsp";
		target = "_self";
		submit();
	}
}

//전방검색 상세보기
function frontDetail(lCode, lNm, wNm, wNo){
	with(document.frontApiForm){
		langCode.value=lCode;
		langNm.value=lNm;
		wordNm.value=wNm;
		wordNo.value=wNo;
		method="get";
		action = "esyFarmDic.jsp";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "esyFarmDic.jsp";
		target = "_self";
		submit();
	}
}

// 시소로스 팝업 띄우기
function fncThesaurusOpen(faoCodeVal){
	var popupUrl="thesaurusPoP.jsp?faoCode="+faoCodeVal;
	var popOption="width=800,height=600";

	window.open(popupUrl,"nongsaroPop",popOption);
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>알기쉬운농업용어</strong> | <strong><a href="farmDic.jsp">농업용어사전</a></strong></h3>
<hr>
<form name="searchApiForm"><!-- 검색폼 -->
용&nbsp;어 : <input type="text" name="keyword" value="<%
	if(request.getParameter("keyword")!=null && !request.getParameter("keyword").equals(""))
		out.print(request.getParameter("keyword"));
	else out.print("");
%>">
<input type="button" name="confirm" value="검색" onclick="return dicSearch()">
<input type="hidden" name="pageNo">
</form>

<form name="equalApiForm"><!-- 일치항목 선택시 폼 -->
<input type="hidden" name="keyword" value="<%=request.getParameter("keyword")%>">
<input type="hidden" name="equalSearchType" value="<%=request.getParameter("equalSearchType")%>">
<input type="hidden" name="langCode" value="<%=request.getParameter("langCode")%>">
<input type="hidden" name="langNm" value="<%=request.getParameter("langNm")%>">
<input type="hidden" name="wordNm" value="<%=request.getParameter("wordNm")%>">
<input type="hidden" name="wordNo" value="<%=request.getParameter("wordNo")%>">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<input type="hidden" name="wordType" value="B">
</form>

<form name="frontApiForm"><!-- 전방검색항목 선택시 폼 -->
<input type="hidden" name="keyword" value="<%=request.getParameter("keyword")%>">
<input type="hidden" name="frontSearchType" value="<%=request.getParameter("frontSearchType")%>">
<input type="hidden" name="langCode" value="<%=request.getParameter("langCode")%>">
<input type="hidden" name="langNm" value="<%=request.getParameter("langNm")%>">
<input type="hidden" name="wordNm" value="<%=request.getParameter("wordNm")%>">
<input type="hidden" name="wordNo" value="<%=request.getParameter("wordNo")%>">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<input type="hidden" name="wordType" value="B">
</form>

<!--======================================================== 일치항목 부분 시작 ==================================================================-->
<%
if(request.getParameter("keyword")!=null && !request.getParameter("keyword").equals("")){
	out.println("<hr><h4>▷검색어 일치항목◁</h4>");

	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="searchEqualWord";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&word="+ request.getParameter("keyword");
	parameter += "&wordType=B";

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	Document doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	int size = 0;

	NodeList items = null;
	NodeList langCodes = null;
	NodeList langNms = null;
	NodeList wordNms = null;
	NodeList wordNos = null;
	NodeList faoCodes = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	langCodes = doc.getElementsByTagName("langCode");
	langNms = doc.getElementsByTagName("langNm");
	wordNms = doc.getElementsByTagName("wordNm");
	wordNos = doc.getElementsByTagName("wordNo");
	faoCodes = doc.getElementsByTagName("faoCode");

	if(size==0){
%>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<%
	}else{
%>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="25%"/>
			<col width="75%"/>
		</colgroup>
		<tr valign="top">
			<td>
<%
		for(int i=0; i<size; i++){
			//언어 구분 코드
			String langCode = langCodes.item(i).getFirstChild() == null ? "" : langCodes.item(i).getFirstChild().getNodeValue();
			//언어 구분 명
			String langNm = langNms.item(i).getFirstChild() == null ? "" : langNms.item(i).getFirstChild().getNodeValue();
			//용어 명
			String wordNm = wordNms.item(i).getFirstChild() == null ? "" : wordNms.item(i).getFirstChild().getNodeValue();
			//농업 용어 번호
			String wordNo = wordNos.item(i).getFirstChild() == null ? "" : wordNos.item(i).getFirstChild().getNodeValue();
			//시소러스 번호
			String faoCode = faoCodes.item(i).getFirstChild() == null ? "" : faoCodes.item(i).getFirstChild().getNodeValue();
%>
				<a href="javascript:equalDetail('<%=langCode%>','<%=langNm%>','<%=wordNm%>','<%=wordNo%>');"><%=wordNm%></a>&nbsp;[<%=langNm%>]
				<% if(!faoCode.equals("") && faoCode != null) {%>
				<button type="button" onclick="javascript:fncThesaurusOpen('<%=faoCode%>')">시소러스정보</button>
				<% } %>
				<br>
<%
		}
	}
%>
			</td>
<%
}
%>
			<td>
<%

//[일치검색] 해당 단어의 용어 설명
if(request.getParameter("equalSearchType")!=null && !request.getParameter("equalSearchType").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="detailWord";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&wordNo="+ request.getParameter("wordNo");
	parameter += "&wordType=B";

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	Document doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	int size = 0;

	NodeList items = null;
	NodeList farmngWordNos = null;
	NodeList wordDcs = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	farmngWordNos = doc.getElementsByTagName("farmngWordNo");
	wordDcs = doc.getElementsByTagName("wordDc");

	//농업 용어 번호
	String farmngWordNo = farmngWordNos.item(0).getFirstChild() == null ? "" : farmngWordNos.item(0).getFirstChild().getNodeValue();
	//용어 설명
	String wordDc = wordDcs.item(0).getFirstChild() == null ? "" : wordDcs.item(0).getFirstChild().getNodeValue();
%>
			<table width="100%" border="0" rules="rows" cellSpacing="0" cellPadding="0">
				<colgroup>
					<col width="15%"/>
					<col width="85%"/>
				</colgroup>
				<tr valign="top">
					<td><strong>용어 설명</strong></td>
					<td><%=wordDc %></td>
				</tr>
				<tr valign="top">
					<td><strong>유사 용어</strong></td>
					<td>
<%

}
//[일치검색] 해당 단어의 유사 용어
if(request.getParameter("equalSearchType")!=null && !request.getParameter("equalSearchType").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="detailLikeWordList";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&wordNo="+ request.getParameter("wordNo");
	parameter += "&wordNm="+ request.getParameter("wordNm");
	parameter += "&wordType=B";

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	Document doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	int size = 0;

	NodeList items = null;
	NodeList langNms = null;
	NodeList wordNms = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	langNms = doc.getElementsByTagName("langNm");
	wordNms = doc.getElementsByTagName("wordNm");

	if(size==0){
%>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<%
	}else{
		for(int i=0; i<size; i++){
			//언어 구분 명
			String langNm = langNms.item(i).getFirstChild() == null ? "" : langNms.item(i).getFirstChild().getNodeValue();
			//용어 명
			String wordNm = wordNms.item(i+1).getFirstChild() == null ? "" : wordNms.item(i+1).getFirstChild().getNodeValue();

%>
					[<%=langNm %>]&nbsp;&nbsp;<%=wordNm %><br>
<%
		}
	}
%>
					</td>
				</tr>
			</table>
<%
}
if(request.getParameter("keyword")!=null && !request.getParameter("keyword").equals("")){%>
		</td>
	</tr>
</table>
<%}%>

<!--======================================================== 일치항목 부분 끝 ==================================================================-->

<!--======================================================== 전방검색 부분  시작 ==================================================================-->
<hr>
<%if(request.getParameter("keyword")!=null && !request.getParameter("keyword").equals("")){%>
<h4>▷검색어 전방일치항목◁</h4>
<%}%>

<%

Document frontDoc = null;
if(request.getParameter("keyword")!=null && !request.getParameter("keyword").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="searchFrontMatch";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&word="+ request.getParameter("keyword");
	parameter += "&pageNo="+request.getParameter("pageNo");
	parameter += "&wordType=B";

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	try{
		//xml document
		frontDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	int size = 0;

	NodeList items = null;
	NodeList langCodes = null;
	NodeList langNms = null;
	NodeList wordNms = null;
	NodeList wordNos = null;
	NodeList faoCodes = null;

	items = frontDoc.getElementsByTagName("item");
	size = frontDoc.getElementsByTagName("item").getLength();
	langCodes = frontDoc.getElementsByTagName("langCode");
	langNms = frontDoc.getElementsByTagName("langNm");
	wordNms = frontDoc.getElementsByTagName("wordNm");
	wordNos = frontDoc.getElementsByTagName("wordNo");
	faoCodes = frontDoc.getElementsByTagName("faoCode");

	if(size==0){
%>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<%
	}else{
%>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="25%"/>
			<col width="75%"/>
		</colgroup>
		<tr valign="top">
			<td>
<%
		for(int i=0; i<size; i++){
			//언어 구분 코드
			String langCode = langCodes.item(i).getFirstChild() == null ? "" : langCodes.item(i).getFirstChild().getNodeValue();
			//언어 구분 명
			String langNm = langNms.item(i).getFirstChild() == null ? "" : langNms.item(i).getFirstChild().getNodeValue();
			//용어 명
			String wordNm = wordNms.item(i).getFirstChild() == null ? "" : wordNms.item(i).getFirstChild().getNodeValue();
			//농업 용어 번호
			String wordNo = wordNos.item(i).getFirstChild() == null ? "" : wordNos.item(i).getFirstChild().getNodeValue();
			//시소러스 번호
			String faoCode = faoCodes.item(i).getFirstChild() == null ? "" : faoCodes.item(i).getFirstChild().getNodeValue();
%>
			<a href="javascript:frontDetail('<%=langCode%>','<%=langNm%>','<%=request.getParameter("keyword")%>','<%=wordNo%>');"><%=wordNm%></a>&nbsp;[<%=langNm%>]
			<% if(!faoCode.equals("") && faoCode != null) {%>
			<button type="button" onclick="javascript:fncThesaurusOpen('<%=faoCode%>')">시소러스정보</button>
			<% } %>
			<br>
<%
		}
	}
%>
			</td>
<%
}
%>
			<td>
<%

//[전방검색] 해당 단어의 용어 설명
if(request.getParameter("frontSearchType")!=null && !request.getParameter("frontSearchType").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="detailWord";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&wordNo="+ request.getParameter("wordNo");
	parameter += "&wordType=B";

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	Document doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	int size = 0;

	NodeList items = null;
	NodeList farmngWordNos = null;
	NodeList wordDcs = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	farmngWordNos = doc.getElementsByTagName("farmngWordNo");
	wordDcs = doc.getElementsByTagName("wordDc");

	//농업 용어 번호
	String farmngWordNo = farmngWordNos.item(0).getFirstChild() == null ? "" : farmngWordNos.item(0).getFirstChild().getNodeValue();
	//용어 설명
	String wordDc = wordDcs.item(0).getFirstChild() == null ? "" : wordDcs.item(0).getFirstChild().getNodeValue();
%>
			<table width="100%" border="0" rules="rows" cellSpacing="0" cellPadding="0">
				<colgroup>
					<col width="15%"/>
					<col width="85%"/>
				</colgroup>
				<tr valign="top">
					<td><strong>용어 설명</strong></td>
					<td><%=wordDc %></td>
				</tr>
				<tr valign="top">
					<td><strong>유사 용어</strong></td>
					<td>
<%
}
//[전방검색] 해당 단어의 유사 용어
if(request.getParameter("frontSearchType")!=null && !request.getParameter("frontSearchType").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey";
	//서비스 명
	String serviceName="farmDic";
	//오퍼레이션 명
	String operationName="detailLikeWordList";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&wordNo="+ request.getParameter("wordNo");
	parameter += "&wordNm="+ request.getParameter("wordNm");
	parameter += "&wordType=B";

	//서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();

	Document doc = null;
	try{
		//xml document
		doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}

	int size = 0;

	NodeList items = null;
	NodeList langNms = null;
	NodeList wordNms = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	langNms = doc.getElementsByTagName("langNm");
	wordNms = doc.getElementsByTagName("wordNm");
%>
<%	if(size==0){ %>
<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<%	}else{
		for(int i=0; i<size; i++){
			//언어 구분 명
			String langNm1 = langNms.item(i).getFirstChild() == null ? "" : langNms.item(i).getFirstChild().getNodeValue();
			//용어 명
			String wordNm1 = wordNms.item(i+1).getFirstChild() == null ? "" : wordNms.item(i+1).getFirstChild().getNodeValue();
%>
		[<%=langNm1 %>]&nbsp;&nbsp;<%=wordNm1 %><br>
<%
		}
	}
%>
					</td>
				</tr>
			</table>
<%
}
if(request.getParameter("keyword")!=null && !request.getParameter("keyword").equals("")){%>
		</td>
	</tr>
</table>
<%
//페이징 처리
	//한 페이지에 제공할 건수
	String numOfRows = "";
	//조회된  총 건수
	String totalCount = "";
	//조회할 페이지 번호
	String pageNo = "";
	try{numOfRows = frontDoc.getElementsByTagName("numOfRows").item(0).getFirstChild().getNodeValue();}catch(Exception e){numOfRows = "";}
	try{totalCount = frontDoc.getElementsByTagName("totalCount").item(0).getFirstChild().getNodeValue();}catch(Exception e){totalCount = "";}
	try{pageNo = frontDoc.getElementsByTagName("pageNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){pageNo = "";}

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
	int count = Integer.parseInt( totalCount);
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
}
%>
<!--======================================================== 전방검색 부분 끝 ==================================================================-->

</body>
</html>