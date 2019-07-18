<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>농산물 소득 정보</title>
<script type="text/javascript">
	//메인 테크 항목
	function fncMove(sCode){
		with(document.mainApiForm){
			svcCode.value = sCode;
			method="get";
			action = "farmPrdtIncome.php";
			target = "_self";
			submit();
		}
	}
	//연도 선택
	function yearMove(cYear){
		if("<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>" == "") {
			yearApiForm.svcCode.value ='0';
		}
		
		with(document.yearApiForm){
			year.value = cYear;
			method="get";
			action = "farmPrdtIncome.php";
			target = "_self";
			submit();
		}
	}
	//지역 선택
	function localMove(cLocal){
		if("<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>" == "") {
			localApiForm.svcCode.value ='0';
		}
		if("<?PHP if(isset($_REQUEST["year"])){ echo $_REQUEST["year"];}?>" == "") {
			localApiForm.year.value = viewForm.yearCombo.value; 
		}
		
		with(document.localApiForm){
			atptCode.value = cLocal;
			method="get";
			action = "farmPrdtIncome.php";
			target = "_self";
			submit();
		}
	}
	//상세 보기
	function detailMove(eCode){
		
		if("<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>" == "") {
			detailApiForm.svcCode.value ='0';
		}
		
		if("<?PHP if(isset($_REQUEST["year"])){ echo $_REQUEST["year"];}?>" == "") {
			detailApiForm.year.value = viewForm.yearCombo.value; 
		}
		
		
		if("<?PHP if(isset($_REQUEST["atptCode"])){ echo $_REQUEST["atptCode"];}?>" == "") {
			detailApiForm.atptCode.value = viewForm.atptCode0.value; 
		}
		
		with(document.detailApiForm){
			eqpCode.value = eCode;
			method="get";
			action = "farmPrdtIncome.php";
			target = "_self";
			submit();
		}
	}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>농산물 소득 정보</strong></h3>

<form name="mainApiForm">
<input type="hidden" name="svcCode" value="<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>">
</form>

<form name="yearApiForm">
<input type="hidden" name="svcCode" value="<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>">
<input type="hidden" name="year" value="<?PHP if(isset($_REQUEST["year"])){ echo $_REQUEST["year"];}?>">
</form>

<form name="localApiForm">
<input type="hidden" name="svcCode" value="<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>">
<input type="hidden" name="year" value="<?PHP if(isset($_REQUEST["year"])){ echo $_REQUEST["year"];}?>">
<input type="hidden" name="atptCode" value="<?PHP if(isset($_REQUEST["atptCode"])){ echo $_REQUEST["atptCode"];}?>">
</form>

<form name="detailApiForm">
<input type="hidden" name="svcCode" value="<?PHP if(isset($_REQUEST["svcCode"])){ echo $_REQUEST["svcCode"];}?>">
<input type="hidden" name="year" value="<?PHP if(isset($_REQUEST["year"])){ echo $_REQUEST["year"];}?>">
<input type="hidden" name="atptCode" value="<?PHP if(isset($_REQUEST["atptCode"])){ echo $_REQUEST["atptCode"];}?>">
<input type="hidden" name="eqpCode" value="<?PHP if(isset($_REQUEST["eqpCode"])){ echo $_REQUEST["eqpCode"];}?>">
</form>
<hr>
<form name="viewForm">
<table width="100%" border="1" cellSpacing="0" cellPadding="0">
	<tr>				
		<td align="center"><a href="javascript:fncMove('0');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="0" || $_REQUEST["svcCode"]==null) echo "<strong>전체</strong>"; else echo "전체";}else echo "전체"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('FC');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="FC") echo "<strong>식량작물</strong>"; else echo "식량작물";}else echo "식량작물"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('FG');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="FG") echo "<strong>사료녹비작물</strong>"; else echo "사료녹비작물";}else echo "사료녹비작물"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('FL');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="FL") echo "<strong>화훼</strong>"; else echo "화훼";}else echo "화훼"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('FT');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="FT") echo "<strong>과수</strong>"; else echo "과수";}else echo "과수"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('IC');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="IC") echo "<strong>특용작물</strong>"; else echo "특용작물";}else echo "특용작물"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('LP');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="LP") echo "<strong>축산</strong>"; else echo "축산";}else echo "축산"; ?></a></td>
		<td align="center"><a href="javascript:fncMove('VC');"><?PHP if(isset($_REQUEST["svcCode"])){ if($_REQUEST["svcCode"]=="VC") echo "<strong>채소</strong>"; else echo "채소";}else echo "채소"; ?></a></td>
	</tr>
