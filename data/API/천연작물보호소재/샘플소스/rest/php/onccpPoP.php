<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<?PHP
//화합물 및 참고 문헌리스트
if(isset($_REQUEST["check1"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "searchPlantReferLtrtre";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["lvbNo"])){
		$parameter .= "&lvbNo=";
		$parameter .= $_REQUEST["lvbNo"];
	}
	
	if(isset($_REQUEST["referLtrtreCode"])){
		$parameter .= "&referLtrtreCode=";
		$parameter .= $_REQUEST["referLtrtreCode"];
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
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 및 참고 문헌리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="45%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>참고문헌</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//번호
			$rnum = $item->rnum;
			//화합물 명
			$onccpNm = $item->onccpNm;
			//요소명
			$elmnWrd = $item->elmnWrd;
			//참고문헌
			$cnDc = $item->cnDc;
?>
		<tr>
   			<td><?=$rnum?></td>
   			<td><?=$onccpNm?></td>
   			<td><?=$elmnWrd?></td>
   			<td><?=$cnDc?></td>
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
//참고 문헌리스트
if(isset($_REQUEST["check2"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "searchOnccpReferLtrtre";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["lvbNo"])){
		$parameter .= "&onccpNo=";
		$parameter .= $_REQUEST["lvbNo"];
	}
	
	if(isset($_REQUEST["referLtrtreCode"])){
		$parameter .= "&referLtrtreCode=";
		$parameter .= $_REQUEST["referLtrtreCode"];
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
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>참고 문헌리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="30%"/>
			<col width="65%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>구분</th>
			<th>참고문헌</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//번호
			$rnum = $item->rnum;
			//구분
			$codeNm = $item->codeNm;
			//참고문헌
			$cnDc = $item->cnDc;
?>
		<tr>
   			<td><?=$rnum?></td>
   			<td><?=$codeNm?></td>
   			<td><?=$cnDc?></td>
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
//생물자원리스트
if(isset($_REQUEST["check3"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "searchOnccpLvb";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["lvbNo"])){
		$parameter .= "&onccpNo=";
		$parameter .= $_REQUEST["lvbNo"];
	}
	
	if(isset($_REQUEST["referLtrtreCode"])){
		$parameter .= "&referLtrtreCode=";
		$parameter .= $_REQUEST["referLtrtreCode"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>생물자원리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="20%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//번호
			$rnum = $item->rnum;
			//과명
			$fmlNm = $item->fmlNm;
			//학명
			$bneNm = $item->bneNm;
			//국명
			$yeastNm = $item->yeastNm;
			//비고
			$rm = $item->rm;
?>
		<tr>
   			<td><?=$rnum?></td>
   			<td><?=$fmlNm?></td>
   			<td><?=$bneNm?></td>
   			<td><?=$yeastNm?></td>
   			<td><?=$rm?></td>
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
//생물자원리스트
if(isset($_REQUEST["check4"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "";

	if($_REQUEST["check4"]=="statInsect"){
		$operationName = "statInsectLst";
	}else if($_REQUEST["check4"]=="statMicroorganism"){
		$operationName = "statMicroorganismLst";
	}else if($_REQUEST["check4"]=="statPlant"){
		$operationName = "statPlantLst";
	}
	
	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["lvbNo"])){
		$parameter .= "&fmlNo=";
		$parameter .= $_REQUEST["lvbNo"];
	}
	
	if(isset($_REQUEST["cntCode"])){
		$parameter .= "&cntCode=";
		$parameter .= $_REQUEST["cntCode"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>생물자원리스트</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
			<th>화합물수</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//번호
			$rnum = $item->rnum;
			//과명
			$fmlNm = $item->fmlNm;
			//학명
			$bneNm = $item->bneNm;
			//국명
			$yeastNm = $item->yeastNm;
			//비고
			$rm = $item->rm;
			//화합물 수
			$cnt = $item->cnt;
?>
		<tr>
   			<td><?=$rnum?></td>
   			<td><?=$fmlNm?></td>
   			<td><?=$bneNm?></td>
   			<td><?=$yeastNm?></td>
   			<td><?=$rm?></td>
   			<td><?=$cnt?></td>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP
	}
}
?>
</body>
</html>