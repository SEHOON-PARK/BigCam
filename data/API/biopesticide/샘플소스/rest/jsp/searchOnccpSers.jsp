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
<title>화합물 검색</title>
<script type="text/javascript">

//검색
function fncSearch(){
	with(document.searchApiForm){
		method="get";
		action = "searchOnccpSers.jsp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "searchOnccpSers.jsp";
		target = "_self";
		submit();
	}
}

//화합물 검색
function fncViewSub2(lNo){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		method="get";
		action = "searchOnccpSers.jsp";
		target = "_self";
		submit();
	}
}

//팝업 띄우기
function fncListOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.jsp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check1=1";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

//참고문헌 팝업 띄우기
function fncViewSubOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.jsp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check2=2";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

//생물자원 팝업 띄우기
function fncViewOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.jsp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check3=3";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 검색</strong></h3><hr>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<input type="hidden" name="lvbSeqNo">
<table width="100%" cellSpacing="0" cellPadding="0">
	<tr>
		<td width="85%">
			화합물명&nbsp;<input type="text" name="onccpNm" value="<%=request.getParameter("onccpNm")==null?"":request.getParameter("onccpNm")%>">&nbsp;&nbsp;&nbsp;&nbsp;
			Elements&nbsp;<input type="text" name="elmnWrd" value="<%=request.getParameter("elmnWrd")==null?"":request.getParameter("elmnWrd")%>">&nbsp;&nbsp;&nbsp;&nbsp;
			계열&nbsp;<select name="intltshSe">
				<option value="">선택하세요</option>
<%
					if(true){
						String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
						String serviceName="biopesticide";
						String serviceAction="searchOnccpSers";
						
						//XML 받을 URL 생성
						String parameter = "/"+serviceName+"/"+serviceAction;
						parameter += "?apiKey="+ apiKey;
						
						//서버와 통신
						URL sub_apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
						InputStream sub_apiStream = sub_apiUrl.openStream();
						
						Document sub_doc = null;
						try{
							//xml document
							sub_doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(sub_apiStream);
						}catch(Exception e){
							e.printStackTrace();
						}finally{
							sub_apiStream.close();
						}
						
						int sub_size = 0;
						
						NodeList sub_items = null;
						NodeList sub_codes = null;
						NodeList sub_codeNms = null;
						
						sub_items = sub_doc.getElementsByTagName("item");
						sub_size = sub_doc.getElementsByTagName("item").getLength();
						sub_codes = sub_doc.getElementsByTagName("code");
						sub_codeNms = sub_doc.getElementsByTagName("codeNm");
						
						for(int i=0; i<sub_size; i++){
							String sub_code = sub_codes.item(i).getFirstChild() == null ? "" : sub_codes.item(i).getFirstChild().getNodeValue(); 
							String sub_codeNm = sub_codeNms.item(i).getFirstChild() == null ? "" : sub_codeNms.item(i).getFirstChild().getNodeValue();

%>
					<option value="<%=sub_code%>" <%=request.getParameter("intltshSe")!=null && request.getParameter("intltshSe").equals(sub_code)?"selected":""%>><%=sub_codeNm%></option>
<%
						}
					}
%>					
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	    <td width="15%" align="right">
			<input type="button" name="search" value="조회" onclick="fncSearch();"/>
	    </td>
	</tr>
	<tr>		
		<td colspan="2">
			기타작용기작&nbsp;<input type="text" name="rm" value="<%=request.getParameter("rm")==null?"":request.getParameter("rm")%>">&nbsp;&nbsp;&nbsp;&nbsp;
			참고문헌&nbsp;<input type="text" name="sText" value="<%=request.getParameter("sText")==null?"":request.getParameter("sText")%>">&nbsp;&nbsp;&nbsp;&nbsp;
			살균&nbsp;<input type="checkbox" name="antBactrlYn" value="Y" <%=request.getParameter("antBactrlYn")!=null && request.getParameter("antBactrlYn").equals("Y")?"checked":""%>>&nbsp;&nbsp;&nbsp;&nbsp;
			살충&nbsp;<input type="checkbox" name="insccideYn" value="Y" <%=request.getParameter("insccideYn")!=null && request.getParameter("insccideYn").equals("Y")?"checked":""%>>&nbsp;&nbsp;&nbsp;&nbsp;
			제초&nbsp;<input type="checkbox" name="weedngYn" value="Y" <%=request.getParameter("weedngYn")!=null && request.getParameter("insccideYn").equals("Y")?"checked":""%>>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	</tr>			
</table>
</form>