</table>
<!-- ============================================== 연도 목록 시작 =========================================================== -->

<?PHP
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를입력하십시오";
	//서비스 명
	$serviceName = "farmPrdtIncome";
	//오퍼레이션 명
	$operationName = "farmPrdtIncomeYearList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	//품목 코드
	$sSvcCode = "0";
	if(isset($_REQUEST["svcCode"]) && $_REQUEST["svcCode"]!=""){
		$sSvcCode = $_REQUEST["svcCode"];
	}
	
	$parameter .= "&svcCode=" . $sSvcCode;

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 
	
	//XML Parsing
	$xml1 = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object1 = simplexml_load_string($xml1);

	if(count($object1->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
		 년도 선택 : <select  id="yearCombo" onchange="yearMove(this.value);" > 
<?PHP
		foreach($object1->body[0]->items[0]->item as $item){
			//년도
			$year = $item->year;
			if($_REQUEST["year"] != null || $_REQUEST["year"] != "" ){
				if($_REQUEST["year"] == $year){
?>
				<option value="<?=$year?>" selected> <?=$year?> </option>
<?PHP
				}else{
?>
					<option value="<?=$year?>" > <?=$year?> </option>
<?PHP
				}
			}else{
?>
				<option value="<?=$year?>" > <?=$year?> </option>
<?PHP
			}
		}
?>
		</select>
		</tr>
	</table>
<?PHP
	}
?>
<!-- ============================================== 연도 목록 끝 =========================================================== -->

<!-- ============================================== 지역 목록 시작 =========================================================== -->
<?PHP
	//서비스 명
	$serviceName = "farmPrdtIncome";
	//오퍼레이션 명
	$operationName = "farmPrdtIncomeSidoList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	$sYear = $object1->body[0]->items[0]->item[0]->year;
	if(isset($_REQUEST["year"]) && $_REQUEST["year"]!=""){
		$sYear = $_REQUEST["year"];
	}
	
	$parameter .= "&svcCode=" . $sSvcCode;
	$parameter .= "&year=" . $sYear;

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 
	
	//XML Parsing
	$xml2 = file_get_contents($url);
	$object2 = simplexml_load_string($xml2);
	
	if(!isset($_REQUEST["atptCode"])){
		$sAtptCode = $object2->body[0]->items[0]->item[0]->atptCode;
	}else{
		$sAtptCode = $_REQUEST["atptCode"];
	}
	
	if(count($object2->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
<?PHP
		$i=0;
		foreach($object2->body[0]->items[0]->item as $item){
			//지역 코드
			$atptCode = $item->atptCode;
			//지역 코드 명
			$atptNm = $item->atptNm;
			if($i%5==0){ echo "</tr><tr>"; }
			
			if($sAtptCode==$atptCode){
?>
				<td width="10%" align="left">&nbsp;│&nbsp;<strong><a href="javascript:localMove('<?=$atptCode?>');"><?=$atptNm?></a></strong></td>
				<input type="hidden" name="atptCode<?=$i?>" value="<?=$atptCode?>"  />
<?PHP

			}else{
?>
				<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:localMove('<?=$atptCode?>');"><?=$atptNm?></a></td>
				<input type="hidden" name="atptCode<?=$i?>" value="<?=$atptCode?>"  />
<?PHP
			}
			$i++;
		}
?>
		</tr>
	</table>
<?PHP
	}
?>
<!-- ============================================== 지역 목록 끝 =========================================================== -->

<!-- ============================================== 카테고리 조회 시작 =========================================================== -->
<?PHP
	//서비스 명
	$serviceName = "farmPrdtIncome";
	//오퍼레이션 명
	$operationName = "farmPrdtIncomeList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	$sAtptCode = $object2->body[0]->items[0]->item[0]->atptCode;
	if(isset($_REQUEST["atptCode"]) && $_REQUEST["atptCode"]!=""){
		$sAtptCode = $_REQUEST["atptCode"];
	}
	
	$parameter .= "&svcCode=" . $sSvcCode;
	$parameter .= "&year=" . $sYear;
	$parameter .= "&atptCode=" . $sAtptCode;

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 
	
	//XML Parsing
	$xml3 = file_get_contents($url);
	$object3 = simplexml_load_string($xml3);

	if(!isset($_REQUEST["eqpCode"])){
		$sEqpCode = $object3->body[0]->items[0]->item[0]->eqpCode;
	}else{
		$sEqpCode = $_REQUEST["eqpCode"];
	}

	if(count($object3->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
<?PHP
		$j=0;
		foreach($object3->body[0]->items[0]->item as $item){
			//설비 코드 명
			$eqpCode = $item->eqpCode;
			//설비 명
			$eqpNm = $item->eqpNm;
			if($j%5==0){ echo "</tr><tr>"; }
			
			if($sEqpCode==$eqpCode){
?>
				<td width="10%" align="left">&nbsp;│&nbsp;<strong><a href="javascript:detailMove('<?=$eqpCode?>');"><?=$eqpNm?></a></strong></td>
<?PHP
			}else{
?>
				<td width="10%" align="left">&nbsp;│&nbsp;<a href="javascript:detailMove('<?=$eqpCode?>');"><?=$eqpNm?></a></td>
<?PHP
			}
			$j++;
		}
?>
		</tr>
	</table>
<?PHP
	}
?>
<!-- ============================================== 카테고리 조회 끝 =========================================================== -->

<!-- ============================================== 작목 상세 목록 시작 =========================================================== -->
<?PHP
	//서비스 명
	$serviceName = "farmPrdtIncome";
	//오퍼레이션 명
	$operationName = "farmPrdtIncomeDetailList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	$sEqpCode = $object3->body[0]->items[0]->item[0]->eqpCode;
	if(isset($_REQUEST["eqpCode"]) && $_REQUEST["eqpCode"]!=""){
		$sEqpCode = $_REQUEST["eqpCode"];
	}
	
	$parameter .= "&svcCode=" . $sSvcCode;
	$parameter .= "&year=" . $sYear;
	$parameter .= "&atptCode=" . $sAtptCode;
	$parameter .= "&eqpCode=" . $sEqpCode;

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 
	
	//XML Parsing
	$xml4 = file_get_contents($url);
	$object4 = simplexml_load_string($xml4);

	if(count($object4->body[0]->items[0]->item) == 0){
?>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" class="grid topLine" border="1" cellSpacing="0" summary="" cellPadding="0"><!-- border=1  스타일 지웠을 경우를 데이터 정렬 -->
		 <caption>농수산물 소득정보 리스트</caption>
			<colgroup>
				<col width="5%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="15%" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="4">비목별</th>
				<th scope="col">수량(Kg)</th>
				<th scope="col">단가(원)</th>
				<th scope="col">금액(원)</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>
		  <tr>
			<th scope="row" rowspan="2">조수입</th>
          		<td colspan="3">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						//목록 코드 
						$listCode = $item->listCode;
						//목록 명
						$listNm = $item->listNm;
						//소득 분석 개수
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						//소득 단위
						$incomeUnit = $item->incomeUnit;
						//소득 금액 수
						$incomeAmount = $item->incomeAmount;
						//소득 총 금액
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "주산물가액" || $listNm == "부산물가액") {
							echo $listNm."<br/>";
						}
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
						if($listNm == "주산물가액" || $listNm == "부산물가액"){
							echo $incomeAnalsRnnm.$incomeUnit."<br/>";
						}
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "주산물가액" || $listNm == "부산물가액"){
							echo $incomeAmount."<br/>";
						}
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "주산물가액" || $listNm == "부산물가액"){
							echo $incomeTotAmount."<br/>";
						}
					}
