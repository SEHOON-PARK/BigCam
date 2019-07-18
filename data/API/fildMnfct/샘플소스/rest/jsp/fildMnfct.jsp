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
<title>텃밭가꾸기</title>
<script type="text/javascript">
//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "fildMnfct_D.jsp";
		target = "_self";
		submit();
	}
}

//검색
function fncSearch(){
	with(document.searchApiForm){
		if(sText.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        sText.focus();
	        return false;
	    }else{
	    	pageNo.value = "1";
			method="get";
			action = "fildMnfct.jsp";
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
		action = "fildMnfct.jsp";
		target = "_self";
		submit();
	}
}

function fncTabChg(type){
	with(document.searchApiForm){
		pageNo.value = "1";
		sSeCode.value=type;
		method="get";
		action = "fildMnfct.jsp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>텃밭가꾸기</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>

<%
String sType = request.getParameter("sType")==null?"":request.getParameter("sType");
String sSeCode = request.getParameter("sSeCode")==null?"335001":request.getParameter("sSeCode");
%>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<input type="hidden" name="sSeCode" value="<%=sSeCode%>">

<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">
		<a href="javascript:fncTabChg('335001');">  <% if ( sSeCode.equals("335001")) { %> <strong>채소</strong> <% }else{ %>채소<%} %> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('335002');">  <% if ( sSeCode.equals("335002")) { %> <strong>과수</strong> <% }else{ %>과수<%} %> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('335003');">  <% if ( sSeCode.equals("335003")) { %> <strong>인삼약초버섯</strong> <% }else{ %>인삼약초버섯<%} %> </a>
	</td>
</tr>
</table>


<select name="sType">
	<option value="sCntntsSj" <%=sType.equals("sCntntsSj")?"selected":""%>>제목</option>
	<option value="sWriteNm" <%=sType.equals("sWriteNm")?"selected":""%>>작성자</option>
	<option value="sQuestDtl" <%=sType.equals("sQuestDtl")?"selected":""%>>내용</option>
</select>
<input type="text" name="sText" value="<%=request.getParameter("sText")==null?"":request.getParameter("sText")%>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	String serviceName="fildMnfct";
	//오퍼레이션 명
	String operationName="fildMnfctList";

	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");
	parameter += "&sSeCode="+sSeCode;

	//검색 조건
	if(request.getParameter("sType")!=null&&!request.getParameter("sType").equals("")){
		parameter += "&sType="+ request.getParameter("sType");
	}
	//검색어
	if(request.getParameter("sText")!=null&&!request.getParameter("sText").equals("")){
		parameter += "&sText="+ URLEncoder.encode(request.getParameter("sText"));
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

	NodeList cntntsRdcnts = null;
	NodeList updusrEsntlNms = null;


	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	cntntsSjs = doc.getElementsByTagName("cntntsSj");
	cntntsRdcnts = doc.getElementsByTagName("cntntsRdcnt");
	updusrEsntlNms = doc.getElementsByTagName("updusrEsntlNm");


	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{ %>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col/>
			<col style="width:12%" />
			<col style="width:8%" />
		</colgroup>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
<%
		for(int i=0; i<size; i++){
			//키값
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			//제목
			String cntntsSj = cntntsSjs.item(i).getFirstChild() == null ? "" : cntntsSjs.item(i).getFirstChild().getNodeValue();
			//조회수
			String cntntsRdcnt = cntntsRdcnts.item(i).getFirstChild() == null ? "" : cntntsRdcnts.item(i).getFirstChild().getNodeValue();
			//작성자
			String updusrEsntlNm = updusrEsntlNms.item(i).getFirstChild() == null ? "" : updusrEsntlNms.item(i).getFirstChild().getNodeValue();

%>
		<tr>
			<td><a href="javascript:;move('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
			<td align="center"><%=updusrEsntlNm%></td>
			<td align="center"><%=cntntsRdcnt%></td>
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