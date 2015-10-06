<?php
    echo $header;
    $id = rand(1,9)+rand();
    $product_layout = DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/template/product_layout.tpl';
?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h2><?php echo $heading_title; ?></h2>
      <?php if ($thumb || $description) { ?>
      <div class="row">
        <?php if ($thumb) { ?>
        <div class="col-sm-12 image-thumbnail">
            <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" />
        </div>
        <?php } ?>
        <?php if ($description) { ?>
        <div class="col-sm-12 description-category"><?php echo $description; ?></div>
        <?php } ?>
      </div>
      <hr>
      <?php } ?>

      <?php if ($categories) { ?>
      <div class="widget-refine widget">
          <h3 class="widget-title"><?php echo $text_refine; ?></h3>

          <?php if (count($categories) <= 5) { ?>
          <div class="row">
            <div class="col-sm-3">
              <ul>
                <?php foreach ($categories as $category) { ?>
                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                <?php } ?>
              </ul>
            </div>
          </div>
          <?php } else { ?>
          <div class="row">
            <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
            <div class="col-sm-3">
              <ul>
                <?php foreach ($categories as $category) { ?>
                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                <?php } ?>
              </ul>
            </div>
            <?php } ?>
          </div>
          <?php } ?>
          <?php } ?>

      </div>
      <?php if ($products) { ?>
      <div class="group-compare">
          <a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a>
      </div>
      <div class="group-filter">
          <div class="row">
                <div class="col-md-4 text-left">
                      <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
                      <select id="input-sort" class="form-control" onchange="location = this.value;">
                          <?php foreach ($sorts as $sorts) { ?>
                          <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                          <?php } else { ?>
                          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                          <?php } ?>
                          <?php } ?>
                      </select>
                </div>
                <div class="col-md-4">
                    <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
                    <select id="input-limit" class="form-control" onchange="location = this.value;">
                        <?php foreach ($limits as $limits) { ?>
                        <?php if ($limits['value'] == $limit) { ?>
                        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                        <?php } ?>
                        <?php } ?>
                    </select>
                </div>

                <div class="col-md-4 text-right">
                      <div class="btn-group switch-layout hidden-xs">
                          <a id="grid-view" class="grid-view active" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></a>
                          <a id="list-view" class="list-view" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></a>
                      </div>
                </div>
          </div>
      </div>
      <div class="row">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-list col-xs-12">
            <?php  require($product_layout);?>
        </div>
        <?php } ?>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
      <?php } ?>
      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