?>
				</td>
				<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "상품화율"){
							echo $listNm.$incomeTotAmount.$incomeUnit."<br/>";
						}
					}
?>
				</td>
			</tr>
<?PHP
				$sYearCd = "";
				foreach($object4->body[0]->items[0]->item as $item){
					$yearCode = $item->yearCode;
					$listCode = $item->listCode;
					$listNm = $item->listNm;
					$incomeAnalsRnnm = $item->incomeAnalsRnnm;
					$incomeUnit = $item->incomeUnit;
					$incomeAmount = $item->incomeAmount;
					$incomeTotAmount = $item->incomeTotAmount;
					$sYearCd = $yearCode;
					if($listNm == "조수입 계"){
?>
					<tr>
						<td colspan="3">계</td>
						<td></td>
						<td></td>
						<td><?=$incomeTotAmount?></td>
						<td></td>
					</tr>
<?PHP
					}
				}
?>
			<tr>
				<th scope="row" rowspan="<?PHP if($sYearCd == "2013" ){ echo "6"; }else{ echo "5"; }?>">생<br/>산<br/>비</th>
				<th scope="row" rowspan="4">경<br/>영<br/>비</th>
				<th scope="row" rowspan="2">중<br/>간<br/>재<br/>비</th>
				<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$yearCode = $item->yearCode;
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "종묘비종자" || $listNm == "종묘비종묘" || $listNm == "무기질비료비" || $listNm == "유기질비료비" || $listNm == "농약비" || $listNm == "광열동력비" || $listNm == "수리(水利)비" || $listNm == "제재료비" || $listNm == "소농구비" || $listNm == "대농구상각비" || $listNm == "영농시설상각비" || $listNm == "수리(修理)비" || $listNm == "기타요금"){
							if($yearCode == "2013" && $listCode == "03010104"){
								$listNm = "영농광열비";
							}elseif($yearCode == "2013" && $listCode == "03010131"){
								$listNm = "기타제재료비";
							}elseif($yearCode == "2013" && $listCode == "03010119"){
								$listNm = "수선비";
							}

							echo $listNm."<br/>";
						}
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "종묘비종자" || $listNm == "종묘비종묘" || $listNm == "무기질비료비" || $listNm == "유기질비료비" || $listNm == "농약비" || $listNm == "광열동력비" || $listNm == "수리(水利)비" || $listNm == "제재료비" || $listNm == "소농구비" || $listNm == "대농구상각비" || $listNm == "영농시설상각비" || $listNm == "수리(修理)비" || $listNm == "기타요금"){
							if($incomeAnalsRnnm != "0"){
								echo $incomeAnalsRnnm.$incomeUnit."<br/>";
							}
						}
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "종묘비종자" || $listNm == "종묘비종묘" || $listNm == "무기질비료비" || $listNm == "유기질비료비" || $listNm == "농약비" || $listNm == "광열동력비" || $listNm == "수리(水利)비" || $listNm == "제재료비" || $listNm == "소농구비" || $listNm == "대농구상각비" || $listNm == "영농시설상각비" || $listNm == "수리(修理)비" || $listNm == "기타요금"){
							if($incomeAmount != "0"){
								echo $incomeAmount."<br/>";
							}
						} 
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "종묘비종자" || $listNm == "종묘비종묘" || $listNm == "무기질비료비" || $listNm == "유기질비료비" || $listNm == "농약비" || $listNm == "광열동력비" || $listNm == "수리(水利)비" || $listNm == "제재료비" || $listNm == "소농구비" || $listNm == "대농구상각비" || $listNm == "영농시설상각비" || $listNm == "수리(修理)비" || $listNm == "기타요금"){
							echo $incomeTotAmount."<br/>";
						}
					}
