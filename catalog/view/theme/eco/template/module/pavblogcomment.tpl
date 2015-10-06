<div class="widget widget-pavblogs-comments pavblogs-comments-box">
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>
    <div class="widget-content">
		<?php if( !empty($comments) ) { ?>
        <div class="pavblog-comments comment-meta">
            <?php $default=''; foreach( $comments as $comment ) { ?>
            <div class="pav-comment media">
                <a class="pull-left" href="<?php echo $comment['link'];?>" title="<?php echo $comment['user'];?>">
                    <img src="<?php echo "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $comment['email'] ) ) ) . "?d=" . urlencode( $default ) . "&amp;s=60" ?>" class="media-object img-responsive"/>
                </a>
                <div class="media-body">
                    <h5 class="text-user"><?php echo $comment['user'];?></h5>
                    <p class="comment-text"><?php echo utf8_substr( $comment['comment'],0, 50 ); ?>...</p>
                </div>
            </div>
            <?php } ?>
        </div>
		<?php } ?>
	</div>
</div>

