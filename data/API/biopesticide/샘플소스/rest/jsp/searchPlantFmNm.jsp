<%@page import="java.util.ArrayList"%>
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
<title>식물 검색</title>
<script type="text/javascript">

//검색
function fncSearch(){
	with(document.searchApiForm){
		method="get";
		action = "searchPlantFmNm.jsp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "searchPlantFmNm.jsp";
		target = "_self";
		submit();
	}
}

//화합물 검색
function fncViewSub2(lNo){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		method="get";
		action = "searchPlantFmNm.jsp";
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

//서브 팝업 띄우기
function fncViewSubOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.jsp?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check2=2";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>식물 검색</strong></h3><hr>

<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchPlant";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");
	
	//과명 검색
	if(request.getParameter("fmlNm")!=null&&!request.getParameter("fmlNm").equals("")){
		parameter += "&fmlNm="+request.getParameter("fmlNm");
	}
	//학명 검색
	if(request.getParameter("bneNm")!=null&&!request.getParameter("bneNm").equals("")){
		parameter += "&bneNm="+ request.getParameter("bneNm");
	}
	//국명 검색
	if(request.getParameter("yeastNm")!=null&&!request.getParameter("yeastNm").equals("")){
		parameter += "&yeastNm="+ request.getParameter("yeastNm");
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
	NodeList lvbSeqNos = null;//생물일련번호
	NodeList rnums = null;//순번
	NodeList fmlNms = null;//과명
	NodeList bneNms = null;//학명
	NodeList yeastNms = null;//국명
	NodeList rms = null;//비고
	NodeList antBactrlYns = null;//향균여부
	NodeList insccideYns = null;//살충여부
	NodeList weedngYns = null;//제초여부
	NodeList mapngCnts = null;//화합물 건수
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	lvbSeqNos = doc.getElementsByTagName("lvbSeqNo");
	rnums = doc.getElementsByTagName("rnum");
	fmlNms = doc.getElementsByTagName("fmlNm");
	bneNms = doc.getElementsByTagName("bneNm");
	yeastNms = doc.getElementsByTagName("yeastNm");
	rms = doc.getElementsByTagName("rm");
	antBactrlYns = doc.getElementsByTagName("antBactrlYn");
	insccideYns = doc.getElementsByTagName("insccideYn");
	weedngYns = doc.getElementsByTagName("weedngYn");
	mapngCnts = doc.getElementsByTagName("mapngCnt");
	
	
	if(size==0){
%>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
%>
	<form name="searchApiForm">
	<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
	<input type="hidden" name="lvbSeqNo">

	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
			<td width="85%">
				과명&nbsp;<select name="fmlNm">
					<option value="">선택하세요</option>
<%
						apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
						serviceName="biopesticide";
						serviceAction="searchPlantFmNm";
						
						//XML 받을 URL 생성
						parameter = "/"+serviceName+"/"+serviceAction;
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
						NodeList sub_fmlNms = null;
						NodeList sub_fmlSeqNos = null;
						
						sub_items = sub_doc.getElementsByTagName("item");
						sub_size = sub_doc.getElementsByTagName("item").getLength();
						sub_fmlNms = sub_doc.getElementsByTagName("fmlNm");
						sub_fmlSeqNos = sub_doc.getElementsByTagName("fmlSeqNo");
						
						for(int i=0; i<sub_size; i++){
							String sub_fmlNm = sub_fmlNms.item(i).getFirstChild() == null ? "" : sub_fmlNms.item(i).getFirstChild().getNodeValue(); 
							String sub_fmlSeqNo = sub_fmlSeqNos.item(i).getFirstChild() == null ? "" : sub_fmlSeqNos.item(i).getFirstChild().getNodeValue();

%>
					<option value="<%=sub_fmlNm%>" <%=request.getParameter("fmlNm")!=null && request.getParameter("fmlNm").equals(sub_fmlNm)?"selected":""%>><%=sub_fmlNm%></option>
<%
						}
%>					
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
				학명&nbsp;<input type="text" name="bneNm" value="<%=request.getParameter("bneNm")==null?"":request.getParameter("bneNm")%>">&nbsp;&nbsp;&nbsp;&nbsp;
				국명&nbsp;<input type="text" name="yeastNm" value="<%=request.getParameter("yeastNm")==null?"":request.getParameter("yeastNm")%>">&nbsp;&nbsp;&nbsp;&nbsp;
				비고&nbsp;<input type="text" name="rm" value="<%=request.getParameter("rm")==null?"":request.getParameter("rm")%>">&nbsp;&nbsp;&nbsp;&nbsp;
		    </td>
		    <td width="15%" align="right">
				<input type="button" name="search" value="조회" onclick="fncSearch();"/>
		    </td>
		</tr>
		<tr>		
			<td>
				살균&nbsp;<input type="checkbox" name="antBactrlYn" value="Y" <%=request.getParameter("antBactrlYn")!=null && request.getParameter("antBactrlYn").equals("Y")?"checked":""%>>&nbsp;&nbsp;&nbsp;&nbsp;
				살충&nbsp;<input type="checkbox" name="insccideYn" value="Y" <%=request.getParameter("insccideYn")!=null && request.getParameter("insccideYn").equals("Y")?"checked":""%>>&nbsp;&nbsp;&nbsp;&nbsp;
				제초&nbsp;<input type="checkbox" name="weedngYn" value="Y" <%=request.getParameter("weedngYn")!=null && request.getParameter("insccideYn").equals("Y")?"checked":""%>>&nbsp;&nbsp;&nbsp;&nbsp;
		    </td>
		</tr>			
	</table>
	</form>
	
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="20%"/>
			<col width="35%"/>
			<col width="10%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>화합물</th>

		</tr>
<%
		for(int i=0; i<size; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue(); 
			String fmlNm = fmlNms.item(i).getFirstChild() == null ? "" : fmlNms.item(i).getFirstChild().getNodeValue();
			String bneNm = bneNms.item(i).getFirstChild() == null ? "" : bneNms.item(i).getFirstChild().getNodeValue();
			String yeastNm = yeastNms.item(i).getFirstChild() == null ? "" : yeastNms.item(i).getFirstChild().getNodeValue();
			String rm = rms.item(i).getFirstChild() == null ? "" : rms.item(i).getFirstChild().getNodeValue();
			String antBactrlYn = antBactrlYns.item(i).getFirstChild() == null ? "" : antBactrlYns.item(i).getFirstChild().getNodeValue();
			String insccideYn = insccideYns.item(i).getFirstChild() == null ? "" : insccideYns.item(i).getFirstChild().getNodeValue();
			String weedngYn = weedngYns.item(i).getFirstChild() == null ? "" : weedngYns.item(i).getFirstChild().getNodeValue();
			String mapngCnt = mapngCnts.item(i).getFirstChild() == null ? "" : mapngCnts.item(i).getFirstChild().getNodeValue();
			String lvbSeqNo = lvbSeqNos.item(i).getFirstChild() == null ? "" : lvbSeqNos.item(i).getFirstChild().getNodeValue();
%>
		<tr>
			<td align="center"><%=rnum%></td>
			<td align="center"><%=fmlNm%></td>
			<td align="center"><%=bneNm%></td>
			<td align="center"><%=yeastNm%></td>
			<td align="center"><%=rm%></td>
			<td align="center">
			<%if(antBactrlYn.equals("Y")){%>
				<a href="#" onclick="fncListOpen('<%=lvbSeqNo%>','106001')"><%=antBactrlYn%></a>
			<%}%>
			</td>
			<td align="center">
			<%if(insccideYn.equals("Y")){%>
				<a href="#" onclick="fncListOpen('<%=lvbSeqNo%>','106002')"><%=insccideYn%></a>
			<%}%>
			</td>
			<td align="center">
			<%if(weedngYn.equals("Y")){%>
				<a href="#" onclick="fncListOpen('<%=lvbSeqNo%>','106003')"><%=weedngYn%></a>
			<%}%>
			</td>
			<td align="center"><a href="javascript:fncViewSub2('<%=lvbSeqNo%>')"><%=mapngCnt%></a></td>

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
<br>
<%
if(request.getParameter("lvbSeqNo")!=null && !request.getParameter("lvbSeqNo").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchPlantOnccp";
	
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&lvbNo="+request.getParameter("lvbSeqNo");
	parameter += "&fmlNm="+request.getParameter("fmlNm");
	parameter += "&bneNm="+request.getParameter("bneNm");
	parameter += "&pageNo="+request.getParameter("pageNo");

	//리스트 서버와 통신
	URL listApiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream listApiStream = listApiUrl.openStream();
	
	Document listDoc = null;
	try{
		//xml document
		listDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(listApiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		listApiStream.close();
	}
	
	int listSize = 0;
	
	NodeList listItems = null;
	NodeList rnums = null;//순번
	NodeList onccpSeqNos = null;//유기화합물_일련_번호
	NodeList onccpNms = null;//유기화합물_명
	NodeList elmnWrds = null;//요소(要素)_단어
	NodeList intltshSeCodeNms = null;//계열_구분_코드명
	NodeList rms = null;//비고
	NodeList antBactrlYns = null;//항균여부
	NodeList insccideYns = null;//살충여부
	NodeList weedngYns = null;//제초여부
	NodeList referltrtreCnts = null;//참고문헌 수
	
	listItems = listDoc.getElementsByTagName("item");
	listSize = listDoc.getElementsByTagName("item").getLength();
	
	rnums = listDoc.getElementsByTagName("rnum");
	onccpSeqNos = listDoc.getElementsByTagName("onccpSeqNo");
	onccpNms = listDoc.getElementsByTagName("onccpNm");
	elmnWrds = listDoc.getElementsByTagName("elmnWrd");
	intltshSeCodeNms = listDoc.getElementsByTagName("intltshSeCodeNm");
	rms = listDoc.getElementsByTagName("rm");
	antBactrlYns = listDoc.getElementsByTagName("antBactrlYn");
	insccideYns = listDoc.getElementsByTagName("insccideYn");
	weedngYns = listDoc.getElementsByTagName("weedngYn");
	referltrtreCnts = listDoc.getElementsByTagName("referltrtreCnt");

	if(listSize==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="15%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>NO</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>계열</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>기타</th>
			<th>참고문헌</th>
		</tr>
		
<%
		for(int i=0; i<listSize; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue();
			String onccpSeqNo = onccpSeqNos.item(i).getFirstChild() == null ? "" : onccpSeqNos.item(i).getFirstChild().getNodeValue();
			String onccpNm = onccpNms.item(i).getFirstChild() == null ? "" : onccpNms.item(i).getFirstChild().getNodeValue();
			String elmnWrd = elmnWrds.item(i).getFirstChild() == null ? "" : elmnWrds.item(i).getFirstChild().getNodeValue();
			String intltshSeCodeNm = intltshSeCodeNms.item(i).getFirstChild() == null ? "" : intltshSeCodeNms.item(i).getFirstChild().getNodeValue();
			String rm = rms.item(i).getFirstChild() == null ? "" : rms.item(i).getFirstChild().getNodeValue();
			String antBactrlYn = antBactrlYns.item(i).getFirstChild() == null ? "" : antBactrlYns.item(i).getFirstChild().getNodeValue();
			String insccideYn = insccideYns.item(i).getFirstChild() == null ? "" : insccideYns.item(i).getFirstChild().getNodeValue();
			String weedngYn = weedngYns.item(i).getFirstChild() == null ? "" : weedngYns.item(i).getFirstChild().getNodeValue();
			String referltrtreCnt = referltrtreCnts.item(i).getFirstChild() == null ? "" : referltrtreCnts.item(i).getFirstChild().getNodeValue();

%>
		<tr>
		    <td><%=rnum%></td>
   			<td><%=onccpNm%></td>
   			<td><%=elmnWrd%></td>
   			<td><%=intltshSeCodeNm%></td>
			<td align="center">
			<%if(antBactrlYn.equals("Y")){%>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','106001')"><%=antBactrlYn%></a>
			<%}%>
			</td>
			<td align="center">
			<%if(insccideYn.equals("Y")){%>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','106002')"><%=insccideYn%></a>
			<%}%>
			</td>
			<td align="center">
			<%if(weedngYn.equals("Y")){%>
				<a href="#" onclick="fncViewSubOpen('<%=onccpSeqNo%>','106003')"><%=weedngYn%></a>
			<%}%>
			</td>
   			<td><%=rm%></td>
   			<td><%=referltrtreCnt%></td>
		</tr>
<%		
		}
%>
	</table>
<%
	}
}
%>
</body>
</html>