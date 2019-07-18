<%@page import="java.util.HashMap"%>
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
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>사료 검색 상세</strong></h3>
<hr>

<%
//사료 검색 상세조회
if(request.getParameter("hsrrlManageNo")!=null && !request.getParameter("hsrrlManageNo").equals("")){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	String apiKey="발급받은인증키를입력하세요";
	//서비스 명
	String serviceName="feedSearch";
	//오퍼레이션 명	
	String[] operationName = {"feedSearchInfoDtl", "feedSearchMineralDtl", "feedSearchNutritiveDtl", "feedSearchDigestDtl", "feedSearchAminoDtl", "feedSearchVitaminDtl", "feedSearchCellDtl", "feedSearchChemDtl"};
	
	HashMap<String, Document> operationNameMap = new HashMap<String, Document>();
	
	Document doc = null;

	for(int i=0; i<operationName.length; i++){
		//XML 받을 URL 생성
		String parameter = "/"+serviceName+"/"+operationName[i];
		parameter += "?apiKey="+ apiKey;
		parameter += "&hsrrlManageNo="+ request.getParameter("hsrrlManageNo");
		
		//서버와 통신
		URL apiUrl = new URL("http://api.nongsaro.go.kr/service"+parameter);
		InputStream apiStream = apiUrl.openStream();
		
		try{
			//xml document
			doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(apiStream);
			operationNameMap.put(operationName[i], doc);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			apiStream.close();
		}
	}
	
	//사료검색 - 기본정보
	if(operationNameMap.containsKey("feedSearchInfoDtl")){
		doc=operationNameMap.get("feedSearchInfoDtl");
		
		//사료 관리 번호
		String hsrrlManageNo = null;
		//년도
		String year = null;
		//사료 번호
		String hsrrlNo = null;
		//한글 명
		String koreanNm = null;
		//영문 명
		String engNm = null;
		//사료 품목 코드 명
		String hsrrlPrdlstCodeNm = null;
		//사료 종류
		String hsrrlPrdlstCodeLclasNm = null;

		try{hsrrlManageNo = doc.getElementsByTagName("hsrrlManageNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){hsrrlManageNo = "";}
		try{year = doc.getElementsByTagName("year").item(0).getFirstChild().getNodeValue();}catch(Exception e){year = "";}
		try{hsrrlNo = doc.getElementsByTagName("hsrrlNo").item(0).getFirstChild().getNodeValue();}catch(Exception e){hsrrlNo = "";}
		try{koreanNm = doc.getElementsByTagName("koreanNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){koreanNm = "";}
		try{engNm = doc.getElementsByTagName("engNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){engNm = "";}
		try{hsrrlPrdlstCodeNm = doc.getElementsByTagName("hsrrlPrdlstCodeNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){hsrrlPrdlstCodeNm = "";}
		try{hsrrlPrdlstCodeLclasNm = doc.getElementsByTagName("hsrrlPrdlstCodeLclasNm").item(0).getFirstChild().getNodeValue();}catch(Exception e){hsrrlPrdlstCodeLclasNm = "";}
%>
	<h4>사료정보</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="20%" />
			<col width="30%" />
			<col width="20%" />
			<col width="30%" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">한글사료명</th>
				<td><%=koreanNm%></td>
				<th scope="row">영문사료명</th>
				<td><%=engNm%></td>
			</tr>
			<tr>
				<th scope="row">사료종류</th>
				<td><%=hsrrlPrdlstCodeNm%></td>
				<th scope="row">사료구분</th>
				<td><%=hsrrlPrdlstCodeLclasNm%></td>
			</tr>
			<tr>
				<th scope="row">사료년도</th>
				<td><%=year%></td>
				<th scope="row">사료번호</th>
				<td><%=hsrrlNo%></td>
			</tr>
		</tbody>
	</table>
<%
	}
	
	//사료 검색 - 일반 조성분
	if(operationNameMap.containsKey("feedSearchMineralDtl")){
		doc=operationNameMap.get("feedSearchMineralDtl");

		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList gnrlmakemntSeNms = doc.getElementsByTagName("gnrlmakemntSeNm");
		NodeList mitrValues = doc.getElementsByTagName("mitrValue");
		NodeList takprotValues = doc.getElementsByTagName("takprotValue");
		NodeList cuftValues = doc.getElementsByTagName("cuftValue");
		NodeList usefulRdshNtrgwaterValues = doc.getElementsByTagName("usefulRdshNtrgwaterValue");
		NodeList crfbValues = doc.getElementsByTagName("crfbValue");
		NodeList inqiremntValues = doc.getElementsByTagName("inqiremntValue");
		NodeList analsScoreValues = doc.getElementsByTagName("analsScoreValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
		
%>
	<h4>일반조성분 (Chem.corp. %)</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="12%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="9">일반조성분 (Chem.corp. %)</th>
			</tr>
			<tr>
				<th scope="col">구분</th>
				<th scope="col">수분<br />(Moisture)</th>
				<th scope="col">조단백질<br />(CP)</th>
				<th scope="col">조지방<br />(EE)</th>
				<th scope="col">가용무질소물<br />(NFE)</th>
				<th scope="col">조섬유<br />(C.Fib.)</th>
				<th scope="col">조회분<br />(Ash)</th>
				<th scope="col">분석점수</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>
<%
		if(size==0){
%>
			<tr>
				<td colspan="9" align="center">조회한 정보가 없습니다.</td>
			</tr>
<% 			
		}else{
			
			for(int i=0; i<size; i++){
				//일반 조성분 구분 코드 명
				String gnrlmakemntSeNm = gnrlmakemntSeNms.item(i).getFirstChild() == null ? "" : gnrlmakemntSeNms.item(i).getFirstChild().getNodeValue();
				//수분
				String mitrValue = mitrValues.item(i).getFirstChild() == null ? "" : mitrValues.item(i).getFirstChild().getNodeValue();
				//조단백질
				String takprotValue = takprotValues.item(i).getFirstChild() == null ? "" : takprotValues.item(i).getFirstChild().getNodeValue();
				//조지방
				String cuftValue = cuftValues.item(i).getFirstChild() == null ? "" : cuftValues.item(i).getFirstChild().getNodeValue();
				//가용무기질소물
				String usefulRdshNtrgwaterValue = usefulRdshNtrgwaterValues.item(i).getFirstChild() == null ? "" : usefulRdshNtrgwaterValues.item(i).getFirstChild().getNodeValue();
				//조섬유
				String crfbValue = crfbValues.item(i).getFirstChild() == null ? "" : crfbValues.item(i).getFirstChild().getNodeValue();
				//조회분
				String inqiremntValue = inqiremntValues.item(i).getFirstChild() == null ? "" : inqiremntValues.item(i).getFirstChild().getNodeValue();
				//분석점수
				String analsScoreValue = analsScoreValues.item(i).getFirstChild() == null ? "" : analsScoreValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();

%>		
			<tr>
				<th scope="row"><%=gnrlmakemntSeNm%></th>
				<td><%=mitrValue%></td>
				<td><%=takprotValue%></td>
				<td><%=cuftValue%></td>
				<td><%=usefulRdshNtrgwaterValue%></td>
				<td><%=crfbValue%></td>
				<td><%=inqiremntValue%></td>
				<% if(i==0){ %>
				<td rowspan="3"><%=analsScoreValue%></td>
				<td rowspan="3"><%=sRm%></td>
				<% } %>
			</tr>
<%
			}
		}
%>			
		</tbody>
	</table>
<%		
	}
	
	//사료 검색 - 영양가
	if(operationNameMap.containsKey("feedSearchNutritiveDtl")){
		doc=operationNameMap.get("feedSearchNutritiveDtl");
	
		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList ntrtmpyKdlsNms = doc.getElementsByTagName("ntrtmpyKdlsNm");
		NodeList ntrtmpySeNms = doc.getElementsByTagName("ntrtmpySeNm");
		NodeList tdngValues = doc.getElementsByTagName("tdngValue");
		NodeList deValues = doc.getElementsByTagName("deValue");
		NodeList methylValues = doc.getElementsByTagName("methylValue");
		NodeList trmreValues = doc.getElementsByTagName("trmreValue");
		NodeList nemValues = doc.getElementsByTagName("nemValue");
		NodeList negValues = doc.getElementsByTagName("negValue");
		NodeList nelValues = doc.getElementsByTagName("nelValue");
		NodeList geValues = doc.getElementsByTagName("geValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
		
%>
	<h4>영양가 (Nutritive value)</h4>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="2">구분</th>
				<th scope="col">TDN<br />(%)</th>
				<th scope="col">DE<br />(Mcal/kg)</th>
				<th scope="col">GE<br />(Mcal/kg)</th>
				<th scope="col">ME<br />(Mcal/kg)</th>
				<th scope="col">NE<br />(Mcal/kg)</th>
				<th scope="col">Nem<br />(Mcal/kg)</th>
				<th scope="col">Neg<br />(Mcal/kg)</th>
				<th scope="col">Neℓ<br />(Mcal/kg)</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>
<%
		if(size==0){
%>
		<tr>
			<td colspan="10" align="center">조회한 정보가 없습니다.</td>
		</tr>
<% 			
		}else{
			
			for(int i=0; i<size; i++){
				//영양가 축종 명
				String ntrtmpyKdlsNm = ntrtmpyKdlsNms.item(i).getFirstChild() == null ? "" : ntrtmpyKdlsNms.item(i).getFirstChild().getNodeValue();
				//영양가 구분 명
				String ntrtmpySeNm = ntrtmpySeNms.item(i).getFirstChild() == null ? "" : ntrtmpySeNms.item(i).getFirstChild().getNodeValue();
				//TDN
				String tdngValue = tdngValues.item(i).getFirstChild() == null ? "" : tdngValues.item(i).getFirstChild().getNodeValue();
				//DE
				String deValue = deValues.item(i).getFirstChild() == null ? "" : deValues.item(i).getFirstChild().getNodeValue();
				//ME
				String methylValue = methylValues.item(i).getFirstChild() == null ? "" : methylValues.item(i).getFirstChild().getNodeValue();
				//TME
				String trmreValue = trmreValues.item(i).getFirstChild() == null ? "" : trmreValues.item(i).getFirstChild().getNodeValue();
				//NEM
				String nemValue = nemValues.item(i).getFirstChild() == null ? "" : nemValues.item(i).getFirstChild().getNodeValue();
				//NEG
				String negValue = negValues.item(i).getFirstChild() == null ? "" : negValues.item(i).getFirstChild().getNodeValue();
				//NEL
				String nelValue = nelValues.item(i).getFirstChild() == null ? "" : nelValues.item(i).getFirstChild().getNodeValue();
				//GE
				String geValue = geValues.item(i).getFirstChild() == null ? "" : geValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();
%>		
		<tr>
			<% if((i+1) % 2 > 0){ %>
			<th scope="row" rowspan="2"><%=ntrtmpySeNm%></th>
			<% } %>
			<th scope="row"><%=ntrtmpyKdlsNm%></th>
			<td><%=tdngValue%></td>
			<td><%=deValue%></td>
			<td><%=geValue%></td>
			<td><%=methylValue%></td>
			<td><%=trmreValue%></td>
			<td><%=nemValue%></td>
			<td><%=negValue%></td>
			<td><%=nelValue%></td>
			<% if((i+1) % 2 > 0){ %>
			<th scope="row" rowspan="2"><%=sRm%></th>
			<% } %>
		</tr>
<%
			}
		}
%>			
		</tbody>
	</table>
<%		
	}
	
	//사료 검색 - 소화율
	if(operationNameMap.containsKey("feedSearchDigestDtl")){
		doc=operationNameMap.get("feedSearchDigestDtl");

		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList frexrtKdlsNms = doc.getElementsByTagName("frexrtKdlsNm");
		NodeList frexrtSeNms = doc.getElementsByTagName("frexrtSeNm");
		NodeList dryMttrValues = doc.getElementsByTagName("dryMttrValue");
		NodeList protValues = doc.getElementsByTagName("protValue");
		NodeList lcltyValues = doc.getElementsByTagName("lcltyValue");
		NodeList usefulRdshNtrgwaterValues = doc.getElementsByTagName("usefulRdshNtrgwaterValue");
		NodeList fberValues = doc.getElementsByTagName("fberValue");
		NodeList analsScoreValues = doc.getElementsByTagName("analsScoreValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
%>
		<h4>소화율 (Dig.coef.)</h4>
		<table width="100%" border="1" cellSpacing="0" cellPadding="0">
			<thead>
				<tr>
				<th colspan="2">구분</th>
				<th width="12%">건물<br>(DM)</th>
				<th width="12%">조단백질<br>(CP)</th>
				<th width="12%">조지방<br>(EE)</th>
				<th width="13%">가용무질소물<br>(NFE)</th>
				<th width="12%">조섬유<br>(C.Fib.)</th>
				<th width="12%">분석점수</th>
				<th width="12%">비고</th></tr>
			</thead>
		<tbody>
<%
		if(size==0){
%>
		<tr>
			<td colspan="8" align="center">조회한 정보가 없습니다.</td>
		</tr>
<% 			
		}else{
			
			for(int i=0; i<size; i++){
				//소화율 축종 명
				String frexrtKdlsNm = frexrtKdlsNms.item(i).getFirstChild() == null ? "" : frexrtKdlsNms.item(i).getFirstChild().getNodeValue();
				//소화율 구분 명
				String frexrtSeNm = frexrtSeNms.item(i).getFirstChild() == null ? "" : frexrtSeNms.item(i).getFirstChild().getNodeValue();
				//건조 물질
				String dryMttrValue = dryMttrValues.item(i).getFirstChild() == null ? "" : dryMttrValues.item(i).getFirstChild().getNodeValue();
				//단백질
				String protValue = protValues.item(i).getFirstChild() == null ? "" : protValues.item(i).getFirstChild().getNodeValue();
				//지방
				String lcltyValue = lcltyValues.item(i).getFirstChild() == null ? "" : lcltyValues.item(i).getFirstChild().getNodeValue();
				//가용무질소물
				String usefulRdshNtrgwaterValue = usefulRdshNtrgwaterValues.item(i).getFirstChild() == null ? "" : usefulRdshNtrgwaterValues.item(i).getFirstChild().getNodeValue();
				//섬유
				String fberValue = fberValues.item(i).getFirstChild() == null ? "" : fberValues.item(i).getFirstChild().getNodeValue();
				//분석 점수
				String analsScoreValue = analsScoreValues.item(i).getFirstChild() == null ? "" : analsScoreValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();
%>		
		<tr>
			<% if((i+1) % 2 > 0){ %>
			<th scope="row" rowspan="2"><%=frexrtSeNm%></th>
			<% } %>
			<th scope="row"><%=frexrtKdlsNm%></th>
			<td><%=dryMttrValue%></td>
			<td><%=protValue%></td>
			<td><%=lcltyValue%></td>
			<td><%=usefulRdshNtrgwaterValue%></td>
			<td><%=fberValue%></td>
			<% if((i+1) % 2 > 0){ %>
			<th scope="row" rowspan="2"><%=analsScoreValue%></th>
			<th scope="row" rowspan="2"><%=sRm%></th>
			<% } %>
		</tr>
<%
			}
		}
%>			
		</tbody>
	</table>
<%		
	}
	
	//사료 검색 - 무기질
	if(operationNameMap.containsKey("feedSearchChemDtl")){
		doc=operationNameMap.get("feedSearchChemDtl");

		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList inorganicMatterSeNms = doc.getElementsByTagName("inorganicMatterSeNm");
		NodeList dryMttrValues = doc.getElementsByTagName("dryMttrValue");
		NodeList clciValues = doc.getElementsByTagName("clciValue");
		NodeList phphValues = doc.getElementsByTagName("phphValue");
		NodeList ptssValues = doc.getElementsByTagName("ptssValue");
		NodeList naValues = doc.getElementsByTagName("naValue");
		NodeList mgnValues = doc.getElementsByTagName("mgnValue");
		NodeList gtValues = doc.getElementsByTagName("gtValue");
		NodeList sulfurValues = doc.getElementsByTagName("sulfurValue");
		NodeList seasnValues = doc.getElementsByTagName("seasnValue");
		NodeList mangValues = doc.getElementsByTagName("mangValue");
		NodeList cbltValues = doc.getElementsByTagName("cbltValue");
		NodeList zincValues = doc.getElementsByTagName("zincValue");
		NodeList copprValues = doc.getElementsByTagName("copprValue");
		NodeList flrnValues = doc.getElementsByTagName("flrnValue");
		NodeList analsScoreValues = doc.getElementsByTagName("analsScoreValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
%>
		<h4>무기질</h4>
		<table width="100%" border="1" cellSpacing="0" cellPadding="0">
			<thead>
			<tr>
				<th>구분</th>
				<th width="11%">건물<br>DM(%)</th>
				<th width="11%">칼슘<br>Ca(%)</th>
				<th width="11%">인<br>P(%)</th>
				<th width="11%">칼륨<br>K(%)</th>
				<th width="11%">나트륨<br>Na(%)</th>
				<th width="11%">마그네슘<br>Mg(%)</th>
				<th width="11%">염소<br>Cl(%)</th	>
				<th width="11%">요황<br>S(%)</th>
			</tr>
			</thead>
			<tbody>
<%
		if(size==0){
%>
		<tr>
			<td colspan="9" align="center">조회한 정보가 없습니다.</td>
		</tr>
<% 			
		}else{
			for(int i=0; i<size; i++){
				//무기물 구분 명
				String inorganicMatterSeNm = inorganicMatterSeNms.item(i).getFirstChild() == null ? "" : inorganicMatterSeNms.item(i).getFirstChild().getNodeValue();
				//건조물질
				String dryMttrValue = dryMttrValues.item(i).getFirstChild() == null ? "" : dryMttrValues.item(i).getFirstChild().getNodeValue();
				//칼슘
				String clciValue = clciValues.item(i).getFirstChild() == null ? "" : clciValues.item(i).getFirstChild().getNodeValue();
				//인
				String phphValue = phphValues.item(i).getFirstChild() == null ? "" : phphValues.item(i).getFirstChild().getNodeValue();
				//칼륨
				String ptssValue = ptssValues.item(i).getFirstChild() == null ? "" : ptssValues.item(i).getFirstChild().getNodeValue();
				//나트륨
				String naValue = naValues.item(i).getFirstChild() == null ? "" : naValues.item(i).getFirstChild().getNodeValue();
				//마그네슘
				String mgnValue = mgnValues.item(i).getFirstChild() == null ? "" : mgnValues.item(i).getFirstChild().getNodeValue();
				//염소
				String gtValue = gtValues.item(i).getFirstChild() == null ? "" : gtValues.item(i).getFirstChild().getNodeValue();
				//황
				String sulfurValue = sulfurValues.item(i).getFirstChild() == null ? "" : sulfurValues.item(i).getFirstChild().getNodeValue();
%>		
		<tr>
			<th scope="row"><%=inorganicMatterSeNm%></th>
			<td><%=dryMttrValue%></td>
			<td><%=clciValue%></td>
			<td><%=phphValue%></td>
			<td><%=ptssValue%></td>
			<td><%=naValue%></td>
			<td><%=mgnValue%></td>
			<td><%=gtValue%></td>
			<td><%=sulfurValue%></td>
		</tr>
<%
			}
%>			
		</tbody>
	</table>
	
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">철<br>Fe(Mg/Kg)</th>
			<th width="11%">망간<br>Mn(Mg/Kg)</th>
			<th width="11%">코발트<br>Co(Mg/Kg)</th>
			<th width="11%">아연<br>Zn(Mg/Kg)</th>
			<th width="11%">구리<br>Cu(Mg/Kg)</th>
			<th width="11%">불소<br>F(%)</th>
			<th width="11%">분석점수</th>
			<th width="11%">비고</th>
		</tr>
		</thead>
		<tbody>
<% 			
			for(int i=0; i<size; i++){
				//무기물 구분명
				String inorganicMatterSeNm = inorganicMatterSeNms.item(i).getFirstChild() == null ? "" : inorganicMatterSeNms.item(i).getFirstChild().getNodeValue();
				//철
				String seasnValue = seasnValues.item(i).getFirstChild() == null ? "" : seasnValues.item(i).getFirstChild().getNodeValue();
				//망간
				String mangValue = mangValues.item(i).getFirstChild() == null ? "" : mangValues.item(i).getFirstChild().getNodeValue();
				//코발트
				String cbltValue = cbltValues.item(i).getFirstChild() == null ? "" : cbltValues.item(i).getFirstChild().getNodeValue();
				//아연
				String zincValue = zincValues.item(i).getFirstChild() == null ? "" : zincValues.item(i).getFirstChild().getNodeValue();
				//구리
				String copprValue = copprValues.item(i).getFirstChild() == null ? "" : copprValues.item(i).getFirstChild().getNodeValue();
				//불소
				String flrnValue = flrnValues.item(i).getFirstChild() == null ? "" : flrnValues.item(i).getFirstChild().getNodeValue();
				//분석점수
				String analsScoreValue = analsScoreValues.item(i).getFirstChild() == null ? "" : analsScoreValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();
%>		
		<tr>
			<th scope="row"><%=inorganicMatterSeNm%></th>
			<td><%=seasnValue%></td>
			<td><%=mangValue%></td>
			<td><%=cbltValue%></td>
			<td><%=zincValue%></td>
			<td><%=copprValue%></td>
			<td><%=flrnValue%></td>
			<% if(i < 1){ %>
			<th scope="row" rowspan="3"><%=analsScoreValue%></th>
			<th scope="row" rowspan="3"><%=sRm%></th>
			<% } %>
		</tr>
<%
			}
%>			
		</tbody>
	</table>
<%		
		}
	}
	
	//사료 검색 - 아미노산
	if(operationNameMap.containsKey("feedSearchAminoDtl")){
		doc=operationNameMap.get("feedSearchAminoDtl");
	
		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList aminoAcdSeCodeNms = doc.getElementsByTagName("aminoAcdSeCodeNm");
		NodeList takprotValues = doc.getElementsByTagName("takprotValue");
		NodeList cystineValues = doc.getElementsByTagName("cystineValue");
		NodeList mthnValues = doc.getElementsByTagName("mthnValue");
		NodeList asparticAcdValues = doc.getElementsByTagName("asparticAcdValue");
		NodeList thrnValues = doc.getElementsByTagName("thrnValue");
		NodeList serineValues = doc.getElementsByTagName("serineValue");
		NodeList glutamicAcdValues = doc.getElementsByTagName("glutamicAcdValue");
		NodeList prliValues = doc.getElementsByTagName("prliValue");
		NodeList artclysnValues = doc.getElementsByTagName("artclysnValue");
		NodeList alnnValues = doc.getElementsByTagName("alnnValue");
		NodeList valineValues = doc.getElementsByTagName("valineValue");
		NodeList isoliritnwValues = doc.getElementsByTagName("isoliritnwValue");
		NodeList liritnwValues = doc.getElementsByTagName("liritnwValue");
		NodeList tyrsValues = doc.getElementsByTagName("tyrsValue");
		NodeList phnyValues = doc.getElementsByTagName("phnyValue");
		NodeList lysnValues = doc.getElementsByTagName("lysnValue");
		NodeList hstdValues = doc.getElementsByTagName("hstdValue");
		NodeList nh3Values = doc.getElementsByTagName("nh3Value");
		NodeList argnValues = doc.getElementsByTagName("argnValue");
		NodeList trypValues = doc.getElementsByTagName("trypValue");
		NodeList analsScoreValues = doc.getElementsByTagName("analsScoreValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
%>
		<h4>아미노산</h4>
		<table width="100%" border="1" cellSpacing="0" cellPadding="0">
			<thead>
			<tr>
				<th>구분</th>
				<th width="11%">조단백질<br>CP(%)</th>
				<th width="11%">시스틴<br>Cystine</th>
				<th width="11%">메치오닌</th>
				<th width="12%">아스파라틱산<br>Aspartic acid</th>
				<th width="11%">트레오닌<br>Threonine</th>
				<th width="11%">써린<br>Serine</th>
				<th width="11%">글루타믹산<br>Glutamic acid</th>
				<th width="11%">프롤린<br>Proline</th>
			</tr>
			</thead>
			<tbody>
<%
		if(size==0){
%>
			<tr>
				<td colspan="9" align="center">조회한 정보가 없습니다.</td>
			</tr>
<% 			
		}else{
			for(int i=0; i<size; i++){
				//아미노산 구분 코드
				String aminoAcdSeCodeNm = aminoAcdSeCodeNms.item(i).getFirstChild() == null ? "" : aminoAcdSeCodeNms.item(i).getFirstChild().getNodeValue();
				//조단백질
				String takprotValue = takprotValues.item(i).getFirstChild() == null ? "" : takprotValues.item(i).getFirstChild().getNodeValue();
				//시스틴
				String cystineValue = cystineValues.item(i).getFirstChild() == null ? "" : cystineValues.item(i).getFirstChild().getNodeValue();
				//메치오닌
				String mthnValue = mthnValues.item(i).getFirstChild() == null ? "" : mthnValues.item(i).getFirstChild().getNodeValue();
				//아스파라틱산
				String asparticAcdValue = asparticAcdValues.item(i).getFirstChild() == null ? "" : asparticAcdValues.item(i).getFirstChild().getNodeValue();
				//트레오닌
				String thrnValue = thrnValues.item(i).getFirstChild() == null ? "" : thrnValues.item(i).getFirstChild().getNodeValue();
				//써린
				String serineValue = serineValues.item(i).getFirstChild() == null ? "" : serineValues.item(i).getFirstChild().getNodeValue();
				//글루타믹산
				String glutamicAcdValue = glutamicAcdValues.item(i).getFirstChild() == null ? "" : glutamicAcdValues.item(i).getFirstChild().getNodeValue();
				//프롤린
				String prliValue = prliValues.item(i).getFirstChild() == null ? "" : prliValues.item(i).getFirstChild().getNodeValue();
%>		
			<tr>
				<th scope="row"><%=aminoAcdSeCodeNm%></th>
				<td><%=takprotValue%></td>
				<td><%=cystineValue%></td>
				<td><%=mthnValue%></td>
				<td><%=asparticAcdValue%></td>
				<td><%=thrnValue%></td>
				<td><%=serineValue%></td>
				<td><%=glutamicAcdValue%></td>
				<td><%=prliValue%></td>
			</tr>
<%
			}
%>			
		</tbody>
	</table>
	
	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">글라이신<br>Glycine</th>
			<th width="11%">알라닌<br>Alanine</th>
			<th width="11%">바린<br>Valine</th>
			<th width="12%">이소-리우신<br>Iso-leucine</th>
			<th width="11%">리우신<br>Leucine</th>
			<th width="11%">티로신<br>Tyrosine</th>
			<th width="11%">페닐알라닌<br>Phenylalanine</th>
			<th width="11%">라이신<br>Lysine</th>
		</tr>
		</thead>
		<tbody>
<% 			
			for(int i=0; i<size; i++){
				//아미노산 구분 코드
				String aminoAcdSeCodeNm = aminoAcdSeCodeNms.item(i).getFirstChild() == null ? "" : aminoAcdSeCodeNms.item(i).getFirstChild().getNodeValue();
				//글라이신
				String artclysnValue = artclysnValues.item(i).getFirstChild() == null ? "" : artclysnValues.item(i).getFirstChild().getNodeValue();
				//알라닌
				String alnnValue = alnnValues.item(i).getFirstChild() == null ? "" : alnnValues.item(i).getFirstChild().getNodeValue();
				//바린
				String valineValue = valineValues.item(i).getFirstChild() == null ? "" : valineValues.item(i).getFirstChild().getNodeValue();
				//이소-리우신
				String isoliritnwValue = isoliritnwValues.item(i).getFirstChild() == null ? "" : isoliritnwValues.item(i).getFirstChild().getNodeValue();
				//리우신
				String liritnwValue = liritnwValues.item(i).getFirstChild() == null ? "" : liritnwValues.item(i).getFirstChild().getNodeValue();
				//티로신
				String tyrsValue = tyrsValues.item(i).getFirstChild() == null ? "" : tyrsValues.item(i).getFirstChild().getNodeValue();
				//페닐알라닌
				String phnyValue = phnyValues.item(i).getFirstChild() == null ? "" : phnyValues.item(i).getFirstChild().getNodeValue();
				//라이신
				String lysnValue = lysnValues.item(i).getFirstChild() == null ? "" : lysnValues.item(i).getFirstChild().getNodeValue();
%>		
		<tr>
			<th scope="row"><%=aminoAcdSeCodeNm%></th>
			<td><%=artclysnValue%></td>
			<td><%=alnnValue%></td>
			<td><%=valineValue%></td>
			<td><%=isoliritnwValue%></td>
			<td><%=liritnwValue%></td>
			<td><%=tyrsValue%></td>
			<td><%=phnyValue%></td>
			<td><%=lysnValue%></td>
		</tr>
<%
			}
%>			
		</tbody>
	</table>

	<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
		<thead>
		<tr>
			<th>구분</th>
			<th width="11%">히스티딘<br>Fe(Mg/Kg)</th>
			<th width="11%">암모니아<br>Mn(Mg/Kg)</th>
			<th width="11%">아르기닌<br>Co(Mg/Kg)</th>
			<th width="12%">트립토판<br>Zn(Mg/Kg)</th>
			<th width="11%"></th>
			<th width="11%"></th>
			<th width="11%">분석점수</th>
			<th width="11%">비고</th>
		</tr>
		</thead>
		<tbody>
<% 			
			for(int i=0; i<size; i++){
				//아미노산 구분 코드
				String aminoAcdSeCodeNm = aminoAcdSeCodeNms.item(i).getFirstChild() == null ? "" : aminoAcdSeCodeNms.item(i).getFirstChild().getNodeValue();
				//히스티딘	
				String hstdValue = hstdValues.item(i).getFirstChild() == null ? "" : hstdValues.item(i).getFirstChild().getNodeValue();
				//암모니아
				String nh3Value = nh3Values.item(i).getFirstChild() == null ? "" : nh3Values.item(i).getFirstChild().getNodeValue();
				//아르기닌
				String argnValue = argnValues.item(i).getFirstChild() == null ? "" : argnValues.item(i).getFirstChild().getNodeValue();
				//트립토판
				String trypValue = trypValues.item(i).getFirstChild() == null ? "" : trypValues.item(i).getFirstChild().getNodeValue();
				//분석점수
				String analsScoreValue = analsScoreValues.item(i).getFirstChild() == null ? "" : analsScoreValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();
%>		
		<tr>
			<th scope="row"><%=aminoAcdSeCodeNm%></th>
			<td><%=hstdValue%></td>
			<td><%=nh3Value%></td>
			<td><%=argnValue%></td>
			<td><%=trypValue%></td>
			<td></td>
			<td></td>
			<% if(i < 1){ %>
			<th scope="row" rowspan="2"><%=analsScoreValue%></th>
			<th scope="row" rowspan="2"><%=sRm%></th>
			<% } %>
		</tr>
<%
			}
		}
%>			
		</tbody>
	</table>
<%
	}
	
	//사료 검색 - 비타민
	if(operationNameMap.containsKey("feedSearchVitaminDtl")){
		doc=operationNameMap.get("feedSearchVitaminDtl");
	
		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList vtmnSeCodeNms = doc.getElementsByTagName("vtmnSeCodeNm");
		NodeList dryMttrValues = doc.getElementsByTagName("dryMttrValue");
		NodeList catnValues = doc.getElementsByTagName("catnValue");
		NodeList vtmaValues = doc.getElementsByTagName("vtmaValue");
		NodeList vteValues = doc.getElementsByTagName("vteValue");
		NodeList vtb1Values = doc.getElementsByTagName("vtb1Value");
		NodeList vtb2Values = doc.getElementsByTagName("vtb2Value");
		NodeList pnacValues = doc.getElementsByTagName("pnacValue");
		NodeList nacnValues = doc.getElementsByTagName("nacnValue");
		NodeList vtb6Values = doc.getElementsByTagName("vtb6Value");
		NodeList biotinValues = doc.getElementsByTagName("biotinValue");
		NodeList flacValues = doc.getElementsByTagName("flacValue");
		NodeList cholineValues = doc.getElementsByTagName("cholineValue");
		NodeList vtb12Values = doc.getElementsByTagName("vtb12Value");
		NodeList analsScoreValues = doc.getElementsByTagName("analsScoreValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
%>
		<h4>비타민</h4>
		<table width="100%" border="1" cellSpacing="0" cellPadding="0">
			<thead>
			<tr>
				<th>구분</th>
				<th width="11%">건물<br>DM(%)</th>
				<th width="11%">캐로틴<br>Carotin<br>(mg/kg)</th>
				<th width="11%">비타민A<br>VitaminA<br>(mg/kg)</th>
				<th width="11%">비타민E<br>ETocopherol<br>(mg/kg)</th>
				<th width="11%">비타민B1<br>Thiamine<br>(mg/kg)</th>
				<th width="11%">비타민B2<br>Riboflavin<br>(mg/kg)</th>
				<th width="11%">판토텐산<br>Pantothenic<br>acid (mg/kg)</th>
				<th width="11%">나이아신<br>Niacin<br>(mg/kg)</th>
			</tr>
			</thead>
			<tbody>
<%
		if(size==0){
%>
			<tr>
				<td colspan="9" align="center">조회한 정보가 없습니다.</td>
			</tr>
<% 			
		}else{
			for(int i=0; i<size; i++){
				//비타민 구분 명
				String vtmnSeCodeNm = vtmnSeCodeNms.item(i).getFirstChild() == null ? "" : vtmnSeCodeNms.item(i).getFirstChild().getNodeValue();
				//건조물질
				String dryMttrValue = dryMttrValues.item(i).getFirstChild() == null ? "" : dryMttrValues.item(i).getFirstChild().getNodeValue();
				//카로틴
				String catnValue = catnValues.item(i).getFirstChild() == null ? "" : catnValues.item(i).getFirstChild().getNodeValue();
				//비타민A
				String vtmaValue = vtmaValues.item(i).getFirstChild() == null ? "" : vtmaValues.item(i).getFirstChild().getNodeValue();
				//비타민E
				String vteValue = vteValues.item(i).getFirstChild() == null ? "" : vteValues.item(i).getFirstChild().getNodeValue();
				//비타민B1
				String vtb1Value = vtb1Values.item(i).getFirstChild() == null ? "" : vtb1Values.item(i).getFirstChild().getNodeValue();
				//비타민B2
				String vtb2Value = vtb2Values.item(i).getFirstChild() == null ? "" : vtb2Values.item(i).getFirstChild().getNodeValue();
				//판토텐산
				String pnacValue = pnacValues.item(i).getFirstChild() == null ? "" : pnacValues.item(i).getFirstChild().getNodeValue();
				//나이아신
				String nacnValue = nacnValues.item(i).getFirstChild() == null ? "" : nacnValues.item(i).getFirstChild().getNodeValue();
%>		
			<tr>
				<th scope="row"><%=vtmnSeCodeNm%></th>
				<td><%=dryMttrValue%></td>
				<td><%=catnValue%></td>
				<td><%=vtmaValue%></td>
				<td><%=vteValue%></td>
				<td><%=vtb1Value%></td>
				<td><%=vtb2Value%></td>
				<td><%=pnacValue%></td>
				<td><%=nacnValue%></td>
			</tr>
<%
			}
%>			
			</tbody>
		</table>

		<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
			<thead>
			<tr>
				<th>구분</th>
				<th width="11%">비타민B6<br>Pyridoxine<br>(mg/kg)</th>
				<th width="11%">바이오틴<br>Biotin<br>(mg/kg)</th>
				<th width="11%">엽산<br>Folic<br>(mg/kg)</th>
				<th width="11%">콜린<br>Choline<br>(mg/kg)</th>
				<th width="11%">비타민B12<br>VitaminB12<br>(mg/kg)</th>
				<th width="11%"></th>
				<th width="11%">분석점수</th><th width="11%">비고</th>
			</tr>
			</thead>
			<tbody>	
<% 			
			for(int i=0; i<size; i++){
				//비타민 구분 코드
				String vtmnSeCodeNm = vtmnSeCodeNms.item(i).getFirstChild() == null ? "" : vtmnSeCodeNms.item(i).getFirstChild().getNodeValue();
				//비타민B6
				String vtb6Value = vtb6Values.item(i).getFirstChild() == null ? "" : vtb6Values.item(i).getFirstChild().getNodeValue();
				//바이오틴
				String biotinValue = biotinValues.item(i).getFirstChild() == null ? "" : biotinValues.item(i).getFirstChild().getNodeValue();
				//엽산
				String flacValue = flacValues.item(i).getFirstChild() == null ? "" : flacValues.item(i).getFirstChild().getNodeValue();
				//콜린
				String cholineValue = cholineValues.item(i).getFirstChild() == null ? "" : cholineValues.item(i).getFirstChild().getNodeValue();
				//비타민B12
				String vtb12Value = vtb12Values.item(i).getFirstChild() == null ? "" : vtb12Values.item(i).getFirstChild().getNodeValue();
				//분석 점수
				String analsScoreValue = analsScoreValues.item(i).getFirstChild() == null ? "" : analsScoreValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();
%>		
			<tr>
				<th scope="row"><%=vtmnSeCodeNm%></th>
				<td><%=vtb6Value%></td>
				<td><%=biotinValue%></td>
				<td><%=flacValue%></td>
				<td><%=cholineValue%></td>
				<td><%=vtb12Value%></td>
				<td></td>
				<% if(i < 1){ %>
				<th scope="row" rowspan="3"><%=analsScoreValue%></th>
				<th scope="row" rowspan="3"><%=sRm%></th>
				<% } %>
			</tr>
<%
			}
		}
%>			
			</tbody>
		</table>	
<%
	}
	
	//사료 검색 - 세포막
	if(operationNameMap.containsKey("feedSearchCellDtl")){
		doc=operationNameMap.get("feedSearchCellDtl");
	
		int size = doc.getElementsByTagName("item").getLength();
		NodeList items = doc.getElementsByTagName("item");
		NodeList cellThnflmSeCodeNms = doc.getElementsByTagName("cellThnflmSeCodeNm");
		NodeList dryMttrValues = doc.getElementsByTagName("dryMttrValue");
		NodeList ndfValues = doc.getElementsByTagName("ndfValue");
		NodeList adfValues = doc.getElementsByTagName("adfValue");
		NodeList hemicelluloseValues = doc.getElementsByTagName("hemicelluloseValue");
		NodeList ligninValues = doc.getElementsByTagName("ligninValue");
		NodeList celluloseValues = doc.getElementsByTagName("celluloseValue");
		NodeList silictarValues = doc.getElementsByTagName("silictarValue");
		NodeList nfcValues = doc.getElementsByTagName("nfcValue");
		NodeList analsScoreValues = doc.getElementsByTagName("analsScoreValue");
		NodeList sRms = doc.getElementsByTagName("sRm");
%>
		<h4>세포막</h4>
		<table width="100%" border="1" cellSpacing="0" cellPadding="0">
			<thead>
			<tr>
				<th>구분</th>
				<th width="17%">건물<br>DM(%)</th>
				<th width="17%">NDF</th>
				<th width="17%">ADF</th>
				<th width="17%">헤미셀룰로오스<br>Hemicellulose</th>
				<th width="17%">리기닌<br>Lignin</th>
			</tr>
			</thead>
			<tbody>
<%
		if(size==0){
%>
			<tr>
				<td colspan="6" align="center">조회한 정보가 없습니다.</td>
			</tr>
<% 			
		}else{
			for(int i=0; i<size; i++){
				//세포 박막 구분 코드 명
				String cellThnflmSeCodeNm = cellThnflmSeCodeNms.item(i).getFirstChild() == null ? "" : cellThnflmSeCodeNms.item(i).getFirstChild().getNodeValue();
				//건조 물질
				String dryMttrValue = dryMttrValues.item(i).getFirstChild() == null ? "" : dryMttrValues.item(i).getFirstChild().getNodeValue();
				//NDF
				String ndfValue = ndfValues.item(i).getFirstChild() == null ? "" : ndfValues.item(i).getFirstChild().getNodeValue();
				//ADF
				String adfValue = adfValues.item(i).getFirstChild() == null ? "" : adfValues.item(i).getFirstChild().getNodeValue();
				//헤미셀룰로오스
				String hemicelluloseValue = hemicelluloseValues.item(i).getFirstChild() == null ? "" : hemicelluloseValues.item(i).getFirstChild().getNodeValue();
				//리기닌
				String ligninValue = ligninValues.item(i).getFirstChild() == null ? "" : ligninValues.item(i).getFirstChild().getNodeValue();
%>		
			<tr>
				<th scope="row"><%=cellThnflmSeCodeNm%></th>
				<td><%=dryMttrValue%></td>
				<td><%=ndfValue%></td>
				<td><%=adfValue%></td>
				<td><%=hemicelluloseValue%></td>
				<td><%=ligninValue%></td>
			</tr>
<%
			}
%>			
			</tbody>
		</table>	
		
		<table width="100%" border="1" cellSpacing="0" cellPadding="0" style="margin-top: 5px;">
			<thead>
			<tr>
				<th>구분</th>
				<th width="17%">셀룰로오스<br>Cellulose</th>
				<th width="17%">실리카<br>Silica</th>
				<th width="17%">NFC</th>
				<th width="17%">분석점수</th>
				<th width="17%">비고</th>
			</tr>
			</thead>
<% 			
			for(int i=0; i<size; i++){
				//세포 박막 구분 코드 명
				String cellThnflmSeCodeNm = cellThnflmSeCodeNms.item(i).getFirstChild() == null ? "" : cellThnflmSeCodeNms.item(i).getFirstChild().getNodeValue();
				//셀롤로오스
				String celluloseValue = celluloseValues.item(i).getFirstChild() == null ? "" : celluloseValues.item(i).getFirstChild().getNodeValue();
				//실리카
				String silictarValue = silictarValues.item(i).getFirstChild() == null ? "" : silictarValues.item(i).getFirstChild().getNodeValue();
				//NFC
				String nfcValue = nfcValues.item(i).getFirstChild() == null ? "" : nfcValues.item(i).getFirstChild().getNodeValue();
				//분석 점수
				String analsScoreValue = analsScoreValues.item(i).getFirstChild() == null ? "" : analsScoreValues.item(i).getFirstChild().getNodeValue();
				//비고
				String sRm = sRms.item(i).getFirstChild() == null ? "" : sRms.item(i).getFirstChild().getNodeValue();
%>		
			<tr>
				<th scope="row"><%=cellThnflmSeCodeNm%></th>
				<td><%=celluloseValue%></td>
				<td><%=silictarValue%></td>
				<td><%=nfcValue%></td>
				<% if(i < 1){ %>
				<th scope="row" rowspan="3"><%=analsScoreValue%></th>
				<th scope="row" rowspan="3"><%=sRm%></th>
				<% } %>
			</tr>
<%
			}
		}
%>				
			</tbody>
		</table>	
<%
	}
}
%>
<br>
<input type="button" onclick="javascript:location.href='feedSearchList.jsp'" value="목록"/>
</body>
</html>