?>
				</td>
				<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						if($listNm =="복합"){$listNm = "복합비료";}
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "N" || $listNm == "P" || $listNm == "K" || $listNm == "요소" || $listNm == "유안" || $listNm == "용성인비" || $listNm == "염화칼리" || $listNm == "붕소" || $listNm == "농용석회" || $listNm == "복합비료" || $listNm == "규산질" || $listNm == "영양제액제" || $listNm == "영양제수화제" || $listNm == "살충제유제" || $listNm == "살충제입제" || $listNm == "살충제수화제" 
								|| $listNm == "살균제유제" || $listNm == "살균제분제" || $listNm == "살균제입제" || $listNm == "살균제수화제" || $listNm == "영양제수화제" || $listNm == "제초제유제" || $listNm == "제초제입제" || $listNm == "전기" || $listNm == "가스"
								|| $listNm == "유류" || $listNm == "비닐" || $listNm == "활죽" || $listNm == "폿트" || $listNm == "비닐끈"
									|| $listNm == "짚" || $listNm == "왕겨" || $listNm == "포장상자" || $listNm == "보온덮개"){

							if($incomeAnalsRnnm != "0"){
								echo $listNm." ".$incomeAnalsRnnm." ".$incomeUnit."<br/>";

							}
						}
					}
?>
				</td>
			</tr>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "중간재비 계"){
?>
					<tr>
						<td>계</td>
						<td></td>
						<td></td>
						<td align="right"><?=$incomeTotAmount?></td>
						<td></td>
					</tr>
<?PHP
						}
					}
