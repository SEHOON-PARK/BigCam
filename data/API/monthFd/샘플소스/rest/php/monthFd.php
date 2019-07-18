<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>이달의음식</title>
<script type='text/javascript'>

//조회
function mainMove(){
	with(document.searchYearForm){
		method="post";
		action = "monthFd.php";
		target = "_self";
		submit();
	}
}
//식재료 상세보기
function move1(dNo){
	with(document.searchYearForm){
		cntntsNo.value = dNo;
		method="get";
		action = "monthFd_D1.php";
		target = "_self";
		submit();
	}
}
//레시피 상세보기
function move2(dNo){
	with(document.searchYearForm){
		cntntsNo.value = dNo;
		method="get";
		action = "monthFd_D2.php";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>이달의음식</strong></h3>
<hr>

<?PHP
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "monthFd";
	//오퍼레이션 명
	$operationName = "monthFdYearLst";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	$thisYear ="";
	$thisMonth="";
	//검색조건
	if(isset($_REQUEST["thisYear"])){
		$parameter .= "&thisYear=";
		$parameter .= $_REQUEST["thisYear"];
		$thisYear = $_REQUEST["thisYear"];
	}else{
		$thisYear = date("Y");
	}
	//검색어
	if(isset($_REQUEST["thisMonth"])){
		$parameter .= "&thisMonth=";
		$parameter .= $_REQUEST["thisMonth"];
		$thisMonth = $_REQUEST["thisMonth"];
	}else{
		$thisMonth = date("m");
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
	<form name="searchYearForm">
	<input type="hidden" name="cntntsNo"/>
		연도&nbsp;
		<select name="thisYear" onchange="mainMove();">
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//연도값
			$year = $item->year;
?>
		<option value="<?=$year?>" <?PHP if($thisYear == $year) echo "selected"; ?> ><?=$year?></option>

<?PHP
		}
?>
	</select>
		월&nbsp;
		<select name="thisMonth" onchange="mainMove();">
			<option value="01" <?PHP if($thisMonth == "01") echo "selected"; ?> >1월</option>
			<option value="02" <?PHP if($thisMonth == "02") echo "selected"; ?> >2월</option>
			<option value="03" <?PHP if($thisMonth == "03") echo "selected"; ?> >3월</option>
			<option value="04" <?PHP if($thisMonth == "04") echo "selected"; ?> >4월</option>
			<option value="05" <?PHP if($thisMonth == "05") echo "selected"; ?> >5월</option>
			<option value="06" <?PHP if($thisMonth == "06") echo "selected"; ?> >6월</option>
			<option value="07" <?PHP if($thisMonth == "07") echo "selected"; ?> >7월</option>
			<option value="08" <?PHP if($thisMonth == "08") echo "selected"; ?> >8월</option>
			<option value="09" <?PHP if($thisMonth == "09") echo "selected"; ?> >9월</option>
			<option value="10" <?PHP if($thisMonth == "10") echo "selected"; ?> >10월</option>
			<option value="11" <?PHP if($thisMonth == "11") echo "selected"; ?> >11월</option>
			<option value="12" <?PHP if($thisMonth == "12") echo "selected"; ?> >12월</option>
		</select>
	</form>
<?PHP
	}
	//오퍼레이션 명
	$operationName = "monthFdmtLst";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&thisYear=";
	$parameter .= $thisYear;
	$parameter .= "&thisMonth=";
	$parameter .= $thisMonth;

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
	<div>
	<ul>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//키값
			$cntntsNo = $item->cntntsNo;
			//파일구분코드
			$rtnImgSeCode = $item->rtnImgSeCode;
			//파일경로
			$rtnFileCours = $item->rtnFileCours;
			//파일명
			$rtnStreFileNm = $item->rtnStreFileNm;
			//파일제목
			$fdmtNm = $item->fdmtNm;

			$imgCnt =-1;
			$rtnImgSeCodeArr = explode('|',$rtnImgSeCode);
			$rtnFileCoursArr = explode('|',$rtnFileCours);
			$rtnStreFileNmArr = explode('|',$rtnStreFileNm);

			$rtnImgSeCodeCnt = count($rtnImgSeCodeArr);
			for($k=0; $k < $rtnImgSeCodeCnt; $k++){
				if("209006" ==$rtnImgSeCodeArr[$k]){
					$imgCnt = $k;
				}
			}
			$imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
			if($imgCnt > -1){
				$imgUrl = "http://www.nongsaro.go.kr/" + $rtnFileCoursArr[$imgCnt] + "/" + $rtnStreFileNmArr[$imgCnt];
			}
?>

			<li style="width: 33%;display: inline-block;"><a href="#" onclick="javascript:move1('<?=$cntntsNo?>');">
			<img src="<?=$imgUrl?>" alt="<?=$fdmtNm?>"  title="<?=$fdmtNm?>" style="width: 249px;height: 198px;"/>
			</a>
			<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><?=$fdmtNm?></p>
			</li>
<?PHP
		}
	}
