<?php 
	echo $header; 
	echo $column_left;
?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-banner" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Save"><i class="fa fa-save"></i></button>
				<a class="btn btn-danger" href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div><!-- End div#page-header -->

	<div id="page-content" class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
			<?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if (isset($success) && !empty($success)) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-latest" class="form-horizontal">
					<div class="tab-pane">
						<ul class="nav nav-tabs" id="language">
							<?php $i=0; foreach ($languages as $language) { $i++;?>
							<?php $active = ($i==1)?"class='active'":''; ?>
							<li <?php echo $active; ?>><a href="#tab-module-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
							<?php } ?>
						</ul>
						<div class="tab-content">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-name"><?php echo $objlang->get('entry_module_name'); ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-name" placeholder="<?php echo $objlang->get('entry_module_name'); ?>" value="<?php echo $name; ?>" name="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="input-status" name="status" style="width:55%;">
                                        <?php if ($status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-tabs"><?php echo $entry_tabs;?></label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="input-tabs" name="tabs[]" multiple="multiple" style="width:55%;" size="10">
                                        <?php foreach ($tmptabs as $tab => $tabName) { ?>
                                        <?php if ( in_array($tab,(array)$tabs) ) { ?>
                                        <option value="<?php echo $tab; ?>" selected="selected"><?php echo $tabName; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $tab; ?>"><?php echo $tabName; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-product"><?php echo $objlang->get('entry_product'); ?></label>
                                <div class="col-sm-10">
                                    <input type="text" style="width:55%;" name="product" value="" placeholder="<?php echo $objlang->get('entry_product'); ?>" id="input-product" class="form-control" />
                                    <div id="featured-product" class="well well-sm" style="width:55%; overflow: auto; height: 150px;">
                                        <?php foreach ($products as $product) { ?>
                                        <div id="featured-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                                            <input type="hidden" name="product[]" value="<?php echo $product['product_id']; ?>" />
                                        </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-display"><?php echo $objlang->get('Display options'); ?></label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="input-display" name="display" style="width:55%;">
                                        <?php if ($display == 'grid') { ?>
                                        <option value="grid" selected="selected"><?php echo $objlang->get('Grid'); ?></option>
                                        <option value="list"><?php echo $objlang->get('List'); ?></option>
                                        <?php } else { ?>
                                        <option value="grid"><?php echo $objlang->get('Grid'); ?></option>
                                        <option value="list" selected="selected"><?php echo $objlang->get('List'); ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-carousel"><?php echo $objlang->get('entry_enablecarousel');; ?></label>
                                <div class="col-sm-10 grid-depend">
                                    <select class="form-control" id="input-carousel" name="carousel" style="width:55%;">
                                        <?php if ($carousel) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-slideshow"><?php echo $objlang->get('entry_slideshow'); ?></label>
                                <div class="col-sm-10 grid-depend">
                                    <input type="text" class="form-control" style="width:55%;" id="input-slideshow" placeholder="<?php echo $objlang->get('entry_slideshow'); ?>" value="<?php echo $slideshow; ?>" name="slideshow">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-row"><?php echo $objlang->get('entry_row'); ?></label>
                                <div class="col-sm-10 grid-depend">
                                    <input type="text" class="form-control" style="width:55%;" id="input-name" placeholder="<?php echo $objlang->get('entry_row'); ?>" value="<?php echo $row; ?>" name="row">
                                </div>
                            </div>

						    <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-itemsperpage"><?php echo $objlang->get('entry_items'); ?></label>
                                <div class="col-sm-10 grid-depend">
                                    <input type="text" class="form-control" style="width:55%;" id="input-itemsperpage" placeholder="<?php echo $objlang->get('entry_items'); ?>" value="<?php echo $itemsperpage; ?>" name="itemsperpage">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-limit"><?php echo $objlang->get('entry_limit'); ?></label>
                                <div class="col-sm-10 grid-depend">
                                    <input type="text" class="form-control" style="width:55%;" id="input-limit" placeholder="<?php echo $objlang->get('entry_limit'); ?>" value="<?php echo $limit; ?>" name="limit">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-width"><?php echo $objlang->get('entry_width'); ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-width" placeholder="<?php echo $objlang->get('entry_width'); ?>" value="<?php echo $width; ?>" name="width">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-height"><?php echo $objlang->get('entry_height'); ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-height" placeholder="<?php echo $objlang->get('entry_height'); ?>" value="<?php echo $height; ?>" name="height">
                                </div>
                            </div>
						</div>
					</div>
				</form>
			</div>
		</div><!-- end div content form -->

		</div>
	</div><!-- End div#page-content -->

</div><!-- End div#content -->
<script type="text/javascript">
	<?php foreach ($languages as $language) { ?>
		$("#description-<?php echo $language['language_id']; ?>").summernote({ height: 150 });
	<?php } ?>
    $(document).ready(function(){
        if( $('#input-display').val() == 'list') $('.grid-depend').each(function(){ $(this).parent().hide();});
        $('#input-display').on('change',function(){
            if(this.value == 'list'){
                $('.grid-depend').each(function(){
                    $(this).parent().hide();
                });
            } else {
                $('.grid-depend').each(function(){
                    $(this).parent().show();
                });
            }
        });


        $('#input-tabs').on('change',function(){
            var options = $('#input-tabs').val();
            if($.inArray('featured',options) > -1) {
                $('#input-product').closest('.form-group').show();
            } else {
                $('#input-product').closest('.form-group').hide();
            }
        });


        $('input[name=\'product\']').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('input[name=\'product\']').val('');

                $('#featured-product' + item['value']).remove();

                $('#featured-product').append('<div id="featured-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');
            }
        });

        $('#featured-product').delegate('.fa-minus-circle', 'click', function() {
            $(this).parent().remove();
        });
    });
</script>
<?php echo $footer; ?>