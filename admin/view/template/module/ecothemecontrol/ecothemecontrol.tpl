<?php echo $header; ?>
<?php global $config;?>
<!-- <script type="text/javascript" src="view/javascript/colorpicker/colorpicker-color.js"></script>
<script type="text/javascript" src="view/javascript/colorpicker/colorpicker.js"></script> -->
<link rel="stylesheet" href="view/javascript/colorpicker/bootstrap-3.0.0.min.css">
<link rel="stylesheet" type="text/css" href="view/javascript/colorpicker/css/colorpicker.css" />
<script type="text/javascript" src="view/javascript/colorpicker/js/colorpicker.js"></script>


<?php echo $column_left; ?>
<div id="content">
<div class="page-header">
    <div class="container-fluid">
        <div class="pull-right">
            <button type="submit" form="form-eco" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
</div>
<div class="panel-body">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-eco" class="form-horizontal">


<ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
    <li class="active"><a href="#general" data-toggle="tab">General</a></li>
    <li><a href="#colors" data-toggle="tab">Colors</a></li>
    <li><a href="#fonts" data-toggle="tab">Fonts</a></li>
</ul>
<div id="my-tab-content" class="tab-content">
<div class="tab-pane active" id="general">
<br>
<b class="heading">GENERAL THEME SETTINGS</b><hr>


