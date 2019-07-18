<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>작목기술 서비스</title>
<script type='text/javascript'>
//메인 카테고리 항목
function mainMove(){
	with(document.searchInsttForm){
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}
//미들 카테고리 항목
function middleMove(mCode){
	with(document.mainApiForm){
		mainCategoryCode.value = mCode;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}

//메인 테크 항목
function mainTechMove(sCode, mCode){
	with(document.mainTechApiForm){
		subCategoryCode.value = sCode;
		middleCategoryCode.value = mCode;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}

//서브 테크 항목
function subTechMove(mCode){
	with(document.subTechApiForm){
		mainTechCode.value = mCode;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}

//동영상 팝업
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

//동영상 목록 조회
function videoListMove(){
	with(document.videoListApiForm){
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}
//동영상 페이지 이동
function vid_fncGoPage(page){
	with(document.videoListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}

//기술정보 목록 조회
function techInfoMove(sCode){
	with(document.techInfoListApiForm){
		subTechCode.value = sCode;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}
//기술정보 페이지 이동
function tech_fncGoPage(page){
	with(document.techInfoListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}

//품종정보 목록 조회
function varietyList(){
	with(document.varietyListApiForm){
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}

//품종정보  페이지 이동
function var_fncGoPage(page){
	with(document.varietyListApiForm){
		pageNo.value = page;
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}
//검색
function fncSearch(){
	with(document.searchInsttForm){
		method="post";
		action = "cropTechInfo.php";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>작목기술 서비스</strong></h3>
<hr>

<?PHP
//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
$apiKey = "인증키를입력해주세요";

//서비스 명
$serviceName = "cropTechInfo";

//기관코드 등록
$insttCode = "";
if(isset($_REQUEST["insttCode"])){
	$insttCode = $_REQUEST["insttCode"];
}

//기관명
$insttName = "";
if(isset($_REQUEST["insttName"])){
	$insttName = $_REQUEST["insttName"];
}

//작물명 검색
$subCategoryNm = "";
if(isset($_REQUEST["subCategoryNm"])){
	$subCategoryNm = $_REQUEST["subCategoryNm"];
}

//제목 검색
$subject = "";
if(isset($_REQUEST["subject"])){
	$subject = $_REQUEST["subject"];
}


?>

<form name="mainApiForm">
<input type="hidden" name="mainCategoryCode" value="<?=$_REQUEST["mainCategoryCode"]?>">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
<input type="hidden" name="subCategoryNm" value="<?=$subCategoryNm?>">
<input type="hidden" name="subject" value="<?=$subject?>">
</form>

<form name="mainTechApiForm">
<input type="hidden" name="mainCategoryCode" value="<?=$_REQUEST["mainCategoryCode"]?>">
<input type="hidden" name="middleCategoryCode" value="<?=$_REQUEST["middleCategoryCode"]?>">
<input type="hidden" name="subCategoryCode" value="<?=$_REQUEST["subCategoryCode"]?>">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
<input type="hidden" name="subCategoryNm" value="<?=$subCategoryNm?>">
<input type="hidden" name="subject" value="<?=$subject?>">
</form>

<form name="subTechApiForm">
<input type="hidden" name="mainCategoryCode" value="<?=$_REQUEST["mainCategoryCode"]?>">
<input type="hidden" name="middleCategoryCode" value="<?=$_REQUEST["middleCategoryCode"]?>">
<input type="hidden" name="subCategoryCode" value="<?=$_REQUEST["subCategoryCode"]?>">
<input type="hidden" name="mainTechCode" value="<?=$_REQUEST["mainTechCode"]?>">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
<input type="hidden" name="subCategoryNm" value="<?=$subCategoryNm?>">
<input type="hidden" name="subject" value="<?=$subject?>">
</form>

<form name="videoListApiForm">
<input type="hidden" name="mainCategoryCode" value="<?=$_REQUEST["mainCategoryCode"]?>">
<input type="hidden" name="middleCategoryCode" value="<?=$_REQUEST["middleCategoryCode"]?>">
<input type="hidden" name="subCategoryCode" value="<?=$_REQUEST["subCategoryCode"]?>">
<input type="hidden" name="movieCheck" value="1">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
<input type="hidden" name="subCategoryNm" value="<?=$subCategoryNm?>">
<input type="hidden" name="subject" value="<?=$subject?>">
</form>

<form name="techInfoListApiForm">
<input type="hidden" name="mainCategoryCode" value="<?=$_REQUEST["mainCategoryCode"]?>">
<input type="hidden" name="middleCategoryCode" value="<?=$_REQUEST["middleCategoryCode"]?>">
<input type="hidden" name="subCategoryCode" value="<?=$_REQUEST["subCategoryCode"]?>">
<input type="hidden" name="mainTechCode" value="<?=$_REQUEST["mainTechCode"]?>">
<input type="hidden" name="subTechCode" value="<?=$_REQUEST["subTechCode"]?>">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
<input type="hidden" name="subCategoryNm" value="<?=$subCategoryNm?>">
<input type="hidden" name="subject" value="<?=$subject?>">
</form>

<form name="varietyListApiForm">
<input type="hidden" name="mainCategoryCode" value="<?=$_REQUEST["mainCategoryCode"]?>">
<input type="hidden" name="middleCategoryCode" value="<?=$_REQUEST["middleCategoryCode"]?>">
<input type="hidden" name="subCategoryCode" value="<?=$_REQUEST["subCategoryCode"]?>">
<input type="hidden" name="mainTechCode" value="<?=$_REQUEST["mainTechCode"]?>">
<input type="hidden" name="varietyCheck" value="1">
<input type="hidden" name="pageNo">
<input type="hidden" name="insttName" value="<?=$insttName?>">
<input type="hidden" name="insttCode" value="<?=$insttCode?>">
<input type="hidden" name="subCategoryNm" value="<?=$subCategoryNm?>">
<input type="hidden" name="subject" value="<?=$subject?>">
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
	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

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
		작목명&nbsp;
		<input type="text" id="subCategoryNm" name="subCategoryNm" value="<?=$subCategoryNm?>">
		제목&nbsp;
		<input type="text" id="subject" name="subject" value="<?=$subject?>">
		<input type="button" name="search" value="검색" onclick="return fncSearch();"/>

	</form>	
<?PHP
	}
}
?>

<?PHP
//대분류 카테고리
if(true){
	//오퍼레이션 명
	$operationName = "mainCategoryList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&insttCode=".$insttCode;
	$parameter .= "&insttName=" . urlencode($insttName);
	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

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
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//대분류 카테고리 명
			$mainCategoryNm = $item->mainCategoryNm;
			//대분류 카테고리 코드
			$mainCategoryCode = $item->mainCategoryCode;
?>
				<td width="11%" align="center"><a href="javascript:middleMove('<?=$mainCategoryCode?>');"><?=$mainCategoryNm?></a></td>
<?PHP
		}
?>
		<tr>
	</table>
<?PHP
	}
}
?>

<?PHP
//중분류 카테고리
if(isset($_REQUEST["mainCategoryCode"])){
	//오퍼레이션 명
	$operationName = "middleCategoryList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&insttCode=".$insttCode;
	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

	if($_REQUEST["mainCategoryCode"]!=NULL){
		$parameter .= "&mainCategoryCode=";
		$parameter .= $_REQUEST["mainCategoryCode"];
	}
	$parameter .= "&insttName=" . urlencode($insttName);

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" rules="rows" cellSpacing="0" cellPadding="0">
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//중분류 카테고리 명
			$middleCategoryNm = $item->middleCategoryNm;
			//중분류 카테고리 코드
			$middleCategoryCode = $item->middleCategoryCode;
?>
		<tr>
			<td width="15%"><strong><?=$middleCategoryNm?></strong></td> 			
 			<td width="85%"><table width="100%" cellSpacing="0" cellPadding="0"><tr>
<?PHP		//소분류 카테고리
			if(true){
				//오퍼레이션 명
				$operationName_Sub = "subCategoryList";
			
				//XML 받을 URL 생성
				$parameter_Sub = "/".$serviceName."/".$operationName_Sub;
				$parameter_Sub .= "?apiKey=".$apiKey;
				$parameter_Sub .= "&middleCategoryCode=".$middleCategoryCode;
				$parameter_Sub .= "&insttCode=" . $insttCode;
				$parameter_Sub .= "&insttName=" . urlencode($insttName);
				//작목명 검색
				$parameter_Sub .= "&subCategoryNm=" . urlencode($subCategoryNm);
				//제목 검색
				$parameter_Sub .= "&subject=" . urlencode($subject);

				$url_Sub = "http://api.nongsaro.go.kr/service" . $parameter_Sub; 

				//XML Parsing
				$xml_Sub = file_get_contents($url_Sub);
				$object_Sub = simplexml_load_string($xml_Sub);
				
				$index=0;
				foreach($object_Sub->body[0]->items[0]->item as $item){
					//소분류 카테고리 명
					$subCategoryNm1 = $item->subCategoryNm;
					//소분류 카테고리 코드
					$subCategoryCode = $item->subCategoryCode;
					if($index%4==0){
						echo "</tr><tr>";
					}
?>
					<td width="25%">&nbsp;│&nbsp;<a href="javascript:mainTechMove('<?=$subCategoryCode?>', '<?=$middleCategoryCode?>');"><?=$subCategoryNm1?></a></td>
<?PHP
				$index++;
				}
			}
?>
			</tr>
		</table>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP
	}
}
?>


<?PHP
//대분류 기술코드 조회
if(isset($_REQUEST["subCategoryCode"])){
	//오퍼레이션 명
	$operationName = "mainTechList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["subCategoryCode"]!=NULL){
		$parameter .= "&subCategoryCode=";
		$parameter .= $_REQUEST["subCategoryCode"];
	}
	$parameter .= "&insttName=" . urlencode($insttName);
	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP

	}else{
?>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//대분류 기술 코드
			$mainTechCode = $item->mainTechCode;
			//대분류 기술 코드 명
			$mainTechNm = $item->mainTechNm;
			
			if($mainTechCode=="movie"){
?>
				<td align="center"><a href="javascript:videoListMove();"><?=$mainTechNm?></a></td>
<?PHP
			}else{
?>
				<td align="center"><a href="javascript:subTechMove('<?=$mainTechCode?>');"><?=$mainTechNm?></a></td>

<?PHP
			}
		}
?>			
		<tr>
	</table>
<?PHP
	}
}
?>

<?PHP
//동영상 목록 조회
if(isset($_REQUEST["movieCheck"])){
	//오퍼레이션 명
	$operationName = "videoList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["subCategoryCode"]!=NULL){
		$parameter .= "&subCategoryCode=";
		$parameter .= $_REQUEST["subCategoryCode"];
	}
	
	if($_REQUEST["pageNo"]!=NULL){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}
	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<br>
	<table border="1" cellSpacing="0" summary="" cellPadding="0">
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
		foreach($object->body[0]->items[0]->item as $item){
			//비디오 썸네일 이미지 링크
			$videoImg = $item->videoImg;
			//비디오 링크
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
			echo "<a href='javascript:vid_fncGoPage(".$startPnt.");'>[이전]</a>";
		}

		for($i=$startPage; $i<=$endPage; $i++){
			$startPnt = $i;
			echo "<a href='javascript:vid_fncGoPage(".$startPnt.");'>";

			if($currentPage == $i){
				echo "<strong>[$i]</strong>";
			}else{
				echo "[$i]";
			}
			echo "</a>";
		}

		if($numPageGroup < $pageGroupCount){
			$startPnt = ($numPageGroup*$pageGroupSize+1);
			echo "<a href='javascript:vid_fncGoPage(".$startPnt.");'>[다음]</a>";
		}
	}
//페이징 처리 끝
}
?>


<?PHP
//소분류 기술코드 조회
if(isset($_REQUEST["mainTechCode"])){
	//오퍼레이션 명
	$operationName = "subTechList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["mainCategoryCode"]!=NULL){
		$parameter .= "&mainCategoryCode=";
		$parameter .= $_REQUEST["mainCategoryCode"];
	}
	
	if($_REQUEST["middleCategoryCode"]!=NULL){
		$parameter .= "&middleCategoryCode=";
		$parameter .= $_REQUEST["middleCategoryCode"];
	}
	
	if($_REQUEST["subCategoryCode"]!=NULL){
		$parameter .= "&subCategoryCode=";
		$parameter .= $_REQUEST["subCategoryCode"];
	}
	
	if($_REQUEST["mainTechCode"]!=NULL){
		$parameter .= "&mainTechCode=";
		$parameter .= $_REQUEST["mainTechCode"];
	}
	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

	$parameter .= "&insttName=" . urlencode($insttName);

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//소분류 기술 코드
			$subTechCode = $item->subTechCode;
			//소분류 기술코드 명
			$subTechNm = $item->subTechNm;
			
			if($subTechCode=="variety"){
?>
			&nbsp;│&nbsp;<a href="javascript:varietyList();"><?=$subTechNm?></a>
<?PHP
			}else{
?>
			&nbsp;│&nbsp;<a href="javascript:techInfoMove('<?=$subTechCode?>');"><?=$subTechNm?></a>
<?PHP
			}
		}
?>			
		<tr>
	</table>
<?PHP
	}
}
?>

