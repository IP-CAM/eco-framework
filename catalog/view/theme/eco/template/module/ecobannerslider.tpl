<?php
$id = rand(1,9)+rand();
?>
<div class="widget widget-banner">
    <div class="widget-content no-padding">
        <div id="eco-slideshow_<?php echo $id ?>" class="<?php if($enable_slider): ?> owl-carousel <?php endif; ?><?php echo $class; ?>">
        <?php foreach ($slider as $slide) { ?>
        <div class="item group-image">
            <a class="buttom_name" href="<?php echo $slide['link']; ?>"><span class="btn btn_name"><?php echo $slide['btn_name'];?></span></a>
            <div class="group-description">
                <h3 class="short_title"><?php echo $slide['short_title'];?></h3>
                <p class="description"><?php echo $slide['description'];?></p>
            </div>

            <?php if ($slide['link']) { ?>
            <a  class="image-banner" href="<?php echo $slide['link']; ?>"><img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['title']; ?>" class="img-responsive" /></a>
            <?php } else { ?>
            <img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['title']; ?>" class="img-responsive" />
            <?php } ?>
        </div>
        <?php }?>
        </div>
    </div>
</div>

<?php if($enable_slider): ?>
<script type="text/javascript"><!--
    $('#eco-slideshow_<?php echo $id ?>').owlCarousel({
        items: 6,
        autoPlay: 3000,
        singleItem: true,
        navigation: true,
        navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
        pagination: true
    });
    --></script>
<?php endif; ?>