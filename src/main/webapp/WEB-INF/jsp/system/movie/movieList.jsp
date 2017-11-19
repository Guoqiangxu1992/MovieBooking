<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>

<title>电影列表</title>
<%@ include file="/WEB-INF/common/common.jsp"%>
<script type="text/javascript"
	src="${xgq }/common/bootstrap/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"
	src="${xgq }/common/bootstrap/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
<script type="text/javascript"
	src="${xgq}/common/bootstrap/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type='text/javascript'
	src="${xgq }/js/paginate/jquery.myPagination.js"></script>
<script type='text/javascript'
	src="${xgq }/js/paginate/commonPagination.js"></script>
<%-- <script type='text/javascript' src="${xgq }/js/myCommon.js"></script> --%>
<script type='text/javascript' src="${xgq }/js/car/carEdit.js"></script>

<script type="text/javascript">
	$(function() {
		// 调用分页控件初始化函数
		COMMON_PAGINATION.init("pagination", 10, search);
		search();

	});
	$(function() {
		$(".form_date").datepicker({
			format : "yyyy-mm-dd",
			showMeridian : true,
			autoclose : true,
			todayBtn : true,
			startDate : "2015-02-14 ",
		});

	});
	 function managerCron(id){
		 $("#movieId").val(id);
	 }
	function uploadPicture(movieId) {
		//alert(carId);
		var base = ' ${xgq }/movie/uploadInfoPic.do';
		var param = {
			movieId : movieId
		}
		common.loadPage(base, param);
	}
	
	function uploadMainPicture(movieId) {
		//alert(carId);
		var base = ' ${xgq }/movie/uploadMainPictureInit.do';
		var param = {
			movieId : movieId
		}
		common.loadPage(base, param);
	}
	
	
	

	function addMovieInfo() {
		var base = ' ${xgq }/movie/addMovieInfo.do';
		var param = {
		//carId:carId
		}
		common.loadPage(base, param);
	}

	function editMovie(movieId) {
		var base = ' ${xgq }/movie/editMovie.do';
		var param = {
				movieId : movieId
			}
			common.loadPage(base, param);
	}

	function publish(movieId) {
		var base = ' ${xgq }/movie/publishMovie.do';
		var param = {
			movieId : movieId
		}
		common.loadPage(base, param);
	}
	
	function DateMovie(){
		var base = ' ${xgq }/movie/DateMovie.do';
		var date2 =  $("#date").val();
		if(date2.length=10){
			date2 = date2+' 00:00:00';
		}
		var param = {
			movieId : $("#movieId").val(),
			placeNum : $("#placeNum").val(),
			languag : $("#languag").val(),
			date1 : date2,
			marketPrice : $("#marketPrice").val(),
			memberPrice : $("#memberPrice").val(),
			number : $("#number").val(),
		}
		console.log(param);
		common.loadPage(base, param);
		$("#myModal_editrole_close").click();
	}
	function search() {
		//COMMON_PAGINATION.reset();
		// var loginName = $('#carName').val().trim();
		//var roleId = $('#variableBox option:selected') .val();
		//var startTime = $('#startTime').val();
		//var endTime = $('#endTime').val();
		var param = {
		// 'carInfoDto.carName': carName,
		//'carInfoDto.variableBox' : variableBox
		};
		COMMON_PAGINATION.initParam(param);//@
		var aj = $
				.ajax({
					url : '${xgq}/movie/getMovieInformation.do',// 跳转到 action    
					type : 'POST',
					dataType : 'json',
					data : param,
					success : function(data) {
						var str = eval(data);
						if (str != '') {
							$("#taskResult").empty();
							$
									.each(
											str.rows,
											function(n, value) {
												html = "";
												html += '<tr>';
												html += '<td><p class="long_txt">'
														+ value.ID
														+ '</p></td>';
												html += '<td> <p class="long_txt">'
														+ value.productType
														+ '</p></td>';
												html += '<td><p class="long_txt">'
														+ value.name
														+ '</p></td>';
												
												html += '<td><p class="long_txt">'
														+ value.marketPrice
														+ '</p></td>';
												html += '<td><p class="long_txt">'
														+ value.membersPrice
														+ '</p></td>';
												if (value.recommed == 0) {
													html += '<td><p class="long_txt">'
															+ '不推荐'
															+ '</p></td>';
												} else {
													html += '<td><p class="long_txt">'
															+ '推荐'
															+ '</p></td>';
												}

												if (value.status == 0) {
													html += '<td><p class="long_txt" style="color:green;">'
															+ '待发布'
															+ '</p></td>';
												} else {
													html += '<td><p class="long_txt" style="color:red;">'
															+ '已发布'
															+ '</p></td>';
												}
												
												html += '<td><p class="long_txt">'
														+ value.remark
														+ '</p></td>';
												html += '<td><p class="long_txt">'
														+ formartDate(
																"yyyy-MM-dd HH:mm:ss",
																value.recommendDate.time)
														+ '</p></td>';
												html += '<td><button class="btn btn-primary btn-xs" onclick="uploadMainPicture('
														+ value.ID
														+ ')"><i class="icon-edit" title="编辑">主图上传</i></button></td><td><button class="btn btn-primary btn-xs" onclick="uploadPicture('
														+ value.ID
														+ ')"><i class="icon-edit" title="编辑">剧照上传</i></button></td>';
												html += '<td><button class="btn btn-primary btn-xs"onclick="editMovie('+ value.ID+ ');"><i class="icon-edit" title="编辑">编辑</i></button></td><td><button class="btn btn-primary btn-xs"onclick="publish('+ value.ID+ ');"><i class="icon-edit" title="发布">发布</i></button></td>'
												+'<td><button href="#myModal_editrole" data-toggle="modal"  onclick="managerCron('+value.ID+');" class="btn btn-info btn-xs"><i class="icon-edit">排期</i></button></td>';
												html += '</tr>';
												$("#taskResult").append(html);
											});
							COMMON_PAGINATION.refresh(data);
						}
					}
				});
	}
