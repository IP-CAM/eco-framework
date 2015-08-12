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
                                    <select class="form-control" id="input-status" name="status">
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
                                    <select class="form-control" id="input-tabs" name="tabs[]" multiple="multiple">
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
                                <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_dimension; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-name" placeholder="<?php echo $entry_dimension; ?>" value="<?php echo $width; ?>" name="width">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_dimension; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-name" placeholder="<?php echo $entry_dimension; ?>" value="<?php echo $height; ?>" name="height">
                                </div>
                            </div>
						    <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-itemsperpage"><?php echo $entry_carousel; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-itemsperpage" placeholder="<?php echo $entry_dimension; ?>" value="<?php echo $itemsperpage; ?>" name="itemsperpage">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-cols"><?php echo $entry_carousel; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-cols" placeholder="<?php echo $entry_dimension; ?>" value="<?php echo $cols; ?>" name="cols">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_carousel; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" style="width:55%;" id="input-limit" placeholder="<?php echo $entry_dimension; ?>" value="<?php echo $limit; ?>" name="limit">
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
<style type="text/css">
	.nostyle { width: 36%; }
</style>
<script type="text/javascript">
	<?php foreach ($languages as $language) { ?>
		$("#description-<?php echo $language['language_id']; ?>").summernote({ height: 150 });
	<?php } ?>
</script>
<?php echo $footer; ?>