?>
	</ul>
	</div>
<?PHP


//오퍼레이션 명
	$operationName = "monthNewFdLst";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	$parameter .= "&thisYear=";
	$parameter .= $thisYear;
	$parameter .= "&thisMonth=";
	$parameter .= $thisMonth;

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
	<div>
	<ul>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//키값
			$cntntsNo = $item->cntntsNo;
			//파일구분코드
			$rtnImgSeCode = $item->rtnImgSeCode;
			//파일경로
			$rtnFileCours = $item->rtnFileCours;
			//파일명
			$rtnStreFileNm = $item->rtnStreFileNm;
			//파일제목
			$fdNm = $item->fdNm;
			//레시피구분
			$fdSeCode = $item->fdSeCode;
			if("290001" == $fdSeCode){

				$imgCnt =-1;
				$rtnImgSeCodeArr = explode('|',$rtnImgSeCode);
				$rtnImgSeCodeCnt = count($rtnImgSeCodeArr);
				for($k=0; $k < $rtnImgSeCodeCnt; $k++){
					if("209006" ==$rtnImgSeCodeArr[$k]){
						$imgCnt = $k;
					}
				}
				$imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
				if($imgCnt > -1){
					$rtnFileCoursArr = explode('|',$rtnFileCours);
					$rtnStreFileNmArr = explode('|',$rtnStreFileNm);
					$imgUrl = "http://www.nongsaro.go.kr/"+ $rtnFileCoursArr[$imgCnt] +"/"+ $rtnStreFileNmArr[$imgCnt];
				}
?>

				<li style="width: 33%;display: inline-block;"><a href="#" onclick="javascript:move2('<?=$cntntsNo?>');">
				<img src="<?=$imgUrl?>" alt="<?=$fdNm?>"  title="<?=$fdNm?>" style="width: 249px;height: 198px;"/>
				</a>
				<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><?=$fdNm?></p>
				</li>
<?PHP		}
		}
	}
?>
	</ul>
	</div>
	<hr>
	<div>
	<ul>
<?PHP

	foreach($object->body[0]->items[0]->item as $item){
			//키값
			$cntntsNo = $item->cntntsNo;
			//파일구분코드
			$rtnImgSeCode = $item->rtnImgSeCode;
			//파일경로
			$rtnFileCours = $item->rtnFileCours;
			//파일명
			$rtnStreFileNm = $item->rtnStreFileNm;
			//파일제목
			$fdNm = $item->fdNm;
			//레시피구분
			$fdSeCode = $item->fdSeCode;
			if("290002" == $fdSeCode || "290003" == $fdSeCode){

				$imgCnt =-1;
				$rtnImgSeCodeArr = explode('|',$rtnImgSeCode);
				$rtnImgSeCodeCnt = count($rtnImgSeCodeArr);
				for($k=0; $k < $rtnImgSeCodeCnt; $k++){
					if("209006" ==$rtnImgSeCodeArr[$k]){
						$imgCnt = $k;
					}
				}
				$imgUrl ="http://www.nongsaro.go.kr/ps/img/common/anvil_img.jpg";
				if($imgCnt > -1){
					$rtnFileCoursArr = explode('|',$rtnFileCours);
					$rtnStreFileNmArr = explode('|',$rtnStreFileNm);
					$imgUrl = "http://www.nongsaro.go.kr/"+ $rtnFileCoursArr[$imgCnt] +"/"+ $rtnStreFileNmArr[$imgCnt];
				}
?>

				<li style="width: 33%;display: inline-block;"><a href="#">
				<img src="<?=$imgUrl?>" alt="<?=$fdNm?>"  title="<?=$fdNm?>" style="width: 249px;height: 198px;"/>
				</a>
				<p class="con" style="position: relative;text-align:center;line-height:18px;color:rgb(255,255,255); bottom:5px; width: 245px; top: auto; background:#333 !important;"><?=$fdNm?></p>
				</li>
<?PHP		}
		}
?>
</ul>
</div>
</body>
</html>