<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchOnccp";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");
	
	//화합물 검색
	if(request.getParameter("onccpNm")!=null&&!request.getParameter("onccpNm").equals("")){
		parameter += "&onccpNm="+request.getParameter("onccpNm");;
	}
	//Elements 검색
	if(request.getParameter("elmnWrd")!=null&&!request.getParameter("elmnWrd").equals("")){
		parameter += "&elmnWrd="+ request.getParameter("elmnWrd");
	}
	//계열 검색
	if(request.getParameter("intltshSe")!=null&&!request.getParameter("intltshSe").equals("")){
		parameter += "&intltshSe="+ request.getParameter("intltshSe");
	}
	//비고 검색
	if(request.getParameter("rm")!=null&&!request.getParameter("rm").equals("")){
		parameter += "&rm="+ request.getParameter("rm");
	}
	//살균 여부 검색
	if(request.getParameter("antBactrlYn")!=null&&!request.getParameter("antBactrlYn").equals("")){
		parameter += "&antBactrlYn="+ request.getParameter("antBactrlYn");
	}
	//살충 여부 검색
	if(request.getParameter("insccideYn")!=null&&!request.getParameter("insccideYn").equals("")){
		parameter += "&insccideYn="+ request.getParameter("insccideYn");
	}
	//제초 검색
	if(request.getParameter("weedngYn")!=null&&!request.getParameter("weedngYn").equals("")){
		parameter += "&weedngYn="+ request.getParameter("weedngYn");
	}
	
	//메인카테고리 서버와 통신
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
	NodeList rnums = null;//순번
	NodeList onccpNms = null;//화합물명
	NodeList elmnWrds = null;//elements
	NodeList intltshSes = null;//계열
	NodeList antBactrlYns = null;//향균
	NodeList insccideYns = null;//살충
	NodeList weedngYns = null;//제초
	NodeList rms = null;//기타
	NodeList referltrtreCnts = null;//참고문헌
	NodeList lvbCnts = null;//생물자원
	NodeList onccpSeqNos = null;//화합물코드

	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	rnums = doc.getElementsByTagName("rnum");
	onccpNms = doc.getElementsByTagName("onccpNm");
	elmnWrds = doc.getElementsByTagName("elmnWrd");
	intltshSes = doc.getElementsByTagName("intltshSe");
	antBactrlYns = doc.getElementsByTagName("antBactrlYn");
	insccideYns = doc.getElementsByTagName("insccideYn");
	weedngYns = doc.getElementsByTagName("weedngYn");
	rms = doc.getElementsByTagName("rm");
	referltrtreCnts = doc.getElementsByTagName("referltrtreCnt");
	lvbCnts = doc.getElementsByTagName("lvbCnt");
	onccpSeqNos = doc.getElementsByTagName("onccpSeqNo");


	if(size==0){
%>
	<hr>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>계열</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>기타</th>
			<th>참고문헌</th>
			<th>생물자원</th>
		</tr>
<%
		for(int i=0; i<size; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue(); 
			String onccpNm = onccpNms.item(i).getFirstChild() == null ? "" : onccpNms.item(i).getFirstChild().getNodeValue();
			String elmnWrd = elmnWrds.item(i).getFirstChild() == null ? "" : elmnWrds.item(i).getFirstChild().getNodeValue();
			String intltshSe = intltshSes.item(i).getFirstChild() == null ? "" : intltshSes.item(i).getFirstChild().getNodeValue();
			String antBactrlYn = antBactrlYns.item(i).getFirstChild() == null ? "" : antBactrlYns.item(i).getFirstChild().getNodeValue();
			String insccideYn = insccideYns.item(i).getFirstChild() == null ? "" : insccideYns.item(i).getFirstChild().getNodeValue();
			String weedngYn = weedngYns.item(i).getFirstChild() == null ? "" : weedngYns.item(i).getFirstChild().getNodeValue();
			String rm = rms.item(i).getFirstChild() == null ? "" : rms.item(i).getFirstChild().getNodeValue();
			String referltrtreCnt = referltrtreCnts.item(i).getFirstChild() == null ? "" : referltrtreCnts.item(i).getFirstChild().getNodeValue();
			String lvbCnt = lvbCnts.item(i).getFirstChild() == null ? "" : lvbCnts.item(i).getFirstChild().getNodeValue();
			String onccpSeqNo = onccpSeqNos.item(i).getFirstChild() == null ? "" : onccpSeqNos.item(i).getFirstChild().getNodeValue();
%>
		<tr>
			<td align="center"><%=rnum%></td>
			<td align="center"><%=onccpNm%></td>
			<td align="center"><%=elmnWrd%></td>
			<td align="center"><%=intltshSe%></td>
			<td align="center">
			<%if(antBactrlYn.equals("Y")){%>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','')"><%=antBactrlYn%></a>
			<%}%>
			</td>
			<td align="center">
			<%if(insccideYn.equals("Y")){%>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','')"><%=insccideYn%></a>
			<%}%>
			</td>
			<td align="center">
			<%if(weedngYn.equals("Y")){%>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','')"><%=weedngYn%></a>
			<%}%>
			</td>
			<td align="center"><%=rm%></td>
			<td align="center"><a href="javascript:fncViewSubOpen('<%=onccpSeqNo%>','')"><%=referltrtreCnt%></a></td>
			<td align="center">
			<%if(!lvbCnt.equals("0")){%>
				<a href="javascript:fncViewOpen('<%=onccpSeqNo%>')"><%=lvbCnt%></a>
			<%}%>
			</td>

		</tr>
<%		
		}
%>
	</table>
<%
	}
	
	//페이징 처리
	String numOfRows = "";
	String totalCount = "";
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
</body>
</html>