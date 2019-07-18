<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
?>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>식물 검색</title>
<script type="text/javascript">

//검색
function fncSearch(){
	with(document.searchApiForm){
		pageNo.value = "1";
		method="get";
		action = "searchPlantFmNm.php";
		target = "_self";
		submit();
	}
}
//페이지 이동
function fncGoPage(page){
	with(document.searchApiForm){
		pageNo.value = page;
		method="get";
		action = "searchPlantFmNm.php";
		target = "_self";
		submit();
	}
}
//화합물 검색
function fncViewSub2(lNo, fNm, bNm){
	with(document.searchApiForm){
		lvbSeqNo.value = lNo;
		cFmlNm.value = fNm;
		cBneNm.value = bNm;
		method="get";
		action = "searchPlantFmNm.php";
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

//서브 팝업 띄우기
function fncViewSubOpen(lvbNo,referLtrtreCode){
	var popupUrl="onccpPoP.php?lvbNo="+lvbNo+"&referLtrtreCode="+referLtrtreCode+"&check2=2";
	var popOption="width=800,height=440";
	
	window.open(popupUrl,"nongsaroPop",popOption);
}

</script>
</head>
<body>
<h4><strong> * 샘플화면은 디자인을 적용하지 않았으니, 개별 사이트의 스타일에 맞게 코딩하시기 바랍니다.</strong></h4>
<h3><strong>식물 검색</strong></h3><hr>

<?PHP
if(true){
	$apiKey = "발급받은인증키를삽입하세요";
	
	$serviceName = "biopesticide";
	$operationName = "searchPlant";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["fmlNm"])){
		$parameter .= "&fmlNm=";
		$parameter .= $_REQUEST["fmlNm"];
	}
	
	if(isset($_REQUEST["bneNm"])){
		$parameter .= "&bneNm=";
		$parameter .= $_REQUEST["bneNm"];
	}
	
	if(isset($_REQUEST["yeastNm"])){
		$parameter .= "&yeastNm=";
		$parameter .= $_REQUEST["yeastNm"];
	}
	
	if(isset($_REQUEST["rm"])){
		$parameter .= "&rm=";
		$parameter .= $_REQUEST["rm"];
	}
	
	if(isset($_REQUEST["antBactrlYn"])){
		$parameter .= "&antBactrlYn=";
		$parameter .= $_REQUEST["antBactrlYn"];
	}
	
	if(isset($_REQUEST["insccideYn"])){
		$parameter .= "&insccideYn=";
		$parameter .= $_REQUEST["insccideYn"];
	}
	
	if(isset($_REQUEST["weedngYn"])){
		$parameter .= "&weedngYn=";
		$parameter .= $_REQUEST["weedngYn"];
	}
	
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
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<form name="searchApiForm">
	<input type="hidden" name="pageNo" value="<?PHP if(isset($_REQUEST["pageNo"])){ echo $_REQUEST["pageNo"]; }?>">
	<input type="hidden" name="lvbSeqNo">
	<input type="hidden" name="cFmlNm">
	<input type="hidden" name="cBneNm">
	<table width="100%" cellSpacing="0" cellPadding="0">
		<tr>
			<td width="85%">
				과명&nbsp;<select name="fmlNm">
					<option value="">선택하세요</option>
<?PHP
					$sub_apiKey = "발급받은인증키를삽입하세요";
					
					$sub_serviceName = "biopesticide";
					$sub_operationName = "searchPlantFmNm";
				
					//XML 받을 URL 생성
					$sub_parameter = "/".$sub_serviceName."/".$sub_operationName;
					$sub_parameter .= "?apiKey=".$sub_apiKey;
					
					$sub_url = "http://api.nongsaro.go.kr/service" . $sub_parameter; 
				
					//XML Parsing
					$sub_xml = file_get_contents($sub_url);
					$sub_object = simplexml_load_string($sub_xml);
					
					foreach($sub_object->body[0]->items[0]->item as $item){
						$sub_fmlNm = $item->fmlNm;
						$sub_fmlSeqNo = $item->fmlSeqNo;
?>
					<option value="<?=$sub_fmlNm?>" <?PHP if(isset($_REQUEST["fmlNm"])){ if($_REQUEST["fmlNm"]==$sub_fmlNm) echo "selected"; }?>><?=$sub_fmlNm?></option>
<?PHP
					}
?>					
				</select>&nbsp;&nbsp;&nbsp;&nbsp;
				학명&nbsp;<input type="text" name="bneNm" value="<?PHP if(isset($_REQUEST["bneNm"])){ echo $_REQUEST["bneNm"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
				국명&nbsp;<input type="text" name="yeastNm" value="<?PHP if(isset($_REQUEST["yeastNm"])){ echo $_REQUEST["yeastNm"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
				비고&nbsp;<input type="text" name="rm" value="<?PHP if(isset($_REQUEST["rm"])){ echo $_REQUEST["rm"]; }?>">&nbsp;&nbsp;&nbsp;&nbsp;
		    </td>
		    <td width="15%" align="right">
				<input type="button" name="search" value="조회" onclick="fncSearch();"/>
		    </td>
		</tr>
		<tr>		
			<td>
				살균&nbsp;<input type="checkbox" name="antBactrlYn" value="Y" <?PHP if(isset($_REQUEST["antBactrlYn"])){ if($_REQUEST["antBactrlYn"]=="Y") echo "checked"; }?>>&nbsp;&nbsp;&nbsp;&nbsp;
				살충&nbsp;<input type="checkbox" name="insccideYn" value="Y" <?PHP if(isset($_REQUEST["insccideYn"])){ if($_REQUEST["insccideYn"]=="Y") echo "checked"; }?>>&nbsp;&nbsp;&nbsp;&nbsp;
				제초&nbsp;<input type="checkbox" name="weedngYn" value="Y" <?PHP if(isset($_REQUEST["weedngYn"])){ if($_REQUEST["weedngYn"]=="Y") echo "checked"; }?>>&nbsp;&nbsp;&nbsp;&nbsp;
		    </td>
		</tr>			
	</table>
	</form>

	<hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="20%"/>
			<col width="35%"/>
			<col width="10%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>번호</th>
			<th>과명</th>
			<th>학명</th>
			<th>국명</th>
			<th>비고</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>화합물</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			$rnum = $item->rnum;
			$fmlNm = $item->fmlNm;
			$bneNm = $item->bneNm;
			$yeastNm = $item->yeastNm;
			$rm = $item->rm;
			$antBactrlYn = $item->antBactrlYn;
			$insccideYn = $item->insccideYn;
			$weedngYn = $item->weedngYn;
			$mapngCnt = $item->mapngCnt;
			$lvbSeqNo = $item->lvbSeqNo;
?>
		<tr>
			<td align="center"><?=$rnum?></td>
			<td align="center"><?=$fmlNm?></td>
			<td align="center"><?=$bneNm?></td>
			<td align="center"><?=$yeastNm?></td>
			<td align="center"><?=$rm?></td>
			<td align="center">
			<?PHP if($antBactrlYn=="Y"){ ?>
				<a href="#" onclick="fncListOpen('<?=$lvbSeqNo?>','106001')"><?=$antBactrlYn?></a>
			<?PHP } ?>
			</td>
			<td align="center">
			<?PHP if($insccideYn=="Y"){ ?>
				<a href="#" onclick="fncListOpen('<?=$lvbSeqNo?>','106002')"><?=$insccideYn?></a>
			<?PHP } ?>
			</td>
			<td align="center">
			<?PHP if($weedngYn=="Y"){ ?>
				<a href="#" onclick="fncListOpen('<?=$lvbSeqNo?>','106003')"><?=$weedngYn?></a>
			<?PHP } ?>
			</td>
			<td align="center"><a href="javascript:fncViewSub2('<?=$lvbSeqNo?>', '<?=$fmlNm?>', '<?=$bneNm?>')"><?=$mapngCnt?></a></td>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP
	}
	
	$numOfRows = $object->body[0]->items[0]->numOfRows;
	$totalCount = $object->body[0]->items[0]->totalCount;
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
}
?>
<br>

