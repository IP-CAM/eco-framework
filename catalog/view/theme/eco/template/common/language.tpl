<?php if (count($languages) > 1) { ?>
<div class="pull-left languages link">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <div class="btn btn-link dropdown-toggle" data-toggle="dropdown">
        <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_language; ?> : </span>
        <?php foreach ($languages as $language) { ?>
            <?php if ($language['code'] == $code) { ?>
                <strong><?php echo $language['name']; ?></strong>
                <img  class="hidden" src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
                <i class="fa fa-caret-down hidden"></i>
            <?php } ?>
         <?php } ?>
    </div>
    <ul class="dropdown-menu">
      <?php foreach ($languages as $language) { ?>
      <li>
          <a href="<?php echo $language['code']; ?>">
              <?php echo $language['name']; ?>
              <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" />

          </a>
      </li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
