<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>


<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>반려동물 집밥원료</title>
<script type='text/javascript'>
//검색
function fncSearch(){
	with(document.searchApiForm){
		pageNo.value = "1";
		method="get";
		action = "feedRawMaterialList.php";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "feedRawMaterialList.php";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>반려동물 집밥원료</strong></h3>
<hr>
<?PHP
$sFeedNm = isset($_REQUEST["sFeedNm"]) ? $_REQUEST["sFeedNm"] : "" ;
$upperListSel = isset($_REQUEST["upperListSel"]) ? $_REQUEST["upperListSel"] : "" ;
?>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<colgroup>
		<col width="100%"/>
	</colgroup>
	<tr>
		<td>
<?PHP
//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
$apiKey = "nongsaroSampleKey";
//서비스 명
$serviceName = "feedRawMaterial";
//오퍼레이션 명
$operationName = array("upperList");

$urls = array();


for($i=0; $i<count($operationName); $i++){
  //XML 받을 URL 생성
  $parameter = "/".$serviceName."/".$operationName[$i];
  $parameter .= "?apiKey=".$apiKey;

  $url = "http://api.nongsaro.go.kr/service" . $parameter;

  $urls[$operationName[$i]] = $url;
}

$codes = "";
$codeNm = "";

for($i=0; $i<count($operationName); $i++){
  //오퍼레이션명
  $operNm = $operationName[$i];

  //XML Parsing
  $xml = file_get_contents($urls[$operationName[$i]]);
  //PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
  $object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
	echo "조회한 정보가 없습니다.";
	}else{
    $index = 0;
		foreach($object->body[0]->items[0]->item as $item){
			//코드
			$code = $item->code;
			//코드명
			$codeNm = $item->codeNm;

      if ($operNm == "upperList"){
        if($index == 0){
?>
        <select id="upperListSel" name="upperListSel">
        <option value="">전체</option>
<?PHP
        }
?>
        <option value="<?=$code?>" <?= $upperListSel == $code ? "selected" : "" ?> ><?=$codeNm?></option>
<?PHP
      }
    $index = $index + 1;
		}
  }
  if($operNm =="upperList"){
    echo "</select>";
  }
}
?>
			<input type="text" name="sFeedNm" value="<?PHP if(isset($_REQUEST["sFeedNm"])){ echo $_REQUEST["sFeedNm"]; }?>">
			<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
		</td>
	</tr>
</table>
</form>
<hr>
<?PHP
if(true){
	//오퍼레이션 명
	$operationName = "feedRawMaterialList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
//여기만수정
	 $srchNmArr = array("pageNo","sFeedNm");

	  for($i=0; $i<sizeof($srchNmArr); $i++){
	    if(isset($_REQUEST[$srchNmArr[$i]])){
	      $parameter .= "&".$srchNmArr[$i]."=".$_REQUEST[$srchNmArr[$i]];
	    }
	  }
	$parameter .= "&upperFeedClCode=".$upperListSel;




	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
	   echo "조회한 정보가 없습니다.";
	}else{
?>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<tr>
    	<th width="4%">출처</th>
    	<th width="*">원료</th>
    	<th width="4%">원료가격(원/kg)</th>
    	<th width="4%">건물(%)</th>
    	<th width="4%">수분(%)</th>
    	<th width="4%">단백질(%)</th>
    	<th width="4%">트립토판(%)</th>
    	<th width="4%">칼슘(%)</th>
    	<th width="4%">인(%)</th>
    	<th width="4%">지방(%)</th>
    	<th width="4%">리놀레산(%)</th>
    	<th width="4%">리놀렌산(%)</th>
    	<th width="4%">회분(%)</th>
    	<th width="4%">비타민 A(RE/100g)</th>
    	<th width="4%">탄수화물(%)</th>
    	<th width="4%">조섬유(%)</th>
    	<th width="4%">총식이섬유(%)</th>
    	<th width="4%">불용성식이섬유(%)</th>
    	<th width="4%">수용성식이섬유(%)</th>
    	<th width="4%">나트륨(%)</th>
    	<th width="4%">칼륨(%)</th>
    	</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){

			$originNm = $item->originNm;
			$feedClCodeNm = $item->feedClCodeNm;
			$feedNm = $item->feedNm;
			$mtralPc = $item->mtralPc;
			$dryMatter = $item->dryMatter;
			$mitrQy = $item->mitrQy;
			$protQy = $item->protQy;
			$trypQy = $item->trypQy;
			$clciQy = $item->clciQy;
			$phphQy = $item->phphQy;
			$fatQy = $item->fatQy;
			$lnacQy = $item->lnacQy;
			$liacQy = $item->liacQy;
			$ashsQy = $item->ashsQy;
			$vtmaQy = $item->vtmaQy;
			$crbQy = $item->crbQy;
			$crfbQy = $item->crfbQy;
			$totEdblfibrQy = $item->totEdblfibrQy;
			$inslbltyEdblfibrQy = $item->inslbltyEdblfibrQy;
			$slwtEdblfibrQy = $item->slwtEdblfibrQy;
			$naQy = $item->naQy;
			$ptssQy = $item->ptssQy;

?>

    	<tr>
				<td width="4%"><?=$originNm?></td>
				<td width="*"><?=$feedClCodeNm?> > <?=$feedNm?></td>
				<td width="4%"><?=$mtralPc?></td>
				<td width="4%"><?=$dryMatter?></td>
				<td width="4%"><?=$mitrQy?></td>
				<td width="4%"><?=$protQy?></td>
				<td width="4%"><?=$trypQy?></td>
				<td width="4%"><?=$clciQy?></td>
				<td width="4%"><?=$phphQy?></td>
				<td width="4%"><?=$fatQy?></td>
				<td width="4%"><?=$lnacQy?></td>
				<td width="4%"><?=$liacQy?></td>
				<td width="4%"><?=$ashsQy?></td>
				<td width="4%"><?=$vtmaQy?></td>
				<td width="4%"><?=$crbQy?></td>
				<td width="4%"><?=$crfbQy?></td>
				<td width="4%"><?=$totEdblfibrQy?></td>
				<td width="4%"><?=$inslbltyEdblfibrQy?></td>
				<td width="4%"><?=$slwtEdblfibrQy?></td>
				<td width="4%"><?=$naQy?></td>
				<td width="4%"><?=$ptssQy?></td>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP
	}
//페이징 처리
	//한 페이지에 제공할 건수
	$numOfRows = $object->body[0]->items[0]->numOfRows;
	//조회된 총 건수
	$totalCount = $object->body[0]->items[0]->totalCount;
	//조회할 페이지 번호
	$pageNo = $object->body[0]->items[0]->pageNo;

	$pageGroupSize = 10;
	$pageSize = 0;

	$pageSize = (int)$numOfRows;
	if($pageSize==0) $pageSize=10;

	$start = (int)$pageNo;
	if($start==0)$start=1;

	$currentPage = (int)$pageNo;

	$startRow = ($currentPage -1) * $pageSize +1;//한 페이지의 시작글 번호
	$endRow = $currentPage * $pageSize;//한 페이지의 마지막 글번호

	$count = (int)$totalCount;
	$number=0;

	$number=$count-($currentPage-1)*$pageSize;//글목록에 표시할 글번호

	//페이지그룹의 갯수
	//ex) pageGroupSize가 3일 경우 '[1][2][3]'가 pageGroupCount 개 만큼 있다.
	$pageGroupCount = $count/($pageSize*$pageGroupSize);

	//페이지 그룹 번호
	//ex) pageGroupSize가 3일 경우  '[1][2][3]'의 페이지그룹번호는 1 이고  '[2][3][4]'의 페이지그룹번호는 2 이다.
	$numPageGroup = (int)ceil((double)$currentPage/$pageGroupSize);

	if($count > 0){
		$pageCount = $count / $pageSize + ( $count % $pageSize == 0 ? 0 : 1);
		$startPage = $pageGroupSize*($numPageGroup-1)+1;
		$endPage = $startPage + $pageGroupSize-1;
		$startPnt = 0;

		if($endPage > $pageCount){
			$endPage = $pageCount;
		}

		if($numPageGroup > 1){
			$startPnt = ($numPageGroup-2)*$pageGroupSize+1;
			echo "<a href='javascript:fncGoPage(".$startPnt.");'>[이전]</a>";
		}

		for($i=$startPage; $i<=$endPage; $i++){
			$startPnt = $i;
			echo "<a href='javascript:fncGoPage(".$startPnt.");'>";

			if($currentPage == $i){
				echo "<strong>[$i]</strong>";
			}else{
				echo "[$i]";
			}
			echo "</a>";
		}

		if($numPageGroup < $pageGroupCount){
			$startPnt = ($numPageGroup*$pageGroupSize+1);
			echo "<a href='javascript:fncGoPage(".$startPnt.");'>[다음]</a>";
		}
	}
//페이징 처리 끝
}
?>

</body>
</html>
