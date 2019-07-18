<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>현장애로기술사례</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>현장애로기술사례</strong></h3>
<hr>
<?PHP
//현장애로기술사례 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "elctrnCvpl";
	//오퍼레이션 명
	$operationName = "elctrnCvplView";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["cntntsNo"]!=NULL){
		$parameter .= "&cntntsNo=";
		$parameter .= $_REQUEST["cntntsNo"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);

	//키값
	$cntntsNo = $object->body[0]->item[0]->cntntsNo;
	//제목
	$cntntsSj = $object->body[0]->item[0]->cntntsSj;
	//장소
	$placeInfo = $object->body[0]->item[0]->placeInfo;
	//처리일
	$regDt = $object->body[0]->item[0]->regDt;
	//조회수
	$rdcnt = $object->body[0]->item[0]->rdcnt;
	//작성자
	$wrterNm = $object->body[0]->item[0]->wrterNm;
	//질의내용
	$questDtl = $object->body[0]->item[0]->questDtl;
	//답변내용
	$answerDtl = $object->body[0]->item[0]->answerDtl;
?>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
			<col width="20%">
			<col width="*">
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td>제목</td>
			<td colspan="5"><?=$cntntsSj?></td>
		</tr>
		<tr>
			<td>장소</td>
			<td colspan="5"><?=$placeInfo?></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><?=$wrterNm?></td>
			<td>처리일</td>
			<td><?=$regDt?></td>
			<td>조회수</td>
			<td><?=$rdcnt?></td>
		</tr>
		<tr>
			<td>질의내용</td>
			<td colspan="5"><?=$questDtl?></td>
		</tr>
		<tr>
			<td>답변내용</td>
			<td colspan="5"><?=$answerDtl?></td>
		</tr>
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='elctrnCvpl.php'" value="처음화면으로"/>&nbsp;
</body>
</html>