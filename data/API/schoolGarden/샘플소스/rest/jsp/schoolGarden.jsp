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
<title>진로체험</title>
<script type="text/javascript">
//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "schoolGarden_D.jsp";
		target = "_self";
		submit();
	}
}
function fncTabChg(type){
	with(document.searchApiForm){
		pageNo.value = "1";
		menuType.value=type;
		method="get";
		action = "schoolGarden.jsp";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "schoolGarden.jsp";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>진로체험</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>

<%
String menuType = request.getParameter("menuType")==null?"PS03962":request.getParameter("menuType");
%>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<%=request.getParameter("pageNo")%>">
<input type="hidden" name="menuType" value="<%=menuType%>">
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">
		<a href="javascript:fncTabChg('PS03962');">  <% if ( menuType.equals("PS03962")) { %> <strong>토마토 재배부터 판매까지</strong> <% }else{ %>토마토 재배부터 판매까지<%} %> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('PS04127');">  <% if ( menuType.equals("PS04127")) { %> <strong>씨앗부터 플라워 카페까지</strong> <% }else{ %>씨앗부터 플라워 카페까지<%} %> </a>
	</td>
</tr>
</table>
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<th>분류</th>
	<td>
		<select name="code">
<%					//과명 서브 리스트 출력
			//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
			String apiKey="nongsaroSampleKey";
			//서비스 명
			String serviceName="schoolGarden";
			//오퍼레이션 명
			String operationName="cmmCodeInfo";

			//XML 받을 URL 생성
			String parameter = "/"+serviceName+"/"+operationName;
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
				//코드
				String sub_code = sub_codes.item(i).getFirstChild() == null ? "" : sub_codes.item(i).getFirstChild().getNodeValue();
				//코드명
				String sub_codeNm = sub_codeNms.item(i).getFirstChild() == null ? "" : sub_codeNms.item(i).getFirstChild().getNodeValue();
%>
		<option value="<%=sub_code%>" <%=request.getParameter("code")!=null && request.getParameter("code").equals(sub_code)?"selected":""%>><%=sub_codeNm%></option>
<%
			}
%>
   </select>
	</td>
</tr>
</table>
</form>
<%
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	apiKey="nongsaroSampleKey"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	//서비스 명
	serviceName="schoolGarden";
	//오퍼레이션 명
	operationName="schoolGardenList";

	//XML 받을 URL 생성
	parameter = "/"+serviceName+"/"+operationName;
	parameter += "?apiKey="+ apiKey;
	parameter += "&pageNo="+request.getParameter("pageNo");
	parameter += "&menuId="+menuType;
	if(request.getParameter("code")!=null&&!request.getParameter("code").equals("")){
		parameter += "&code="+request.getParameter("code");
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
	NodeList tmrds = null;
	NodeList cntntsSjs = null;
	NodeList downUrls = null;
	NodeList fileNames = null;

	items = doc.getElementsByTagName("item");
	size = doc.getElementsByTagName("item").getLength();
	cntntsNos = doc.getElementsByTagName("cntntsNo");
	tmrds = doc.getElementsByTagName("tmrd");
	cntntsSjs = doc.getElementsByTagName("cntntsSj");
	downUrls = doc.getElementsByTagName("downUrl");
	fileNames = doc.getElementsByTagName("fileName");

	if(size==0){ %>
	<h3>조회한 정보가 없습니다.</h3>
<%	}else{ %>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="10%"/>
			<col width="50%"/>
			<col width="40%"/>
		</colgroup>
		<tr>
			<th>회기</th>
			<th>제목</th>
			<th>첨부</th>
		</tr>
<%
		for(int i=0; i<size; i++){
			//키값
			String cntntsNo = cntntsNos.item(i).getFirstChild() == null ? "" : cntntsNos.item(i).getFirstChild().getNodeValue();
			//회기
			String tmrd = tmrds.item(i).getFirstChild() == null ? "" : tmrds.item(i).getFirstChild().getNodeValue();
			//제목
			String cntntsSj = cntntsSjs.item(i).getFirstChild() == null ? "" : cntntsSjs.item(i).getFirstChild().getNodeValue();
			//파일다운로드 URL
			String downUrl = downUrls.item(i).getFirstChild() == null ? "" : downUrls.item(i).getFirstChild().getNodeValue();
			//파일명
			String fileName = fileNames.item(i).getFirstChild() == null ? "" : fileNames.item(i).getFirstChild().getNodeValue();

			String[] s_downUrl=downUrl.split(";");
			String[] s_fileName=fileName.split(";");
%>
		<tr>
			<td><%=tmrd%></td>

			<td><a href="javascript:;move('<%=cntntsNo%>');"><%=cntntsSj%></a></td>
			<td align="center">
<%
			for(int j=0; j<s_downUrl.length; j++){
%>
				<a href="<%=s_downUrl[j]%>"><%=s_fileName[j]%></a><br>
<%
			}
%>
			</td>
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