</script>
<link rel="stylesheet" type="text/css"
	href="${xgq }/js/paginate/myPagination.css" />
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<section class="panel">
				<header class="panel-heading">
					<span class="tools pull-left"> <a class="icon-search"
						style="padding: 10px;" href="javascript:void(0);"
						onclick="goUp(this);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
					</span>
					<div class="clearfix">
						<div class="pull-right">
							<button style="margin-top: 23px;" class="btn btn-success"
								type="button" onclick="addMovieInfo('${xgq}')">增加</button>
							
						</div>
					</div>
				</header>
				<div class="panel-body" style="display: none;">
					<form id="myForm" role="form" class="form-inline" method="post">
						<input type="hidden" name="" value="" />
						<div class="form-group">
							<label for="title">汽车种类</label> <input type="text"
								placeholder="汽车种类" name="carName" id="carName"
								class="form-control">
						</div>
						<div class="form-group">
							<label for="approvestatus">变速箱</label> <select name="variableBox"
								id="variableBox" class="form-control">
								<option value="0">全部</option>
								<option value="1">手动</option>
								<option value="2">自动</option>
							</select>
						</div>

						<div class="form-group date " style="width: 150px"
							data-date="2012-12-21T15:25:00Z">
							<label>注册日期开始于</label> <input type="text" size="16"
								name="startTime" id="startTime" class="form-control form_date">
						</div>
						<div class="form-group date form_datetime-meridian"
							style="width: 150px">
							<label>注册日期结束于</label> <input type="text" size="16"
								name="EndTime" id="endTime" class="form-control form_date">
						</div>
						<button style="margin-top: 23px;" class="btn btn-success"
							type="button" onclick="search()">查找</button>
						<button style="margin-top: 23px;" class="btn btn-default"
							type="button" onclick="reset()">重置</button>
					</form>
				</div>


				<table class="table table-striped table-advance table-hover">
					<thead>
						<tr>

							<th><i class="icon-bookmark"></i>电影编号</th>
							<th><i class="icon-bookmark"></i>电影种类</th>
							<th><i class="icon-bookmark"></i>电影名称</th>
							<th><i class="icon-bookmark"></i>官方价</th>
							<th><i class="icon-bookmark"></i>会员价</th>
							<th><i class="icon-bookmark"></i>是否推荐</th>
							<th><i class="icon-bookmark"></i>发布状态</th>
							<th><i class="icon-bookmark"></i>备注</th>
							<th><i class="icon-bookmark"></i>推荐时间</th>
							<th><i class="icon-bookmark"></i>图片上传</th>
							<th><i class="icon-edit"></i> 操作</th>

						</tr>
					</thead>
					<tbody class="taskResult" name="taskResult" id="taskResult">

					</tbody>
				</table>
			</section>
		</div>
	</div>
	<div class="table_handle page_box clearfix" style="float: right">
		<div class="page-model clearfix financial-record-page fr">
			<div class="yhdbk-page clearfix">
				<div id="pagination" class="pg_right"></div>
			</div>
		</div>
	</div>
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal_editrole" class="modal fade in" >
  <div class="modal-dialog">
	  <div class="modal-content">
		  <div class="modal-header">
			  <button aria-hidden="true" id="myModal_editrole_close"  data-dismiss="modal" class="close" type="button" >×</button>
			  <h4 class="modal-title" id="roleTitle">电影排期</h4>
		  </div>
		  <div class="modal-body">
			  <form role="form" class="form-horizontal" id="editJobform" >
              <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >电影ID</label>
                   <div class="col-lg-10">
                       <input type="text" placeholder="" id="movieId" name=""movieId"" class="form-control">
                   </div>
               </div>
                <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >语种/制式</label>
                   <div class="col-lg-10">
                       <input type="text" placeholder="" id="languag" name="languag" class="form-control">
                   </div>
               </div>
                <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >影厅</label>
                   <div class="col-lg-10">
                       <input type="text" placeholder="" id="placeNum" name="placeNum" class="form-control">
                   </div>
               </div>
                <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >放应时间</label>
                   <div class="col-lg-10">
                       <input type="text" size="16"
								name="date" id="date" class="">
                   </div>
               </div>
                <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >原价</label>
                   <div class="col-lg-10">
                       <input type="text" placeholder="" id="marketPrice" name="marketPrice" class="form-control">
                   </div>
               </div>
                <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >会员价</label>
                   <div class="col-lg-10">
                       <input type="text" placeholder="" id="memberPrice" name="memberPrice" class="form-control">
                   </div>
               </div>
                <div class="form-group">
                   <label class="col-lg-2 col-sm-2 control-label" >票数</label>
                   <div class="col-lg-10">
                       <input type="text" placeholder="" id="number" name="number" class="form-control">
                   </div>
               </div>
				  <div class="form-group">
				  <div class="col-lg-5" ></div>
				  		<div class="col-lg-5" >
						  <button class="btn btn-primary" type="button" onclick="DateMovie();">确认</button>
						  </div>
				  </div>
			  </form>
		  </div>
	  </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>	
	<!-- 主体内容结束 -->
	<!-- 分页 -->
	<input type="hidden" value="searchMenuForm" id="currentFormId" />
</body>
<script type="text/javascript">
	$(document).ready(function() {
		// 调用分页控件初始化函数
		COMMON_PAGINATION.init("pagination", 10, search);
	});

	function getDateType(type) {
		var date = type.split("@");
		var str ="";
		for(var i = 0;i<date.length;i++){
			str+='<td>'+date+'</td>';
		}
		return str;
	}
</script>
</html>