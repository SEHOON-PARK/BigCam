<?PHP
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>추천식단</title>
<script type='text/javascript'>
//품종정보 리스트
function mainMove(dCode){
	with(document.mainApiForm){
		dietSeCode.value = dCode;
		method="get";
		action = "recomendDiet.php";
		target = "_self";
		submit();
	}
}

//추천식단 컨텐츠 상세조회
function detailMove(cNo){
	with(document.detailApiForm){
		cntntsNo.value = cNo;
		method="get";
		action = "recomendDiet.php";
		target = "_self";
		submit();
	}
}

//추천식단 컨텐츠 상세조회
function tabMove(tNo){
	with(document.tabApiForm){
		tabNo.value = tNo;
		method="get";
		action = "recomendDiet.php";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.mainApiForm){
		pageNo.value = page;
		method="get";
		action = "recomendDiet.php";
		target = "_self";
		submit();
	}
}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>추천식단</strong></h3><hr>

<form name="mainApiForm">
	<input type="hidden" name="dietSeCode" value="<?=$_REQUEST["dietSeCode"]?>">
	<input type="hidden" name="pageNo">
</form>

<form name="detailApiForm">
	<input type="hidden" name="cntntsNo" value="<?=$_REQUEST["cntntsNo"]?>">
	<input type="hidden" name="tabNo" value="0">
</form>

<form name="tabApiForm">
	<input type="hidden" name="cntntsNo" value="<?=$_REQUEST["cntntsNo"]?>">
	<input type="hidden" name="tabNo" value="<?=$_REQUEST["tabNo"]?>">
</form>


