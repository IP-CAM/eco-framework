<div class="widget widget-banner">
    <div class="widget-content">
        <div id="banner<?php echo $module; ?>" class="widget owl-carousel">
            <?php foreach ($banners as $banner) { ?>
                <div class="item">
                    <?php if ($banner['link']) { ?>
                        <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
                        <?php } else { ?>
                        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
                    <?php } ?>
                </div>
            <?php } ?>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
$('#banner<?php echo $module; ?>').owlCarousel({
	items: 6,
	autoPlay: 3000,
	singleItem: true,
	navigation: false,
	pagination: false,
	transitionStyle: 'fade'
});
--></script>
