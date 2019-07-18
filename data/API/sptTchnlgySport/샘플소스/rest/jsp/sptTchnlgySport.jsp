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
<title>현장기술지원</title>
<script type="text/javascript">
//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "sptTchnlgySport_D.jsp";
		target = "_self";
		submit();
	}
}

//검색
function fncSearch(){
	with(document.searchApiForm){
		if(searchword.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        searchword.focus();
	        return false;
	    }else{
	    	pageNo.value = "1";
			method="get";
			action = "sptTchnlgySport.jsp";
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
		action = "sptTchnlgySport.jsp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>현장기술지원</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>

<%String searchtype = request.getParameter("searchtype")==null?"":request.getParameter("searchtype");%>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<select name="searchtype">
	<option value="1" <%=searchtype.equals("1")?"selected":""%>>제목</option>
	<option value="2" <%=searchtype.equals("2")?"selected":""%>>작성자</option>
	<option value="3" <%=searchtype.equals("3")?"selected":""%>>품목</option>
	<option value="4" <%=searchtype.equals("4")?"selected":""%>>내용</option>
</select>
<input type="text" name="searchword" value="<%=request.getParameter("searchword")==null?"":request.getParameter("searchword")%>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="nongsaroSampleKey"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	String serviceName="sptTchnlgySport";
	//오퍼레이션 명
	String operationName="sptTchnlgySportList";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");

	//검색 조건
	if(request.getParameter("searchtype")!=null&&!request.getParameter("searchtype").equals("")){
		parameter += "&searchtype="+ request.getParameter("searchtype");
	}
	//검색어
	if(request.getParameter("searchword")!=null&&!request.getParameter("searchword").equals("")){
		parameter += "&searchword="+ URLEncoder.encode(request.getParameter("searchword"));
	}

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
	NodeList cntntsNos = null;
	NodeList cntntsSjs = null;
	NodeList regDts = null;
	NodeList rdcnts = null;
	NodeList wrterNms = null;
	NodeList prdlstCodeNms = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	cntntsSjs = doc.getElementsByTagName("cntntsSj");
	regDts = doc.getElementsByTagName("regDt");
	rdcnts = doc.getElementsByTagName("rdcnt");
	wrterNms = doc.getElementsByTagName("wrterNm");
	prdlstCodeNms = doc.getElementsByTagName("prdlstCodeNm");

	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{ %>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="10%"/>
			<col width="45%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>품목</th>
			<th>제목</th>
			<th>작성자</th>
			<th>기술지원일</th>
			<th>조회수</th>
		</tr>
<%
		for(int i=0; i<size; i++){
			//키값
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			//제목
			String cntntsSj = cntntsSjs.item(i).getFirstChild() == null ? "" : cntntsSjs.item(i).getFirstChild().getNodeValue();
			//기술지원일
			String regDt = regDts.item(i).getFirstChild() == null ? "" : regDts.item(i).getFirstChild().getNodeValue();
			//조회수
			String rdcnt = rdcnts.item(i).getFirstChild() == null ? "" : rdcnts.item(i).getFirstChild().getNodeValue();
			//작성자
			String wrterNm = wrterNms.item(i).getFirstChild() == null ? "" : wrterNms.item(i).getFirstChild().getNodeValue();
			//품목
			String prdlstCodeNm = prdlstCodeNms.item(i).getFirstChild() == null ? "" : prdlstCodeNms.item(i).getFirstChild().getNodeValue();
%>
		<tr>
			<td align="center"><%=prdlstCodeNm%></td>
			<td><a href="javascript:;move('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
			<td align="center"><%=wrterNm%></td>
			<td align="center"><%=regDt%></td>
			<td align="center"><%=rdcnt%></td>
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