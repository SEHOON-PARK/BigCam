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
<title>추천식단</title>
<script type="text/javascript">
//품종정보 리스트
function mainMove(dCode){
	with(document.mainApiForm){
		dietSeCode.value = dCode;
		method="get";
		action = "recomendDiet.jsp";
		target = "_self";
		submit();
	}
}

//추천식단 컨텐츠 상세조회
function detailMove(cNo){
	with(document.detailApiForm){
		cntntsNo.value = cNo;
		method="get";
		action = "recomendDiet.jsp";
		target = "_self";
		submit();
	}
}

//추천식단 컨텐츠 상세조회
function tabMove(tNo){
	with(document.tabApiForm){
		tabNo.value = tNo;
		method="get";
		action = "recomendDiet.jsp";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.mainApiForm){
		pageNo.value = page;
		method="get";
		action = "recomendDiet.jsp";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>추천식단</strong></h3><hr>

<form name="mainApiForm">
	<input type="hidden" name="dietSeCode" value="<%=request.getParameter("dietSeCode")%>">
	<input type="hidden" name="pageNo">
</form>

<form name="detailApiForm">
	<input type="hidden" name="cntntsNo" value="<%=request.getParameter("cntntsNo")%>">
	<input type="hidden" name="tabNo" value="0">
</form>

<form name="tabApiForm">
	<input type="hidden" name="cntntsNo" value="<%=request.getParameter("cntntsNo")%>">
	<input type="hidden" name="tabNo" value="<%=request.getParameter("tabNo")%>">
</form>


<!-- ============================================== 메인카테고리 조회 시작 =========================================================== -->

<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="recomendDiet";
	String serviceAction="mainCategoryList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	
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
	NodeList dietSeCodes = null;
	NodeList dietSeNames = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	dietSeCodes = doc.getElementsByTagName("dietSeCode");
	dietSeNames = doc.getElementsByTagName("dietSeName");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		for(int i=0; i<size; i++){
			String dietSeCode = dietSeCodes.item(i).getFirstChild() == null ? "" : dietSeCodes.item(i).getFirstChild().getNodeValue();
			String dietSeName = dietSeNames.item(i).getFirstChild() == null ? "" : dietSeNames.item(i).getFirstChild().getNodeValue();
%>
				<td align="center"><a href="javascript:mainMove('<%=dietSeCode%>');"><%=dietSeName%></a></td>
<%		
		}
%>
		<tr>
	</table>
<%
	}
}
%>

<!-- ============================================== 메인카테고리 조회 끝 =========================================================== -->