?>		
					<tr>
			<td colspan="2">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "임차료(농기계.시설)" || $listNm == "임차료(토지)" || $listNm == "위탁영농비" || $listNm == "고용노력비"){
							echo $listNm."<br/>";
						}
					}
?>
			</td>
			<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "임차료(농기계.시설)" || $listNm == "임차료(토지)" || $listNm == "위탁영농비" || $listNm == "고용노력비"){
							if($incomeAnalsRnnm != "0"){
								echo $incomeAnalsRnnm.$incomeUnit."<br/>";
							}
						}
					}
?>
			</td>
			<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listCode == "030100A1" || $listCode == "030100A2"){
							if($listNm != "남"){
								echo "남".$incomeAmount."<br/>";
							}else if($listNm != "여"){
								echo "여".$incomeAmount."<br/>";
							}
						}
					}
?>
			</td>
			<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "임차료(농기계.시설)" || $listNm == "임차료(토지)" || $listNm == "위탁영농비" || $listNm == "고용노력비" || $listNm == "남" || $listNm == "여"){
							if($incomeTotAmount != "0"){
								echo $incomeTotAmount."<br/>";
							}
						}
					}
?>
			</td>
			<td><br/><br/><br/>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listCode == "04030002" || $listCode == "0403A002"){
							echo $listNm." ".$incomeAnalsRnnm." ".$incomeUnit."<br/>";
						}
					}
?>
			</td>
			</tr>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listNm == "경영비 계"){
?>
						<tr valign="top">
							<td colspan="2">계</td>
							<td>&#160;</td>
							<td>&#160;</td>
							<td align="right"><?=$incomeTotAmount?></td>
							<td>&#160;</td>
						</tr>
<?PHP
						}
					}
?>
			<tr valign="top">
				<td colspan="3">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$yearCode = $item->yearCode;
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
						
						if($yearCode =="2013"){
							if($listCode =="030000A0" || $listCode =="03000009" || $listCode =="03000010" || $listCode =="03000011"){
								echo $listNm."<br/>";
							}
						}else{
							if($listCode =="030000A0"){
								$listNm = "자가노력비";
								echo $listNm;
							}
						}
					}
?>
				</td>
				<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listCode =="030000A0" || $listCode == "030000A1" || $listCode == "030000A2"){
							if($incomeAnalsRnnm != "0"){
								echo $incomeAnalsRnnm.$incomeUnit;
							}
						}
					}
?>
				</td>
				<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listCode =="030000A0" || $listCode == "030000A1" || $listCode == "030000A2"){
							if($incomeAmount != "0"){
								if($listNm != "남"){
									echo "남".$incomeAmount."<br/>";
								}else if($listNm != "여"){
									echo "여".$incomeAmount."<br/>";
								}
							}
						}
					}
?>
				</td>
				<td align="right">
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$yearCode = $item->yearCode;
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
						
						if($yearCode == "2013"){
							if($listCode =="030000A0" || $listCode =="03000009" || $listCode =="03000010" || $listCode =="03000011"){
								if($listCode =="030000A0"){
									$fIncomeTotAmount = (float)$incomeAnalsRnnm * 13932;
									echo $incomeTotAmount."*<br/>";
									echo $fIncomeTotAmount."**<br/>";
								}else{
									echo $incomeTotAmount."<br/>";
								}
							}
						}else{
							if($listCode =="030000A0"){
								echo $incomeTotAmount."<br/>";
							}
						}
					}
?>
				</td>
				<td>
<?PHP
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeTotAmount = $item->incomeTotAmount;
					
						if($listCode == "0402A001" || $listCode == "0402A002"){
							echo $listNm.$incomeAnalsRnnm.$incomeUnit."<br/>";
						}
					}
?>
				</td>
			</tr>
