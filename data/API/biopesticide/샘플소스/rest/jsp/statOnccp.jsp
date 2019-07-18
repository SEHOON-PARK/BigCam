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
<title>화합물 통계</title>
<script type="text/javascript">

//검색
function fncSearch(){
	with(document.searchApiForm){
		method="get";
		action = "statOnccp.jsp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "statOnccp.jsp";
		target = "_self";
		submit();
	}
}

//화합물 검색
function fncViewSub2(lNo){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		method="get";
		action = "statOnccp.jsp";
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
<h3><strong>화합물 통계</strong></h3><hr>

<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="statOnccp";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	
	//메인카테고리 서버와 통신
	URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
	InputStream apiStream = apiUrl.openStream();
	
	Document mainDoc = null;
	try{
		//xml document
		mainDoc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		apiStream.close();
	}
	
	int size = 0;
	
	NodeList items = null;

      
	NodeList cntAs=null;       
	NodeList cntBs=null;   
	NodeList cntCs=null;
	NodeList cntDs=null; 
	NodeList cntEs=null; 
	NodeList cntFs=null; 
	NodeList cntGs=null; 
	
	items = mainDoc.getElementsByTagName("item");
	size = mainDoc.getElementsByTagName("item").getLength();
	
	cntAs = mainDoc.getElementsByTagName("cntA");
	cntBs = mainDoc.getElementsByTagName("cntB");
	cntCs = mainDoc.getElementsByTagName("cntC");
	cntDs = mainDoc.getElementsByTagName("cntD");
	cntEs = mainDoc.getElementsByTagName("cntE");
	cntFs = mainDoc.getElementsByTagName("cntF");
	cntGs = mainDoc.getElementsByTagName("cntG");
	
	
	if(size==0){
%>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
		
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		 <colgroup>
			<col width="*" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
		</colgroup>
           <thead>
               <tr>
				<th scope="col" >살균.살충.제초</th>
				<th scope="col" >살균.살충</th>
				<th scope="col" >살균.제초</th>
				<th scope="col" >살충.제초</th>
				<th scope="col" >살균</th>
				<th scope="col" >살충</th>
				<th scope="col" >제초</th>
              </tr>
            </thead>
            <tbody>
                <%
			       for(int i=0; i<size; i++){
						String cntA = cntAs.item(i).getFirstChild() == null ? "" : cntAs.item(i).getFirstChild().getNodeValue();
						String cntB = cntBs.item(i).getFirstChild() == null ? "" : cntBs.item(i).getFirstChild().getNodeValue();
						String cntC = cntCs.item(i).getFirstChild() == null ? "" : cntCs.item(i).getFirstChild().getNodeValue();
						String cntD = cntDs.item(i).getFirstChild() == null ? "" : cntDs.item(i).getFirstChild().getNodeValue();
						String cntE = cntEs.item(i).getFirstChild() == null ? "" : cntEs.item(i).getFirstChild().getNodeValue();
						String cntF = cntFs.item(i).getFirstChild() == null ? "" : cntFs.item(i).getFirstChild().getNodeValue();
						String cntG = cntGs.item(i).getFirstChild() == null ? "" : cntGs.item(i).getFirstChild().getNodeValue();
			      	 %>
                    <tr>
                      <td><%=cntA%></td>
                      <td><%=cntB%></td>
                      <td><%=cntC%></td>
                      <td><%=cntD%></td>
                      <td><%=cntE%></td>
                      <td><%=cntF%></td>
                      <td><%=cntG%></td>
					</tr>
                <% } %>
            </tbody>
        </table>
		<%		
	}
}
%>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
</form>
<h3><strong>화합물 리스트</strong></h3><hr>
<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="searchOnccp";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");
	
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
	
	NodeList rnums = null;//생물일련번호
	NodeList onccpNms = null;//순번
	NodeList elmnWrds = null;//과명
	NodeList intltshSes = null;//학명
	NodeList antBactrlYns = null;//국명
	NodeList insccideYns = null;//비고
	NodeList weedngYns = null;//향균여부
	NodeList onccpSeqNos = null;//살충여부
	NodeList rms = null;//제초여부
	NodeList referltrtreCnts = null;//화합물 건수
	NodeList lvbCnts = null;//화합물 건수
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	
	rnums = doc.getElementsByTagName("rnum");
	onccpNms = doc.getElementsByTagName("onccpNm");
	elmnWrds = doc.getElementsByTagName("elmnWrd");
	intltshSes = doc.getElementsByTagName("intltshSe");
	antBactrlYns = doc.getElementsByTagName("antBactrlYn");
	insccideYns = doc.getElementsByTagName("insccideYn");
	weedngYns = doc.getElementsByTagName("weedngYn");
	onccpSeqNos = doc.getElementsByTagName("onccpSeqNo");
	rms = doc.getElementsByTagName("rm");
	referltrtreCnts = doc.getElementsByTagName("referltrtreCnt");
	lvbCnts = doc.getElementsByTagName("lvbCnt");

	if(size==0){
%>
	<hr>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		 <colgroup>
			<col width="5%" />
			<col width="*" />
			<col width="100px" />
			<col width="100px" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
          <thead>
              <tr>
				<th scope="col" >No</th>
				<th scope="col" >화합물명</th>
				<th scope="col" >Elements</th>
				<th scope="col" >계열</th>
				<th scope="col" >살균</th>
				<th scope="col" >살충</th>
				<th scope="col" >제초</th>
				<th scope="col" >기타작용기작</th>
             </tr>
         </thead>
	
<%
		for(int i=0; i<size; i++){
			String rnum = rnums.item(i).getFirstChild() == null ? "" : rnums.item(i).getFirstChild().getNodeValue(); 
			String onccpNm = onccpNms.item(i).getFirstChild() == null ? "" : onccpNms.item(i).getFirstChild().getNodeValue();
			String elmnWrd = elmnWrds.item(i).getFirstChild() == null ? "" : elmnWrds.item(i).getFirstChild().getNodeValue();
			String intltshSe = intltshSes.item(i).getFirstChild() == null ? "" : intltshSes.item(i).getFirstChild().getNodeValue();
			String antBactrlYn = antBactrlYns.item(i).getFirstChild() == null ? "" : antBactrlYns.item(i).getFirstChild().getNodeValue();
			String insccideYn = insccideYns.item(i).getFirstChild() == null ? "" : insccideYns.item(i).getFirstChild().getNodeValue();
			String weedngYn = weedngYns.item(i).getFirstChild() == null ? "" : weedngYns.item(i).getFirstChild().getNodeValue();
			String onccpSeqNo = onccpSeqNos.item(i).getFirstChild() == null ? "" : onccpSeqNos.item(i).getFirstChild().getNodeValue();
			String rm = rms.item(i).getFirstChild() == null ? "" : rms.item(i).getFirstChild().getNodeValue();
			String referltrtreCnt = referltrtreCnts.item(i).getFirstChild() == null ? "" : referltrtreCnts.item(i).getFirstChild().getNodeValue();
			String lvbCnt = lvbCnts.item(i).getFirstChild() == null ? "" : lvbCnts.item(i).getFirstChild().getNodeValue();
%>
		<tr>
			<td align="center"><%=rnum%></td>
			<td ><%=onccpNm%></td>
			<td align="center"><%=elmnWrd%></td>
			<td align="center"></td>
			<td align="center">
			<%if(antBactrlYn.equals("Y")){%>
				<%=antBactrlYn%>
			<%}%>
			</td>
			<td align="center">
			<%if(insccideYn.equals("Y")){%>
				<%=insccideYn%>
			<%}%>
			</td>
			<td align="center">
			<%if(weedngYn.equals("Y")){%>
				<%=weedngYn%>
			<%}%>
			</td>
			<td><%=rm%></td>
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