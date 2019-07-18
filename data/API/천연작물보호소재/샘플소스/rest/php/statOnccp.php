<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<title>화합물 통계</title>
<script type='text/javascript'>

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "statOnccp.php";
		target = "_self";
		submit();
	}
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 통계</strong></h3><hr>

<?PHP
//종합 통계
if(true){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "statOnccp";

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
			<col width="*" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
		</colgroup>
           <thead>
               <tr>
				<th scope="col" >살균.살충.제초</th>
				<th scope="col" >살균.살충</th>
				<th scope="col" >살균.제초</th>
				<th scope="col" >살충.제초</th>
				<th scope="col" >살균</th>
				<th scope="col" >살충</th>
				<th scope="col" >제초</th>
              </tr>
            </thead>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//살균, 살충, 제초
			$cntA = $item->cntA;
			//살균, 살충
			$cntB = $item->cntB;
			//살균, 제초
			$cntC = $item->cntC;
			//살충, 제초
			$cntD = $item->cntD;
			//살균
			$cntE = $item->cntE;
			//살충
			$cntF = $item->cntF;
			//제초
			$cntG = $item->cntG;
?>
                    <tr>
                      <td><?=$cntA?></td>
                      <td><?=$cntB?></td>
                      <td><?=$cntC?></td>
                      <td><?=$cntD?></td>
                      <td><?=$cntE?></td>
                      <td><?=$cntF?></td>
                      <td><?=$cntG?></td>
					</tr>
<?PHP
		}
?>
            </tbody>
        </table>
<?PHP
	}
}
?>
<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
</form>
<h3><strong>화합물 리스트</strong></h3><hr>
<?PHP
//화합물 리스트
if(true){
	//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
	$apiKey = "발급받은인증키를삽입하세요";
	//서비스 명
	$serviceName = "biopesticide";
	//오퍼레이션 명
	$operationName = "searchOnccp";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;

	if(isset($_REQUEST["pageNo"])){
		$parameter .= "&pageNo=";
		$parameter .= $_REQUEST["pageNo"];
	}

	$url = "http://api.nongsaro.go.kr/service" . $parameter; 

	//XML Parsing
	$xml = file_get_contents($url);
	$object = simplexml_load_string($xml);

	if(count($object->body[0]->items[0]->item) == 0){
?>
	<hr>
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		 <colgroup>
			<col width="5%" />
			<col width="*" />
			<col width="100px" />
			<col width="100px" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
          <thead>
              <tr>
				<th scope="col" >No</th>
				<th scope="col" >화합물명</th>
				<th scope="col" >Elements</th>
				<th scope="col" >계열</th>
				<th scope="col" >살균</th>
				<th scope="col" >살충</th>
				<th scope="col" >제초</th>
				<th scope="col" >기타작용기작</th>
             </tr>
         </thead>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//순번				
			$rnum = $item->rnum;
			//유기화합물 명
			$onccpNm = $item->onccpNm;
			//요소 단어
			$elmnWrd = $item->elmnWrd;
			//계열 구분
			$intltshSe = $item->intltshSe;
			//향균 여부
			$antBactrlYn = $item->antBactrlYn;
			//살충 여부
			$insccideYn = $item->insccideYn;
			//제초 여부
			$weedngYn = $item->weedngYn;
			//유기화합물 일련 번호
			$onccpSeqNo = $item->onccpSeqNo;
			//비고
			$rm = $item->rm;
			//참고문헌 수
			$referltrtreCnt = $item->referltrtreCnt;
			//생물 자원 수
			$lvbCnt = $item->lvbCnt;
?>
		<tr>
			<td align="center"><?=$rnum?></td>
			<td ><?=$onccpNm?></td>
			<td align="center"><?=$elmnWrd?></td>
			<td align="center"></td>
			<td align="center">
			<?PHP if($antBactrlYn=="Y"){ ?>
				<?=$antBactrlYn?>
			<?PHP } ?>
			</td>
			<td align="center">
			<?PHP if($insccideYn=="Y"){ ?>
				<?=$insccideYn?>
			<?PHP } ?>
			</td>
			<td align="center">
			<?PHP if($weedngYn=="Y"){ ?>
				<?=$weedngYn?>
			<?PHP } ?>
			</td>
			<td><?=$rm?></td>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP
	}
//페이징 처리
	//한 페이지에 제공 할 건수
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
}
?>
</body>
</html>








