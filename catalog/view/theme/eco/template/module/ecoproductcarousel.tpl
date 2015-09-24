<?php
$id = rand(1,9)+rand();
$product_layout = DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/template/product_layout.tpl';
if($itemsperpage == 0) $itemsperpage = 1;
$slice = 12 / (int)$itemsperpage;
$class = "col-lg-$slice col-md-".(int)$slice." col-sm-6 col-xs-12";
?>
<div class="box box-normal <?php echo count($tabs) > 1 ? 'producttabs' : '' ?>">
    <div class="box-heading">
        <?php if(count($tabs) > 1): ?>
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
                    <div class="category-products <?php echo $carousel == 0 ? $class : '';?>">
                        <?php if ($carousel == 1 && $row == 1): ?>
                        <ul id="product<?php echo $module.$cid; ?>" class="products-grid">
                        <?php else: ?>
                            <ul class="products-grid">
                         <?php endif; ?>
                            <?php endif ?>
                            <?php $i++ ?>
                            <li>
                                <div class="product-layout">
                                <?php  require($product_layout);?>
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
    });
</script>