<!-- ============================================== 품종정보 리스트 시작 =========================================================== -->
<%
if(request.getParameter("dietSeCode")!=null && !request.getParameter("dietSeCode").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="recomendDiet";
	String serviceAction="recomendDietList";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&dietSeCode="+ request.getParameter("dietSeCode");
	parameter += "&pageNo="+request.getParameter("pageNo");

	
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
	NodeList rtnImageDcs = null;
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	cntntsSjs = doc.getElementsByTagName("cntntsSj");
	rtnImageDcs = doc.getElementsByTagName("rtnImageDc");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
<%
		for(int i=0; i<size; i++){
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			String cntntsSj = cntntsSjs.item(i).getFirstChild() == null ? "" : cntntsSjs.item(i).getFirstChild().getNodeValue();
			String rtnImageDc = rtnImageDcs.item(i).getFirstChild() == null ? "" : rtnImageDcs.item(i).getFirstChild().getNodeValue();
%>
		<tr>
			<td width="15%"><img src="<%=rtnImageDc%>" width="128" height="103"></img></td>
			<td width="85%"><a href="javascript:detailMove('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
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

<!-- ============================================== 품종정보 리스트 끝 =========================================================== -->

<!-- ============================================== 컨텐츠 상세조회 목록 시작 =========================================================== -->
<%
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="recomendDiet";
	String serviceAction="recomendDietDtl";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&cntntsNo="+ request.getParameter("cntntsNo");
	
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
	
	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	cntntsSjs = doc.getElementsByTagName("cntntsSj");

	if(size==0){ 
%>
	<h3>조회한 정보가 없습니다.</h3>
<%
	}else{
%>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<%
		for(int i=0; i<size; i++){
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			String cntntsSj = cntntsSjs.item(i).getFirstChild() == null ? "" : cntntsSjs.item(i).getFirstChild().getNodeValue();
%>
				<td align="center"><a href="javascript:tabMove('<%=i%>');"><%=cntntsSj%></a></td>
<%		
		}
%>
		<tr>
	</table>
<%
	}
}
%>

<!-- ============================================== 컨텐츠 상세조회 목록 시작 =========================================================== -->

<!-- ============================================== 컨텐츠 상세조회 시작 =========================================================== -->
<%
if(request.getParameter("cntntsNo")!=null && !request.getParameter("cntntsNo").equals("")){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="recomendDiet";
	String serviceAction="recomendDietDtl";
	
	//XML 받을 URL 생성
	String parameter = "/"+serviceName+"/"+serviceAction;
	parameter += "?apiKey="+ apiKey;
	parameter += "&cntntsNo="+ request.getParameter("cntntsNo");
	
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
	
	NodeList items = null;
	NodeList rtnImageDcs = null; //이미지
	NodeList fdNms = null; //식단구성
	NodeList dietCns = null; //식단구성
	NodeList dietNtrsmallInfos = null; //영양소
	NodeList matrlInfos = null; //식단구성
	NodeList ckngMthInfos = null; //식단소개
	NodeList ntkQyInfos = null;//1회섭취량
	NodeList crbhInfos = null;//당질
	NodeList ntrfsInfos = null;//지질
	NodeList crfbInfos = null;//조섬유
	NodeList ircnInfos = null;//철분
	NodeList frmlasaltEqvlntqyInfos = null;//식염상당량
	NodeList vtmbInfos = null;//비타민b
	NodeList clriInfos = null;//열량
	NodeList protInfos = null;//단백질
	NodeList chlsInfos = null;//콜레스테롤
	NodeList clciInfos = null;//칼슘
	NodeList naInfos = null;//나트륨
	NodeList vtmaInfos = null;//비타민a
	NodeList vtmcInfos = null;//비타민c
	
	items = doc.getElementsByTagName("item");
	
	rtnImageDcs = doc.getElementsByTagName("rtnImageDc");
	fdNms = doc.getElementsByTagName("fdNm");
	dietCns = doc.getElementsByTagName("dietCn");
	dietNtrsmallInfos = doc.getElementsByTagName("dietNtrsmallInfo");
	matrlInfos = doc.getElementsByTagName("matrlInfo");
	ckngMthInfos = doc.getElementsByTagName("ckngMthInfo");
	ntkQyInfos = doc.getElementsByTagName("ntkQyInfo");
	crbhInfos = doc.getElementsByTagName("crbhInfo");
	ntrfsInfos = doc.getElementsByTagName("ntrfsInfo");
	crfbInfos = doc.getElementsByTagName("crfbInfo");
	ircnInfos = doc.getElementsByTagName("ircnInfo");
	frmlasaltEqvlntqyInfos = doc.getElementsByTagName("frmlasaltEqvlntqyInfo");
	vtmbInfos = doc.getElementsByTagName("vtmbInfo");
	clriInfos = doc.getElementsByTagName("clriInfo");
	protInfos = doc.getElementsByTagName("protInfo");
	chlsInfos = doc.getElementsByTagName("chlsInfo");
	clciInfos = doc.getElementsByTagName("clciInfo");
	naInfos = doc.getElementsByTagName("naInfo");
	vtmaInfos = doc.getElementsByTagName("vtmaInfo");
	vtmcInfos = doc.getElementsByTagName("vtmcInfo");

	int i=Integer.parseInt(request.getParameter("tabNo"));
	
	String rtnImageDc = rtnImageDcs.item(i).getFirstChild() == null ? "" : rtnImageDcs.item(i).getFirstChild().getNodeValue();
	String fdNm = fdNms.item(i).getFirstChild() == null ? "" : fdNms.item(i).getFirstChild().getNodeValue();
	String dietCn = dietCns.item(i).getFirstChild() == null ? "" : dietCns.item(i).getFirstChild().getNodeValue();
	String dietNtrsmallInfo = dietNtrsmallInfos.item(i).getFirstChild() == null ? "" : dietNtrsmallInfos.item(i).getFirstChild().getNodeValue();
	String matrlInfo = matrlInfos.item(i).getFirstChild() == null ? "" : matrlInfos.item(i).getFirstChild().getNodeValue();
	String ckngMthInfo = ckngMthInfos.item(i).getFirstChild() == null ? "" : ckngMthInfos.item(i).getFirstChild().getNodeValue();
	String ntkQyInfo = ntkQyInfos.item(i).getFirstChild() == null ? "" : ntkQyInfos.item(i).getFirstChild().getNodeValue();
	String crbhInfo = crbhInfos.item(i).getFirstChild() == null ? "" : crbhInfos.item(i).getFirstChild().getNodeValue();
	String ntrfsInfo = ntrfsInfos.item(i).getFirstChild() == null ? "" : ntrfsInfos.item(i).getFirstChild().getNodeValue();
	String crfbInfo = crfbInfos.item(i).getFirstChild() == null ? "" : crfbInfos.item(i).getFirstChild().getNodeValue();
	String ircnInfo = ircnInfos.item(i).getFirstChild() == null ? "" : ircnInfos.item(i).getFirstChild().getNodeValue();
	String frmlasaltEqvlntqyInfo = frmlasaltEqvlntqyInfos.item(i).getFirstChild() == null ? "" : frmlasaltEqvlntqyInfos.item(i).getFirstChild().getNodeValue();
	String vtmbInfo = vtmbInfos.item(i).getFirstChild() == null ? "" : vtmbInfos.item(i).getFirstChild().getNodeValue();
	String clriInfo = clriInfos.item(i).getFirstChild() == null ? "" : clriInfos.item(i).getFirstChild().getNodeValue();
	String protInfo = protInfos.item(i).getFirstChild() == null ? "" : protInfos.item(i).getFirstChild().getNodeValue();
	String chlsInfo = chlsInfos.item(i).getFirstChild() == null ? "" : chlsInfos.item(i).getFirstChild().getNodeValue();
	String clciInfo = clciInfos.item(i).getFirstChild() == null ? "" : clciInfos.item(i).getFirstChild().getNodeValue();
	String naInfo = naInfos.item(i).getFirstChild() == null ? "" : naInfos.item(i).getFirstChild().getNodeValue();
	String vtmaInfo = vtmaInfos.item(i).getFirstChild() == null ? "" : vtmaInfos.item(i).getFirstChild().getNodeValue();
	String vtmcInfo = vtmcInfos.item(i).getFirstChild() == null ? "" : vtmcInfos.item(i).getFirstChild().getNodeValue();
	
%>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
			<td width="15%"><img src="<%=rtnImageDc%>" width="128" height="103"></img></td>
			<td width="85%">
				<strong>식단구성&nbsp;&nbsp;</strong><%=fdNm%><br>
				<strong>식단소개&nbsp;&nbsp;</strong><%=dietCn%><br>
				<strong>영양소&nbsp;&nbsp;</strong><%=dietNtrsmallInfo%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><strong>식단별 조리법</strong></td>
		</tr>
		<tr>
			<td colspan="2">
				<strong>식단구성&nbsp;&nbsp;</strong><%=matrlInfo%><br>
				<strong>식단소개&nbsp;&nbsp;</strong><%=ckngMthInfo%><br>
				<strong>영양소&nbsp;&nbsp;</strong>
			</td>
		<tr>
			<td colspan="2">
				<table width="100%" border="0" rules="rows">
					<tr>
						<td width="25%" align="center"><strong>1회 섭취량</strong></td>
						<td width="25%"><%=ntkQyInfo%>&nbsp;ml</td>
						<td width="25%" align="center"><strong>열량</strong></td>
						<td width="25%"><%=clriInfo%>&nbsp;kcal</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>당질</strong></td>
						<td width="25%"><%=crbhInfo%>&nbsp;g</td>
						<td width="25%" align="center"><strong>단백질</strong></td>
						<td width="25%"><%=protInfo%>&nbsp;g</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>지질</strong></td>
						<td width="25%"><%=ntrfsInfo%>&nbsp;g</td>
						<td width="25%" align="center"><strong>콜레스트롤</strong></td>
						<td width="25%"><%=chlsInfo%>&nbsp;mg</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>조섬유</strong></td>
						<td width="25%"><%=crfbInfo%>&nbsp;g</td>
						<td width="25%" align="center"><strong>칼슘</strong></td>
						<td width="25%"><%=clciInfo%>&nbsp;mg</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>철분</strong></td>
						<td width="25%"><%=ircnInfo%>&nbsp;mg</td>
						<td width="25%" align="center"><strong>나트륨</strong></td>
						<td width="25%"><%=naInfo%>&nbsp;mg</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>식염상당량</strong></td>
						<td width="25%"><%=frmlasaltEqvlntqyInfo%>&nbsp;g</td>
						<td width="25%" align="center"><strong>비타민A</strong></td>
						<td width="25%"><%=vtmaInfo%>&nbsp;㎍RE</td>
					</tr>
					<tr>
						<td width="25%" align="center"><strong>비타민B</strong></td>
						<td width="25%"><%=vtmbInfo%>&nbsp;mg</td>
						<td width="25%" align="center"><strong>비타민C</strong></td>
						<td width="25%"><%=vtmcInfo%>&nbsp;mg</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<%
	
}
%>

<!-- ============================================== 컨텐츠 상세조회 시작 =========================================================== -->


</body>
</html>