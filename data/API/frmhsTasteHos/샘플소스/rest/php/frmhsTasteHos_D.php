<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농가맛집</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농가맛집</strong></h3>
<hr>
<?PHP
//농가맛집 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "frmhsTasteHos";
	//오퍼레이션 명
	$operationName = "frmhsTasteHosDtl";

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
	//지역명
	$adstrdNm = $object->body[0]->item[0]->adstrdNm;
	//슬로건
	$slogan = $object->body[0]->item[0]->slogan;
	//개요
	$smm = $object->body[0]->item[0]->smm;
	//전화번호
	$telno = $object->body[0]->item[0]->telno;
	//주소
	$locplc = $object->body[0]->item[0]->locplc;
	//운영방법
	$operMth = $object->body[0]->item[0]->operMth;
	//쉬는날
	$restde = $object->body[0]->item[0]->restde;
	//영업시간
	$bsnTime = $object->body[0]->item[0]->bsnTime;
	//취급메뉴
	$trtmntMenu = $object->body[0]->item[0]->trtmntMenu;
	//체험프로그램
	$exprnProgrm = $object->body[0]->item[0]->exprnProgrm;
	//좌석형태
	$seatStle = $object->body[0]->item[0]->seatStle;
	//홈페이지 주소
	$url = $object->body[0]->item[0]->url;
	//주변 관광/볼거리
	$trrsrt = $object->body[0]->item[0]->trrsrt;
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
            		<img src="<?=$imgUrl1?>" style="width:255px; height:178px;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl2 != ""){
				?>
            		<img src="<?=$imgUrl2?>" style="width:255px; height:178px;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl3 != ""){
				?>
            		<img src="<?=$imgUrl3?>" style="width:255px; height:178px;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl4 != ""){
				?>
            		<img src="<?=$imgUrl4?>" style="width:255px; height:178px;"/>
            	<?PHP
					}
				?>
            	<?PHP
					if ($imgUrl5 != ""){
				?>
            		<img src="<?=$imgUrl5?>" style="width:255px; height:178px;"/>
            	<?PHP
					}
				?>
			</td>
		</tr>
		<tr>
			<td>명칭</td>
			<td><?=$cntntsSj?>
			<?PHP
					if ($imgUrl4 != ""){
			?>
			 | <?=$slogan?>
			<?PHP
				}
			?>
			</td>
		</tr>
		<tr>
			<td>지역</td>
			<td><?=$adstrdNm?></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><?=$locplc?></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><?=$telno?></td>
		</tr>
		<tr>
			<td>운영방법</td>
			<td><?=$operMth?></td>
		</tr>
		<tr>
			<td>쉬는날</td>
			<td><?=$restde?></td>
		</tr>
		<tr>
			<td>영업시간</td>
			<td><?=$bsnTime?></td>
		</tr>
		<tr>
			<td>좌석형태</td>
			<td><?=$seatStle?></td>
		</tr>
		<tr>
			<td>홈페이지 주소</td>
			<td><?=$url?></td>
		</tr>
		<tr>
			<td>개요</td>
			<td><?=$smm?></td>
		</tr>
		<tr>
			<td>취급메뉴</td>
			<td><?=$trtmntMenu?></td>
		</tr>
		<tr>
			<td>체험프로그램</td>
			<td><?=$exprnProgrm?></td>
		</tr>
		<tr>
			<td>주변 관광/볼거리</td>
			<td><?=$trrsrt?></td>
		</tr>
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='frmhsTasteHosList.php'" value="처음화면으로"/>&nbsp;
</body>
</html>