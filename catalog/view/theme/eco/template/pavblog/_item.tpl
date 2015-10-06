<div class="blog-item archive-blog">
<?php if( $config->get('cat_show_title') ) { ?>

    <?php if( $blog['thumb'] && $config->get('cat_show_image') )  { ?>
        <a href="<?php echo $blog['link'];?>" class="post-image">
            <img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" align="center" class="blog-thumb"/>
        </a>
    <?php } ?>
    <?php if( $config->get('blog_show_category') ) { ?>
                <span class="post-cat">
                    <a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
                </span>
    <?php } ?>
    <h3 class="entry-title"><a href="<?php echo $blog['link'];?>"><?php echo $blog['title'];?></a></h3>
    <div class="article-meta">
        <?php if( $config->get('cat_show_created') ) { ?>
                        <span class="post-date">
                            <?php echo date("d",strtotime($blog['created']));?>
                            <?php echo date("M",strtotime($blog['created']));?>,
                            <?php echo date("Y",strtotime($blog['created']));?>

                        </span>
        <?php } ?>
        <span> // </span>
        <?php if( $config->get('cat_show_author') ) { ?>
					<span class="post-author">
                        <?php echo $objlang->get("text_write_by");?><span class="author"><?php echo $blog['author'];?></span>
                    </span>
        <?php } ?>
    </div>
    <div class="article-description" align="center"><?php echo $blog['description'];?></div>
    <div class="article-bottom clearfix">
        <div class="btn-read-more pull-left">
            <?php if( $config->get('cat_show_readmore') ) { ?>
                <a href="<?php echo $blog['link'];?>" class="readmore"><?php echo $objlang->get('text_readmore');?></a>
            <?php } ?>
        </div>
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
<?php } ?>

</div>