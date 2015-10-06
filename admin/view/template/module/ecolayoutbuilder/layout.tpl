<?php
	echo $header; 
	echo $column_left;
?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">

                <a class="btn btn-primary" onclick="$('#form-layout-builder').submit();"><?php echo $button_save; ?></a>
                <a class="btn btn-success" onclick="$('#action').val('save_stay');$('#form-layout-builder').submit();"><?php echo $button_save_stay; ?></a>
                <a class="btn btn-danger" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>

            </div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div><!-- End div#page-header -->
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $objlang->get('text_edit'); ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-layout-builder" class="form-horizontal">
                    <input type="hidden" name="action" value="" id="action"/>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-name"><?php echo $objlang->get('entry_name'); ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $objlang->get('entry_name'); ?>" id="input-name" class="form-control" />
                            <?php if ($error_name) { ?>
                            <div class="text-danger"><?php echo $error_name; ?></div>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $objlang->get('entry_status'); ?></label>
                        <div class="col-sm-10">
                            <select name="status" id="input-status" class="form-control">
                                <?php if ($status) { ?>
                                <option value="1" selected="selected"><?php echo $objlang->get('text_enabled'); ?></option>
                                <option value="0"><?php echo $objlang->get('text_disabled'); ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $objlang->get('text_enabled'); ?></option>
                                <option value="0" selected="selected"><?php echo $objlang->get('text_disabled'); ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <input type="text"
                           name="layout"
                           id="jform_params_layout"
                           value="<?php echo json_encode($layoutData, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP); ?>"
                           style="display: none"
                           class="hfLayoutHtml" />
                </form>
            </div>
        </div>
    </div>

    <div id="layoutbuilder-container">

        <!-- Main layout -->
        <div id="droppable-container">

            <div class="zo2-container">
                <div class="zo2-add-new-row" data-zo2-type="row" data-zo2-customclass="" data-zo2-fullwidth="0" data-zo2-visibility-xs="1" data-zo2-visibility-sm="1" data-zo2-visibility-md="1" data-zo2-visibility-lg="1">
                    <button class="btn btn-primary add-new-row" title="" data-toggle="tooltip" form="form-carousel" type="button" data-original-title="Add new row"><?php echo $objlang->get('button_add_new_row'); ?></button>
                </div>
                <?php if(isset($layout_data)): ?>
                    <?php foreach ($layout_data as $row) : ?>
                    <?php require("layout_row.tpl"); ?>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </div>





    </div>

</div>
<!-- Modal: Row settings -->
<div id="rowSettingsModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="rowSettingsModal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!-- Modal header -->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3><?php echo $objlang->get('text_row_header_setting'); ?></h3>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
                <div class="form-inline">
                    <!-- Tab contents -->
                    <div class="zo2-tabs-content">
                        <!-- Basic -->
                        <div class="active " id="row-basic">
                            <div class="control-group ">
                                <label class="control-label" for="txtRowName"><?php echo $objlang->get('text_row_name'); ?></label>
                                <input type="text" class="form-control" id="txtRowName" placeholder="<?php echo $objlang->get('text_row_name'); ?>">
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtRowCss"><?php echo $objlang->get('text_row_custom_class'); ?></label>
                                <input type="text" id="txtRowCss" class="form-control" placeholder="<?php echo $objlang->get('text_row_custom_class'); ?>">
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtWithCss"><?php echo $objlang->get('text_layout'); ?></label>
                                <select name="layout" id="input-layout" class="form-control">
                                    <option value="0" selected="selected"><?php echo $objlang->get('box_width'); ?></option>
                                    <option value="1"><?php echo $objlang->get('full_width'); ?></option>
                                </select>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtWithCss"><?php echo $objlang->get('text_layout'); ?></label>
                                <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail">
                                    <img src="ecolayoutbuilder_image[image]" alt="" title="" data-placeholder="" />
                                </a>
                                <input type="hidden" name="ecolayoutbuilder_image[<?php echo $image_row; ?>][image]" value="<?php echo $ecolayoutbuilder_image['image']; ?>" id="input-image" /></td>
                            </div>
                            <div id="column-responsive">
                                <div class="control-group">
                                    <div class="control-label"><?php echo $objlang->get('text_layout_responsive'); ?></div>
                                    <div class="controls clearfix">
                                        <div class="control btn-group btn-group-onoff" id="btgRowPhone">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Mobile"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Mobile"></button>
                                        </div>
                                        <div class="control btn-group btn-group-onoff" id="btgRowTablet">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Tablet"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Tablet"></button>
                                        </div>
                                        <div class="control btn-group btn-group-onoff" id="btgRowDesktop">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Destop"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Destop"></button>
                                        </div>
                                        <div class="control btn-group btn-group-onoff" id="btgRowLargeDesktop">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Large Destop"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Large Destop"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Model footer -->
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $objlang->get('text_common_close'); ?></button>
                <button class="btn btn-primary" id="btnSaveRowSettings"><?php echo $objlang->get('text_common_save_change'); ?></button>
            </div>
        </div>
    </div>
</div>
<!-- Model: Column settings -->
<div id="colSettingsModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="colSettingsModal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3><?php echo $objlang->get('text_col_header_setting'); ?></h3>
            </div>
            <div class="modal-body">
                <div class="form-inline">
                    <div class="zo2-tabs-content">
                        <div class="active" id="column-basic">
                            <!-- begin -->
                            <div class="control-group">
                                <label class="control-label" for="dlColType"><?php echo $objlang->get('text_module'); ?></label>
                                <select id="dlColPosition" class="form-control">
                                    <?php foreach ($extensions as $extension) { ?>
                                    <?php if (!$extension['module']) { ?>
                                    <?php if ($extension['code'] == $layout_module['code']) { ?>
                                    <option value="<?php echo $extension['code']; ?>" selected="selected"><?php echo $extension['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $extension['code']; ?>"><?php echo $extension['name']; ?></option>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <optgroup label="<?php echo $extension['name']; ?>">
                                        <?php foreach ($extension['module'] as $module) { ?>
                                        <?php if ($module['code'] == $layout_module['code']) { ?>
                                        <option value="<?php echo $module['code']; ?>" selected="selected"><?php echo $module['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $module['code']; ?>"><?php echo $module['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </optgroup>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtColCss"><?php echo $objlang->get('text_col_custom_class'); ?></label>
                                <input type="text" id="txtColCss" class="form-control" placeholder="<?php echo $objlang->get('text_col_custom_class'); ?>">
                            </div>
                            <div id="column-responsive">
                                <div class="control-group">
                                    <div class="control-label"><?php echo $objlang->get('text_layout_responsive'); ?></div>
                                    <div class="controls clearfix">
                                        <div class="control btn-group btn-group-onoff" id="btgColPhone">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Mobile"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Mobile"></button>
                                        </div>
                                        <div class="control btn-group btn-group-onoff" id="btgColTablet">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Tablet"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Tablet"></button>
                                        </div>
                                        <div class="control btn-group btn-group-onoff" id="btgColDesktop">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Destop"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Destop"></button>
                                        </div>
                                        <div class="control btn-group btn-group-onoff" id="btgColLargeDesktop">
                                            <button class="btn btn-on active" data-toggle="tooltip" data-placement="left" title="Enable On Large Destop"></button>
                                            <button class="btn btn-off" data-toggle="tooltip" data-placement="left" title="Disable On Large Destop"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $objlang->get('text_common_close'); ?></button>
                <button id="btnSaveColSettings" class="btn btn-primary"><?php echo $objlang->get('text_common_save_change'); ?></button>
            </div>
        </div>
    </div>
</div>