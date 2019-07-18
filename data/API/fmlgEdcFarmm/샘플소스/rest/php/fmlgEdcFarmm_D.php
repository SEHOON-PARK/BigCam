<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농촌교육농장</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농촌교육농장</strong></h3>
<hr>
<?PHP
//농촌교육농장 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "fmlgEdcFarmm";
	//오퍼레이션 명
	$operationName = "fmlgEdcFarmmDtl";

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
	//소재지
	$locplc = $object->body[0]->item[0]->locplc;
	//주제
	$thema = $object->body[0]->item[0]->thema;
	//지정연도
	$appnYear = $object->body[0]->item[0]->appnYear;
	//홈페이지주소
	$url = $object->body[0]->item[0]->url;
	//연락처
	$telno = $object->body[0]->item[0]->telno;
	//품질인증연도
	$crtfcYearInfo = $object->body[0]->item[0]->crtfcYearInfo;
	//내용
	$cn = $object->body[0]->item[0]->cn;
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
			<td>제목</td>
			<td><?=$cntntsSj?></td>
		</tr>
		<tr>
			<td>소재지</td>
			<td><?=$locplc?></td>
		</tr>
		<tr>
			<td>주제</td>
			<td><?=$thema?></td>
		</tr>
		<tr>
			<td>지정연도</td>
			<td><?=$appnYear?></td>
		</tr>
		<tr>
			<td>홈페이지주소</td>
			<td><?=$url?></td>
		</tr>
		<tr>
			<td>연락처</td>
			<td><?=$telno?></td>
		</tr>
		<tr>
			<td>품질인증연도</td>
			<td><?=$crtfcYearInfo?></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><?=$cn?></td>
		</tr>
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='fmlgEdcFarmmList.php'" value="처음화면으로"/>&nbsp;
</body>
</html>