<?php if (count($currencies) > 1) { ?>
<div class="pull-left currency link">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
  <div class="btn-group">
    <div class="btn btn-link dropdown-toggle" data-toggle="dropdown">
        <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_currency; ?> : </span>
        <?php foreach ($currencies as $currency) { ?>

            <?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
                <strong><?php echo $currency['code']; ?></strong>
            <?php }
            elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
                <strong><?php echo $currency['code']; ?></strong>
            <?php } ?>
        <?php } ?>
        <i class="fa fa-caret-down hidden"></i>
    </div>
    <ul class="dropdown-menu">
      <?php foreach ($currencies as $currency) { ?>
          <?php if ($currency['symbol_left']) { ?>
              <li>
                  <span class="currency-select" type="button" name="<?php echo $currency['code']; ?>">
                       <?php echo $currency['title']; ?> : <?php echo $currency['symbol_left']; ?>
                  </span>
              </li>
          <?php }
          else { ?>
          <li>
              <span class="currency-select" type="button" name="<?php echo $currency['code']; ?>">
                   <?php echo $currency['title']; ?> : <?php echo $currency['symbol_right']; ?>
              </span>
          </li>
      <?php } ?>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
