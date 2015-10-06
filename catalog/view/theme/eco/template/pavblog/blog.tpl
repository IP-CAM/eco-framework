<?php echo $header; ?>

<div class="container">

	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="row"><?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
		<?php $class = 'col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
		<?php $class = 'col-sm-9'; ?>
		<?php } else { ?>
		<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
		<!-- Start Div Content -->

		<div class="pav-blog">
				<?php if( $blog['thumb_large'] ) { ?>
					<div class="post-image">
						<img src="<?php echo $blog['thumb_large'];?>" title="<?php echo $blog['title'];?>"/>
					</div>
				<?php } ?>
                <?php if( $config->get('blog_show_category') ) { ?>
					<span class="post-cat">
						<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
					</span>
                <?php } ?>
                <h1 class="entry-title"><?php echo $blog['title'];?></h1>
				<div class="article-meta">
                    <?php if( $config->get('blog_show_created') ) { ?>
                        <span class="post-date">
                                        <?php echo date("d",strtotime($blog['created']));?>
                                        <?php echo date("M",strtotime($blog['created']));?>,
                                        <?php echo date("Y",strtotime($blog['created']));?>

                        </span>
                    <?php } ?>
                    <span> // </span>
					<?php if( $config->get('blog_show_author') ) { ?>
					<span class="post-author">
                        <?php echo $objlang->get("text_write_by");?><span class="author"><?php echo $blog['author'];?></span>
                    </span>
					<?php } ?>
				</div>
				 <div class="description hidden"><?php echo $description;?></div>
				 <div class="entry-content clearfix">
						<div class="content-wrap clearfix">
						<?php echo $content;?>
						</div>
					<?php if( $blog['video_code'] ) { ?>
					<div class="pav-video clearfix"><?php echo html_entity_decode($blog['video_code'], ENT_QUOTES, 'UTF-8');?></div>
					<?php } ?>
				 </div>
                <div class="entry-bottom clearfix">
				 <?php if( !empty($tags) ) { ?>
				 <div class="blog-tags tags pull-left">
					<span class="tags-title"><?php echo $objlang->get('text_tags');?></span>
					<?php foreach( $tags as $tag => $tagLink ) { ?>
						<a class="item-tag " href="<?php echo $tagLink; ?>" title="<?php echo $tag; ?>"><?php echo $tag; ?> </a>
					<?php } ?>
				 </div>
				 <?php } ?>
				 <div class="blog-social pull-right">
                     <div class="social share-links ">
                         <ul class="social-icons list-unstyled list-inline ">
                             <li class="social-item">
                                 <a href="http://www.facebook.com/sharer.php?u=<?php echo $blog['category_link']; ?>" title="<?php echo $blog['title'];?>" class="post_share_facebook facebook" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=220,width=600');return false;">
                                     <i class="fa fa-facebook"></i>
                                 </a>
                             </li>
                             <li class="social-item">
                                 <a href="https://twitter.com/share?url=<?php echo $blog['category_link']; ?>" title="<?php echo $blog['title'];?>" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=260,width=600');return false;" class="product_share_twitter twitter">
                                     <i class="fa fa-twitter"></i>
                                 </a>
                             </li>
                             <li class="social-item">
                                 <a href="https://plus.google.com/share?url=<?php echo $blog['category_link']; ?>" class="googleplus" title="<?php echo $blog['title'];?>" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                     <i class="fa fa-google-plus"></i>
                                 </a>
                             </li>
                             <li class="social-item">
                                 <a href="http://pinterest.com/pin/create/button/?url=<?php echo $blog['category_link']; ?>&media=<?php echo $blog['thumb_large'];?>&description=<?php echo $blog['title'];?>" title="<?php echo $blog['title'];?>" class="pinterest">
                                     <i class="fa fa-pinterest"></i>
                                 </a>
                             </li>
                             <li class="social-item">
                                 <a href="mailto:?subject=<?php echo $blog['title'];?>&body=<?php echo $blog['category_link']; ?>" title="<?php echo $blog['title'];?>" class="product_share_email mail">
                                     <i class="fa fa-envelope"></i>
                                 </a>
                             </li>
                         </ul>
                     </div>
				 </div>
                </div>
				
				 <div id="comments" class="comments">
					<?php if( $config->get('blog_show_comment_form') ) { ?>
						<?php if( $config->get('comment_engine') == 'diquis' ) { ?>
					    <div id="disqus_thread"></div>
							<script type="text/javascript">
								//CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE 
								var disqus_shortname = '<?php echo $config->get('diquis_account');?>'; // required: replace example with your forum shortname

								//DON'T EDIT BELOW THIS LINE
								(function() {
									var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
									dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
									(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
								})();
							</script>
							<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
							<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>

						<?php } elseif( $config->get('comment_engine') == 'facebook' ) { ?>
						<div id="fb-root"></div>
							<script>(function(d, s, id) {
							  var js, fjs = d.getElementsByTagName(s)[0];
							  if (d.getElementById(id)) {return;}
							  js = d.createElement(s); js.id = id;
							  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=<?php echo $config->get("facebook_appid");?>";
							  fjs.parentNode.insertBefore(js, fjs);
							}(document, 'script', 'facebook-jssdk'));</script>
							<div class="fb-comments" data-href="<?php echo $link; ?>" 
									data-num-posts="<?php echo $config->get("comment_limit");?>" data-width="<?php echo $config->get("facebook_width")?>">
							</div>
						<?php }else { ?>
							<?php if( count($comments) ) { ?>
							<ul class="comment-list">
								<?php foreach( $comments as $comment ) {  $default='';?>
								<li class="comment-item clearfix" id="comment<?php echo $comment['comment_id'];?>">
									<img src="<?php echo "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $comment['email'] ) ) ) . "?d=" . urlencode( $default ) . "&s=60" ?>" align="left"/>
									<div class="comment-wrap">
										<div class="comment-author meta">
                                            <h5 class="text-user"><?php echo $comment['user'];?></h5>
                                            <span class="meta-user">
                                                <span class="comment-created"><?php echo $comment['created'];?></span>/
                                                <span class="comment-reply-link"><a href="<?php echo $link;?>#comment<?php echo $comment['comment_id'];?>"><?php echo $objlang->get('text_comment_link');?></a></span>
                                            </span>


										</div>
                                        <div class="comment-text">
										    <?php echo $comment['comment'];?>
                                        </div>
									</div>
								</li>
								<?php } ?>
								<div class="pagination">
									<?php echo $pagination;?>
								</div>
							</ul>
							<?php } ?>
                            <div id="commentform">
                                <h3 class="comment-reply-title"><?php echo $objlang->get("text_leave_a_comment");?></h3>
                                <form action="<?php echo $comment_action;?>" method="post" id="comment-form" class="form-horizontal">

                                        <div class="message" style="display:none"></div>
                                        <div class="form-group required">

                                            <div class="col-sm-5">
                                                <input class="form-control" type="text" name="comment[user]" value="" id="comment-user" placeholder="<?php echo $objlang->get('entry_name');?> *"/>
                                            </div>
                                        </div>

                                        <div class="form-group required">

                                            <div class="col-sm-5">
                                                <input class="form-control" type="text" name="comment[email]" value="" id="comment-email" placeholder="<?php echo $objlang->get('entry_email');?> *"/>
                                            </div>
                                        </div>

                                        <div class="form-group required">
                                            <div class="col-md-12">
                                                <textarea class="form-control" name="comment[comment]" rows="10" id="comment-comment" placeholder="<?php echo $objlang->get('entry_comment');?> *"></textarea>
                                            </div>
                                        </div>

                                        <?php if( $config->get('enable_recaptcha') ) { ?>
                                        <div class="recaptcha">
                                             <p><b><?php echo $entry_captcha; ?></b> </p>

                                            <img src="index.php?route=tool/captcha" alt="" aligh="left"/>
                                            <input class="form-control" type="text" name="captcha" value="<?php echo $captcha; ?>" size="10" />
                                        </div>
                                        <?php } ?>
                                        <input type="hidden" name="comment[blog_id]" value="<?php echo $blog['blog_id']; ?>" />
                                        <br/>
                                        <div class="buttons-wrap">
                                            <button class="btn btn-primary" type="submit">
                                                <span><?php echo $objlang->get('text_submit');?></span>
                                            </button>
                                        </div>
                                </form>
                                <script type="text/javascript">
                                    $( "#comment-form .message" ).hide();
                                    $("#comment-form").submit( function(){
                                        $.ajax( {type: "POST",url:$("#comment-form").attr("action"),data:$("#comment-form").serialize(), dataType: "json",}).done( function( data ){
                                            if( data.hasError ){
                                                $( "#comment-form .message" ).html( data.message ).show();
                                            }else {
                                                location.href='<?php echo str_replace("&amp;","&",$link);?>';
                                            }
                                        } );
                                        return false;
                                    } );

                                </script>
                            </div>
						<?php } ?>
					<?php } ?>
				</div>
		</div>

		<!-- End Div Content -->
		<?php echo $content_bottom; ?></div>
		<!-- End Div Row -->
		<?php echo $column_right; ?>
	</div>

</div><!-- End Div Container -->
<?php echo $footer; ?>