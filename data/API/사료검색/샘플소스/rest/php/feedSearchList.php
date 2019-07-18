<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>사료검색</title>
<script type='text/javascript'>
//상세보기
function fncDtl(hNo){
	with(document.apiForm){
		hsrrlManageNo.value = hNo;
		method="get";
		action = "feedSearchDtl.php";
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
			method="get";
			action = "feedSearchList.php";
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
		action = "feedSearchList.php";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>사료검색</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="hsrrlManageNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
<select name="sType"> 
	<option value="sAll" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sAll") echo "selected"; }?>>전체</option>
	<option value="sKoreanNm" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sKoreanNm") echo "selected"; }?>>한글명</option>
	<option value="sEngNm" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sEngNm") echo "selected"; }?>>영문명</option>
	<option value="sHsrrlNo" <?PHP if(isset($_REQUEST["sType"])){ if($_REQUEST["sType"]=="sHsrrlNo") echo "selected"; }?>>사료번호</option>
</select> 
<input type="text" name="sText" value="<?PHP if(isset($_REQUEST["sText"])){ echo $_REQUEST["sText"]; }?>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>


<?PHP
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를입력하세요";
	//서비스 명
	$serviceName = "feedSearch";
	//오퍼레이션 명
	$operationName = "feedSearchList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
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
			<col width="35%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>한글 사료명</th>
			<th>영문 사료명</th>
			<th>사료군</th>
			<th>사료번호</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//사료 관리 번호
			$hsrrlManageNo = $item->hsrrlManageNo;
			//사료 번호
			$hsrrlNo = $item->hsrrlNo;
			//한글 사료명
			$koreanNm = $item->koreanNm;
			//영문 사료명
			$engNm = $item->engNm;
			//사료 품목 명
			$hsrrlPrdlstCodeLclasNm = $item->hsrrlPrdlstCodeLclasNm;
			
?>
		<tr>
			<td align="center"><a href="javascript:fncDtl('<?=$hsrrlManageNo?>');"><?=$koreanNm?></a></td>
			<td align="center"><?=$engNm?></td>
			<td align="center"><?=$hsrrlPrdlstCodeLclasNm?></td>
			<td align="center"><?=$hsrrlNo?></td>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP

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