<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>화합물 검색</title>
<script type="text/javascript">

//검색
function fncSearch(){
	with(document.searchApiForm){
		pageNo.value = "1";
		method="get";
		action = "searchOnccpSers.php";
		target = "_self";
		submit();
	}
}

//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "searchOnccpSers.php";
		target = "_self";
		submit();
	}
}

//화합물 검색
function fncViewSub2(lNo){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		method="get";
		action = "searchOnccpSers.php";
		target = "_self";
		submit();
	}
}

//팝업 띄우기
function fncListOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.php?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check1=1";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

//참고문헌 팝업 띄우기
function fncViewSubOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.php?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check2=2";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

//생물자원 팝업 띄우기
function fncViewOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.php?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check3=3";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>화합물 검색</strong></h3><hr>

<form name="searchApiForm">
<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
<input type="hidden" name="lvbSeqNo">
<table width="100%" cellSpacing="0" cellPadding="0">
	<tr>
		<td width="85%">
			화합물명&nbsp;<input type="text" name="onccpNm" value="<?PHP if(isset($_REQUEST["onccpNm"])){ echo $_REQUEST["onccpNm"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
			Elements&nbsp;<input type="text" name="elmnWrd" value="<?PHP if(isset($_REQUEST["elmnWrd"])){ echo $_REQUEST["elmnWrd"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
			계열&nbsp;<select name="intltshSe">
				<option value="">선택하세요</option>
<?PHP			//계열 리스트 출력
				if(true){
					//apiKey - 농사로 Open API에서 신청 후 승인되면 확인 가능
					$apiKey = "발급받은인증키를삽입하세요";
					//서비스 명
					$serviceName = "biopesticide";
					//오퍼레이션 명
					$operationName = "searchOnccpSers";
				
					//XML 받을 URL 생성
					$parameter = "/".$serviceName."/".$operationName;
					$parameter .= "?apiKey=".$apiKey;
					
					$url = "http://api.nongsaro.go.kr/service" . $parameter; 
				
					//XML Parsing
					$xml = file_get_contents($url);
					//PHP5.x 이상이 설치되어 있어야 하며, php.ini에 allow_url_fopen을 on으로 해주시기 바랍니다.
					$object = simplexml_load_string($xml);
			
					foreach($object->body[0]->items[0]->item as $item){
						//계열 코드
						$code = $item->code;
						//계열 명
						$codeNm = $item->codeNm;
?>
						<option value="<?=$code?>" <?PHP if(isset($_REQUEST["intltshSe"])){ if($_REQUEST["intltshSe"]==$code) echo "selected"; }?>><?=$codeNm?></option>
<?PHP
						}
					}
?>					
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	    <td width="15%" align="right">
			<input type="button" name="search" value="조회" onclick="fncSearch();"/>
	    </td>
	</tr>
	<tr>		
		<td colspan="2">
			기타작용기작&nbsp;<input type="text" name="rm" value="<?PHP if(isset($_REQUEST["rm"])){ echo $_REQUEST["rm"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
			참고문헌&nbsp;<input type="text" name="sText" value="<?PHP if(isset($_REQUEST["sText"])){ echo $_REQUEST["sText"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
			살균&nbsp;<input type="checkbox" name="antBactrlYn" value="Y" <?PHP if(isset($_REQUEST["antBactrlYn"])){ if($_REQUEST["antBactrlYn"]=="Y") echo "checked"; }?>>&nbsp;&nbsp;&nbsp;&nbsp;
			살충&nbsp;<input type="checkbox" name="insccideYn" value="Y" <?PHP if(isset($_REQUEST["insccideYn"])){ if($_REQUEST["insccideYn"]=="Y") echo "checked"; }?>>&nbsp;&nbsp;&nbsp;&nbsp;
			제초&nbsp;<input type="checkbox" name="weedngYn" value="Y" <?PHP if(isset($_REQUEST["weedngYn"])){ if($_REQUEST["weedngYn"]=="Y") echo "checked"; }?>>&nbsp;&nbsp;&nbsp;&nbsp;
	    </td>
	</tr>			
