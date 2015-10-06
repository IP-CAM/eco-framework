<?php
$product_layout = DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/template/product_layout.tpl';
?>
<div class="widget widget-featured">
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>
    <div class="widget-content">
        <div class="row">
              <?php foreach ($products as $product) { ?>
              <div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <?php require($product_layout); ?>
              </div>
              <?php } ?>
        </div>
    </div>
</div>