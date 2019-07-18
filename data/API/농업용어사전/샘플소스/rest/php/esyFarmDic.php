<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>알기쉬운농업용어</title>
<script type='text/javascript'>
//검색하기
function dicSearch(cCode){
	with(document.searchApiForm){
		if(keyword.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        keyword.focus();
	        return false;
	    }else{
			method="get";
			action = "esyFarmDic.php";
			target = "_self";
			submit();
		}
	}
}

//일치검색 상세보기
function equalDetail(lCode, lNm, wNm, wNo){
	with(document.equalApiForm){
		langCode.value=lCode;
		langNm.value=lNm;
		wordNm.value=wNm;
		wordNo.value=wNo;
		method="get";
		action = "esyFarmDic.php";
		target = "_self";
		submit();
	}
}

//전방검색 상세보기
function frontDetail(lCode, lNm, wNm, wNo){
	with(document.frontApiForm){
		langCode.value=lCode;
		langNm.value=lNm;
		wordNm.value=wNm;
		wordNo.value=wNo;
		method="get";
		action = "esyFarmDic.php";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "esyFarmDic.php";
		target = "_self";
		submit();
	}
}

// 시소로스 팝업 띄우기
function fncThesaurusOpen(faoCodeVal){
	var popupUrl="thesaurusPoP.php?faoCode="+faoCodeVal;
	var popOption="width=800,height=600";

	window.open(popupUrl,"nongsaroPop",popOption);
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>알기쉬운농업용어</strong> | <strong><a href="farmDic.php">농업용어사전</a></strong></h3>
<hr>
<form name="searchApiForm"><!-- 검색폼 -->
용&nbsp;어 : <input type="text" name="keyword" value="<?PHP if(isset($_REQUEST["keyword"])){ echo $_REQUEST["keyword"]; }?>">
<input type="button" name="confirm" value="검색" onclick="return dicSearch()">
<input type="hidden" name="pageNo">
</form>

<form name="equalApiForm"><!-- 일치항목 선택시 폼 -->
<input type="hidden" name="keyword" value="<?=$_REQUEST["keyword"]?>">
<input type="hidden" name="equalSearchType" value="searchEqualWord">
<input type="hidden" name="langCode" value="<?=$_REQUEST["langCode"]?>">
<input type="hidden" name="langNm" value="<?=$_REQUEST["langNm"]?>">
<input type="hidden" name="wordNm" value="<?=$_REQUEST["wordNm"]?>">
<input type="hidden" name="wordNo" value="<?=$_REQUEST["wordNo"]?>">
<input type="hidden" name="pageNo" value="<?=$_REQUEST["pageNo"]?>">
<input type="hidden" name="wordType" value="B">
</form>

<form name="frontApiForm"><!-- 전방검색항목 선택시 폼 -->
<input type="hidden" name="keyword" value="<?=$_REQUEST["keyword"]?>">
<input type="hidden" name="frontSearchType" value="searchFrontMatch">
<input type="hidden" name="langCode" value="<?=$_REQUEST["langCode"]?>">
<input type="hidden" name="langNm" value="<?=$_REQUEST["langNm"]?>">
<input type="hidden" name="wordNm" value="<?=$_REQUEST["wordNm"]?>">
<input type="hidden" name="wordNo" value="<?=$_REQUEST["wordNo"]?>">
<input type="hidden" name="pageNo" value="<?=$_REQUEST["pageNo"]?>">
<input type="hidden" name="wordType" value="B">
</form>
<!--======================================================== 일치항목 부분 시작 ==================================================================-->
<?PHP
if(isset($_REQUEST["keyword"])){
	echo "<hr><h4>▷검색어 일치항목◁</h4>";

	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "searchEqualWord";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["keyword"]!=NULL){
		$parameter .= "&word=";
		$parameter .= $_REQUEST["keyword"];
	}

	$parameter .= "&wordType=B";

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="25%"/>
			<col width="75%"/>
		</colgroup>
		<tr valign="top">
			<td>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//언어 구분 코드
			$langCode = $item->langCode;
			//언구 구분 명
			$langNm = $item->langNm;
			//용어 명
			$wordNm = $item->wordNm;
			//농업 용어 번호
			$wordNo = $item->wordNo;
			//시소러스 번호
			$faoCode = $item->faoCode;
?>
				<a href="javascript:equalDetail('<?=$langCode?>','<?=$langNm?>','<?=$wordNm?>','<?=$wordNo?>');"><?=$wordNm?></a>&nbsp;[<?=$langNm?>]
				<?PHP if($faoCode != "" && $faoCode != null) { ?>
				<button type="button" onclick="javascript:fncThesaurusOpen('<?=$faoCode?>')">시소러스정보</button>
				<?PHP } ?>
				<br>
<?PHP
		}
	}
?>
			</td>
<?PHP
}
?>
			<td>
