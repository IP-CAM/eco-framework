<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-ecobannerslider" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-ecobannerslider" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
        
        <div class="form-group required">
        <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
        <div class="col-sm-10">
        <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
        <?php if ($error_width) { ?>
        <div class="text-danger"><?php echo $error_width; ?></div>
        <?php } ?>
        </div>
        </div>

        <div class="form-group required">
        <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
        <div class="col-sm-10">
        <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
        <?php if ($error_height) { ?>
        <div class="text-danger"><?php echo $error_height; ?></div>
        <?php } ?>
        </div>
        </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-class"><?php echo $objlang->get('Custom Class'); ?></label>
            <div class="col-sm-10">
              <input type="text" name="class" value="<?php echo $class; ?>" placeholder="<?php echo $objlang->get('Custom Class'); ?>" id="input-class" class="form-control" />
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-slider"><?php echo $objlang->get('Enable Slider'); ?></label>
            <div class="col-sm-10">
              <select name="slider" id="input-slider" class="form-control">
                <?php if ($slider) { ?>
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
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
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
          <table id="images" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $entry_title; ?></td>
                <td class="text-left"><?php echo $entry_link; ?></td>
                <td class="text-left"><?php echo $entry_image; ?></td>
                <td class="text-right"><?php echo $entry_description; ?></td>
                <td></td>
              </tr>
            </thead>
            <tbody>
              <?php $image_row = 0; ?>
              <?php if($ecobannerslider_images){
              foreach ($ecobannerslider_images as $ecobannerslider_image) { ?>
              <tr id="image-row<?php echo $image_row; ?>">
                <td class="text-left">
                  <?php foreach ($languages as $language) {?>
                  <div class="input-group pull-left">
                    <span class="input-group-addon">
                      <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> 
                    </span>
                     <input type="text" name="ecobannerslider_image[<?php echo $image_row; ?>][ecobannerslider_image_title][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($ecobannerslider_image['ecobannerslider_image_title'][$language['language_id']]) ? $ecobannerslider_image['ecobannerslider_image_title'][$language['language_id']]['title'] : ''; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control" />

                  </div>
                  <?php }?>
                </td>


                <td class="text-left" style="width: 30%;">
                  <input type="text" name="ecobannerslider_image[<?php echo $image_row; ?>][link]" value="<?php echo $ecobannerslider_image['link']; ?>" placeholder="<?php echo $entry_link; ?>" class="form-control" />
                </td>

                <td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $ecobannerslider_image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="ecobannerslider_image[<?php echo $image_row; ?>][image]" value="<?php echo $ecobannerslider_image['image']; ?>" id="input-image<?php echo $image_row; ?>" /></td>
                
                <td class="text-right">
                  <?php foreach ($languages as $language) {?>
                <div class="input-group pull-left">
                <span class="input-group-addon">
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> 
                </span>
            
                  <textarea name="ecobannerslider_image[<?php echo $image_row; ?>][ecobannerslider_image_description][<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" class="form-control"><?php echo isset($ecobannerslider_image['ecobannerslider_image_description'][$language['language_id']]) ? $ecobannerslider_image['ecobannerslider_image_description'][$language['language_id']]['description'] : ''; ?></textarea>
                </div>
                  <?php } ?>
                </td>
                <td class="text-left"><button type="button" onclick="$('#image-row<?php echo $image_row; ?>, .tooltip').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
              </tr>
              <?php $image_row++; ?>
              <?php } }?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="4"></td>
                <td class="text-left"><button type="button" onclick="addImage();" data-toggle="tooltip" title="<?php echo $button_ecobannerslider_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
  html  = '<tr id="image-row' + image_row + '">';
    html += '  <td class="text-left">';
  <?php foreach ($languages as $language) { ?>
  html += '    <div class="input-group">';
  html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="ecobannerslider_image[' + image_row + '][ecobannerslider_image_title][<?php echo $language['language_id']; ?>][title]" value="" placeholder="<?php echo $entry_title; ?>" class="form-control" />';
    html += '    </div>';
  <?php } ?>
  html += '  </td>';  
  html += '  <td class="text-left"><input type="text" name="ecobannerslider_image[' + image_row + '][link]" value="" placeholder="<?php echo $entry_link; ?>" class="form-control" /></td>'; 
  html += '  <td class="text-left"><a href="" id="thumb-image' + image_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="ecobannerslider_image[' + image_row + '][image]" value="" id="input-image' + image_row + '" /></td>';
  html += '  <td class="text-left">';
  <?php foreach ($languages as $language) { ?>
    html += '    <div class="input-group">';
   html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><textarea type="text" name="ecobannerslider_image[' + image_row + '][ecobannerslider_image_description][<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" class="form-control"></textarea>';
    html += '    </div>';
  <?php }?>
    html += '  </td>';  
  html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + image_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
  html += '</tr>';
  
  $('#images tbody').append(html);
  
  image_row++;
}
//--></script></div>
<?php echo $footer; ?>