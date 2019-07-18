<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>진로체험</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>진로체험</strong></h3>
<hr>
<?PHP
//진로체험 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "schoolGarden";
	//오퍼레이션 명
	$operationName = "schoolGardenDtl";

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

	//제목
	$cntntsSj = $object->body[0]->item[0]->cntntsSj;
	//내용
	$cn = $object->body[0]->item[0]->cn;
	//관련동영상
	$linkUrl = $object->body[0]->item[0]->linkUrl;
	//활동목적
	$actGoalDtl = $object->body[0]->item[0]->actGoalDtl;
	//원예활동
	$gardnactDtl = $object->body[0]->item[0]->gardnactDtl;

	//파일 다운로드 URL
	$downUrl = $object->body[0]->item[0]->downUrl;
	//파일명
	$fileName = $object->body[0]->item[0]->fileName;


	$strDownUrl=explode(';',$downUrl);
	$strFileName=explode(';',$fileName);
?>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td colspan="2"><?=$cntntsSj?></td>
		</tr>
		<tr>
			<td>활동목적</td>
			<td><?=$actGoalDtl?></td>
		</tr>
		<tr>
			<td>원예활동</td>
			<td><?=$gardnactDtl?></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
<?PHP
			$cnt=count($strDownUrl);
			for($i=0; $i<$cnt;$i++){

?>
				<a href="<?=$strDownUrl[$i]?>"><?=$strFileName[$i]?></a><br>
<?PHP
			}
?>
			</td>
		</tr>
		<tr>
			<td>관련동영상</td>
			<td><a target="_blank" href="<?=$linkUrl?>"><?=$linkUrl?></a></td>
		</tr>
	</table>
	<?=$cn?>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='schoolGarden.php'" value="처음화면으로"/>&nbsp;
</body>
</html>