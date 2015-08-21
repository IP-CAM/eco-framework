<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-store" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-store" class="form-horizontal">
                    <div class="form-group">
						<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
						<div class="col-sm-10">
							<input type="text" name="name" style="width:55%;" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
							<?php if ($error_name) { ?>
							<div class="text-danger"><?php echo $error_name; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                        <div class="col-sm-10">
                            <select name="status" style="width:55%;" id="input-status" class="form-control">
                                <?php   if ($status) { ?>
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
                        <label class="col-sm-2 control-label" for="input-width"><?php echo $text_ecodeals_width; ?></label>
                        <div class="col-sm-10">
                            <input type="text" id="input-width" name="width" value="<?php echo isset($width)? $width:'' ; ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-height"><?php echo $text_ecodeals_height; ?></label>
                        <div class="col-sm-10">
                            <input type="text" id="input-height" name="height" value="<?php echo isset($height)? $height:'' ; ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-carousel"><?php echo $objlang->get('entry_enablecarousel');; ?></label>
                        <div class="col-sm-10">
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
                        <label class="col-sm-2 control-label" for="input-heading-title"><?php echo $objlang->get('entry_heading_title'); ?></label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" style="width:55%;" id="input-heading-title" placeholder="<?php echo $objlang->get('entry_heading_title'); ?>" value="<?php echo $entry_heading_title; ?>" name="entry_heading_title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-category"><span data-toggle="tooltip" title="<?php echo $objlang->get('entry_category'); ?>"><?php echo $objlang->get('entry_category'); ?></span></label>
                        <div class="col-sm-10">
                            <input type="text" name="category" style="width:55%;" value="" placeholder="<?php echo $objlang->get('entry_category'); ?>" id="input-category" class="form-control" />
                            <div id="product-category" class="well well-sm" style="height: 150px; overflow: auto; width:55%;">
                                <?php foreach ($product_categories as $product_category) { ?>
                                <div id="product-category<?php echo $product_category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product_category['name']; ?>
                                    <input type="hidden" name="product_category[]" value="<?php echo $product_category['category_id']; ?>" />
                                </div>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-slideshow"><?php echo $objlang->get('entry_slideshow'); ?></label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" style="width:55%;" id="input-slideshow" placeholder="<?php echo $objlang->get('entry_slideshow'); ?>" value="<?php echo $slideshow; ?>" name="slideshow">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-row"><?php echo $objlang->get('entry_row'); ?></label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" style="width:55%;" id="input-name" placeholder="<?php echo $objlang->get('entry_row'); ?>" value="<?php echo $row; ?>" name="row">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-itemsperpage"><?php echo $objlang->get('entry_items'); ?></label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" style="width:55%;" id="input-itemsperpage" placeholder="<?php echo $objlang->get('entry_items'); ?>" value="<?php echo $itemsperpage; ?>" name="itemsperpage">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-limit"><?php echo $objlang->get('entry_limit'); ?></label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" style="width:55%;" id="input-limit" placeholder="<?php echo $objlang->get('entry_limit'); ?>" value="<?php echo $limit; ?>" name="limit">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    // Category
    $('input[name=\'category\']').autocomplete({
        'source': function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['category_id']
                        }
                    }));
                }
            });
        },
        'select': function(item) {
            $('input[name=\'category\']').val('');

            $('#product-category' + item['value']).remove();

            $('#product-category').append('<div id="product-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_category[]" value="' + item['value'] + '" /></div>');
        }
    });

    $('#product-category').delegate('.fa-minus-circle', 'click', function() {
        $(this).parent().remove();
    });
</script>
<?php echo $footer; ?>