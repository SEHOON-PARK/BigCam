<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농업기술 동영상</title>
<script type='text/javascript'>

//기관 카테고리
function mainMove(){
	with(document.searchInsttForm){
		method="post";
		action = "agriTechVideo.php";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.listApiForm){
		subCategoryCode.value = document.getElementById("subCombo")[document.getElementById("subCombo").selectedIndex].value;
		pageNo.value = page;
		method="post";
		action = "agriTechVideo.php";
		target = "_self";
		submit();
	}
}

//카테고리 이동
function fncNextPage(cCode){
	with(document.apiForm){
		categoryCode.value = cCode;
		method="post";
		action = "agriTechVideo.php";
		target = "_self";
		submit();
	}
}

//상세 리스트 조회
function listMove(){
	with(document.listApiForm){
		subCategoryCode.value = document.getElementById("subCombo")[document.getElementById("subCombo").selectedIndex].value;
		method="post";
		action = "agriTechVideo.php";
		target = "_self";
		submit();
	}
}

//비디오 팝업
function fncNongsaroOpenVideo(videoLink){
	var agent = navigator.userAgent.toLowerCase();
	var isLowIe = (agent.indexOf("msie 7") > 0) || (agent.indexOf("msie 8") > 0);

	var dWidth = 1120;
	var dHeight = 505;

	if(isLowIe){
		dWidth = 800;
		dHeight = 440;
		videoLink = videoLink.replace("view01", "view01ie8");
	}

	window.open(videoLink, "nongsaroVideoPop","width=" + dWidth + ",height=" + dHeight);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농업기술 동영상</strong></h3>
<?PHP
//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
$apiKey = "발급받은인증키";

//서비스 명
$serviceName = "agriTechVideo";

//기관코드 등록
$insttCode = "";
if(isset($_REQUEST["insttCode"])){
	$insttCode = $_REQUEST["insttCode"];
}
//기관코드 등록
$insttName = "";
if(isset($_REQUEST["insttName"])){
	$insttName = $_REQUEST["insttName"];
}
?>

<form name="apiForm">
<input type="hidden" name="categoryCode" value="<?PHP if(isset($_REQUEST["categoryCode"])){ echo $_REQUEST["categoryCode"];}?>">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
</form>

<?PHP

//기관 코드
if(true){
	//오퍼레이션 명
	$operationName = "insttList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&insttCode=".$insttCode;

	
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
	<form name="searchInsttForm">
		<input type="hidden" name="insttCode" value="<?=$insttCode?>">
		기관명&nbsp;
		<select name="insttName" onchange="mainMove();">
		<option value="">선택하세요</option>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//대분류 카테고리 명
			//대분류 카테고리 코드
			$codeNm = $item->codeNm;
?>
				<option value="<?=$codeNm?>" <?PHP if(isset($_REQUEST["insttName"])){ if($_REQUEST["insttName"]==$codeNm) echo "selected"; }?>> <?=$codeNm?></option>
<?PHP
		}
?>
		</select>
	</form>	
<?PHP
	}
}
?>


<?PHP
//메인 카테고리
	//오퍼레이션 명
	$operationName = "mainCategoryList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&insttCode=".$insttCode;
	$parameter .= "&insttName=".urlencode($insttName);


	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml1 = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며 php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object1 = simplexml_load_string($xml1);

	if(count($object1->body[0]->items[0]->item) == 0){
?>
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<?PHP
		foreach($object1->body[0]->items[0]->item as $item){
			//메인 카테고리 명
			$categoryNm = $item->categoryNm;
			//메인 카테고리 분류 코드
			$categoryCode = $item->categoryCode;
?>
			<td><a href="javascript:fncNextPage('<?=$categoryCode?>');"><?=$categoryNm?></a></td>
<?PHP
		}
?>
		<tr>
	</table>
<?PHP
	}
?>
<hr>