<?PHP
//기술정보 목록 조회
if(isset($_REQUEST["subTechCode"])){
	//오퍼레이션 명
	$operationName = "techInfoList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["subCategoryCode"]!=NULL){
		$parameter .= "&subCategoryCode=";
		$parameter .= $_REQUEST["subCategoryCode"];
	}
	
	if($_REQUEST["subTechCode"]!=NULL){
		$parameter .= "&subTechCode=";
		$parameter .= $_REQUEST["subTechCode"];
	}
	
	if($_REQUEST["pageNo"]!=NULL){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}

	$parameter .= "&insttName=" . urlencode($insttName);

	//작목명 검색
	$parameter .= "&subCategoryNm=" . urlencode($subCategoryNm);
	//제목 검색
	$parameter .= "&subject=" . urlencode($subject);

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
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
			<col width="70%"/>
			<col width="15%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>제목</th>
			<th>등록일</th>
			<th>첨부</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//첨부파일 다운로드 URL
			$fileDownUrl = $item->fileDownUrl;
			//등록일자
			$regDt = $item->regDt;
			//기술정보 제목
			$techNm = $item->techNm;
?>		
			<tr>
				<td><?=$techNm?></td>
				<td align="center"><?=$regDt?></td>
				<td align="center"><a href="<?=$fileDownUrl?>">파일다운</a></td>
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

