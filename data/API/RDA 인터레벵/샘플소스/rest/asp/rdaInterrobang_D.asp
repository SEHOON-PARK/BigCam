<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>RDA 인테러뱅</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>RDA 인테러뱅</strong></h3>
<hr>

<%
'인테러뱅 상세 조회
If Not Request("dataNo") Is Nothing And Request("dataNo") <> "" Then
	'apiKey - 농사로 Open API에서 신청 후 승인되면 확인가능
	apiKey = "발급받은인증키를삽입하세요"
	'서비스 명
	serviceName = "rdaInterrobang"
	'오퍼레이션 명
	operationName = "interrobangView"
	
	'XML 받을 URL 생성
	parameter = "/" & serviceName & "/" & operationName
	parameter = parameter & "?apiKey="&apiKey
	parameter = parameter & "&dataNo=" & Request("dataNo")
	
	targetURL = "http://api.nongsaro.go.kr/service" & parameter
	
	'농사로 Open API 통신 시작
	Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
	xmlHttp.Open "GET", targetURL, False   
	xmlHttp.Send    
	
	Set oStream = CreateObject("ADODB.Stream")   
	oStream.Open   
	oStream.Position = 0   
	oStream.Type = 1   
	oStream.Write xmlHttp.ResponseBody   
	oStream.Position = 0   
	oStream.Type = 2   
	oStream.Charset = "utf-8"   
	sText = oStream.ReadText   
	oStream.Close   
	
	Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
	xmlDOM.async = False    
	xmlDOM.LoadXML sText   
	'농사 Open API 통신 끝
	
	Set item = xmlDOM.SelectNodes("//body")
	cnt = item(0).childNodes.length

	If cnt = 0 Then
		Response.Write("<h3>조회한 정보가 없습니다.</h3>")
	Else
		'요약
		Set contList = xmlDOM.SelectNodes("//contList")
		If Not contList(0) Is Nothing Then contListText= contList(0).Text Else contListText = "" End If
		'목차
		Set content = xmlDOM.SelectNodes("//content")
		If Not content(0) Is Nothing Then contentText= content(0).Text Else contentText = "" End If
		'키값
		Set dataNo = xmlDOM.SelectNodes("//dataNo")
		If Not dataNo(0) Is Nothing Then dataNoText= dataNo(0).Text Else weedsKorNameText = "" End If
		'파일 다운로드 URL
		Set downUrl = xmlDOM.SelectNodes("//downUrl")
		If Not downUrl(0) Is Nothing Then downUrlText= downUrl(0).Text Else downUrlText = "" End If
		'파일명
		Set fileName = xmlDOM.SelectNodes("//fileName")
		If Not fileName(0) Is Nothing Then fileNameText= fileName(0).Text Else fileNameText = "" End If
		'조회수
		Set hitCt = xmlDOM.SelectNodes("//hitCt")
		If Not hitCt(0) Is Nothing Then hitCtText= hitCt(0).Text Else hitCtText = "" End If
		'평점
		Set optGrade = xmlDOM.SelectNodes("//optGrade")
		If Not optGrade(0) Is Nothing Then optGradeText= optGrade(0).Text Else optGradeText = "" End If
		'댓글 수
		Set optNum = xmlDOM.SelectNodes("//optNum")
		If Not optNum(0) Is Nothing Then optNumText= optNum(0).Text Else optNumText = "" End If
		'등록일
		Set regDt = xmlDOM.SelectNodes("//regDt")
		If Not regDt(0) Is Nothing Then regDtText= regDt(0).Text Else regDtText = "" End If
		'평가회원수
		Set scoreCnt = xmlDOM.SelectNodes("//scoreCnt")
		If Not scoreCnt(0) Is Nothing Then scoreCntText= scoreCnt(0).Text Else scoreCntText = "" End If
		'제목
		Set subject = xmlDOM.SelectNodes("//subject")
		If Not subject(0) Is Nothing Then subjectText= subject(0).Text Else subjectText = "" End If
		'글쓴이 이메일
		Set writerEmail = xmlDOM.SelectNodes("//writerEmail")
		If Not writerEmail(0) Is Nothing Then writerEmailText= writerEmail(0).Text Else writerEmailText = "" End If
		'글쓴이
		Set writerNm = xmlDOM.SelectNodes("//writerNm")
		If Not writerNm(0) Is Nothing Then writerNmText= writerNm(0).Text Else writerNmText = "" End If

		s_downUrl=Split(downUrlText,";")
		s_fileName=Split(fileNameText,";")

%>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td>제목</td>
			<td><%=subjectText%></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=regDtText%>&nbsp;<%=writerNmText%>&nbsp;(<%=writerEmailText%>)</td>
		</tr>
		<tr>
			<td>평점</td>
			<td><%=optGradeText%>점/5점만점(rda.go.kr회원<%=scoreCntText%>분이평가한점수입니다.)</td>
		</tr>
		<tr>
			<td>요약</td>
			<td><%=contListText%></td>
		</tr>
		<tr>
			<td>목차</td>
			<td><%=contentText%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
<%
			For j=0 To UBound(s_downUrl)
%>
				<a href="<%=s_downUrl(j)%>"><%=s_fileName(j)%></a><br>
<%				
			Next
%>
			</td>
		</tr>
	</table>
<%
	End If
End If
%>
<input type="button" onclick="javascript:location.href='rdaInterrobang.asp'" value="처음화면으로"/>&nbsp;
</body>
</html>