<?PHP
				if($sYearCd =="2013"){
					$tot2 = 0;
					$tot2 = 0;
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeAnalsRnnm = str_replace(",","",$incomeAnalsRnnm);
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeAmount = str_replace(",","",$incomeAmount);
						$incomeTotAmount = $item->incomeTotAmount;
						$incomeTotAmount = str_replace(",","",$incomeTotAmount);
						
						if($listNm =="경영비 계"){
							$tot2 = $tot2 + $incomeTotAmount;
							$tot3 = $tot3 + $incomeTotAmount;
						}elseif($listCode == "030000A0"){
							$tot2 = $tot2 + $incomeTotAmount;
							$tot3 = $tot3 + (float)$incomeAnalsRnnm * 13932;
						}elseif($listCode == "03000009"){
							$tot2 = $tot2 + $incomeTotAmount;
							$tot3 = $tot3 + $incomeTotAmount;
						}elseif($listCode == "03000010"){
							$tot2 = $tot2 + $incomeTotAmount;
							$tot3 = $tot3 + $incomeTotAmount;
						}elseif($listCode == "03000011"){
							$tot2 = $tot2 + $incomeTotAmount;
							$tot3 = $tot3 + $incomeTotAmount;
						}
					}
?>
					<tr valign="top">
						<td scope="row" colspan="3">계</td>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><?=$tot2?><br/><?=$tot3?></td>
						<td>&#160;</td>
					</tr>
<?PHP
				}
				foreach($object4->body[0]->items[0]->item as $item){
					$listCode = $item->listCode;
					$listNm = $item->listNm;
					$incomeAnalsRnnm = $item->incomeAnalsRnnm;
					$incomeUnit = $item->incomeUnit;
					$incomeAmount = $item->incomeAmount;
					$incomeTotAmount = $item->incomeTotAmount;
				
					if($listNm == "소득"){
?>
					<tr>
						<th scope="row" colspan="4">소 &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;득</th>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><?=$incomeTotAmount?></td>
						<td>&#160;</td>
					</tr>
<?PHP
					}
				}
				foreach($object4->body[0]->items[0]->item as $item){
					$listCode = $item->listCode;
					$listNm = $item->listNm;
					$incomeAnalsRnnm = $item->incomeAnalsRnnm;
					$incomeUnit = $item->incomeUnit;
					$incomeAmount = $item->incomeAmount;
					$incomeTotAmount = $item->incomeTotAmount;
				
					if($listNm == "부가가치"){
?>
				<tr>
					<th scope="row" colspan="4">부 &#160;가 &#160;가 &#160;치 </th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><?=$incomeTotAmount?></td>
					<td>&#160;</td>
				</tr>
<?PHP
					}
				}
				if($sYearCd =="2013"){
					$sum1 = 0;
					$sum2 = 0;
					$fTot = 0;
					foreach($object4->body[0]->items[0]->item as $item){
						$listCode = $item->listCode;
						$listNm = $item->listNm;
						$incomeAnalsRnnm = $item->incomeAnalsRnnm;
						$incomeAnalsRnnm = str_replace(",","",$incomeAnalsRnnm);
						$incomeUnit = $item->incomeUnit;
						$incomeAmount = $item->incomeAmount;
						$incomeAmount = str_replace(",","",$incomeAmount);
						$incomeTotAmount = $item->incomeTotAmount;
						$incomeTotAmount = str_replace(",","",$incomeTotAmount);
					
						if($listNm == "조수입 계"){
							$sum1 = $sum1 + $incomeTotAmount;
						}elseif($listNm == "중간재비 계"){
							$sum2 = $sum2 + $incomeTotAmount;
						}
					}

					$fTot =(($sum1-$sum2)/$sum1)*100;
?>
					<tr>
						<th scope="row" colspan="4">부 &#160;가 &#160;가 &#160;치&#160;율(%) </th>
						<td>&#160;</td>
						<td>&#160;</td>
						<td align="right"><?=round($fTot, 1)?></td>
						<td>&#160;</td>
					</tr>
<?PHP
				}
				foreach($object4->body[0]->items[0]->item as $item){
					$listCode = $item->listCode;
					$listNm = $item->listNm;
					$incomeAnalsRnnm = $item->incomeAnalsRnnm;
					$incomeUnit = $item->incomeUnit;
					$incomeAmount = $item->incomeAmount;
					$incomeTotAmount = $item->incomeTotAmount;
				
					if($listNm == "소득율(%)"){
?>
				<tr>
					<th scope="row" colspan="4">소 &#160;득 &#160;률(%)</th>
					<td>&#160;</td>
					<td>&#160;</td>
					<td align="right"><?=$incomeTotAmount?>
					</td>
					<td>&#160;</td>
				</tr>
<?PHP
					}
				}
?>
		</tbody>
	</table>
<?PHP
	}
?>
</form>
</body>
</html>