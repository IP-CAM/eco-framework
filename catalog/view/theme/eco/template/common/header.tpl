<?php
//$megamenu = $this->newAction('module/ecomegamenu');

$setting = $this->newModel('setting/setting');
//$setting = $this->registry->get('model_setting_setting');


$aThemeSettings = $setting->getSetting('ecothemecontrol',0);
$aThemeSettings = $aThemeSettings['ecothemecontrol'];

?>
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css" rel="stylesheet" type="text/css" />


<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
    <link href="catalog/view/javascript/jquery/colorbox/css/colorbox.css" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
    <script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php echo $google_analytics; ?>

    <style type="text/css">
        <?php if($aThemeSettings['eco_fonttransform']!=''){?>
body {font-family:<?php echo $aThemeSettings['eco_fonttransform']; ?>, sans-serif !important ;}
<?php }?>

 /* sale label */
.sale-label {background:<?php $aThemeSettings['eco_sale_labelcolor']; ?>}

/*Main color section */
<?php if($aThemeSettings['eco_body_bg_ed']==1) { ?>
        body {background:<?php echo $aThemeSettings['eco_body_bg']; ?> }
<?php } ?>
 <?php if($aThemeSettings['eco_fontcolor_ed']==1) { ?>
        body {color:<?php echo $aThemeSettings['eco_fontcolor']; ?> }
<?php } ?>
<?php if($aThemeSettings['eco_linkcolor_ed']==1) { ?>
        a,a:visited {color:<?php echo $aThemeSettings['eco_linkcolor']; ?>}
<?php } ?>
<?php if($aThemeSettings['eco_linkhovercolor_ed']==1) { ?>
        a:hover {color:<?php echo $aThemeSettings['eco_linkhovercolor']; ?>}
<?php } ?>


/* header color section */
<?php if($aThemeSettings['eco_headerbg_ed']==1) { ?>
.header-top { background-color: <?php echo $aThemeSettings['eco_headerbg']; ?>;} <?php } ?>
<?php if($aThemeSettings['eco_headerlinkcolor_ed']==1) { ?>
.header-top a,.block-language{color:<?php echo $aThemeSettings['eco_headerlinkcolor']."! important"; ?>;} <?php } ?>
<?php if($aThemeSettings['eco_headerlinkhovercolor_ed']==1) { ?>
.header-top a:hover,.block-language:hover{color:<?php echo $aThemeSettings['eco_headerlinkhovercolor']."! important"; ?>;} <?php } ?>

<?php /* if($aThemeSettings['eco_headerclcolor_ed']==1) { ?>
ul.currencies_list li a{color:<?php echo $aThemeSettings['eco_headerclcolor']."! important"; ?>;} <?php } */ ?>

