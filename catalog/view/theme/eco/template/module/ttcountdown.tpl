<?php if($permission == true): ?>
<div class="countdown-container">
<div class="countdown-title"><h3><?php echo $heading_title; ?></h3></div>
<div class="row">
<div class="product-layout countdown-products">
    <?php foreach ($products as $product) : ?>
    <div class="item-inner">
        <div class="product-thumb transition">
		<?php if($product['special']){
            $a = ($product['special2']);
            $b = ($product['price2']);
            $c = round(($a-$b)/$b,2)*100;
        ?>
        <div class="sale-percent"><span><?php echo $c;?>%</span></div>
        <?php }?>
			<div class="box-item">
				<div class="product-image">
					<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
				</div>
				<?php if(strtotime($product['date_end'])) { ?>
        <div id="Countdown<?php echo $product['product_id']?>"></div>
        <?php } ?>


		</div>
			</div>

                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                <p class="description"><?php echo $product['description']; ?></p>
                <?php if (isset($product['rating'])) { ?>
					<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="" /></div>
				<?php } ?>
				<div class="box-price">
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
                <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><span><?php echo $button_cart; ?></span></button>
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





    <?php endforeach;  ?>
</div>
</div>
</div>
<script type="text/javascript">
	$('.countdown-products').owlCarousel({
			navigation:true,
			pagination: false,
			slideSpeed : 500,
			goToFirstSpeed : 1500,
			autoHeight : false,
			items :4,
			itemsDesktop : [1199,3],
			itemsDesktopSmall : [900,3],
			itemsTablet: [680,2],
			itemsMobile : [480,1]
	});
</script>

<?php endif; ?>