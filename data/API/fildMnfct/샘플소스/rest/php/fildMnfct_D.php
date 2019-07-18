<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>텃밭가꾸기</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>텃밭가꾸기</strong></h3>
<hr>
<?PHP
//텃밭가꾸기 상세조회
if(isset($_REQUEST["cntntsNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "fildMnfct";
	//오퍼레이션 명
	$operationName = "fildMnfctView";

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
	//제목
	$cntntsSj = $object->body[0]->item[0]->cntntsSj;
	//다운URL
	$downUrl = $object->body[0]->item[0]->downUrl;
	//등록일
	$svcDtx = $object->body[0]->item[0]->svcDtx;
	//조회수
	$cntntsRdcnt = $object->body[0]->item[0]->cntntsRdcnt;
	//작성자
	$updusrEsntlNm = $object->body[0]->item[0]->updusrEsntlNm;
	//다운파일명
	$fileName = $object->body[0]->item[0]->fileName;
	//내용
	$cn = $object->body[0]->item[0]->cn;

	$strDownUrl=explode(';',$downUrl);
	$strFileName=explode(';',$fileName);
?>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col style="width:16%" />
			<col style="width:18%" />
			<col style="width:16%" />
			<col style="width:18%" />
			<col style="width:16%" />
			<col/>
		</colgroup>
		<tr>
			<td>제목</td>
			<td colspan="5"><?=$cntntsSj?></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><?=$updusrEsntlNm?></td>
			<td>등록일</td>
			<td><?=$svcDtx?></td>
			<td>조회수</td>
			<td><?=$cntntsRdcnt?></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="5">
<?PHP
			$cnt=count($strDownUrl);
			for($i=0; $i<$cnt;$i++){

?>
				<a href="<?=$strDownUrl[$i]?>"><?=$strFileName[$i]?></a><br>
<?PHP
			}
?>
			</td>
		</tr>
		<tr>
			<td colspan="6"><?=$cn?></td>
		</tr>
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='fildMnfct.php'" value="처음화면으로"/>&nbsp;
</body>
</html>