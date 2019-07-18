<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>미생물(계열,생리작용별)</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>미생물(계열,생리작용별)</strong></h3><hr>

<?PHP
if(true){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "statMicroorganismLine";

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
		<colgroup>
		<col width="33%" />
		<col width="%" />
		<col width="33%" />
	</colgroup>
      <thead>
         <tr>
			<th scope="col" >계열</th>
			<th scope="col" >화합물 수</th>
			<th scope="col" >비율</th>
         </tr>
       </thead>
       <tbody>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//구분
			$tab = $item->tab;
			//계열 코드
			$code = $item->code;
			//계열 코드 명
			$codeNm = $item->codeNm;
			//화합물 수
			$cnt = $item->cnt;
			//비율
			$ratio = $item->ratio;
			
			if($tab=="ALL"){
?>
			<tr>
			    <?PHP if ($code=="TOTAL") {  ?>
			       <td align="center"><?=$code?></td>
			    <?PHP } else {  ?>
			    	<td align="center"><?=$codeNm?></td>
			    <?PHP } ?>
				<td align="center"><?=$cnt?></td>
				<td align="center"><?=$ratio?></td>
			<tr>
<?PHP
			}
		}
?>
		</tbody>
	</table>
<?PHP
	}
}
?>
</body>
</html>