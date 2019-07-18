<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>미생물 통계</title>
<script type="text/javascript">

	//팝업 띄우기
	function fncNextList(seq,cntCode){
		var popupUrl="onccpPoP.php?lvbNo="+seq+"&cntCode="+cntCode+"&check4=statMicroorganism";
		var popOption="width=800,height=440";
		
		window.open(popupUrl,"nongsaroPop",popOption);
	}
</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>미생물 통계</strong></h3><hr>

<?PHP
if(true){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$serviceAction = "statMicroorganism";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$serviceAction;
	$parameter .= "?apiKey=".$apiKey;
	
	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
?>
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
		foreach($object->body[0]->items[0]->item as $item){
			//과_일련_번호
			$fmlSeqNo = $item->fmlSeqNo;
			//과_명_명
			$fmlNm = $item->fmlNm;
			//살균.살충.제초 
			$cntA = $item->cntA;
			//살균.살충   
			$cntB = $item->cntB;
			//살균.제초
			$cntC = $item->cntC;
			//살충.제초 
			$cntD = $item->cntD;
			//살균 
			$cntE = $item->cntE;
			//살충  
			$cntF = $item->cntF;
			//제초 
			$cntG = $item->cntG;
			//살균.살충.제초 비율
			$ratioA = $item->ratioA;
			//살균.살충 비율
			$ratioB = $item->ratioB;
			//살균.제초 비율 
			$ratioC = $item->ratioC;
			//살충.제초 비율 
			$ratioD = $item->ratioD;
			//살균 비율 
			$ratioE = $item->ratioE;
			//살충 비율 
			$ratioF = $item->ratioF;
			//제초 비율
			$ratioG = $item->ratioG;
			//식물수 비율 
			$cnt = $item->cnt;
?>
<h3><strong><?=$fmlNm?></strong></h3>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
		</colgroup>
		<tr>
			<th>식물수</th>
			<th>살균,살충,제초</th>
			<th>살균,살충</th>
			<th>살균,제초</th>
			<th>살충,제초</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
		</tr>
		<tr>
			<td align="center">
			<?PHP if($cnt!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','1');"><?=$cnt?></a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntA!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_A');"><?=$cntA?>(<?=$ratioA?>%)</a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntB!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_B');"><?=$cntB?>(<?=$ratioB?>%)</a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntC!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_C');"><?=$cntC?>(<?=$ratioC?>%)</a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntD!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_D');"><?=$cntD?>(<?=$ratioD?>%)</a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntE!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_E');"><?=$cntE?>(<?=$ratioE?>%)</a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntF!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_F');"><?=$cntF?>(<?=$ratioF?>%)</a>
			<?PHP }else echo "-";?>
			</td>
			<td align="center">
			<?PHP if($cntG!="0"){?>
				<a href="javascript:fncNextList('<?=$fmlSeqNo?>','COUNT_G');"><?=$cntG?>(<?=$ratioG?>%)</a>
			<?PHP }else echo "-";?>
			</td>
		<tr>
	</table>
<?PHP
		}
	}
}
?>
</body>
</html>