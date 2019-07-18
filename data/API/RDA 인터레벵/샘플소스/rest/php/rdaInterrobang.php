<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>RDA 인테러뱅</title>
<script type='text/javascript'>

//상세보기
function move(dNo){
	with(document.apiForm){
		dataNo.value = dNo;
		method="get";
		action = "rdaInterrobang_D.php";
		target = "_self";
		submit();
	}
}

//검색
function fncSearch(){
	with(document.searchApiForm){
		if(searchword.value.replace(/\s/g,"") == ""){
	        alert("검색어를 입력해 주세요");
	        searchword.focus();
	        return false;
	    }else{
			method="get";
			action = "rdaInterrobang.php";
			target = "_self";
			submit();
		}
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "rdaInterrobang.php";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>RDA 인테러뱅</strong></h3>
<hr>

<form name="apiForm">
<input type="hidden" name="dataNo">
</form>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
<select name="searchtype"> 
	<option value="1" <?PHP if(isset($_REQUEST["searchtype"])){ if($_REQUEST["searchtype"]=="1") echo "selected"; }?>>제목</option>
	<option value="2" <?PHP if(isset($_REQUEST["searchtype"])){ if($_REQUEST["searchtype"]=="2") echo "selected"; }?>>내용</option>
	<option value="4" <?PHP if(isset($_REQUEST["searchtype"])){ if($_REQUEST["searchtype"]=="3") echo "selected"; }?>>작성자</option>
	<option value="3" <?PHP if(isset($_REQUEST["searchtype"])){ if($_REQUEST["searchtype"]=="4") echo "selected"; }?>>제목+내용</option>
</select> 
<input type="text" name="searchword" value="<?PHP if(isset($_REQUEST["searchword"])){ echo $_REQUEST["searchword"]; }?>">
<input type="button" name="search" value="검색" onclick="return fncSearch();"/>
</form>

<?PHP
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "rdaInterrobang";
	//오퍼레이션 명
	$operationName = "interrobangList";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	//검색조건
	if(isset($_REQUEST["searchtype"])){
		$parameter .= "&searchtype=";
		$parameter .= $_REQUEST["searchtype"];
	}
	//검색어
	if(isset($_REQUEST["searchword"])){
		$parameter .= "&searchword=";
		$parameter .= $_REQUEST["searchword"];
	}
	//페이지 이동
	if(isset($_REQUEST["pageNo"])){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
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
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="50%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th>제목</th>
			<th>등록일</th>
			<th>첨부</th>
			<th>의견수</th>
			<th>조회수/평점</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//키값
			$dataNo = $item->dataNo;
			//파일 다운로드 URL
			$downUrl = $item->downUrl;
			//파일명
			$fileName = $item->fileName;
			//조회수
			$hitCt = $item->hitCt;
			//평점
			$optGrade = $item->optGrade;
			//댓글수
			$optNum = $item->optNum;
			//등록일
			$regDt = $item->regDt;
			//제목
			$subject = $item->subject;
			
			$strDownUrl=explode(';',$downUrl);
			$strFileName=explode(';',$fileName);
			
?>
		<tr>
			<td><a href="javascript:;move('<?=$dataNo?>');"><?=$subject?></a></td>
			<td align="center"><?=$regDt?></td>
			<td align="center">
<?PHP
			$cnt=count($strDownUrl);
			for($i=0; $i<$cnt;$i++){
			
?>
				<a href="<?=$strDownUrl[$i]?>"><?=$strFileName[$i]?></a><br>
<?PHP
			}
?>
			</td>
			<td align="center"><?=$optNum?></td>
			<td align="center"><?=$hitCt?>/<?=$optGrade?></td>
		<tr>
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
?>
</body>
</html>