/*Top Menu */
/*background*/
<?php if($aThemeSettings['eco_mmbgcolor_ed']==1) { ?>
nav#menu { background:<?php echo $aThemeSettings['eco_mmbgcolor']; ?> } <?php } ?>
     /*main menu links*/
 <?php if($aThemeSettings['eco_mmlinkscolor_ed']==1) { ?>
li.level0 > a > span{ color:<?php echo $aThemeSettings['eco_mmlinkscolor']."! important"; ?>; } <?php } ?>
/*main menu link hover*/
<?php if($aThemeSettings['eco_mmlinkshovercolor_ed']==1) { ?>
li.level0 > a > span:hover:nth-child(1), #nav > li > a.active:nth-child(1){color:<?php echo $aThemeSettings['eco_mmlinkshovercolor']."! important"; ?>} <?php } ?>
<?php if($aThemeSettings['eco_mmslinkscolor_ed']==1) { ?>
#nav ul.level0 > li > a{color:<?php echo $aThemeSettings['eco_mmslinkscolor']; ?>} <?php } ?>
/*sub links hover*/
<?php if($aThemeSettings['eco_mmslinkshovercolor_ed']==1) { ?>
#nav ul li a:hover{color:<?php echo $aThemeSettings['eco_mmslinkshovercolor']; ?> } <?php } ?>

/*buttons*/
<?php if($aThemeSettings['eco_buttoncolor_ed']==1) { ?>
button.button,.btn{background-color:<?php echo $aThemeSettings['eco_buttoncolor']."! important"; ?> } <?php } ?>
<?php if($aThemeSettings['eco_buttonhovercolor_ed']==1) { ?>
button.button:hover,.btn:hover{background-color: <?php echo $aThemeSettings['eco_buttonhovercolor']."! important"; ?>} <?php } ?>


/*price*/
<?php if($aThemeSettings['eco_pricecolor_ed']==1) { ?>
.regular-price .price{ color:<?php echo $aThemeSettings['eco_pricecolor']; ?> } <?php } ?>
<?php if($aThemeSettings['eco_oldpricecolor_ed']==1) { ?>
.old-price .price{ color:<?php echo $aThemeSettings['eco_oldpricecolor']."! important"; ?> } <?php } ?>
<?php if($aThemeSettings['eco_newpricecolor_ed']==1) { ?>
.special-price .price{ color:<?php echo $aThemeSettings['eco_newpricecolor']; ?> } <?php } ?>

 /*footer*/
<?php if($aThemeSettings['eco_footerbg_ed']==1) { ?>
footer{background:<?php echo $aThemeSettings['eco_footerbg']; ?> } <?php } ?>
<?php if($aThemeSettings['eco_footerlinkcolor_ed']==1) { ?>
footer li a{color: <?php echo $aThemeSettings['eco_footerlinkcolor']; ?>}
<?php } ?>
<?php if($aThemeSettings['eco_footerlinkhovercolor_ed']==1) { ?>
footer li a:hover{color: <?php echo $aThemeSettings['eco_footerlinkhovercolor']; ?>} <?php } ?>
<?php if($aThemeSettings['eco_powerbycolor_ed']==1) { ?>
footer .coppyright{color: <?php echo $aThemeSettings['eco_powerbycolor']; ?>} <?php } ?>

    </style>

</head>
<body class="<?php echo $class; ?>">
<nav id="top">
  <div class="container">
    <?php echo $currency; ?>
    <?php echo $language; ?>
    <div id="top-links" class="nav pull-right">
      <ul class="list-inline">
        <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone"></i></a> <span class="hidden-xs hidden-sm hidden-md"><?php echo $telephone; ?></span></li>
        <li class="dropdown"><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_account; ?></span> <span class="caret"></span></a>
          <ul class="dropdown-menu dropdown-menu-right">
            <?php if ($logged) { ?>
            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } else { ?>
            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
            <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
            <?php } ?>
          </ul>
        </li>
        <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
        <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_shopping_cart; ?></span></a></li>
        <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_checkout; ?></span></a></li>
      </ul>
    </div>
  </div>
</nav>
<header>
  <div class="container">
    <div class="row">
      <div class="col-sm-4">
        <div id="logo">
          <?php if ($logo) { ?>
          <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
          <?php } else { ?>
          <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
          <?php } ?>
        </div>
      </div>
      <div class="col-sm-5"><?php echo $search; ?>
      </div>
      <div class="col-sm-3"><?php echo $cart; ?></div>
    </div>
  </div>
</header>
<?php if (!empty($megamenu)){ echo $megamenu;?>
<?php } else { ?>
<div class="container">
  <nav id="menu" class="navbar">
    <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
      <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
    </div>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav">
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['children']) { ?>
        <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
          <div class="dropdown-menu">
            <div class="dropdown-inner">
              <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
              <ul class="list-unstyled">
                <?php foreach ($children as $child) { ?>
                <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                <?php } ?>
              </ul>
              <?php } ?>
            </div>
            <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
        </li>
        <?php } else { ?>
        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </nav>
</div>
<?php } ?>
