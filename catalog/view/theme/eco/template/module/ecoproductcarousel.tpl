<?php
$id = rand(1,9)+rand();
?>
<div class="box box-normal <?php echo count($tabs) > 1 ? 'producttabs' : '' ?>">
    <div class="box-heading">
        <?php if(count($tabs) > 2): ?>
            <ul class="nav nav-tabs" id="producttabs<?php echo $id;?>">
                <?php foreach( $tabs as $tab => $products ) { if( empty($products) ){ continue;}  ?>
                <li><a href="#tab-<?php echo $tab.$id;?>" data-toggle="tab"><?php echo $objlang->get('text_'.$tab)?></a></li>
                <?php } ?>
            </ul>
        <?php else: ?>
            <?php foreach( $tabs as $tab => $products ) {  ?>
                <h3><?php echo $objlang->get('text_'.$tab)?></a></h3>
            <?php } ?>
        <?php endif; ?>
    </div>

    <div class="<?php echo count($tabs) > 1? 'tab-content' : '' ?> box-content">
        <?php foreach( $tabs as $tab => $products ) {
        if( empty($products) ){ continue;}
        $cid = rand(10,19)+rand();
        $count              = count($products);
        $column             = $carousel == 1 && $row == 1 ? $count : $row;

        ?>
            <div class="tab-pane products-rows  tabcarousel<?php echo $id; ?> slide" id="tab-<?php echo $tab.$id;?>">
                <?php $i=0; foreach ($products as $product) { ?>
                <?php if ($carousel == 1 && $row > 1 && $i == 0): ?>
                <div id="product<?php echo $module.$cid; ?>" class="owl-carousel">
                    <?php endif ?>
                    <?php if ($i % $column == 0 || ($row > 1 && $i % $row == 0)): ?>
                    <div class="category-products <?php echo $carousel == 0 ? 'col-lg-3 col-md-3 col-sm-6 col-xs-12' : '';?>">
                        <?php if ($carousel == 1 && $row == 1): ?>
                        <ul id="product<?php echo $module.$cid; ?>" class="products-grid">
                        <?php else: ?>
                            <ul class="products-grid">
                         <?php endif; ?>
                            <?php endif ?>
                            <?php $i++ ?>
                            <li>
                                <div class="product-layout">
                                    <div class="product-thumb transition">
                                        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
                                        <div class="caption">
                                            <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                                            <?php if ($product['rating']) { ?>
                                            <div class="rating">
                                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                <?php if ($product['rating'] < $i) { ?>
                                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                <?php } else { ?>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                <?php } ?>
                                                <?php } ?>
                                            </div>
                                            <?php } ?>
                                            <?php if ($product['price']) { ?>
                                            <p class="price">
                                                <?php if (!$product['special']) { ?>
                                                <?php echo $product['price']; ?>
                                                <?php } else { ?>
                                                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                                                <?php } ?>
                                                <?php if (isset($product['tax'])) { ?>
                                                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                                <?php } ?>
                                            </p>
                                            <?php } ?>
                                        </div>
                                        <div class="button-group">
                                            <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                                            <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                                            <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                                            <div class="quickview">
                                                <a class="btn btn-default iframe-link dark options-cart" data-toggle="tooltip" data-placement="right" href="<?php echo $url->link('module/ecotheme','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><i class="fa fa-eye"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                             </li>
                            <?php if ($i == $count || $i % $column == 0 || ($row > 1 && $i % $row == 0)): ?>
                        </ul>
                    </div>
                    <?php endif ?>
                    <?php if ($carousel == 1 && $row > 1 && $i == $count): ?>
                </div>
                <?php endif ?>

            <?php } ?>
            </div>
            <script type="text/javascript"><!--
                $('#product<?php echo $module.$cid; ?>').owlCarousel({
                items: <?php echo (int)$itemsperpage; ?>,
                autoPlay: <?php echo (int)$slideshow > 0 ? $slideshow : 'false'; ?>,
                singleItem: false,
                        navigation: true,
                        navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
                        pagination: true
                });
                --></script>
        <?php } ?>

    </div>

</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('#producttabs<?php echo $id;?> a:first').tab('show');


        $('.options-cart').colorbox({
            iframe: true,
            href:this.href,
            opacity:	0.5,
            speed:		300,
            close:      "close",
            innerWidth:'780px',
            innerHeight:'650px',
            onOpen: function(){
                $('#cboxLoadingGraphic').addClass('box-loading');
            },
            onComplete: function(){
                setTimeout(function(){
                    $('#cboxLoadingGraphic').removeClass('box-loading');
                },1300);
            }
        });

    });
</script>