<?PHP
if(count($object1->body[0]->items[0]->item) > 0){
//메인 카테고리 -> 서브 카테고리
	//오퍼레이션 명
	$operationName = "subCategoryList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&insttCode=".$insttCode;
	$parameter .= "&insttName=".urlencode($insttName);


	//서브 카테고리 조회
	$sCategoryCode="";
	if(!isset($_REQUEST["categoryCode"]) || $_REQUEST["categoryCode"]==""){
		$sCategoryCode = $object1->body[0]->items[0]->item[0]->categoryCode;
	}else{
		$sCategoryCode = $_REQUEST["categoryCode"];
	}
	$parameter .= "&categoryCode=" . $sCategoryCode;
	
	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml2 = file_get_contents($url);
	$object2 = simplexml_load_string($xml2);
	
	if(count($object2->body[0]->items[0]->item) == 0){
?>
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
<form name="listApiForm">
<input type="hidden" name="categoryCode" value="<?PHP if(isset($_REQUEST["categoryCode"])){ echo $_REQUEST["categoryCode"];}?>">
<input type="hidden" name="subCategoryCode" value="<?PHP if(isset($_REQUEST["subCategoryCode"])){ echo $_REQUEST["subCategoryCode"];}?>">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
		 상세 분류&nbsp;<select  id="subCombo" onchange="listMove(this.value);" > 
<?PHP
		foreach($object2->body[0]->items[0]->item as $item){
			//서브 카테고리 명
			$categoryNm = $item->categoryNm;
			//서브 카테고리 분류 코드			
			$categoryCode = $item->categoryCode;
?>
			<option value="<?=$categoryCode?>" <?PHP if(isset($_REQUEST["subCategoryCode"])){ if($_REQUEST["subCategoryCode"]==$categoryCode) echo "selected"; }?> > <?=$categoryNm?> </option>
<?PHP
			
		}
?>
		</select>
		동영상 제목&nbsp;<input type="text" name="videoTitle" value="<?PHP if(isset($_REQUEST["videoTitle"])){ echo $_REQUEST["videoTitle"];}?>">
		<td align="right">
			<input type="button" name="search" value="조회" onclick="return listMove();"/>
		</td>
		</tr>
	</table>
</form>
<hr>
<?PHP
	}
?>

<?PHP
//메인 카테고리 -> 서브 카테고리 -> 품목 리스트
if(count($object2->body[0]->items[0]->item) > 0){
	//오퍼레이션 명
	$operationName = "videoList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	//서브 카테고리 조회
	$sSubCategoryCode="";
	if(!isset($_REQUEST["subCategoryCode"]) || $_REQUEST["subCategoryCode"]==""){
		$sSubCategoryCode = $object2->body[0]->items[0]->item[0]->categoryCode;
	}else{
		$sSubCategoryCode = $_REQUEST["subCategoryCode"];
	}
	$parameter .= "&categoryCode=" . $sSubCategoryCode;
	
	//동영상 제목 조회
	if(isset($_REQUEST["videoTitle"])){
		$parameter .= "&videoTitle=";
		$parameter .= $_REQUEST["videoTitle"];
	}
	
	//페이지 이동
	if(isset($_REQUEST["pageNo"])){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml3 = file_get_contents($url);
	$object3 = simplexml_load_string($xml3);
	
	if(count($object3->body[0]->items[0]->item) == 0){
?>
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>

	<table border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" >동영상</th>
				<th scope="col" >제목</th>
				<th scope="col" >출처</th>
			</tr>
		</thead>
		<tbody>
<?PHP
		foreach($object3->body[0]->items[0]->item as $item){
			//동영상 이미지
			$videoImg = $item->videoImg;
			//동영상 링크
			$videoLink = $item->videoLink;
			//동영상 출처
			$videoOriginInstt = $item->videoOriginInstt;
			//동영상 제목
			$videoTitle = $item->videoTitle;
?>
		<tr>
		    <td>
		    <a href="#" title="<?=$videoTitle?>" onclick="fncNongsaroOpenVideo('<?=$videoLink?>');return false;">
		    <img src="<?=$videoImg?>" width="128" height="103"></img>
		    </a>
		    </td>
		    <td><?=$videoTitle?></td>
		    <td><?=$videoOriginInstt?></td>
		</tr>
<?PHP
		}
?>
	    </tbody>
	</table>
<?PHP
	}
	
//페이징 처리 시작
	
	//한페이지에 제공할 건수
	$numOfRows = $object3->body[0]->items[0]->numOfRows;
	//조회된 총 건수
	$totalCount = $object3->body[0]->items[0]->totalCount;
	//조회할 페이지 번호
	$pageNo = $object3->body[0]->items[0]->pageNo;
	
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
}
?>
</body>
</html>




