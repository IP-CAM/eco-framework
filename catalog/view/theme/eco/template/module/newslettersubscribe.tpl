<div class="widget widget-newletter" <?php if($newslettersubscribe_popup) echo "style='display:none'";?> >
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>
    <div class="widget-content">
        <div id="mt_newsletter" class="newletter-container" >
            <div id="frm_subscribe">
                <label><?php echo $newletter_lable; ?></label>
                <form name="subscribe" id="subscribe">
                      <table>
                           <tr>
                               <?php if($thickbox): ?><td><span class="required">*</span>&nbsp;<span><?php echo $entry_name; ?></span><input type="text" value="" name="subscribe_name" id="subscribe_name"></td><?php endif;?>
                             <td><span class="required">*</span>&nbsp;<span><?php echo $entry_email; ?></span><input type="text" value="" name="subscribe_email" id="subscribe_email"></td>
                           </tr>
                           <tr>
                             <td>
                                 <a class="button" onclick="email_subscribe()"><span><?php echo $entry_button; ?></span></a>
                                <?php if($option_unsubscribe) { ?>
                                 <a class="button" onclick="email_unsubscribe()"><span><?php echo $entry_unbutton; ?></span></a>
                                <?php } ?>
                             </td>
                           </tr>
                      </table>
                </form>
            </div><!-- /#frm_subscribe -->
            <?php if($newslettersubscribe_popup):?>
            <div class="block-content">
                  <label class="subcriper_label">
                      <input type="checkbox">
                      <?php echo ("Don't show this popup again");?>
                  </label>
            </div>
            <?php endif;?>
            <div id="notification"></div>
        </div>
    </div>
</div>
<div style="width: 2000px;top:-808px; height: 2000px; display: none; opacity: 0.7;" id="mask"> </div>

  
<script type="text/javascript">
function email_subscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/econewsletter/subscribe',
			dataType: 'html',
            data:$("#subscribe").serialize(),
			success: function (html) {
                //console.log(html);
				eval(html);
			}}); 
	
	
}
function email_unsubscribe(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/econewsletter/unsubscribe',
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
        $('#mt_newsletter .button').on('click', function(){
            setTimeout(function(){
                if($('#notification .success').length){
                    $.cookie('mtNewsletterSubscribeFlag', 'true', {
                        path: '/'
                    });
                }
            }, 500);
        });
        <?php if($newslettersubscribe_popup):?>
        if(!(subscribeFlag) && !$.cookie('mtNewsletterSubscribe')){
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
        <?php endif; ?>
    });
</script>


</div><!-- /.box -->
