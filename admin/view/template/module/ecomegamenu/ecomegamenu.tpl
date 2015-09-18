<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" onclick="$('#form-megamenu').submit();" form="form-carousel" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
                <div id="import-toolbars">
                    <div class="container-fluid">
                        <div class="pull-left">
                            <select class="form-control" name="stores" id="stores" style="width: 250px;">
                                <?php foreach($stores as $store):?>
                                <?php if($store['store_id'] == $store_id):?>
                                <option value="<?php echo $store['store_id'];?>" selected="selected"><?php echo $store['name'];?></option>
                                <?php else:?>
                                <option value="<?php echo $store['store_id'];?>"><?php echo $store['name'];?></option>
                                <?php endif;?>
                                <?php endforeach;?>
                            </select>
                        </div>

                    </div>
                </div>
                <div id="zo2-admin-megamenu" class="zo2-admin-megamenu">
                <div class="admin-inline-toolbox clearfix">
                    <div class="zo2-admin-mm-row clearfix">
                        <!-- Description -->
                        <div id="zo2-admin-mm-intro" class="pull-left">
                            <h3><?php echo ('Megamenu Toolbox') ?></h3>
                            <p><?php echo ('This toolbox includes all settings of megamenu, just select menu then configure. There are 3 level of configuration: sub-megamenu setting, column setting and menu item setting.') ?></p>
                        </div>

                        <div id="zo2-admin-mm-tb">
                            <div id="zo2-admin-mm-toolitem" class="admin-toolbox">
                                <h3><?php echo ('Item Configuration') ?></h3>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Remove Menu') ?>"><?php echo ('Remove Menu') ?></label>
                                        <fieldset class="btn-group">
                                            <a href="" class="btn toolmenu-removemenu toolbox-action" data-action="removeMenu"><i class="fa fa-minus"></i></a>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Submenu') ?>"><?php echo ('Submenu') ?></label>
                                        <fieldset class="radio btn-group toolitem-sub">
                                            <input type="radio" id="toggleSub0" class="toolbox-toggle" data-action="toggleSub" name="toggleSub" value="0"/>
                                            <label for="toggleSub0"><?php echo $objlang->get('text_no') ?></label>
                                            <input type="radio" id="toggleSub1" class="toolbox-toggle" data-action="toggleSub" name="toggleSub" value="1" checked="checked"/>
                                            <label for="toggleSub1"><?php echo $objlang->get('text_yes') ?></label>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Extra Class') ?>"><?php echo ('Extra Class') ?></label>
                                        <fieldset class="">
                                            <input type="text" class="input-medium toolitem-exclass toolbox-input" name="toolitem-exclass" data-name="class" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Icon') ?>">
                                            <a href="http://fortawesome.github.io/Font-Awesome/#icons-web-app" target="_blank"><i class="fa fa-search"></i><?php echo ('Icon') ?></a>
                                        </label>
                                        <fieldset class="">
                                            <input type="text" class="input-medium toolitem-xicon toolbox-input" name="toolitem-xicon" data-name="xicon" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Item Caption') ?>">
                                            <?php echo ('Item Caption') ?>
                                        </label>
                                        <fieldset class="">
                                            <input type="text" class="input-large toolitem-caption toolbox-input" name="toolitem-caption" data-name="caption" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                            </div>

                            <div id="zo2-admin-mm-toolsub" class="admin-toolbox">
                                <h3><?php echo $objlang->get('text_setting_sub_submenu') ?></h3>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo $objlang->get('text_add_row'); ?>"><?php echo $objlang->get('text_add_row'); ?></label>
                                        <fieldset class="btn-group">
                                            <a href="" class="btn toolsub-addrow toolbox-action" data-action="addRow"><i class="fa fa-plus"></i></a>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo $objlang->get('text_collapse_setting') ?>"><?php echo $objlang->get('text_collapse_setting') ?></label>
                                        <fieldset class="radio btn-group toolsub-hidewhencollapse">
                                            <input type="radio" id="togglesubHideWhenCollapse0" class="toolbox-toggle" data-action="hideWhenCollapse" name="togglesubHideWhenCollapse" value="0" checked="checked"/>
                                            <label for="togglesubHideWhenCollapse0"><?php echo $objlang->get('text_yes') ?></label>
                                            <input type="radio" id="togglesubHideWhenCollapse1" class="toolbox-toggle" data-action="hideWhenCollapse" name="togglesubHideWhenCollapse" value="1"/>
                                            <label for="togglesubHideWhenCollapse1"><?php echo $objlang->get('text_no') ?></label>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo $objlang->get('text_submenu_width') ?>"><?php echo $objlang->get('text_submenu_width') ?></label>
                                        <fieldset class="">
                                            <input type="text" class="toolsub-width toolbox-input input-small" name="toolsub-width" data-name="width" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo $objlang->get('text_alignment')?>"><?php echo $objlang->get('text_alignment') ?></label>
                                        <fieldset class="toolsub-alignment">
                                            <div class="btn-group">
                                                <a class="btn toolsub-align-left toolbox-action" href="#" data-action="alignment" data-align="left" title="<?php echo $objlang->get('text_alignment_left') ?>"><i class="fa fa-align-left"></i></a>
                                                <a class="btn toolsub-align-right toolbox-action" href="#" data-action="alignment" data-align="right" title="<?php echo $objlang->get('text_alignment_right') ?>"><i class="fa fa-align-right"></i></a>
                                                <a class="btn toolsub-align-center toolbox-action" href="#" data-action="alignment" data-align="center" title="<?php echo $objlang->get('text_alignment_center') ?>"><i class="fa fa-align-center"></i></a>
                                                <a class="btn toolsub-align-justify toolbox-action" href="#" data-action="alignment" data-align="justify" title="<?php echo $objlang->get('text_alignment_justify') ?>"><i class="fa fa-align-justify"></i></a>
                                            </div>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Extra Class') ?>"><?php echo ('Extra Class') ?></label>
                                        <fieldset class="">
                                            <input type="text" class="toolsub-exclass toolbox-input input-medium" name="toolsub-exclass" data-name="class" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                            </div>

                            <div id="zo2-admin-mm-toolmenu" class="admin-toolbox">
                                <h3><?php echo ('Root Menu') ?></h3>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Add/remove Menu') ?>"><?php echo ('Add/remove Menu') ?></label>
                                        <fieldset class="btn-group">
                                            <a href="" class="btn toolmenu-addmenu toolbox-action" data-action="addMenu"><i class="fa fa-plus"></i></a>
                                            <a href="" class="btn toolmenu-removemenu toolbox-action" data-action="removeMenu"><i class="fa fa-minus"></i></a>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Menu Name') ?>"><?php echo ('Menu Name') ?></label>
                                        <fieldset class="">
                                            <input type="text" class="input-medium toolmenu-name toolbox-input" name="toolmenu-name" data-name="name" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Type')?>"><?php echo ('Type') ?></label>
                                        <fieldset class="">
                                            <select class="toolmenu-type toolbox-input toolbox-select input-medium" name="toolmenu-type" data-name="menu_type" data-placeholder="<?php echo ('Select Type') ?>">
                                                <option value=""></option>
                                                <option value="url">URL</option>
                                                <option value="category">Category</option>
                                                <option value="information">information</option>
                                            </select>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Url')?>"><?php echo ('Url') ?></label>
                                        <fieldset>
                                            <input type="text" class="input-medium toolmenu-url toolbox-input" name="toolmenu-url" data-name="url" value="" />
                                        </fieldset>
                                    </li>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Category')?>"><?php echo ('Category') ?></label>
                                        <fieldset>
                                            <input type="text" class="input-medium toolmenu-category toolbox-input" name="toolmenu-category" data-name="category" value="" />
                                        </fieldset>
                                    </li>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Information')?>"><?php echo ('Information') ?></label>
                                        <fieldset>
                                            <select class="toolmenu-information toolbox-input toolbox-select input-medium" name="toolmenu-information" data-name="information" data-placeholder="<?php echo ('Select Information') ?>">
                                                <?php foreach($informations as $info):?>
                                                <option value="<?php echo $info['information_id'];?>"><?php echo $info['title'];?></option>
                                                <?php endforeach;?>
                                            </select>
                                        </fieldset>
                                    </li>
                                </ul>
                            </div>
                            <div id="zo2-admin-mm-toolcol" class="admin-toolbox">
                                <h3><?php echo ('Column Configuration') ?></h3>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Add/remove Column') ?>"><?php echo ('Add/remove Column') ?></label>
                                        <fieldset class="btn-group">
                                            <a href="" class="btn toolcol-addcol toolbox-action" data-action="addColumn"><i class="fa fa-plus"></i></a>
                                            <a href="" class="btn toolcol-removecol toolbox-action" data-action="removeColumn"><i class="fa fa-minus"></i></a>
                                        </fieldset>
                                    </li>
                                </ul>

                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Hide when collapse') ?>"><?php echo ('Hide when collapse') ?></label>
                                        <fieldset class="radio btn-group toolcol-hidewhencollapse">
                                            <input type="radio" id="toggleHideWhenCollapse0" class="toolbox-toggle" data-action="hideWhenCollapse" name="toggleHideWhenCollapse" value="0" checked="checked"/>
                                            <label for="toggleHideWhenCollapse0"><?php echo $objlang->get('text_no') ?></label>
                                            <input type="radio" id="toggleHideWhenCollapse1" class="toolbox-toggle" data-action="hideWhenCollapse" name="toggleHideWhenCollapse" value="1"/>
                                            <label for="toggleHideWhenCollapse1"><?php echo $objlang->get('text_yes') ?></label>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Width (1-12)Module') ?>"><?php echo ('Width (1-12)Module') ?></label>
                                        <fieldset class="">
                                            <select class="toolcol-width toolbox-input toolbox-select input-mini" name="toolcol-width" data-name="width">
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                                <option value="11">11</option>
                                                <option value="12">12</option>
                                            </select>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Extra Class') ?>"><?php echo ('Extra Class') ?></label>
                                        <fieldset class="">
                                            <input type="text" class="input-medium toolcol-exclass toolbox-input" name="toolcol-exclass" data-name="class" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Type')?>"><?php echo ('Type') ?></label>
                                        <fieldset class="">
                                            <select class="toolmenu-type toolbox-input toolbox-select input-medium" name="toolmenu-type" data-name="menu_type" data-placeholder="<?php echo ('Select Type') ?>">
                                                <option value=""></option>
                                                <option value="url">URL</option>
                                                <option value="category">Category</option>
                                                <option value="information">Information</option>
                                                <option value="module">Module</option>
                                            </select>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Url')?>"><?php echo ('Url') ?></label>
                                        <fieldset>
                                            <input type="text" class="input-medium toolmenu-url" name="toolmenu-url" data-name="url" value="" />
                                        </fieldset>
                                    </li>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Category')?>"><?php echo ('Category') ?></label>
                                        <fieldset>
                                            <input type="text" class="input-medium toolmenu-category" name="toolmenu-category" data-name="category" value="" />
                                        </fieldset>
                                    </li>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Information')?>"><?php echo ('Information') ?></label>
                                        <fieldset>
                                            <select class="toolmenu-information toolbox-select input-medium" name="toolmenu-information" data-name="information" data-placeholder="<?php echo ('Select Information') ?>">
                                                <?php foreach($informations as $info):?>
                                                <option value="<?php echo $info['information_id'];?>"><?php echo $info['title'];?></option>
                                                <?php endforeach;?>
                                            </select>
                                        </fieldset>
                                    </li>
                                    <li class="admin-hide">
                                        <label class="hasTip" title="<?php echo ('Module')?>"><?php echo ('Module') ?></label>
                                        <fieldset class="">
                                            <select class="toolcol-module toolbox-input toolbox-select input-medium toolmenu-module" name="toolcol-module" data-name="module_id" data-placeholder="<?php echo ('Select Module') ?>">
                                                <option value=""></option>
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
                                                    <option value="<?php echo $module['code']; ?>"><?php echo $module['name']; ?></option>
                                                    <?php } ?>
                                                </optgroup>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul class="admin-hide">
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Menu Name') ?>"><?php echo ('Menu Name') ?></label>
                                        <fieldset class="">
                                            <input type="text" class="input-medium toolmenu-name toolbox-input" name="toolmenu-name" data-name="name" value="" />
                                        </fieldset>
                                    </li>
                                </ul>
                                <ul class="admin-hide">
                                    <li>
                                        <label class="hasTip" title="<?php echo ('Add Menu') ?>"><?php echo ('Add Menu') ?></label>
                                        <fieldset class="btn-group">
                                            <a href="#" class="btn toolmenu-addmenu toolbox-action" data-action="addMenu"><i class="fa fa-plus"></i></a>
                                        </fieldset>
                                    </li>
                                </ul>
                            </div>
                            <div id="menuModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="menuModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <!-- Modal header -->
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 class="modal-title" id="menuModalLabel"><?php echo $objlang->get('add_edit_menu'); ?></h3>
                                        </div>
                                        <!-- Modal body -->
                                        <div class="modal-body">
                                                <form>
                                                    <div class="form-group">
                                                        <label class="col-sm-4 control-label" for="input-label"><?php echo $objlang->get('custom_label'); ?></label>
                                                        <div class="col-sm-8">
                                                            <input type="text" name="menu_label" value="" placeholder="<?php echo $objlang->get('custom_label'); ?>" id="input-label" class="form-control" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-4 control-label" for="input-additional-class"><?php echo $objlang->get('additional_class'); ?></label>
                                                        <div class="col-sm-8">
                                                            <input type="text" name="additional_class" value="" placeholder="<?php echo $objlang->get('additional_class'); ?>" id="input-additional-class" class="form-control" />
                                                        </div>
                                                    </div>
                                                </form>
                                        </div>
                                        <!-- Model footer -->
                                        <div class="modal-footer">
                                            <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $objlang->get('text_common_close'); ?></button>
                                            <button class="btn btn-primary" id="btnSaveMenu"><?php echo $objlang->get('text_common_save_change'); ?></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-megamenu" class="form-horizontal">
                <div id="zo2-admin-mm-container" class="navbar clearfix">
                    <div class="zo2-megamenu animate slide" data-hover="hover" data-duration="300">
                        <?php echo $treemenu; ?>
                    </div>
                </div>
                <input type="hidden" name="menu_config" id="jform_params_menu_config" value="">
                <input type="hidden" name="import_categories" id="import_categories" value="">
                <input type="hidden" value="<?php echo (int)$store_id;?>" name="store_id"/></br></br>
                </form>
                </div>
                </div>
            </div>

    </div>