<?PHP
//메인 카테고리 리스트
if(true){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명	
	$serviceName = "recomendDiet";
	//오퍼레이션 명
	$operationName = "mainCategoryList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

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
			//식단 구분 코드			
			$dietSeCode = $item->dietSeCode;
			//식단 구분 명
			$dietSeName = $item->dietSeName;
?>
			<td align="center"><a href="javascript:mainMove('<?=$dietSeCode?>');"><?=$dietSeName?></a></td>
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
//식단 목록
if(isset($_REQUEST["dietSeCode"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명	
	$serviceName = "recomendDiet";
	//오퍼레이션 명
	$operationName = "recomendDietList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["dietSeCode"])){
		$parameter .= "&dietSeCode=";
		$parameter .= $_REQUEST["dietSeCode"];
	}
	
	if(isset($_REQUEST["pageNo"])){
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
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//컨텐츠 번호
			$cntntsNo = $item->cntntsNo;
			//컨텐츠 제목
			$cntntsSj = $item->cntntsSj;
			//이미지 설명
			$rtnImageDc = $item->rtnImageDc;
?>
		<tr>
			<td width="15%"><img src="<?=$rtnImageDc?>" width="128" height="103"></img></td>
			<td width="85%"><a href="javascript:detailMove('<?=$cntntsNo?>');"><?=$cntntsSj?></a></td>
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
//식단 상세
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명	
	$serviceName = "recomendDiet";
	//오퍼레이션 명
	$operationName = "recomendDietDtl";

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
		$cnt=0;
		foreach($object->body[0]->items[0]->item as $item){
			//컨텐츠 번호
			$cntntsNo = $item->cntntsNo;
			//컨텐츠 제목
			$cntntsSj = $item->cntntsSj;
?>
				<td align="center"><a href="javascript:tabMove('<?=$cnt?>');"><?=$cntntsSj?></a></td>
<?PHP
			$cnt++;
		}
?>
		</tr>
	</table>
<?PHP
	}
}
?>

<?PHP
//식단 상세
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명	
	$serviceName = "recomendDiet";
	//오퍼레이션 명
	$operationName = "recomendDietDtl";

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
	$object = simplexml_load_string($xml);
	
	//탭메뉴 이동
	$i=(int)$_REQUEST["tabNo"];
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
		//이미지 설명
		$rtnImageDc = $object->body[0]->items[0]->item[$i]->rtnImageDc;
		//음식명
		$fdNm = $object->body[0]->items[0]->item[$i]->fdNm;
		//식단 내용
		$dietCn = $object->body[0]->items[0]->item[$i]->dietCn;
		//식단 영양소 정보
		$dietNtrsmallInfo = $object->body[0]->items[0]->item[$i]->dietNtrsmallInfo;
		//재료 정보
		$matrlInfo = $object->body[0]->items[0]->item[$i]->matrlInfo;
		//조리 방법 정보
		$ckngMthInfo = $object->body[0]->items[0]->item[$i]->ckngMthInfo;
		//섭취량 정보
		$ntkQyInfo = $object->body[0]->items[0]->item[$i]->ntkQyInfo;
		//당질 정보
		$crbhInfo = $object->body[0]->items[0]->item[$i]->crbhInfo;
		//지질 정보
		$ntrfsInfo = $object->body[0]->items[0]->item[$i]->ntrfsInfo;
		//조섬유 정보
		$crfbInfo = $object->body[0]->items[0]->item[$i]->crfbInfo;
		//철분 정보
		$ircnInfo = $object->body[0]->items[0]->item[$i]->ircnInfo;
		//식염상당량 정보
		$frmlasaltEqvlntqyInfo = $object->body[0]->items[0]->item[$i]->frmlasaltEqvlntqyInfo;
		//비타민 b 정보
		$vtmbInfo = $object->body[0]->items[0]->item[$i]->vtmbInfo;
		//열량 정보
		$clriInfo = $object->body[0]->items[0]->item[$i]->clriInfo;
		//단백질 정보
		$protInfo = $object->body[0]->items[0]->item[$i]->protInfo;
		//콜레스테롤 정보
		$chlsInfo = $object->body[0]->items[0]->item[$i]->chlsInfo;
		//칼슘 정보
		$clciInfo = $object->body[0]->items[0]->item[$i]->clciInfo;
		//나트륨 정보
		$naInfo = $object->body[0]->items[0]->item[$i]->naInfo;
		//비타민 a 정보
		$vtmaInfo = $object->body[0]->items[0]->item[$i]->vtmaInfo;
		//비타민 c 정보
		$vtmcInfo = $object->body[0]->items[0]->item[$i]->vtmcInfo;
?>
		<table width="100%" border="1" cellSpacing="0" cellPadding="0">
			<tr>
				<td width="15%"><img src="<?=$rtnImageDc?>" width="128" height="103"></img></td>
				<td width="85%">
					<strong>식단구성&nbsp;&nbsp;</strong><?=$fdNm?><br>
					<strong>식단소개&nbsp;&nbsp;</strong><?=$dietCn?><br>
					<strong>영양소&nbsp;&nbsp;</strong><?=$dietNtrsmallInfo?>
				</td>
			</tr>
			<tr>
				<td colspan="2"><strong>식단별 조리법</strong></td>
			</tr>
			<tr>
				<td colspan="2">
					<strong>식단구성&nbsp;&nbsp;</strong><?=$matrlInfo?><br>
					<strong>식단소개&nbsp;&nbsp;</strong><?=$ckngMthInfo?><br>
					<strong>영양소&nbsp;&nbsp;</strong>
				</td>
			<tr>
				<td colspan="2">
					<table width="100%" border="0" rules="rows">
						<tr>
							<td width="25%" align="center"><strong>1회 섭취량</strong></td>
							<td width="25%">
							<?PHP if($ntkQyInfo!="0" && $ntkQyInfo!="") { ?>
							<?=$ntkQyInfo?>&nbsp;ml
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>열량</strong></td>
							<td width="25%">
							<?PHP if($clriInfo!="0" && $clriInfo!="") { ?>
							<?=$clriInfo?>&nbsp;kcal
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
						<tr>
							<td width="25%" align="center"><strong>당질</strong></td>
							<td width="25%">
							<?PHP if($crbhInfo!="0" && $crbhInfo!="") { ?>
							<?=$crbhInfo?>&nbsp;g
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>단백질</strong></td>
							<td width="25%">
							<?PHP if($protInfo!="0" && $protInfo!="") { ?>
							<?=$protInfo?>&nbsp;g
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
						<tr>
							<td width="25%" align="center"><strong>지질</strong></td>
							<td width="25%">
							<?PHP if($ntrfsInfo!="0" && $ntrfsInfo!="") { ?>
							<?=$ntrfsInfo?>&nbsp;g
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>콜레스트롤</strong></td>
							<td width="25%">
							<?PHP if($chlsInfo!="0" && $chlsInfo!="") { ?>
							<?=$chlsInfo?>&nbsp;mg
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
						<tr>
							<td width="25%" align="center"><strong>조섬유</strong></td>
							<td width="25%">
							<?PHP if($crfbInfo!="0" && $crfbInfo!="") { ?>
							<?=$crfbInfo?>&nbsp;g
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>칼슘</strong></td>
							<td width="25%">
							<?PHP if($clciInfo!="0" && $clciInfo!="") { ?>
							<?=$clciInfo?>&nbsp;mg
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
						<tr>
							<td width="25%" align="center"><strong>철분</strong></td>
							<td width="25%">
							<?PHP if($ircnInfo!="0" && $ircnInfo!="") { ?>
							<?=$ircnInfo?>&nbsp;mg
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>나트륨</strong></td>
							<td width="25%">
							<?PHP if($naInfo!="0" && $naInfo!="") { ?>
							<?=$naInfo?>&nbsp;mg
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
						<tr>
							<td width="25%" align="center"><strong>식염상당량</strong></td>
							<td width="25%">
							<?PHP if($frmlasaltEqvlntqyInfo!="0" && $frmlasaltEqvlntqyInfo!="") { ?>
							<?=$frmlasaltEqvlntqyInfo?>&nbsp;g
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>비타민A</strong></td>
							<td width="25%">
							<?PHP if($vtmaInfo!="0" && $vtmaInfo!="") { ?>
							<?=$vtmaInfo?>&nbsp;㎍RE
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
						<tr>
							<td width="25%" align="center"><strong>비타민B</strong></td>
							<td width="25%">
							<?PHP if($vtmbInfo!="0" && $vtmbInfo!="") { ?>
							<?=$vtmbInfo?>&nbsp;mg
							<?PHP }else echo "-"; ?>
							</td>
							<td width="25%" align="center"><strong>비타민C</strong></td>
							<td width="25%">
							<?PHP if($vtmcInfo!="0" && $vtmcInfo!="") { ?>
							<?=$vtmcInfo?>&nbsp;mg
							<?PHP }else echo "-"; ?>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
<?PHP
	}
}
?>
</body>
</html>