<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>이달의음식</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>이달의음식</strong></h3>
<hr>
<?PHP
//이달의음식 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "monthFd";
	//오퍼레이션 명
	$operationName = "monthNewFdDtl";

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

	//음식명
	$fdNm = $object->body[0]->item[0]->fdNm;
	//재료정보
	$matrlInfo = $object->body[0]->item[0]->matrlInfo;
	//조리방법정보
	$ckngMthInfo = $object->body[0]->item[0]->ckngMthInfo;
	//단체급식적용정보
	$grpMlsvApplcInfo = $object->body[0]->item[0]->grpMlsvApplcInfo;
	//조리기기 도구정보
	$ckngmhrlsUntInfo = $object->body[0]->item[0]->ckngmhrlsUntInfo;

	//비고정보
	$rmInfo = $object->body[0]->item[0]->rmInfo;
	//인분명
	$phphmntNm = $object->body[0]->item[0]->phphmntNm;
	//에너지량
	$energyQy = $object->body[0]->item[0]->energyQy;
	//탄수화물량
	$crbQy = $object->body[0]->item[0]->crbQy;
	//지질량
	$ntrfsQy = $object->body[0]->item[0]->ntrfsQy;
	//단백질량
	$protQy = $object->body[0]->item[0]->protQy;
	//식이섬유량
	$edblfibrQy = $object->body[0]->item[0]->edblfibrQy;
	//비타민A량
	$vtmaQy = $object->body[0]->item[0]->vtmaQy;
	//비타민E량
	$vteQy = $object->body[0]->item[0]->vteQy;
	//비타민C량
	$vtcQy = $object->body[0]->item[0]->vtcQy;
	//티아민량
	$thiaQy = $object->body[0]->item[0]->thiaQy;
	//리보플라빈량
	$niboplaQy = $object->body[0]->item[0]->niboplaQy;
	//칼슘량
	$clciQy = $object->body[0]->item[0]->clciQy;
	//나트륨량
	$naQy = $object->body[0]->item[0]->naQy;
	//칼륨량
	$ptssQy = $object->body[0]->item[0]->ptssQy;
	//철량
	$irnQy = $object->body[0]->item[0]->irnQy;
	//이미지구분코드
	$rtnImgSeCode = $object->body[0]->item[0]->rtnImgSeCode;
	//이미지 경로
	$rtnFileCours = $object->body[0]->item[0]->rtnFileCours;
	//이미지 물리명
	$rtnStreFileNm = $object->body[0]->item[0]->rtnStreFileNm;
	//이미지 설명
	$rtnImageDc = $object->body[0]->item[0]->rtnImageDc;

	$rtnFileCoursArr = explode('|',$rtnFileCours);
	$rtnStreFileNmArr = explode('|',$rtnStreFileNm);
	$rtnImgSeCodeArr = explode('|',$rtnImgSeCode);
	$rtnImgSeCodeCnt = count($rtnImgSeCodeArr);

	for($k=0; $k < $rtnImgSeCodeCnt; $k++){
		$imgCnt = -1;
		if("209006" == $rtnImgSeCodeArr[$k] || "209007" == $rtnImgSeCodeArr[$k]){
			$imgCnt = $k;
		}
		if($imgCnt > -1){
			$imgUrl = "http://www.nongsaro.go.kr/"+ $rtnFileCoursArr[$imgCnt] +"/"+ $rtnStreFileNmArr[$imgCnt];
?>
			<li style="width: 33%;display: inline-block;">
			<img src="<?=$imgUrl?>" alt=""  title="" style="width: 249px;height: 198px;"/>
			</li>
<?PHP
		}
	}
?>
	<h3><strong><?=$rtnImgSeCodeCnt?>이달의음식 (<?=$fdNm?>)</strong></h3>
	<hr>
	<h2> 기본정보</h2>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:10%;">
			<col width="*">
		</colgroup>
		<tr>
			<td>재료</td>
			<td><?=$matrlInfo?></td>
		</tr>
		<tr>
			<td>만드는 법</td>
			<td><?=$ckngMthInfo?></td>
		</tr>
		<tr>
			<td>단체급식 적용법</td>
			<td><?=$grpMlsvApplcInfo?></td>
		</tr>
	</table>
	<h2><?=$fdNm?> (<?=$phphmntNm?>)</h2>
	<table border="1" cellSpacing="0" cellPadding="0">
			<caption>영양성분 상세표</caption>
			<colgroup>
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="row">에너지<br />(kcal)</th>
					<th scope="row">탄수화물<br />(g)</th>
					<th scope="row">지질<br />(g)</th>
					<th scope="row">단백질<br />(g)</th>
					<th scope="row">식이섬유<br />(g)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt-c"> <?=$energyQy?></td>
					<td class="txt-c"> <?=$crbQy?></td>
					<td class="txt-c"> <?=$ntrfsQy?></td>
					<td class="txt-c"> <?=$protQy?></td>
					<td class="txt-c"> <?=$edblfibrQy?></td>
				</tr>
			</tbody>
		</table>

		<table border="1" cellSpacing="0" cellPadding="0">
			<caption>영양성분 상세표</caption>
			<colgroup>
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
				<col style="width:11%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="row">비타민A<br />(ug RE)</th>
					<th scope="row">비타민E<br />(mg)</th>
					<th scope="row">비타민C<br />(mg)</th>
					<th scope="row">티아민<br />(mg)</th>
					<th scope="row">리보플라빈<br />(mg)</th>
					<th scope="row">칼슘<br />(mg)</th>
					<th scope="row">나트륨<br />(mg)</th>
					<th scope="row">칼륨<br />(mg)</th>
					<th scope="row">철<br />(mg)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt-c"> <?=$vtmaQy?></td>
					<td class="txt-c"> <?=$vteQy?></td>
					<td class="txt-c"> <?=$vtcQy?></td>
					<td class="txt-c"> <?=$thiaQy?></td>
					<td class="txt-c"> <?=$niboplaQy?></td>
					<td class="txt-c"> <?=$clciQy?></td>
					<td class="txt-c"> <?=$naQy?></td>
					<td class="txt-c"> <?=$ptssQy?></td>
					<td class="txt-c"> <?=$irnQy?></td>
				</tr>
			</tbody>
		</table>
<?PHP
		if($ckngmhrlsUntInfo != ""){
			echo "<span>조리기기 및 도구</span><br />";
			echo "<p>";
			echo $ckngmhrlsUntInfo;
			echo "</p>";
		}


}
?>
<br>
<input type="button" onclick="javascript:location.href='monthFd.php'" value="처음화면으로"/>&nbsp;
</body>
</html>