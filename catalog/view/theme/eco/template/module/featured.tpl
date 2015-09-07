<?php
$product_layout = DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/template/product_layout.tpl';
?>
<h3><?php echo $heading_title; ?></h3>
<div class="row">
  <?php foreach ($products as $product) { ?>
  <div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12">
    <?php require($product_layout); ?>
  </div>
  <?php } ?>
</div>