<?PHP
//품목정보 목록 조회
if(isset($_REQUEST["varietyCheck"])){
	//오퍼레이션 명
	$operationName = "varietyList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["subCategoryCode"]!=NULL){
		$parameter .= "&subCategoryCode=";
		$parameter .= $_REQUEST["subCategoryCode"];
	}
	
	if($_REQUEST["pageNo"]!=NULL){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" rules="rows" cellSpacing="0" cellPadding="0">
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//첨부파일 링크
			$atchFileLink = $item->atchFileLink;
			//첨부파일 명
			$atchFileNm = $item->atchFileNm;
			//작물 명
			$cropNm = $item->cropNm;
			//썸네일 이미지
			$imgFileLink = $item->imgFileLink;
			//주요특성
			$mainChartrInfo = $item->mainChartrInfo;
			//육성기관
			$unbrngInsttInfo = $item->unbrngInsttInfo;
			//육성년도
			$unbrngYear = $item->unbrngYear;
			//품종명
			$varietyNm = $item->varietyNm;
?>
		<tr>
		    <td width="15%"><img src="<?=$imgFileLink?>" width="128" height="103"></img></td>
		    <td width="85%">
		    	<table width="100%" cellSpacing="0" cellPadding="0">
		    		<tr>
		    			<td width="10%"><strong>ㆍ작물명</strong></td>
		    			<td><?=$cropNm?></td>
		    			<td width="10%"><strong>ㆍ육성년도</strong></td>
		    			<td><?=$unbrngYear?></td>
		    			<td width="10%"><strong>ㆍ육성기관</strong></td>
		    			<td><?=$unbrngInsttInfo?></td>
		    		</tr>
		    		<tr>
		    			<td width="10%"><strong>ㆍ품종명</strong></td>
		    			<td colspan="5"><?=$varietyNm?></td>
		    		</tr>
		    		<tr>
		    			<td width="10%"><strong>ㆍ주요특성</strong></td>
		    			<td colspan="5"><?=$mainChartrInfo?></td>
		    		</tr>
		    		<tr>
		    			<td width="10%"><strong>ㆍ첨부파일</strong></td>
		    			<td colspan="5"><a href="<?=$atchFileLink?>"><?=$atchFileNm?></a></td>
		    		</tr>
		    	</table>
		    </td>
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
			echo "<a href='javascript:var_fncGoPage(".$startPnt.");'>[이전]</a>";
		}

		for($i=$startPage; $i<=$endPage; $i++){
			$startPnt = $i;
			echo "<a href='javascript:var_fncGoPage(".$startPnt.");'>";

			if($currentPage == $i){
				echo "<strong>[$i]</strong>";
			}else{
				echo "[$i]";
			}
			echo "</a>";
		}

		if($numPageGroup < $pageGroupCount){
			$startPnt = ($numPageGroup*$pageGroupSize+1);
			echo "<a href='javascript:var_fncGoPage(".$startPnt.");'>[다음]</a>";
		}
	}
//페이징 처리 끝
}
?>
</body>
</html>