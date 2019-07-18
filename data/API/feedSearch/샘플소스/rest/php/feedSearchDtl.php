<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>사료 검색</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>사료 검색 상세</strong></h3>
<hr>
<?PHP
//사료 검색 상세조회
if(isset($_REQUEST["hsrrlManageNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를입력하세요";
	//서비스 명
	$serviceName = "feedSearch";
	//오퍼레이션 명
	$operationName = array("feedSearchInfoDtl", "feedSearchMineralDtl", "feedSearchNutritiveDtl", "feedSearchDigestDtl", "feedSearchAminoDtl", "feedSearchVitaminDtl", "feedSearchCellDtl", "feedSearchChemDtl");

	$urls = array();

	for($i=0; $i<count($operationName); $i++){
		//XML 받을 URL 생성
		$parameter = "/".$serviceName."/".$operationName[$i];
		$parameter .= "?apiKey=".$apiKey;

		if($_REQUEST["hsrrlManageNo"]!=NULL){
		$parameter .= "&hsrrlManageNo=";
		$parameter .= $_REQUEST["hsrrlManageNo"];
		}

		$url = "http://api.nongsaro.go.kr/service" . $parameter; 
		
		$urls[$operationName[$i]] = $url;
	}


	if(array_key_exists("feedSearchInfoDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchInfoDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);

		//사료 관리 번호
		$hsrrlManageNo = $object->body[0]->item[0]->hsrrlManageNo;
		//년도
		$year = $object->body[0]->item[0]->year;
		//사료 번호
		$hsrrlNo = $object->body[0]->item[0]->hsrrlNo;
		//한글 명
		$koreanNm = $object->body[0]->item[0]->koreanNm;
		//영문 명
		$engNm = $object->body[0]->item[0]->engNm;
		//사료 품목 코드 명
		$hsrrlPrdlstCodeNm = $object->body[0]->item[0]->hsrrlPrdlstCodeNm;
		//사료 종류
		$hsrrlPrdlstCodeLclasNm = $object->body[0]->item[0]->hsrrlPrdlstCodeLclasNm;
?>
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
				<td><?=$koreanNm?></td>
				<th scope="row">영문사료명</th>
				<td><?=$engNm?></td>
			</tr>
			<tr>
				<th scope="row">사료종류</th>
				<td><?=$hsrrlPrdlstCodeLclasNm?></td>
				<th scope="row">사료구분</th>
				<td><?=$hsrrlPrdlstCodeNm?></td>
			</tr>
			<tr>
				<th scope="row">사료년도</th>
				<td><?=$year?></td>
				<th scope="row">사료번호</th>
				<td><?=$hsrrlNo?></td>
			</tr>
		</tbody>
	</table>
<?PHP
	}
	
	//사료 검색 - 일반 조성분
	if(array_key_exists("feedSearchMineralDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchMineralDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		$index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//일반 조성분 구분 코드 명
			$gnrlmakemntSeNm = $item->gnrlmakemntSeNm;
			//수분
			$mitrValue = $item->mitrValue;
			//조 단백질
			$takprotValue = $item->takprotValue;
			//조지방
			$cuftValue = $item->cuftValue;
			//가용무기질소물
			$usefulRdshNtrgwaterValue = $item->usefulRdshNtrgwaterValue;
			//조섬유
			$crfbValue = $item->crfbValue;
			//조회분
			$inqiremntValue = $item->inqiremntValue;
			//분석점수
			$analsScoreValue = $item->analsScoreValue;
			//비고
			$sRm = $item->sRm;

			
?>
			<tr>
				<th scope="row"><?=$gnrlmakemntSeNm?></th>
				<td><?=$mitrValue?></td>
				<td><?=$takprotValue?></td>
				<td><?=$cuftValue?></td>
				<td><?=$usefulRdshNtrgwaterValue?></td>
				<td><?=$crfbValue?></td>
				<td><?=$inqiremntValue?></td>
				<?PHP if($index == 0){ ?>
				<td rowspan="3"><?=$analsScoreValue?></td>
				<td rowspan="3"><?=$sRm?></td>
				<?PHP } ?>
			</tr>

<?PHP	
			$index++;
		}
	echo "</tbody></table>";
	}

	//사료 검색 - 영양가
	if(array_key_exists("feedSearchNutritiveDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchNutritiveDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		$index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//영양가 축종 명
			$ntrtmpyKdlsNm = $item->ntrtmpyKdlsNm;
			//영야가 구분 명
			$ntrtmpySeNm = $item->ntrtmpySeNm;
			//TDN
			$tdngValue = $item->tdngValue;
			//DE
			$deValue = $item->deValue;
			//ME
			$methylValue = $item->methylValue;
			//TME
			$trmreValue = $item->trmreValue;
			//NEM
			$nemValue = $item->nemValue;
			//NEG
			$negValue = $item->negValue;
			//NEL
			$nelValue = $item->nelValue;
			//GE
			$geValue = $item->geValue;
			//비고
			$sRm = $item->sRm;

			
?>
		<tr>
			<?PHP if(($index+1) % 2 > 0){ ?>
			<th scope="row" rowspan="2"><?=$ntrtmpySeNm?></th>
			<?PHP } ?>
			<th scope="row"><?=$ntrtmpyKdlsNm?></th>
			<td><?=$tdngValue?></td>
			<td><?=$deValue?></td>
			<td><?=$geValue?></td>
			<td><?=$methylValue?></td>
			<td><?=$trmreValue?></td>
			<td><?=$nemValue?></td>
			<td><?=$negValue?></td>
			<td><?=$nelValue?></td>
			<?PHP if(($index+1) % 2 > 0){ ?>
			<th scope="row" rowspan="2"><?=$sRm?></th>
			<?PHP } ?>
		</tr>

<?PHP	
			$index++;
		}
	echo "</tbody></table>";
	}


	//사료 검색 - 소화율
	if(array_key_exists("feedSearchDigestDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchDigestDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		$index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//소화율 축종 명
			$frexrtKdlsNm= $item->frexrtKdlsNm;
			//소화율 구분 명
			$frexrtSeNm = $item->frexrtSeNm;
			//건조 물질
			$dryMttrValue = $item->dryMttrValue;
			//단백질
			$protValue = $item->protValue;
			//지방
			$lcltyValue = $item->lcltyValue;
			//가용무질소물
			$usefulRdshNtrgwaterValue = $item->usefulRdshNtrgwaterValue;
			//섬유
			$fberValue = $item->fberValue;
			//분석 점수
			$analsScoreValue = $item->analsScoreValue;
			//비고
			$sRm = $item->sRm;
			
?>
		<tr>
			<?PHP if(($index+1) % 2 > 0){ ?>
			<th scope="row" rowspan="2"><?=$frexrtSeNm?></th>
			<?PHP } ?>
			<th scope="row"><?=$frexrtKdlsNm?></th>
			<td><?=$dryMttrValue?></td>
			<td><?=$protValue?></td>
			<td><?=$lcltyValue?></td>
			<td><?=$usefulRdshNtrgwaterValue?></td>
			<td><?=$fberValue?></td>
			<?PHP if(($index+1) % 2 > 0){ ?>
			<th scope="row" rowspan="2"><?=$analsScoreValue?></th>
			<th scope="row" rowspan="2"><?=$sRm?></th>
			<?PHP } ?>
		</tr>

<?PHP	
			$index++;
		}
	echo "</tbody></table>";
	}


	//사료 검색 - 무기질
	if(array_key_exists("feedSearchChemDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchChemDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		$index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//무기물 구분 명
			$inorganicMatterSeNm= $item->inorganicMatterSeNm;
			//건조 물질
			$dryMttrValue= $item->dryMttrValue;
			//칼슘
			$clciValue= $item->clciValue;
			//인
			$phphValue= $item->phphValue;
			//칼륨
			$ptssValue= $item->ptssValue;
			//나트륨
			$naValue= $item->naValue;
			//마그네슘
			$mgnValue= $item->mgnValue;
			//염소 
			$gtValue= $item->gtValue;
			//황
			$sulfurValue= $item->sulfurValue;
?>
		<tr>
			<th scope="row"><?=$inorganicMatterSeNm?></th>
			<td><?=$dryMttrValue?></td>
			<td><?=$clciValue?></td>
			<td><?=$phphValue?></td>
			<td><?=$ptssValue?></td>
			<td><?=$naValue?></td>
			<td><?=$mgnValue?></td>
			<td><?=$gtValue?></td>
			<td><?=$sulfurValue?></td>
		</tr>

<?PHP	
			$index++;
		}
		echo "</tbody></table>";

?>
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
<?PHP
		$index1 = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//무기물 구분명
			$inorganicMatterSeNm= $item->inorganicMatterSeNm;
			//철
			$seasnValue= $item->seasnValue;
			//망간
			$mangValue= $item->mangValue;
			//코발트
			$cbltValue= $item->cbltValue;
			//아연
			$zincValue= $item->zincValue;
			//구리
			$copprValue= $item->copprValue;
			//불소
			$flrnValue= $item->flrnValue;
			//분석점수
			$analsScoreValue= $item->analsScoreValue;
			//비고
			$sRm= $item->sRm;

?>
			<tr>
				<th scope="row"><?=$inorganicMatterSeNm?></th>
				<td><?=$seasnValue?></td>
				<td><?=$mangValue?></td>
				<td><?=$cbltValue?></td>
				<td><?=$zincValue?></td>
				<td><?=$copprValue?></td>
				<td><?=$flrnValue?></td>
				<?PHP if($index1 < 1){ ?>
				<td rowspan="3"><?=$analsScoreValue?></td>
				<td rowspan="3"><?=$sRm?></td>
				<?PHP } ?>
			</tr>

<?PHP	
			$index1++;
		}
		echo "</tbody></table>";
	}

	
	//사료 검색 - 아미노산
	if(array_key_exists("feedSearchAminoDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchAminoDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//아미노산 구분 코드
			$aminoAcdSeCodeNm= $item->aminoAcdSeCodeNm;
			//조단백질
			$takprotValue= $item->takprotValue;
			//시스틴
			$cystineValue= $item->cystineValue;
			//메치오닌
			$mthnValue= $item->mthnValue;
			//아스파라틱산
			$asparticAcdValue= $item->asparticAcdValue;
			//트레오닌
			$thrnValue= $item->thrnValue;
			//써린
			$serineValue= $item->serineValue;
			//글루타믹산
			$glutamicAcdValue= $item->glutamicAcdValue;
			//프롤린
			$prliValue= $item->prliValue;

?>
		<tr>
			<th scope="row"><?=$aminoAcdSeCodeNm?></th>
			<td><?=$takprotValue?></td>
			<td><?=$cystineValue?></td>
			<td><?=$mthnValue?></td>
			<td><?=$asparticAcdValue?></td>
			<td><?=$thrnValue?></td>
			<td><?=$serineValue?></td>
			<td><?=$glutamicAcdValue?></td>
			<td><?=$prliValue?></td>
		</tr>

<?PHP	
		}
		echo "</tbody></table>";

?>
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
		<tbody>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//아미노산 구분 코드
			$aminoAcdSeCodeNm= $item->aminoAcdSeCodeNm;
			//글라이신
			$artclysnValue= $item->artclysnValue;
			//알리닌
			$alnnValue= $item->alnnValue;
			//바린
			$valineValue= $item->valineValue;
			//이소-리우신
			$isoliritnwValue= $item->isoliritnwValue;
			//리우신
			$liritnwValue= $item->liritnwValue;
			//티로신
			$tyrsValue= $item->tyrsValue;
			//페닐알라닌
			$phnyValue= $item->phnyValue;
			//라이신
			$lysnValue= $item->lysnValue;
?>
		<tr>
			<th scope="row"><?=$aminoAcdSeCodeNm?></th>
			<td><?=$artclysnValue?></td>
			<td><?=$alnnValue?></td>
			<td><?=$valineValue?></td>
			<td><?=$isoliritnwValue?></td>
			<td><?=$liritnwValue?></td>
			<td><?=$tyrsValue?></td>
			<td><?=$phnyValue?></td>
			<td><?=$lysnValue?></td>
		</tr>

<?PHP	
		}
		echo "</tbody></table>";

?>
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
<?PHP
		$index=0;
		foreach($object->body[0]->items[0]->item as $item){
			//아미노산 구분 코드
			$aminoAcdSeCodeNm= $item->aminoAcdSeCodeNm;
			//히스타민
			$hstdValue= $item->hstdValue;
			//암모니아
			$nh3Value= $item->nh3Value;
			//아르기닌
			$argnValue= $item->argnValue;
			//트립토판
			$trypValue= $item->trypValue;
			//분석점수
			$analsScoreValue= $item->analsScoreValue;
			//비고
			$sRm= $item->sRm;
?>
		<tr>
			<th scope="row"><?=$aminoAcdSeCodeNm?></th>
			<td><?=$hstdValue?></td>
			<td><?=$nh3Value?></td>
			<td><?=$argnValue?></td>
			<td><?=$trypValue?></td>
			<td></td>
			<td></td>
			<?PHP if($index < 1){ ?>
			<td rowspan="3"><?=$analsScoreValue?></td>
			<td rowspan="3"><?=$sRm?></td>
			<?PHP } ?>
		</tr>
<?PHP	
		$index++;
		}
		echo "</tbody></table>";

	}


	//사료 검색 - 비타민
	if(array_key_exists("feedSearchVitaminDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchVitaminDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//비타민 구분 명
			$vtmnSeCodeNm= $item->vtmnSeCodeNm;
			//건조물질
			$dryMttrValue= $item->dryMttrValue;
			//카로틴
			$catnValue= $item->catnValue;
			//비타민A
			$vtmaValue= $item->vtmaValue;
			//비타민E
			$vteValue= $item->vteValue;
			//비타민B1
			$vtb1Value= $item->vtb1Value;
			//비타민B2
			$vtb2Value= $item->vtb2Value;
			//판토텐산
			$pnacValue= $item->pnacValue;
			//나이아신
			$nacnValue= $item->nacnValue;
?>
		<tr>
			<th scope="row"><?=$vtmnSeCodeNm?></th>
			<td><?=$dryMttrValue?></td>
			<td><?=$catnValue?></td>
			<td><?=$vtmaValue?></td>
			<td><?=$vteValue?></td>
			<td><?=$vtb1Value?></td>
			<td><?=$vtb2Value?></td>
			<td><?=$pnacValue?></td>
			<td><?=$nacnValue?></td>
		</tr>

<?PHP	
		}
		echo "</tbody></table>";

?>
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
<?PHP
		$index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//비타민 구분 코드
			$vtmnSeCodeNm= $item->vtmnSeCodeNm;
			//비타민B6
			$vtb6Value= $item->vtb6Value;
			//바이오틴
			$biotinValue= $item->biotinValue;
			//엽산
			$flacValue= $item->flacValue;
			//콜린
			$cholineValue= $item->cholineValue;
			//비타민B12
			$vtb12Value= $item->vtb12Value;
			//분석 점수
			$analsScoreValue= $item->analsScoreValue;
			//비고
			$sRm= $item->sRm;
?>
			<tr>
				<th scope="row"><?=$vtmnSeCodeNm?></th>
				<td><?=$vtb6Value?></td>
				<td><?=$biotinValue?></td>
				<td><?=$flacValue?></td>
				<td><?=$cholineValue?></td>
				<td><?=$vtb12Value?></td>
				<td></td>
				<?PHP if($index < 1){ ?>
				<td rowspan="3"><?=$analsScoreValue?></td>
				<td rowspan="3"><?=$sRm?></td>
				<?PHP } ?>
			</tr>

<?PHP	
			$index++;
		}
		echo "</tbody></table>";
	}

	//사료 검색 - 세포막
	if(array_key_exists("feedSearchCellDtl", $urls)){
		//XML Parsing
		$xml = file_get_contents($urls["feedSearchCellDtl"]);
		//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
		$object = simplexml_load_string($xml);
?>
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
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//세포 박막 구분 코드 명
			$cellThnflmSeCodeNm= $item->cellThnflmSeCodeNm;
			//건조 물질
			$dryMttrValue= $item->dryMttrValue;
			//NDF
			$ndfValue= $item->ndfValue;
			//ADF
			$adfValue= $item->adfValue;
			//헤미셀룰로오스
			$hemicelluloseValue= $item->hemicelluloseValue;
			//리기닌
			$ligninValue= $item->ligninValue;

?>
		<tr>
			<th scope="row"><?=$cellThnflmSeCodeNm?></th>
			<td><?=$dryMttrValue?></td>
			<td><?=$ndfValue?></td>
			<td><?=$adfValue?></td>
			<td><?=$hemicelluloseValue?></td>
			<td><?=$ligninValue?></td>
		</tr>

<?PHP	
		}
		echo "</tbody></table>";

?>
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
<?PHP
		$index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//세포 박막 구분 코드 명
			$cellThnflmSeCodeNm= $item->cellThnflmSeCodeNm;
			//셀롤로오스
			$celluloseValue= $item->celluloseValue;
			//실리카
			$silictarValue= $item->silictarValue;
			//NFC
			$nfcValue= $item->nfcValue;
			//분석 점수
			$analsScoreValue= $item->analsScoreValue;
			//비고
			$sRm= $item->sRm;
?>
			<tr>
				<th scope="row"><?=$cellThnflmSeCodeNm?></th>
				<td><?=$celluloseValue?></td>
				<td><?=$silictarValue?></td>
				<td><?=$nfcValue?></td>
				<?PHP if($index < 1){ ?>
				<td rowspan="3"><?=$analsScoreValue?></td>
				<td rowspan="3"><?=$sRm?></td>
				<?PHP } ?>
			</tr>

<?PHP	
			$index++;
		}
		echo "</tbody></table>";
	}
}
?>

<br>
<input type="button" onclick="javascript:location.href='feedSearchList.php'" value="목록"/>
</body>
</html>