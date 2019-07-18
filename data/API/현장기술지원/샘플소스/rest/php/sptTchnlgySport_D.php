<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>현장기술지원</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>현장기술지원</strong></h3>
<hr>
<?PHP
//현장기술지원 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "sptTchnlgySport";
	//오퍼레이션 명
	$operationName = "sptTchnlgySportView";

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
	//기술지원일
	$regDt = $object->body[0]->item[0]->regDt;
	//조회수
	$rdcnt = $object->body[0]->item[0]->rdcnt;
	//작성자
	$wrterNm = $object->body[0]->item[0]->wrterNm;
	//품목
	$prdlstCodeNm = $object->body[0]->item[0]->prdlstCodeNm;
	//내용
	$cn = $object->body[0]->item[0]->cn;
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
			<td>품목</td>
			<td colspan="5"><?=$prdlstCodeNm?></td>
		</tr>
		<tr>
			<td>장소</td>
			<td colspan="5"><?=$placeInfo?></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><?=$wrterNm?></td>
			<td>기술지원일</td>
			<td><?=$regDt?></td>
			<td>조회수</td>
			<td><?=$rdcnt?></td>
		</tr>
		<tr>
			<td colspan="6"><?=$cn?></td>
		</tr>
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='sptTchnlgySport.php'" value="처음화면으로"/>&nbsp;
</body>
</html>