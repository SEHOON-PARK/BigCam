<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>텃밭가꾸기</title>
<script type='text/javascript'>

//상세보기
function move(dNo){
	with(document.apiForm){
		cntntsNo.value = dNo;
		method="get";
		action = "fildMnfct_D.php";
		target = "_self";
		submit();
	}
}

//검색
function fncSearch(){
	with(document.searchApiForm){
		if(sText.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        sText.focus();
	        return false;
	    }else{
	    	pageNo.value = "1";
			method="get";
			action = "fildMnfct.php";
			target = "_self";
			submit();
		}
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "fildMnfct.php";
		target = "_self";
		submit();
	}
}

function fncTabChg(type){
	with(document.searchApiForm){
		pageNo.value = "1";
		sSeCode.value=type;
		method="get";
		action = "fildMnfct.php";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>텃밭가꾸기</strong></h3>
<hr>
<?PHP
	$sSeCode="335001";
	if(isset($_REQUEST["sSeCode"])){
		$sSeCode = $_REQUEST["sSeCode"];
	}
?>
<form name="apiForm">
<input type="hidden" name="cntntsNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
<input type="hidden" name="sSeCode" value="<?=$sSeCode?>">
<table width="100%" cellSpacing="0" cellPadding="0" border="1">
<tr>
	<td align="center">
		<a href="javascript:fncTabChg('335001');">  <?PHP if ( $sSeCode == "335001") {  echo "<strong>채소</strong>";  }else{  echo "채소";  } ?> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('335002');">  <?PHP if ( $sSeCode == "335002") {  echo "<strong>과수</strong>";  }else{  echo "과수";  } ?> </a>
	</td>
	<td align="center">
		<a href="javascript:fncTabChg('335003');">  <?PHP if ( $sSeCode == "335003") {  echo "<strong>인삼약초버섯</strong>";  }else{  echo "인삼약초버섯";  } ?> </a>
	</td>
</tr>
</table>
<select name="sType">
	<option value="sCntntsSj" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sCntntsSj") echo "selected"; }?>>제목</option>
	<option value="sWriteNm" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sWriteNm") echo "selected"; }?>>작성자</option>
	<option value="sQuestDtl" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sQuestDtl") echo "selected"; }?>>내용</option>
</select>
<input type="text" name="sText" value="<?PHP if(isset($_REQUEST["sText"])){ echo $_REQUEST["sText"]; }?>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<?PHP
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "fildMnfct";
	//오퍼레이션 명
	$operationName = "fildMnfctList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&sSeCode=".$sSeCode;


	//검색조건
	if(isset($_REQUEST["sType"])){
		$parameter .= "&sType=";
		$parameter .= $_REQUEST["sType"];
	}
	//검색어
	if(isset($_REQUEST["sText"])){
		$parameter .= "&sText=";
		$parameter .= $_REQUEST["sText"];
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
			<col/>
			<col style="width:12%" />
			<col style="width:8%" />
		</colgroup>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//키값
			$cntntsNo = $item->cntntsNo;
			//제목
			$cntntsSj = $item->cntntsSj;
			//조회수
			$cntntsRdcnt = $item->cntntsRdcnt;
			//작성자
			$updusrEsntlNm = $item->updusrEsntlNm;

?>
		<tr>
			<td><a href="javascript:;move('<?=$cntntsNo?>');"><?=$cntntsSj?></a></td>
			<td align="center"><?=$updusrEsntlNm?></td>
			<td align="center"><?=$cntntsRdcnt?></td>
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
?>
</body>
</html>