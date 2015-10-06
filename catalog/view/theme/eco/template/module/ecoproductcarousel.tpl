<?php
$id = rand(1,9)+rand();
$product_layout = DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/template/product_layout.tpl';
if($itemsperpage == 0) $itemsperpage = 1;
if(strtoupper($display) == 'LIST') { $itemsperpage = 1; $extClass = 'products-list';}
else $extClass = 'products-grid';
$slice = 12 / (int)$itemsperpage;
$class = "col-lg-$slice col-md-".(int)$slice." col-sm-6 col-xs-12";
?>
<div class="widget widget-ecoproduct <?php echo count($tabs) > 1 ? 'producttabs' : '' ?>">
    <div class="widget-title <?php echo $extClass;?>">
        <?php if(count($tabs) > 1): ?>
            <ul class="nav nav-tabs" id="producttabs<?php echo $id;?>">
                <?php foreach( $tabs as $tab => $products ) { if( empty($products) ){ continue;}  ?>
                <li><a href="#tab-<?php echo $tab.$id;?>" data-toggle="tab"><?php echo $objlang->get('text_'.$tab)?></a></li>
                <?php } ?>
            </ul>
        <?php else: ?>
            <?php foreach( $tabs as $tab => $products ) {  ?>
                <span><?php echo $objlang->get('text_'.$tab)?></span>
            <?php } ?>
        <?php endif; ?>
    </div>

    <div class="<?php echo count($tabs) > 1? 'tab-content' : '' ?> widget-content clearfix">
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
                    <div class="category-products <?php echo $extClass;?>  <?php echo $carousel == 0 ? $class : '';?>">
                        <?php if ($carousel == 1 && $row == 1): ?>
                        <div id="product<?php echo $module.$cid; ?>" class="<?php echo $extClass;?>">
                        <?php else: ?>
                            <div class="<?php echo $extClass;?>">
                         <?php endif; ?>
                            <?php endif ?>
                            <?php $i++ ?>
                                <div class="product-layout">
                                    <?php  require($product_layout);?>
                                </div>
                            <?php if ($i == $count || $i % $column == 0 || ($row > 1 && $i % $row == 0)): ?>
                        </div>
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
    });
</script>