<div class="sortable-col col-md-<?php echo $column->span; ?> col-md-offset-<?php echo $column->offset; ?>"
     data-zo2-jdoc=""
     data-zo2-type="span"
     data-zo2-span="<?php echo $column->span; ?>"
     data-zo2-offset="<?php echo $column->offset; ?>"
     data-zo2-position="<?php echo $column->position; ?>"
     data-zo2-customClass="<?php echo $column->customClass; ?>"
     data-zo2-id="<?php echo $column->id; ?>"
     data-zo2-visibility-xs="<?php echo $column->visibility->xs ? 1 : 0 ?>"
     data-zo2-visibility-sm="<?php echo $column->visibility->sm ? 1 : 0 ?>"
     data-zo2-visibility-md="<?php echo $column->visibility->md ? 1 : 0 ?>"
     data-zo2-visibility-lg="<?php echo $column->visibility->lg ? 1 : 0 ?>"
        >
    <div class="col-wrap">
        <div class="col-name"><?php echo $column->name; ?></div>
        <div class="col-grid-button">
            <i title="Column decrease" class="col-grid-icon col-decrease fa fa-minus-square-o"></i>
            <span class="col-size"><?php echo $column->span; ?>/12</span>
            <i title="Column increase" class="col-grid-icon col-increase fa fa-plus-square-o"></i>
        </div>
        <div class="col-control-buttons">
            <i title="Drag column" class="col-control-icon dragger fa fa-arrows hasTooltip"></i>
            <i title="Column's settings" class="fa fa-cog col-control-icon settings hasTooltip" data-toggle="modal"></i>
            <i title="Add new row" class="col-control-icon add-row fa fa-align-justify hasTooltip"></i>
            <i title="Remove column" class="fa fa-remove col-control-icon delete hasTooltip"></i>
        </div>

        <div class="row-container">
            <?php foreach ($column->children as $row) { ?>
            <?php require 'layout_row.tpl'; ?>
            <?php } ?>
        </div>
    </div>
</div>