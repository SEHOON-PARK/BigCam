<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>이달의음식</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>이달의음식</strong></h3>
<hr>
<?PHP
//이달의음식 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "monthFd";
	//오퍼레이션 명
	$operationName = "monthFdmtDtl";

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
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);

	//키값
	$cntntsNo = $object->body[0]->item[0]->cntntsNo;

	//식재료명
	$fdmtNm = $object->body[0]->item[0]->fdmtNm;
	//식재료유래
	$ctvtIndcDtl = $object->body[0]->item[0]->ctvtIndcDtl;
	//품종특성 구입요령
	$prchCheatDtl = $object->body[0]->item[0]->prchCheatDtl;
	//보관방법 손질법
	$cstdyMthDtl = $object->body[0]->item[0]->cstdyMthDtl;
	//기타정보
	$etcInfoDtl = $object->body[0]->item[0]->etcInfoDtl;
	//섭취방법
	$ntkMthDtl = $object->body[0]->item[0]->ntkMthDtl;
	//영양성분효능
	$ntrIrdntEfcyDtl = $object->body[0]->item[0]->ntrIrdntEfcyDtl;
	//관련연구정보
	$rltRsrchInfoDtl = $object->body[0]->item[0]->rltRsrchInfoDtl;
	//소비량
	$cnsmpqyDtl = $object->body[0]->item[0]->cnsmpqyDtl;
	//이미지구분코드
	$rtnImgSeCode = $object->body[0]->item[0]->rtnImgSeCode;
	//이미지 경로
	$rtnFileCours = $object->body[0]->item[0]->rtnFileCours;
	//이미지 물리명
	$rtnStreFileNm = $object->body[0]->item[0]->rtnStreFileNm;
	//이미지 설명
	$rtnImageDc = $object->body[0]->item[0]->rtnImageDc;

?>
<h3><strong>이달의음식 (<?=$fdmtNm?>)</strong></h3>
	<hr>
	<h2> 기본정보</h2>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:10%;">
			<col width="*">
		</colgroup>
		<tr>
			<td>식재료유래</td>
			<td><?=$ctvtIndcDtl?></td>
		</tr>
		<tr>
			<td>품종특성구입요령</td>
			<td><?=$prchCheatDtl?></td>
		</tr>
		<tr>
			<td>보관법손질법</td>
			<td><?=$cstdyMthDtl?></td>
		</tr>
		<tr>
			<td>기타정보</td>
			<td><?=$etcInfoDtl?></td>
		</tr>
	</table>
	<h2>섭취정보</h2>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:10%;">
			<col width="*">
		</colgroup>
		<tr>
			<td>섭취방법</td>
			<td><?=$ntkMthDtl?></td>
		</tr>
		<tr>
			<td>영양성분효능</td>
			<td><?=$ntrIrdntEfcyDtl?></td>
		</tr>
		<tr>
			<td>관련연구정보</td>
			<td><?=$rltRsrchInfoDtl?></td>
		</tr>
		<tr>
			<td>소비량</td>
			<td><?=$cnsmpqyDtl?></td>
		</tr>
	</table>
<?PHP

			$rtnFileCoursArr = explode('|',$rtnFileCours);
			$rtnStreFileNmArr = explode('|',$rtnStreFileNm);
			$rtnImgSeCodeArr = explode('|',$rtnImgSeCode);
			$rtnImgSeCodeCnt = count($rtnImgSeCodeArr);
			for($k=0; $k < $rtnImgSeCodeCnt; $k++){
				$imgCnt =-1;
				if("209002" ==$rtnImgSeCodeArr[$k] || "209006" ==$rtnImgSeCodeArr[$k]){
					$imgCnt = $k;
				}
				if($imgCnt > -1){
					$imgUrl = "http://www.nongsaro.go.kr/"+ $rtnFileCoursArr[$imgCnt] +"/"+ $rtnStreFileNmArr[$imgCnt];
?>
					<li style="width: 33%;display: inline-block;"><a href="#" onclick="javascript:move1('<?=$cntntsNo?>');">
					<img src="<?=$imgUrl?>" alt="<?=$fdmtNm?>"  title="<?=$fdmtNm?>" style="width: 249px;height: 198px;"/>
					</a></li>
<?PHP
				}
			}
}
?>
<br>
<input type="button" onclick="javascript:location.href='monthFd.php'" value="처음화면으로"/>&nbsp;
</body>
</html>