</div>
<script type="text/javascript">
    var addmenu = '<?php echo str_replace("&amp;","&", $addmenu); ?>',
            editmenu = '<?php echo str_replace("&amp;","&", $editmenu); ?>',
            removemenu = '<?php echo str_replace("&amp;","&", $removemenu); ?>';
    var options = { 'add_menu': addmenu, 'remove_menu' : removemenu, 'edit_menu' : editmenu};
    $(document).ready(function(){
        ZO2AdminMegamenu.prepare(options);
    });

// Mutiple Store
$('#stores').bind('change', function () {
var url = 'index.php?route=module/ecomegamenu&token=<?php echo $token; ?>';
var id = $(this).val();
if (id) {
url += '&store_id=' + encodeURIComponent(id);
}
window.location = url;
});


    $('input[name=\'toolmenu-category\']').autocomplete({
        delay: 500,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    json.unshift({
                        'category_id':  0,
                        'name':  'None'
                    });

                    response($.map(json, function(item) {
                        return {
                            label: item.name,
                            value: item.category_id
                        }
                    }));
                }
            });
        },
        select: function(event, ui) {
            $('input[name=\'toolmenu-category\']').val(ui.item.label);
            $('input[name=\'toolmenu-category\']').data('id',ui.item.value);
            event.stopPropagation();
            return false;
        },
        focus: function(event, ui) {
            return false;
        }
    });


</script>

<?php echo $footer; ?>