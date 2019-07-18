<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<?PHP
//Term
if(isset($_REQUEST["faoCode"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명	
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "thesaurusDtlTerm";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["faoCode"]!=NULL){
		$parameter .= "&faoCode=";
		$parameter .= $_REQUEST["faoCode"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) <> 0){
?>
<div style="float: left; width: 49%; margin-right: 10px">
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Term</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			$languageCodeNm = $item->languageCodeNm;
			$languageCode = $item->languageCode;
			$termSpell = $item->termSpell;
?>
		<tr>
   			<td><?=$termSpell?>(<?=$languageCodeNm?>)</td>
		</tr>
<?PHP
		}
?>
	</table>
</div>
<?PHP
	}
}
?>


<div style="float: left; width: 49%">
<?PHP
//Word Tree
if(isset($_REQUEST["faoCode"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명	
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "thesaurusDtlWordTree";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["faoCode"]!=NULL){
		$parameter .= "&faoCode=";
		$parameter .= $_REQUEST["faoCode"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) <> 0){
?>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Word Tree</th>
		</tr>
		
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			$linkAbr = $item->linkAbr;
			$termSpell = $item->termSpell;
			$termCode2 = $item->termCode2;
?>
		<tr>
   			<td><?=$linkAbr?>&nbsp;&nbsp;<?=$termSpell?>(<?=$termCode2?>)</td>
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
//Scope Notes
if(isset($_REQUEST["faoCode"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "nongsaroSampleKey";
	//서비스 명	
	$serviceName = "farmDic";
	//오퍼레이션 명
	$operationName = "thesaurusDtlScopeNotes";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["faoCode"]!=NULL){
		$parameter .= "&faoCode=";
		$parameter .= $_REQUEST["faoCode"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);
	
	if(count($object->body[0]->items[0]->item) <> 0){
?>
	<br>
	<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<tr>
			<th>Scope Notes</th>
		</tr>
		
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			$tagDesc = $item->tagDesc;
			$tagText = $item->tagText;
?>
		<tr>
   			<td>[<strong><?=$tagDesc?></strong>]&nbsp;<?=$tagText?></td>
		</tr>
<?PHP	
		}
?>
	</table>
<?PHP
	}
}
?>

</div>
</body>
</html>