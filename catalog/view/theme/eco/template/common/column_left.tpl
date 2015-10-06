<?php if ($modules) { ?>
<column id="column-left" class="sidebar sidebar-left col-sm-3 hidden-xs">
    <div class="sidebar-inner">
          <?php foreach ($modules as $module) { ?>
          <?php echo $module; ?>
          <?php } ?>
    </div>
</column>
<?php } ?>