</table>
</form>


<?PHP
//메인
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
	
	//화합물 검색
	if(isset($_REQUEST["onccpNm"])){
		$parameter .= "&onccpNm=";
		$parameter .= $_REQUEST["onccpNm"];
	}
	//요소 검색
	if(isset($_REQUEST["elmnWrd"])){
		$parameter .= "&elmnWrd=";
		$parameter .= $_REQUEST["elmnWrd"];
	}
	//계열 검색
	if(isset($_REQUEST["intltshSe"])){
		$parameter .= "&intltshSe=";
		$parameter .= $_REQUEST["intltshSe"];
	}
	//비고 검색
	if(isset($_REQUEST["rm"])){
		$parameter .= "&rm=";
		$parameter .= $_REQUEST["rm"];
	}
	//살균 여부 검색
	if(isset($_REQUEST["antBactrlYn"])){
		$parameter .= "&antBactrlYn=";
		$parameter .= $_REQUEST["antBactrlYn"];
	}
	//살충 여부 검색
	if(isset($_REQUEST["insccideYn"])){
		$parameter .= "&insccideYn=";
		$parameter .= $_REQUEST["insccideYn"];
	}
	//제초 여부 검색
	if(isset($_REQUEST["weedngYn"])){
		$parameter .= "&weedngYn=";
		$parameter .= $_REQUEST["weedngYn"];
	}
	//페이지 이동
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
	<h3><font color='red'>조회한 정보가 없습니다.</font></h3>
<?PHP
	}else{
?>
	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>계열</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>기타</th>
			<th>참고문헌</th>
			<th>생물자원</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			//순번
			$rnum = $item->rnum;
			//유기화합물 명
			$onccpNm = $item->onccpNm;
			//요소
			$elmnWrd = $item->elmnWrd;
			//계열구분
			$intltshSe = $item->intltshSe;
			//향균여부
			$antBactrlYn = $item->antBactrlYn;
			//살충여부
			$insccideYn = $item->insccideYn;
			//제초여부
			$weedngYn = $item->weedngYn;
			//기타작용기작
			$rm = $item->rm;
			//참고문헌 수
			$referltrtreCnt = $item->referltrtreCnt;
			//생물자원 수
			$lvbCnt = $item->lvbCnt;
			//유기화합물 일련번호
			$onccpSeqNo = $item->onccpSeqNo;
?>
		<tr>
			<td align="center"><?=$rnum?></td>
			<td align="center"><?=$onccpNm?></td>
			<td align="center"><?=$elmnWrd?></td>
			<td align="center"><?=$intltshSe?></td>
			<td align="center">
			<?PHP if($antBactrlYn=="Y"){?>
				<a href="#" onclick="fncViewSubOpen('<?=$onccpSeqNo?>','')"><?=$antBactrlYn?></a>
			<?PHP }?>
			</td>
			<td align="center">
			<?PHP if($insccideYn=="Y"){?>
				<a href="#" onclick="fncViewSubOpen('<?=$onccpSeqNo?>','')"><?=$insccideYn?></a>
			<?PHP }?>
			</td>
			<td align="center">
			<?PHP if($weedngYn=="Y"){?>
				<a href="#" onclick="fncViewSubOpen('<?=$onccpSeqNo?>','')"><?=$weedngYn?></a>
			<?PHP }?>
			</td>
			<td align="center"><?=$rm?></td>
			<td align="center"><a href="javascript:fncViewSubOpen('<?=$onccpSeqNo?>','')"><?=$referltrtreCnt?></a></td>
			<td align="center">
			<?PHP if($lvbCnt!="0"){?>
				<a href="javascript:fncViewOpen('<?=$onccpSeqNo?>')"><?=$lvbCnt?></a>
			<?PHP }?>
			</td>
		</tr>	
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
}
?>
<br>
<div style="TEXT-ALIGN: right"><input type="button" onclick="javascript:location.href='searchOnccpSers.php'" value="초기화면"/></div>
</body>
</html>