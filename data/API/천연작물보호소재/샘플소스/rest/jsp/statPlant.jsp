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
<title>식물통계</title>
<script type="text/javascript">
	//팝업 띄우기
	function fncNextList(seq,cntCode){
		var popupUrl="onccpPoP.jsp?lvbNo="+seq+"&cntCode="+cntCode+"&check4=statPlant";
		var popOption="width=800,height=440";
		
		window.open(popupUrl,"nongsaroPop",popOption);
	}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>식물통계</strong></h3><hr>

<%
if(true){
	String apiKey="발급받은인증키를삽입하세요"; //apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String serviceName="biopesticide";
	String serviceAction="statPlant";
	
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

	
	NodeList fmlSeqNos=null;//과_일련_번호            
	NodeList fmlNms=null;//과_명_명        
	NodeList cntAs=null;//살균.살충.제초  
	NodeList cntBs=null;//살균.살충    
	NodeList cntCs=null;//살균.제초    
	NodeList cntDs=null;//살충.제초    
	NodeList cntEs=null;//살균         
	NodeList cntFs=null;//살충  
	NodeList cntGs=null;//제초         
	NodeList ratioAs=null;//살균.살충.제초 비율
	NodeList ratioBs=null;//살균.살충 비율
	NodeList ratioCs=null;//살균.제초 비율 
	NodeList ratioDs=null;//살충.제초 비율   
	NodeList ratioEs=null;//살균 비율      
	NodeList ratioFs=null;//살충 비율     
	NodeList ratioGs=null;//제초 비율
	NodeList cnts=null;//식물수 비율 		
	
	items = mainDoc.getElementsByTagName("item");
	size = mainDoc.getElementsByTagName("item").getLength();
	fmlSeqNos = mainDoc.getElementsByTagName("fmlSeqNo");
	fmlNms = mainDoc.getElementsByTagName("fmlNm");
	cntAs = mainDoc.getElementsByTagName("cntA");
	cntBs = mainDoc.getElementsByTagName("cntB");
	cntCs = mainDoc.getElementsByTagName("cntC");
	cntDs = mainDoc.getElementsByTagName("cntD");
	cntEs = mainDoc.getElementsByTagName("cntE");
	cntFs = mainDoc.getElementsByTagName("cntF");
	cntGs = mainDoc.getElementsByTagName("cntG");
	ratioAs = mainDoc.getElementsByTagName("ratioA");
	ratioBs = mainDoc.getElementsByTagName("ratioB");
	ratioCs = mainDoc.getElementsByTagName("ratioC");
	ratioDs = mainDoc.getElementsByTagName("ratioD");
	ratioEs = mainDoc.getElementsByTagName("ratioE");
	ratioFs = mainDoc.getElementsByTagName("ratioF");
	ratioGs = mainDoc.getElementsByTagName("ratioG");
	cnts = mainDoc.getElementsByTagName("cnt");
	
	for(int i=0; i<size; i++){
		String fmlSeqNo = fmlSeqNos.item(i).getFirstChild() == null ? "" : fmlSeqNos.item(i).getFirstChild().getNodeValue();
		String fmlNm = fmlNms.item(i).getFirstChild() == null ? "" : fmlNms.item(i).getFirstChild().getNodeValue();
		if(i%10==0) out.print("<br>");
%>
		<span id="<%=fmlSeqNo%>">&nbsp;|&nbsp;<a href="#<%=i%><%=fmlSeqNo%>"><%=fmlNm%></a></span>
<%
	}
	if(size==0){
%>
	<h3>조회한 정보가 없습니다.</h3>
<%	
	}else{
		for(int i=0; i<size; i++){
			String fmlSeqNo = fmlSeqNos.item(i).getFirstChild() == null ? "" : fmlSeqNos.item(i).getFirstChild().getNodeValue();
			String fmlNm = fmlNms.item(i).getFirstChild() == null ? "" : fmlNms.item(i).getFirstChild().getNodeValue();
			String cntA = cntAs.item(i).getFirstChild() == null ? "" : cntAs.item(i).getFirstChild().getNodeValue();
			String cntB = cntBs.item(i).getFirstChild() == null ? "" : cntBs.item(i).getFirstChild().getNodeValue();
			String cntC = cntCs.item(i).getFirstChild() == null ? "" : cntCs.item(i).getFirstChild().getNodeValue();
			String cntD = cntDs.item(i).getFirstChild() == null ? "" : cntDs.item(i).getFirstChild().getNodeValue();
			String cntE = cntEs.item(i).getFirstChild() == null ? "" : cntEs.item(i).getFirstChild().getNodeValue();
			String cntF = cntFs.item(i).getFirstChild() == null ? "" : cntFs.item(i).getFirstChild().getNodeValue();
			String cntG = cntGs.item(i).getFirstChild() == null ? "" : cntGs.item(i).getFirstChild().getNodeValue();
			String ratioA = ratioAs.item(i).getFirstChild() == null ? "" : ratioAs.item(i).getFirstChild().getNodeValue();
			String ratioB = ratioBs.item(i).getFirstChild() == null ? "" : ratioBs.item(i).getFirstChild().getNodeValue();
			String ratioC = ratioCs.item(i).getFirstChild() == null ? "" : ratioCs.item(i).getFirstChild().getNodeValue();
			String ratioD = ratioDs.item(i).getFirstChild() == null ? "" : ratioDs.item(i).getFirstChild().getNodeValue();
			String ratioE = ratioEs.item(i).getFirstChild() == null ? "" : ratioEs.item(i).getFirstChild().getNodeValue();
			String ratioF = ratioFs.item(i).getFirstChild() == null ? "" : ratioFs.item(i).getFirstChild().getNodeValue();
			String ratioG = ratioGs.item(i).getFirstChild() == null ? "" : ratioGs.item(i).getFirstChild().getNodeValue();
			String cnt = cnts.item(i).getFirstChild() == null ? "" : cnts.item(i).getFirstChild().getNodeValue();
%>
<hr>
<div id="<%=i%><%=fmlSeqNo%>"></div>
<h3><strong><%=fmlNm%></strong></h3>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
		</colgroup>
		<tr>
			<th>식물수</th>
			<th>살균,살충,제초</th>
			<th>살균,살충</th>
			<th>살균,제초</th>
			<th>살충,제초</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
		</tr>
		<tr>
			<td align="center">
			<%if(!cnt.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','1');"><%=cnt%></a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntA.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_A');"><%=cntA%>(<%=ratioA%>%)</a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntB.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_B');"><%=cntB%>(<%=ratioB%>%)</a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntC.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_C');"><%=cntC%>(<%=ratioC%>%)</a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntD.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_D');"><%=cntD%>(<%=ratioD%>%)</a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntE.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_E');"><%=cntE%>(<%=ratioE%>%)</a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntF.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_F');"><%=cntF%>(<%=ratioF%>%</a>
			<%}else out.println("-");%>
			</td>
			<td align="center">
			<%if(!cntG.equals("0")){%>
				<a href="javascript:fncNextList('<%=fmlSeqNo%>','COUNT_G');"><%=cntG%>(<%=ratioG%>%)</a>
			<%}else out.println("-");%>
			</td>
		<tr>
	</table>
<%		
		}

	}
}
%>
</body>
</html>