<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_home_option">Home option in menu:</label>
    <div class="col-sm-10">
        <select name="eco_home_option" id="input-eco_home_option" class="form-control">
            <?php if ($eco_home_option) { ?>
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
    <label class="col-sm-2 control-label" for="input-eco_quickview_button">Product's Quick View:</label>
    <div class="col-sm-10">
        <select name="eco_quickview_button" id="input-eco_quickview_button" class="form-control">
            <?php if ($eco_quickview_button) { ?>
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
    <label class="col-sm-2 control-label" for="input-eco_scroll_totop">Show scroll to top button:</label>
    <div class="col-sm-10">
        <select name="eco_scroll_totop" id="input-eco_scroll_totop" class="form-control">
            <?php if ($eco_scroll_totop) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
</div>

</div>
<div class="tab-pane" id="colors">
<br>
<b class="heading">THEME COLORS</b><br>
In this section, you can change theme colors. To change the color of element just click inside text field and use color picker.

<hr><b class="thead">MAIN</b><hr>

<?php if(empty($eco_body_bg)) { $eco_body_bg="#FFFFFF"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_body_bg">Body background:</label>
    <div class="col-sm-2">
        <select name="eco_body_bg_ed" id="input-eco_body_bg_ed" class="form-control">
            <?php if ($eco_body_bg_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_body_bg" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_body_bg; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php if(empty($eco_fontcolor)) { $eco_fontcolor="#333333"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_fontcolor">Body font color:</label>
    <div class="col-sm-2">
        <select name="eco_fontcolor_ed" id="input-eco_fontcolor_ed" class="form-control">
            <?php if ($eco_fontcolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_fontcolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_fontcolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_linkcolor)) { $eco_linkcolor="#333333"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_linkcolor">Link color:</label>
    <div class="col-sm-2">
        <select name="eco_linkcolor_ed" id="input-eco_linkcolor_ed" class="form-control">
            <?php if ($eco_linkcolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_linkcolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_linkcolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_linkhovercolor)) { $eco_linkhovercolor="#da2c2a"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_linkhovercolor">Link hover color:</label>
    <div class="col-sm-2">
        <select name="eco_linkhovercolor_ed" id="input-eco_linkhovercolor_ed" class="form-control">
            <?php if ($eco_linkhovercolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_linkhovercolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_linkhovercolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<hr><b class="thead">HEADER</b><hr>


<?php if(empty($eco_headerbg)) { $eco_headerbg="#000000"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_headerbg">Header background:</label>
    <div class="col-sm-2">
        <select name="eco_headerbg_ed" id="input-eco_headerbg_ed" class="form-control">
            <?php if ($eco_headerbg_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_headerbg" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_headerbg; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php if(empty($eco_headerlinkcolor)) { $eco_headerlinkcolor="#aaaaaa"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_headerlinkcolor">Header link color:</label>
    <div class="col-sm-2">
        <select name="eco_headerlinkcolor_ed" id="input-eco_headerlinkcolor_ed" class="form-control">
            <?php if ($eco_headerlinkcolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_headerlinkcolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_headerlinkcolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_headerlinkhovercolor)) { $eco_headerlinkhovercolor="#FFFFFF"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_headerlinkhovercolor">Header link hover color:</label>
    <div class="col-sm-2">
        <select name="eco_headerlinkhovercolor_ed" id="input-eco_headerlinkhovercolor_ed" class="form-control">
            <?php if ($eco_headerlinkhovercolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_headerlinkhovercolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_headerlinkhovercolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php /* ?>
<?php if(empty($eco_headerclcolor)) { $eco_headerclcolor="#BED6E2"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_headerclcolor">Header currency/language links color:</label>
    <div class="col-sm-2">
        <select name="eco_headerclcolor_ed" id="input-eco_headerclcolor_ed" class="form-control">
            <?php if ($eco_headerclcolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_headerclcolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_headerclcolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>
<?php */ ?>
<hr><b class="thead">MAIN MENU</b><hr>


<?php if(empty($eco_mmbgcolor)) { $eco_mmbgcolor="#000000"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_mmbgcolor">Main menu background color:</label>
    <div class="col-sm-2">
        <select name="eco_mmbgcolor_ed" id="input-eco_mmbgcolor_ed" class="form-control">
            <?php if ($eco_mmbgcolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_mmbgcolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_mmbgcolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_mmlinkscolor)) { $eco_mmlinkscolor="#FFFFFF"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_mmlinkscolor">Main menu links color:</label>
    <div class="col-sm-2">
        <select name="eco_mmlinkscolor_ed" id="input-eco_mmlinkscolor_ed" class="form-control">
            <?php if ($eco_mmlinkscolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_mmlinkscolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_mmlinkscolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_mmlinkshovercolor)) { $eco_mmlinkshovercolor="#ffffff"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_mmlinkshovercolor">Main menu links Hover color:</label>
    <div class="col-sm-2">
        <select name="eco_mmlinkshovercolor_ed" id="input-eco_mmlinkshovercolor_ed" class="form-control">
            <?php if ($eco_mmlinkshovercolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_mmlinkshovercolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_mmlinkshovercolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_mmslinkscolor)) { $eco_mmslinkscolor="#000000"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_mmslinkscolor">Main menu sublinks color:</label>
    <div class="col-sm-2">
        <select name="eco_mmslinkscolor_ed" id="input-eco_mmslinkscolor_ed" class="form-control">
            <?php if ($eco_mmslinkscolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_mmslinkscolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_mmslinkscolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php if(empty($eco_mmslinkshovercolor)) { $eco_mmslinkshovercolor="#000000"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_mmslinkshovercolor">Main menu sublinks Hover color:</label>
    <div class="col-sm-2">
        <select name="eco_mmslinkshovercolor_ed" id="input-eco_mmslinkshovercolor_ed" class="form-control">
            <?php if ($eco_mmslinkshovercolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_mmslinkshovercolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_mmslinkshovercolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<hr><b class="thead">BUTTONS</b><hr>


<?php if(empty($eco_buttoncolor)) { $eco_buttoncolor="#dddddd"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_buttoncolor">Button color:</label>
    <div class="col-sm-2">
        <select name="eco_buttoncolor_ed" id="input-eco_buttoncolor_ed" class="form-control">
            <?php if ($eco_buttoncolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_buttoncolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_buttoncolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php if(empty($eco_buttonhovercolor)) { $eco_buttonhovercolor="#da2c2a"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_buttonhovercolor">Button Hover color:</label>
    <div class="col-sm-2">
        <select name="eco_buttonhovercolor_ed" id="input-eco_buttonhovercolor_ed" class="form-control">
            <?php if ($eco_buttonhovercolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_buttonhovercolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_buttonhovercolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<hr><b class="thead">PRODUCT</b><hr>


<?php if(empty($eco_pricecolor)) { $eco_pricecolor="#FF0000"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_pricecolor">Price color:</label>
    <div class="col-sm-2">
        <select name="eco_pricecolor_ed" id="input-eco_pricecolor_ed" class="form-control">
            <?php if ($eco_pricecolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_pricecolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_pricecolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php if(empty($eco_oldpricecolor)) { $eco_oldpricecolor="#777777"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_oldpricecolor">Old Price color:</label>
    <div class="col-sm-2">
        <select name="eco_oldpricecolor_ed" id="input-eco_oldpricecolor_ed" class="form-control">
            <?php if ($eco_oldpricecolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_oldpricecolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_oldpricecolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_newpricecolor)) { $eco_newpricecolor="#FF0000"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_newpricecolor">New Price color:</label>
    <div class="col-sm-2">
        <select name="eco_newpricecolor_ed" id="input-eco_newpricecolor_ed" class="form-control">
            <?php if ($eco_newpricecolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_newpricecolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_newpricecolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<hr><b class="thead">FOOTER</b><hr>


<?php if(empty($eco_footerbg)) { $eco_footerbg="#171717"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_footerbg">Footer background:</label>
    <div class="col-sm-2">
        <select name="eco_footerbg_ed" id="input-eco_footerbg_ed" class="form-control">
            <?php if ($eco_footerbg_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_footerbg" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_footerbg; ?>" class="pick-a-color form-control"/>
    </div>
</div>

<?php if(empty($eco_footerlinkcolor)) { $eco_footerlinkcolor="#aaaaaa"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_footerlinkcolor">Footer links color:</label>
    <div class="col-sm-2">
        <select name="eco_footerlinkcolor_ed" id="input-eco_footerlinkcolor_ed" class="form-control">
            <?php if ($eco_footerlinkcolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_footerlinkcolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_footerlinkcolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_footerlinkhovercolor)) { $eco_footerlinkhovercolor="#FFFFFF"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_footerlinkhovercolor">Footer links hover color:</label>
    <div class="col-sm-2">
        <select name="eco_footerlinkhovercolor_ed" id="input-eco_footerlinkhovercolor_ed" class="form-control">
            <?php if ($eco_footerlinkhovercolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_footerlinkhovercolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_footerlinkhovercolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>


<?php if(empty($eco_powerbycolor)) { $eco_powerbycolor="#ffffff"; }  ?>
<div class="form-group">
    <label class="col-sm-2 control-label" for="input-eco_powerbycolor">Footer powered by text color:</label>
    <div class="col-sm-2">
        <select name="eco_powerbycolor_ed" id="input-eco_powerbycolor_ed" class="form-control">
            <?php if ($eco_powerbycolor_ed) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-1">
        <input name="eco_powerbycolor" cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" value="<?php echo $eco_powerbycolor; ?>" class="pick-a-color form-control"/>
    </div>
</div>



</div>
<div class="tab-pane" id="fonts">
    <br><b>THEME FONTS</b><br>
    Choose font from list
    <hr>


    <div class="form-group">
        <label class="col-sm-2 control-label" for="input-eco_fonttransform">Font transform:</label>
        <div class="col-sm-8">
            <?php $gfonts = "Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Aguafina Script,Aladin,Aldrich,Alegreya,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra SC,Amaranth,Amatic SC,Amethysta,Andada,Andika,Annie Use Your Telescope,Anonymous Pro,Antic,Anton,Arapey,Arbutus,Architects Daughter,Arial,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Bad Script,Balthazar,Bangers,Basic,Baumans,Belgrano,Bentham,Bevan,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambo,Candal,Cantarell,Cardo,Carme,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Coda,Coda Caption,Comfortaa,Comic Sans MS,Coming Soon,Concert One,Condiment,Contrail One,Convergence,Cookie,Copse,Corben,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Crushed,Cuprum,Damion,Dancing Script,Dawning of a New Day,Days One,Delius,Delius Swash Caps,Delius Unicase,Devonshire,Didact Gothic,Diplomata,Diplomata SC,Dorsa,Dr Sugiyama,Droid Sans,Droid Sans Mono,Droid Serif,Duru Sans,Dynalight,EB Garamond,Eater,Electrolize,Emblema One,Engagement,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Federant,Federo,Felipa,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Fredericka the Great,Fresca,Frijole,Fugaz One,Galdeano,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,Give You Glory,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Goudy Bookletter 1911,Gravitas One,Gruppo,Gudea,Habibi,Hammersmith One,Handlee,Herr Von Muellerhoff,Holtwood One SC,Homemade Apple,Homenaje,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Iceberg,Iceland,Inconsolata,Inder,Indie Flower,Inika,Irish Grover,Istok Web,Italianno,Jim Nightshade,Jockey One,Josefin Sans,Josefin Slab,Judson,Julee,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kameron,Kaushan Script,Kelly Slab,Kenia,Knewave,Kotta One,Kranky,Krmicra,Kristi,La Belle Aurore,Lancelot,Lato,League Script,Leckerli One,Lekton,Lemon,Lilita One,Limelight,Linden Hill,Lobster,Lobster Two,Lora,Love Ya Like A Sister,Loved by the King,Luckiest Guy,Lusitana,Lucida Grande,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Marck Script,Marko One,Marmelad,Marvel,Mate,Mate SC,Maven Pro,Meddon,MedievalSharp,Medula One,Megrim,Merienda One,Merriweather,Metamorphous,Metrophobic,Michroma,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Modern Antiqua,Molengo,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Mountains of Christmas,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Muli,Neucha,Neuton,News Cycle,Niconne,Nixie One,Nobile,Norican,Nosifer,Nothing You Could Do,Noticia Text,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,Numans,Nunito,Old Standard TT,Oldenburg,Open Sans,Open Sans Condensed,Orbitron,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Ovo,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Pacifico,Parisienne,Passero One,Passion One,Patrick Hand,Patua One,Paytone One,Permanent Marker,Petrona,Philosopher,Piedra,Pinyon Script,Plaster,Play,Playball,Playfair Display,Podkova,Poller One,Poly,Pompiere,Port Lligat Sans,Port Lligat Slab,Prata,Princess Sofia,Prociono,Puritan,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Qwigley,Radley,Raleway,Rammetto One,Rancho,Rationale,Redressed,Reenie Beanie,Ribeye,Ribeye Marrow,Righteous,Rochester,Rock Salt,Rokkitt,Ropa Sans,Rosario,Rouge Script,Ruda,Ruge Boogie,Ruluko,Ruslan Display,Ruthie,Sail,Salsa,Sancreek,Sansita One,sans-serif,Sarina,Satisfy,Schoolbell,Shadows Into Light,Shanti,Share,Shojumaru,Short Stack,Sigmar One,Signika,Signika Negative,Sirin Stencil,Six Caps,Slackey,Smokum,Smythe,Sniglet,Snippet,Sofia,Sonsie One,Sorts Mill Goudy,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Sue Ellen Francisco,Sunshiney,Supermercado One,Swanky and Moo Moo,Syncopate,Tangerine,Tahoma,Times New Roman,Telex,Tenor Sans,Terminal Dosis,The Girl Next Door,Tienne,Tinos,Titan One,Trade Winds,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,VT323,Varela,Varela Round,Vast Shadow,Vibur,Vidaloka,Viga,Volkhov,Vollkorn,Voltaire,Verdana,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Wellfleet,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada";
      $ecofonts = explode(',', $gfonts);
      ?>

            <select name="eco_fonttransform" id="input-eco_fonttransform" class="form-control">
                <option value="" <?php if ($eco_fonttransform=='') {?>selected<?php } ?>  ></option>
                <?php foreach ($ecofonts as $f ){ ?>
                <option value="<?php echo $f; ?>" <?php if($eco_fonttransform==$f){echo 'selected';} ?>>
                <?php echo $f; ?>
                </option>
                <?php } ?>
            </select>


        </div>

    </div>



</div>

</div>


</form>
</div>
</div>
</div>
</div>


<script type="text/javascript">

    $(document).ready(function () {


        $('input.pick-a-color').each( function(){
            var input = this;
            $(input).attr('readonly','readonly');
            $(input).ColorPicker({
                onChange:function (hsb, hex, rgb) {
                    $(input).css('backgroundColor', '#' + hex);
                    $(input).val( '#' + hex );
                }
            });
        } );

    });

</script>

<?php echo $footer; ?>