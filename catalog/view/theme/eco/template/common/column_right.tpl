<?php if ($modules) { ?>
<column id="column-right" class="sidebar sidebar-right col-sm-3 hidden-xs">
    <div class="sidebar-inner">
          <?php foreach ($modules as $module) { ?>
          <?php echo $module; ?>
          <?php } ?>
    </div>
</column>
<?php } ?>