<?PHP
if(isset($_REQUEST["lvbSeqNo"]) && $_REQUEST["lvbSeqNo"]!=null){
	$apiKey = "발급받은인증키를삽입하세요";
	
	$serviceName = "biopesticide";
	$operationName = "searchPlantOnccp";

	//XML 받을 URL 생성
	$parameter = "/".$serviceName."/".$operationName;
	$parameter .= "?apiKey=".$apiKey;
	
	if(isset($_REQUEST["lvbSeqNo"])){
		$parameter .= "&lvbNo=";
		$parameter .= $_REQUEST["lvbSeqNo"];
	}
	
	if(isset($_REQUEST["fmlNm"])){
		$parameter .= "&fmlNm=";
		$parameter .= $_REQUEST["fmlNm"];
	}
	
	if(isset($_REQUEST["bneNm"])){
		$parameter .= "&bneNm=";
		$parameter .= $_REQUEST["bneNm"];
	}
	
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
	<h3>조회한 정보가 없습니다.</h3>
<?PHP
	}else{
?>
	<hr>
	<h3><strong>화합물 리스트 (학명 : (<?=$_REQUEST["cBneNm"] ?>), 과명 : <?=$_REQUEST["cFmlNm"] ?>)</strong></h3><hr>
	<table width="100%" border="1" cellSpacing="0" cellPadding="0">
		<colgroup>
			<col width="5%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="15%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="5%"/>
			<col width="10%"/>
		</colgroup>
		<tr>
			<th>NO</th>
			<th>화합물명</th>
			<th>Elements</th>
			<th>계열</th>
			<th>살균</th>
			<th>살충</th>
			<th>제초</th>
			<th>기타</th>
			<th>참고문헌</th>
		</tr>
<?PHP
		foreach($object->body[0]->items[0]->item as $item){
			$rnum = $item->rnum;
			$onccpSeqNo = $item->onccpSeqNo;
			$onccpNm = $item->onccpNm;
			$elmnWrd = $item->elmnWrd;
			$intltshSeCodeNm = $item->intltshSeCodeNm;
			$rm = $item->rm;
			$antBactrlYn = $item->antBactrlYn;
			$insccideYn = $item->insccideYn;
			$weedngYn = $item->weedngYn;
			$referltrtreCnt = $item->referltrtreCnt;
?>
		<tr>
		    <td><?=$rnum?></td>
   			<td><?=$onccpNm?></td>
   			<td><?=$elmnWrd?></td>
   			<td><?=$intltshSeCodeNm?></td>
			<td align="center">
			<?PHP if($antBactrlYn=="Y"){ ?>
				<a href="#" onclick="fncViewSubOpen('<?=$onccpSeqNo?>','106001')"><?=$antBactrlYn?></a>
			<?PHP } ?>
			</td>
			<td align="center">
			<?PHP if($insccideYn=="Y"){ ?>
				<a href="#" onclick="fncViewSubOpen('<?=$onccpSeqNo?>','106002')"><?=$insccideYn?></a>
			<?PHP } ?>
			</td>
			<td align="center">
			<?PHP if($weedngYn=="Y"){ ?>
				<a href="#" onclick="fncViewSubOpen('<?=$onccpSeqNo?>','106003')"><?=$weedngYn?></a>
			<?PHP } ?>
			</td>
   			<td><?=$rm?></td>
   			<td><?=$referltrtreCnt?></td>
		</tr>
<?PHP
		}
?>
	</table>
<?PHP
	}
}
?>
<br>
<div style="TEXT-ALIGN: right"><input type="button" onclick="javascript:location.href='searchPlantFmNm.php'" value="초기화면"/></div>
</body>
</html>