<?PHP
//[일치검색] 해당 단어의 용어 설명
if(isset($_REQUEST["equalSearchType"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "detailWord";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["wordNo"]!=NULL){
		$parameter .= "&wordNo=";
		$parameter .= $_REQUEST["wordNo"];
	}

	$parameter .= "&wordType=B";

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);

	//농업 용어 번호
	$farmngWordNo = $object->body[0]->item[0]->farmngWordNo;
	//용어 설명
	$wordDc = $object->body[0]->item[0]->wordDc;
?>
			<table width="100%" border="0" rules="rows" cellSpacing="0" cellPadding="0">
				<colgroup>
					<col width="15%"/>
					<col width="85%"/>
				</colgroup>
				<tr valign="top">
					<td><strong>용어 설명</strong></td>
					<td><?=$wordDc?></td>
				</tr>
				<tr valign="top">
					<td><strong>유사 용어</strong></td>
					<td>
<?PHP
}
//[일치검색] 해당 단어의 유사 용어
if(isset($_REQUEST["equalSearchType"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "detailLikeWordList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["wordNo"]!=NULL){
		$parameter .= "&wordNo=";
		$parameter .= $_REQUEST["wordNo"];
	}

	if($_REQUEST["wordNm"]!=NULL){
		$parameter .= "&wordNm=";
		$parameter .= $_REQUEST["wordNm"];
	}

	$parameter .= "&wordType=B";

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
		foreach($object->body[0]->items[0]->item as $item){
			//언어 구분 명
			$langNm = $item->langNm;
			//용어 명
			$wordNm = $item->wordNm;
?>
			[<?=$langNm?>]&nbsp;&nbsp;<?=$wordNm?><br>
<?PHP
		}
	}
?>
					</td>
				</tr>
			</table>
<?PHP
}
if(isset($_REQUEST["keyword"])){ echo "</td></tr></table>"; }?>

<!--======================================================== 일치항목 부분 끝 ==================================================================-->

<hr>
<!--======================================================== 전방검색 부분  시작 ==================================================================-->

<?PHP
$m_object=null;
if(isset($_REQUEST["keyword"])){
	echo "<h4>▷검색어 전방일치항목◁</h4>";

	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "searchFrontMatch";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["keyword"]!=NULL){
		$parameter .= "&word=";
		$parameter .= urlencode($_REQUEST["keyword"]);
	}

	if(isset($_REQUEST["pageNo"])){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}

	$parameter .= "&wordType=B";

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	$m_object = simplexml_load_string($xml);

	if(count($m_object->body[0]->items[0]->item) == 0){
?>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="25%"/>
			<col width="75%"/>
		</colgroup>
		<tr valign="top">
			<td>
<?PHP
		foreach($m_object->body[0]->items[0]->item as $item){
			//언어 구분 코드
			$langCode = $item->langCode;
			//언어 구분 명
			$langNm = $item->langNm;
			//용어 명
			$wordNm = $item->wordNm;
			//농업 용어 번호
			$wordNo = $item->wordNo;
			//시소러스 코드
			$faoCode = $item->faoCode;

?>
			<a href="javascript:frontDetail('<?=$langCode?>','<?=$langNm?>','<?=$_REQUEST["keyword"]?>','<?=$wordNo?>');"><?=$wordNm?></a>&nbsp;[<?=$langNm?>]
			<?PHP if($faoCode != "" && $faoCode != null) { ?>
			<button type="button" onclick="javascript:fncThesaurusOpen('<?=$faoCode?>')">시소러스정보</button>
			<?PHP } ?>
			<br>
<?PHP
		}
	}
?>
			</td>
<?PHP
}
?>
			<td>
<?PHP
//[전방검색] 해당 단어의 용어 설명
if(isset($_REQUEST["frontSearchType"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "detailWord";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["wordNo"]!=NULL){
		$parameter .= "&wordNo=";
		$parameter .= $_REQUEST["wordNo"];
	}

	$parameter .= "&wordType=B";

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);

	$farmngWordNo = $object->body[0]->item[0]->farmngWordNo;
	$wordDc = $object->body[0]->item[0]->wordDc;
?>
			<table width="100%" border="0" rules="rows" cellSpacing="0" cellPadding="0">
				<colgroup>
					<col width="15%"/>
					<col width="85%"/>
				</colgroup>
				<tr valign="top">
					<td><strong>용어 설명</strong></td>
					<td><?=$wordDc?></td>
				</tr>
				<tr valign="top">
					<td><strong>유사 용어</strong></td>
					<td>
<?PHP
}
//[전방검색] 해당 단어의 유사 용어
if(isset($_REQUEST["frontSearchType"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를입력하십시오";
	//서비스 명
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "detailLikeWordList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if($_REQUEST["wordNo"]!=NULL){
		$parameter .= "&wordNo=";
		$parameter .= $_REQUEST["wordNo"];
	}

	if($_REQUEST["wordNm"]!=NULL){
		$parameter .= "&wordNm=";
		$parameter .= $_REQUEST["wordNm"];
	}

	$parameter .= "&wordType=B";

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3><font color="red">조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
		foreach($object->body[0]->items[0]->item as $item){
			//언어 구분 명
			$langNm = $item->langNm;
			//용어 명
			$wordNm = $item->wordNm;
?>
		[<?=$langNm?>]&nbsp;&nbsp;<?=$wordNm?><br>
<?PHP
		}
	}
?>
				</td>
			</tr>
		</table>
<?PHP
}
	if(isset($_REQUEST["keyword"])){
	echo "</td></tr></table>";

//페이징 처리
	//한 페이지에 제공할 건수
	$numOfRows = $m_object->body[0]->items[0]->numOfRows;
	//조회된 총 건수
	$totalCount = $m_object->body[0]->items[0]->totalCount;
	//조회할 페이지 번호
	$pageNo = $m_object->body[0]->items[0]->pageNo;

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
}
?>
<!--======================================================== 전방검색 부분 끝 ==================================================================-->

</body>
</html>
