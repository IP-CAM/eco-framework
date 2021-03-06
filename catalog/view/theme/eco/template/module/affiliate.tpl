<div class="widget widget-affiliate ">
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>
    <ul class="widget-content">
      <?php if (!$logged) { ?>
        <li class="list-item">
            <a href="<?php echo $login; ?>">
                <?php echo $text_login; ?>
            </a>
        </li>
        <li class="list-item">
            <a href="<?php echo $register; ?>">
                <?php echo $text_register; ?>
            </a>
        </li>
        <li class="list-item">
            <a href="<?php echo $forgotten; ?>">
                <?php echo $text_forgotten; ?>
            </a>
        </li>
        <?php } ?>
        <li class="list-item">
            <a href="<?php echo $account; ?>">
              <?php echo $text_account; ?>
            </a>
        </li>
      <?php if ($logged) { ?>
        <li class="list-item">
            <a href="<?php echo $edit; ?>">
              <?php echo $text_edit; ?>
            </a>
        </li>
        <li class="list-item">
            <a href="<?php echo $password; ?>">
                <?php echo $text_password; ?>
            </a>
        </li>
      <?php } ?>
        <li class="list-item">
            <a href="<?php echo $payment; ?>">
              <?php echo $text_payment; ?>
            </a>
        </li>
        <li class="list-item">
            <a href="<?php echo $tracking; ?>">
                <?php echo $text_tracking; ?>
            </a>
        </li>
        <li class="list-item">
            <a href="<?php echo $transaction; ?>">
                <?php echo $text_transaction; ?>
            </a>
        </li>
      <?php if ($logged) { ?>
        <li class="list-item">
            <a href="<?php echo $logout; ?>">
              <?php echo $text_logout; ?>
            </a>
        </li>
      <?php } ?>
    </ul>
</div>
