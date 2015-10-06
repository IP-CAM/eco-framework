<div class="widget widget-newletter">
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>
    <div class="widget-content">
        <div id="mt_newsletter" class="newletter-container">
            <div id="frm_subscribe">
                <label><?php echo $newletter_lable; ?></label>
                <form name="subscribe">
                      <table>
                           <tr>
                             <td><span class="required">*</span>&nbsp;<span><?php echo $entry_email; ?></span><input type="text" value="" name="subscribe_email" id="subscribe_email"></td>
                           </tr>
                           <tr>
                             <td>
                                <button class="button" onclick="email_subscribe()"><span><?php echo $entry_button; ?></span></button>
                                <?php if($option_unsubscribe) { ?>
                                <button class="button" onclick="email_unsubscribe()"><span><?php echo $entry_unbutton; ?></span></button>
                                <?php } ?>
                             </td>
                           </tr>
                      </table>
                </form>
            </div><!-- /#frm_subscribe -->
            <div class="block-content">
                  <label class="subcriper_label">
                      <input type="checkbox">
                      <?php echo ("Don't show this popup again");?>
                  </label>
            </div>
            <div id="notification"></div>
        </div>
    </div>
</div>
<div style="width: 2000px;top:-808px; height: 2000px; display: none; opacity: 0.7;" id="mask"> </div>

  
<script type="text/javascript">
function email_subscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/newslettersubscribe/subscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
				eval(html);
			}}); 
	
	
}
function email_unsubscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/newslettersubscribe/unsubscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
				eval(html);
			}}); 
	$('html, body').delay( 1500 ).animate({ scrollTop: 0 }, 'slow'); 
	
}
</script>
<script type="text/javascript">
    $(document).ready(function() {
        //var isSuccess = $('ul.messages li.success-msg').length;
        var subscribeFlag = $.cookie('mtNewsletterSubscribeFlag');
        function subsSetcookie(){
            $.cookie('mtNewsletterSubscribe', 'true', {
                expires: 30,
                path: '/'
            });
        }
        $('#mt_newsletter .subcriper_label input').on('click', function(){
            if($(this).parent().find('input:checked').length){
                subsSetcookie();
            } else {
                $.removeCookie('mtNewsletterSubscribe', { path: '/' });
            }
        });
        $('#mt_newsletter .input-box button.button').on('click', function(){
            var button = $(this);
            setTimeout(function(){
                if(!button.parent().find('input#newsletter').hasClass('validation-failed')){
                    $.cookie('mtNewsletterSubscribeFlag', 'true', {
                        path: '/'
                    });
                }
            }, 500);
        });
        if(!(subscribeFlag) && true){
            $.colorbox({
                inline:true,
                href:$('#mt_newsletter'),
                opacity:	0.3,
                speed:		500,
                innerWidth:'500px',
                innerHeight:'350px',
                fixed: true,
                onOpen: function(){
                    $('#cboxContent').addClass('newsletterbox');
                    $('#cboxLoadingGraphic').addClass('box-loading');
                },
                onComplete: function(){
                    setTimeout(function(){
                        $('#cboxLoadingGraphic').removeClass('box-loading');
                    },800);
                },
                onClosed: function(){
                    $('#cboxContent').removeClass('newsletterbox');
                }
            });
        }else{
            $.removeCookie('mtNewsletterSubscribeFlag', { path: '/' });
            subsSetcookie();
        }
    });
</script>


</div><!-- /.box -->
