<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>민간약초</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>민간약초</strong></h3>
<hr>
<?PHP
//민간약초 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "prvateTherpy";
	//오퍼레이션 명
	$operationName = "prvateTherpyDtl";

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
	//명칭
	$cntntsSj = $object->body[0]->item[0]->cntntsSj;
	//학명
	$bneNm = $object->body[0]->item[0]->bneNm;
	//생약명
	$hbdcNm = $object->body[0]->item[0]->hbdcNm;
	//이용_부위
	$useeRegn = $object->body[0]->item[0]->useeRegn;
	//형태
	$stle = $object->body[0]->item[0]->stle;
	//민간_요법
	$prvateTherpy = $object->body[0]->item[0]->prvateTherpy;
	//이미지1
	$imgUrl1 = $object->body[0]->item[0]->imgUrl1;
	//이미지2
	$imgUrl2 = $object->body[0]->item[0]->imgUrl2;
	//이미지3
	$imgUrl3 = $object->body[0]->item[0]->imgUrl3;
	//이미지4
	$imgUrl4 = $object->body[0]->item[0]->imgUrl4;
	//이미지5
	$imgUrl5 = $object->body[0]->item[0]->imgUrl5;
	//이미지6
	$imgUrl6 = $object->body[0]->item[0]->imgUrl6;
?>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td colspan="2">
            	<?PHP
					if ($imgUrl1 != ""){
				?>
            		<img src="<?=$imgUrl1?>" style="max-width:255px; height:auto;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl2 != ""){
				?>
            		<img src="<?=$imgUrl2?>" style="max-width:255px; height:auto;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl3 != ""){
				?>
            		<img src="<?=$imgUrl3?>" style="max-width:255px; height:auto;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl4 != ""){
				?>
            		<img src="<?=$imgUrl4?>" style="max-width:255px; height:auto;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl5 != ""){
				?>
            		<img src="<?=$imgUrl5?>" style="max-width:255px; height:auto;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl6 != ""){
				?>
            		<img src="<?=$imgUrl6?>" style="max-width:255px; height:auto;"/>
            	<?PHP
					}
				?>
			</td>
		</tr>
		<tr>
			<td>명칭</td>
			<td><?=$cntntsSj?></td>
		</tr>
		<tr>
			<td>학명</td>
			<td><?=$bneNm?></td>
		</tr>
		<tr>
			<td>생약명</td>
			<td><?=$hbdcNm?></td>
		</tr>
		<tr>
			<td>이용부위</td>
			<td><?=$useeRegn?></td>
		</tr>
		<tr>
			<td>형태</td>
			<td><?=$stle?></td>
		</tr>
		<tr>
			<td>민간요법</td>
			<td><?=$prvateTherpy?></td>
		</tr>
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='prvateTherpyList.php'" value="처음화면으로"/>&nbsp;
</body>
</html>