$(document).ready( function(){	
	
	// 日期选择	
	if ($( ".datepicker").size()>0)	{
		$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
		$( ".datepicker").datepicker({
			showOn: "button",
			buttonImage: "img/calendar.gif",
			buttonImageOnly: true			
		});
	}
	
	// 登陆路径
	$(".login-path")
		.hover(
			function(){ $(this).children("p").show();},
			function(){ $(this).children("p").hide();}
		);
	
	// 下拉SELECT
	$(".ncSelect>span")
		.click(function(){
			if($(this).css("display")=="inline-block"){					
				$(this)
					.next()
					.css("top", $(this).outerHeight())
					.show();
			}else{
				$(this).next().hide();
			}
		});
	$(".ncSelect a")
		.click(function(){
			$(this).parent().hide();
			$(this).parent().parent().children("span").html($(this).html());
		});

	// 大后台管理 menu
	$(".menu .toggle")
		.click( function(){
			$(".menu dt, .menu dd").removeClass("current");
			$(this).parent().attr("class", "current");
	 		$(this).parent().next().attr("class", "current");
		});
	
	// 大后台顶部日志列表
	$(".logDrop")
		.hover(
			function(){	$(this).children(".log-popmenu").show();},
			function(){	$(this).children(".log-popmenu").hide();}
		);
	
	// 关于我们类 
	$("#coNav>ul :has('.dorpBox')")
		 .hover(
			function(){
				$(this)
					.addClass("hover")
					.children(".dorpBox")
					.stop(true,true)
					.css({
						"left"	: $(this).position().left,
						"top"	: $(this).position().top + $(this).outerHeight()
					})
					.slideDown(100);
			},
			function(){
				$(this)
					.removeClass("hover")	
					.children(".dorpBox")
					.slideUp("fast");
			});
});


//NEW CANTURY
var NC = {
	options : {
		isIE6			: $.browser.msie && $.browser.version == 6.0			// 判断是否是IE6
	},
	
	// 客户类型
	guestType : function(n){
		$(".gt-panel>ol")
			.hide()
			.eq(n).show();
	},
	
	// 查看/更改预定
	viewChangeScheduled : function(ele){
		$(ele)
			.parent()
			.children("ol")
			.toggle();
	},
	
	// 更多房型
	moreRoom : function(ele){
		$(ele)
			.parent()
			.next(".tbl_hotel")
			.find("tbody>tr:gt(1)")
			.toggle();
	}
};
