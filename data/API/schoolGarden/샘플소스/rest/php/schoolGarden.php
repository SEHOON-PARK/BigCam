<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>진로체험</title>
<script type='text/javascript'>

//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "schoolGarden_D.php";
		target = "_self";
		submit();
	}
}
function fncTabChg(type){
	with(document.searchApiForm){
		pageNo.value = "1";
		menuType.value=type;
		method="get";
		action = "schoolGarden.php";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "schoolGarden.php";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>진로체험</strong></h3>
<hr>
<?PHP
	$menuType="PS03962";
	if(isset($_REQUEST["menuType"])){
		$menuType = $_REQUEST["menuType"];
	}
?>
<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="menuType">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">
		<a href="javascript:fncTabChg('PS03962');">  <?PHP if ( $menuType == "PS03962") {  echo "<strong>토마토 재배부터 판매까지</strong>";  }else{  echo "토마토 재배부터 판매까지";  } ?> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('PS04127');">  <?PHP if ( $menuType == "PS04127") {  echo "<strong>씨앗부터 플라워 카페까지</strong>";  }else{  echo "씨앗부터 플라워 카페까지";  } ?> </a>
	</td>
</tr>
</table>
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">분류</td>
	<td align="center">
		<select name="sidoCode">
<?PHP
				$apiKey = "nongsaroSampleKey";
				//서비스 명
				$serviceName = "schoolGarden";
				//오퍼레이션 명
				$operationName = "cmmCodeInfo";

				//XML 받을 URL 생성
				$parameter = "/".$serviceName."/".$operationName;
				$parameter .= "?apiKey=".$apiKey;
				$url1 = "http://api.nongsaro.go.kr/service" . $parameter;

				//XML Parsing
				$xml1 = file_get_contents($url1);
				//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
				$object1 = simplexml_load_string($xml1);
				foreach($object1->body[0]->items[0]->item as $item){
					//키값
					$code = $item->code;
					//파일 다운로드 URL
					$codeNm = $item->codeNm;
?>
				<option value="<?=$code?>" <?PHP if(isset($_REQUEST["code"])){ if($_REQUEST["code"]== $code) echo "selected"; }?> ><?=$codeNm?></option>
<?PHP
				}
?>
			</select>
	</td>
</tr>
</table>
</form>

<?PHP
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명
	$serviceName = "schoolGarden";
	//오퍼레이션 명
	$operationName = "schoolGardenList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&menuId=".$menuType;

	//분류코드
	if(isset($_REQUEST["code"])){
		$parameter .= "&code=";
		$parameter .= $_REQUEST["code"];
	}
	//페이지 이동
	if(isset($_REQUEST["pageNo"])){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter;

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="10%"/>
			<col width="50%"/>
			<col width="40%"/>
		</colgroup>
		<tr>
			<th>회기</th>
			<th>제목</th>
			<th>첨부</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//키값
			$cntntsNo = $item->cntntsNo;
			//파일 다운로드 URL
			$downUrl = $item->downUrl;
			//파일명
			$fileName = $item->fileName;
			//회차
			$tmrd = $item->tmrd;
			//제목
			$cntntsSj = $item->cntntsSj;


			$strDownUrl=explode(';',$downUrl);
			$strFileName=explode(';',$fileName);

?>
		<tr>
			<td align="center"><?=$tmrd?></td>
			<td><a href="javascript:;move('<?=$cntntsNo?>');"><?=$cntntsSj?></a></td>
			<td align="center">
<?PHP
			$cnt=count($strDownUrl);
			for($i=0; $i<$cnt;$i++){

?>
				<a href="<?=$strDownUrl[$i]?>"><?=$strFileName[$i]?></a><br>
<?PHP
			}
?>
			</td>
		<tr>
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
?>
</body>
</html>