<h3><?php echo $heading_title; ?></h3>
<?php
    $count              = count($products);
    $column             = $carousel == 1 && $row == 1 ? $count : $row;
?>
<div class="productdeals">
    <?php $i=0; foreach ($products as $product) { ?>
    <?php if ($carousel == 1 && $row > 1 && $i == 0): ?>
    <div id="product-deal" class="owl-carousel">
    <?php endif ?>
        <?php if ($i % $column == 0 || ($row > 1 && $i % $row == 0)): ?>
        <div class="category-products <?php echo $carousel == 0 ? 'col-lg-3 col-md-3 col-sm-6 col-xs-12' : '';?>">
            <?php if ($carousel == 1 && $row == 1): ?>
            <ul id="product-deal" class="products-grid">
                <?php else: ?>
                <ul class="products-grid">
                <?php endif; ?>
        <?php endif ?>
                    <?php $i++ ?>
                    <li>
                        <div class="product-thumb transition">
                            <?php if($product['special']){
                            $a = ($product['special2']);
                            $b = ($product['price2']);
                            $c = round(($a-$b)/$b,2)*100;
                        ?>
                            <div class="sale-percent"><span><?php echo $c;?>%</span></div>
                            <?php }?>
                            <div class="image">
                                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a>
                                <?php if(strtotime($product['date_end'])) { ?>
                                <div id="Countdown<?php echo $product['product_id']?>"></div>
                                <?php } ?>
                            </div>
                            <div class="caption">
                                <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                                <p><?php echo $product['description']; ?></p>
                                <?php if (isset($product['rating'])) { ?>
                                <div class="rating">
                                    <?php for ($ri = 1; $ri <= 5; $ri++) { ?>
                                    <?php if ($product['rating'] < $ri) { ?>
                                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                    <?php } else { ?>
                                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                                    <?php } ?>
                                    <?php } ?>
                                </div>
                                <?php } ?>
                                <?php if ($product['orgprice']) { ?>
                                <p class="price">
                                    <?php if (!$product['special']) { ?>
                                    <?php echo $product['orgprice']; ?>
                                    <?php } else { ?>
                                    <span class="price-old"><?php echo $product['orgprice']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                    <?php } ?>
                                    <?php if ($product['tax']) { ?>
                                    <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                    <?php } ?>
                                </p>
                                <?php } ?>
                            </div>
                            <div class="button-group">
                                <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                                <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                                <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                            </div>
                            <?php if(strtotime($product['date_end'])) { ?>
                            <script type="text/javascript">
                                $(function () {
                                    var austDay = new Date();
                                    austDay = new Date(austDay.getFullYear() + 1, 1 - 1, 26);
                                    $('#Countdown<?php echo $product['product_id'];?>').countdown({
                                        until: new Date(
                                                <?php echo date("Y",strtotime($product['date_end']))?>,
                                            <?php echo date("m",strtotime($product['date_end']))?> -1,
                                    <?php echo date("d",strtotime($product['date_end']))?>,
                                    <?php echo date("H",strtotime($product['date_end']))?>,
                                    <?php echo date("i",strtotime($product['date_end']))?>,
                                    <?php echo date("s",strtotime($product['date_end']))?>
                                    )
                                });
                                });
                            </script>
                            <?php } ?>
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
    $('#product-deal').owlCarousel({
        items: <?php echo (int)$itemsperpage; ?>,
    autoPlay: <?php echo (int)$slideshow > 0 ? $slideshow : 'false'; ?>,
    singleItem: false,
            navigation: true,
            navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
            pagination: true
    });
    --></script>
