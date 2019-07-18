<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>RDA 인테러뱅</title>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>RDA 인테러뱅</strong></h3>
<hr>
<?PHP
//인테러뱅 상세조회
if(isset($_REQUEST["dataNo"])){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "rdaInterrobang";
	//오퍼레이션 명
	$operationName = "interrobangView";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if($_REQUEST["dataNo"]!=NULL){
		$parameter .= "&dataNo=";
		$parameter .= $_REQUEST["dataNo"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
	$object = simplexml_load_string($xml);
	
	//요약
	$contList = $object->body[0]->item[0]->contList;
	//목차
	$content = $object->body[0]->item[0]->content;
	//키값
	$dataNo = $object->body[0]->item[0]->dataNo;
	//파일 다운로드 URL
	$downUrl = $object->body[0]->item[0]->downUrl;
	//파일명
	$fileName = $object->body[0]->item[0]->fileName;
	//조회수
	$hitCt = $object->body[0]->item[0]->hitCt;
	//평점
	$optGrade = $object->body[0]->item[0]->optGrade;
	//댓글수
	$optNum = $object->body[0]->item[0]->optNum;
	//등록일
	$regDt = $object->body[0]->item[0]->regDt;
	//평가원 수 
	$scoreCnt = $object->body[0]->item[0]->scoreCnt;
	//제목
	$subject = $object->body[0]->item[0]->subject;
	//글쓴이 이메일
	$writerEmail = $object->body[0]->item[0]->writerEmail;
	//글쓴이
	$writerNm = $object->body[0]->item[0]->writerNm;
	
	$strDownUrl=explode(';',$downUrl);
	$strFileName=explode(';',$fileName);
?>
	<table  border="1" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tr>
			<td>제목</td>
			<td><?=$subject?></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><?=$regDt?>&nbsp;<?=$writerNm?>&nbsp;(<?=$writerEmail?>)</td>
		</tr>
		<tr>
			<td>평점</td>
			<td><?=$optGrade?>점/5점만점(rda.go.kr회원<?=$scoreCnt?>분이평가한점수입니다.)</td>
		</tr>
		<tr>
			<td>요약</td>
			<td><?=$contList?></td>
		</tr>
		<tr>
			<td>목차</td>
			<td><?=$content?></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
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
	</table>
<?PHP
}
?>
<br>
<input type="button" onclick="javascript:location.href='rdaInterrobang.php'" value="처음화면으로"/>&nbsp;
</body>
</html>