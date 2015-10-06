<div class="product-thumb  transition">
    <div class="product-image">
        <div class="image">
            <a href="<?php echo $product['href']; ?>">
                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
            </a>
        </div>
        <div class="quick-view">
            <a class="button iframe-link dark options-cart" data-toggle="tooltip" data-placement="right" href="<?php echo $this->url->link('module/ecotheme','product_id='.$product['product_id']);?>"  title="<?php echo $this->language->get('quick view'); ?>" ><i class="icon icon-eye"></i></a>
        </div>

        <div class="button-group">
            <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="icon icon-shuffle"></i></button>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="icon icon-handbag"></i> <span class="hidden"><?php echo $button_cart; ?></span></button>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="icon icon-heart "></i></button>
        </div>
    </div>

    <div class="caption clearfix">
        <div class="group-meta group-meta-product">
            <div class="name">
                <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            </div>

            <?php if ($product['rating']) { ?>
            <div class="rating">
                <?php for ($k = 1; $k <= 5; $k++) { ?>
                <?php if ($product['rating'] < $k) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
            </div>
            <?php } ?>

        </div>
        <?php if ($product['price']) { ?>
        <div class="price price-product">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span>
            <span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
            <?php if ($product['tax']) { ?>
            <span class="price-tax hidden"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
            <?php } ?>
        </div>
        <div class="description-product">
            <?php echo $product['description']; ?>
        </div>
        <div class="button-group-list">
            <button type="button" data-toggle="tooltip" title="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>');"><span><?php echo $button_cart; ?></span><i class="icon icon-handbag"></i></button>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="icon icon-heart "></i></button>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="icon icon-shuffle"></i></button>
        </div>
        <?php } ?>
    </div>
</div>
