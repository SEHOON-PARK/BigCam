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
<title>사료 검색</title>
<script type="text/javascript">
//상세보기
function fncDtl(hNo){
	with(document.apiForm){
		hsrrlManageNo.value = hNo;
		method="get";
		action = "feedSearchDtl.jsp";
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
			method="get";
			action = "feedSearchList.jsp";
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
		action = "feedSearchList.jsp";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>사료 검색</strong></h3>
<hr>
<% String sType = request.getParameter("sType")==null?"":request.getParameter("sType"); %>
<form name="apiForm">
	<input type="hidden" name="hsrrlManageNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<select name="sType"> 
	<option value="sAll" <%=sType.equals("sAll")?"selected":""%>>전체</option>
	<option value="sKoreanNm" <%=sType.equals("sKoreanNm")?"selected":""%>>한글명</option>
	<option value="sEngNm" <%=sType.equals("sEngNm")?"selected":""%>>영문명</option>
	<option value="sHsrrlNo" <%=sType.equals("sHsrrlNo")?"selected":""%>>사료번호</option>
</select> 
<input type="text" name="sText" value="<%=request.getParameter("sText")==null?"":request.getParameter("sText")%>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>
<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="발급받은인증키를입력하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	String serviceName="feedSearch";
	//오퍼레이션 명
	String operationName="feedSearchList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");
	
	//검색 조건
	if(request.getParameter("sType")!=null&&!request.getParameter("sType").equals("")){
		parameter += "&sType="+ request.getParameter("sType");
	}
	//검색어
	if(request.getParameter("sText")!=null&&!request.getParameter("sText").equals("")){
		parameter += "&sText="+ request.getParameter("sText");
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
	NodeList hsrrlManageNos = null;
	NodeList hsrrlNos = null;
	NodeList koreanNms = null;
	NodeList engNms = null;
	NodeList hsrrlPrdlstCodeLclasNms = null;
		
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	hsrrlManageNos = doc.getElementsByTagName("hsrrlManageNo");
	hsrrlNos = doc.getElementsByTagName("hsrrlNo");
	koreanNms = doc.getElementsByTagName("koreanNm");
	engNms = doc.getElementsByTagName("engNm");
	hsrrlPrdlstCodeLclasNms = doc.getElementsByTagName("hsrrlPrdlstCodeLclasNm");

	String resultCode="";
	String resultMsg="";
	try{resultCode = doc.getElementsByTagName("resultCode").item(0).getFirstChild().getNodeValue();}catch(Exception e){resultCode = "";}
	try{resultMsg = doc.getElementsByTagName("resultMsg").item(0).getFirstChild().getNodeValue();}catch(Exception e){resultMsg = "";}

	if(resultCode.equals("00")){ %>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="35%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>한글 사료명</th>
			<th>영문 사료명</th>
			<th>사료군</th>
			<th>사료번호</th>
		</tr>
<%
		if(size==0){
%>
		<tr>
			<td colspan="4" align="center">조회한 정보가 없습니다.</td>
		</tr>
<% 			
		}else{
			
			for(int i=0; i<size; i++){
				//사료 관리 번호
				String hsrrlManageNo = hsrrlManageNos.item(i).getFirstChild() == null ? "" : hsrrlManageNos.item(i).getFirstChild().getNodeValue();
				//사료번호
				String hsrrlNo = hsrrlNos.item(i).getFirstChild() == null ? "" : hsrrlNos.item(i).getFirstChild().getNodeValue();
				//한글 사료명
				String koreanNm = koreanNms.item(i).getFirstChild() == null ? "" : koreanNms.item(i).getFirstChild().getNodeValue();
				//영문 사료명
				String engNm = engNms.item(i).getFirstChild() == null ? "" : engNms.item(i).getFirstChild().getNodeValue();
				//사료 품목 명
				String hsrrlPrdlstCodeLclasNm = hsrrlPrdlstCodeLclasNms.item(i).getFirstChild() == null ? "" : hsrrlPrdlstCodeLclasNms.item(i).getFirstChild().getNodeValue(); 
%>
		<tr>
			<td align="center"><a href="javascript:fncDtl('<%=hsrrlManageNo%>');"><%=koreanNm%></a></td>
			<td align="center"><%=engNm%></td>
			<td align="center"><%=hsrrlPrdlstCodeLclasNm%></td>
			<td align="center"><%=hsrrlNo%></td>
		</tr>
<%		
			}
		}
%>
	</table>
<%

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
	}else{
		out.print(resultMsg);
	}
%>
<br>
</body>
</html>