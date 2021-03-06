<div class="zo2-row sortable-row clearfix"
     data-zo2-type="row"
     data-zo2-customClass="<?php echo $row->customClass; ?>"
     data-zo2-background="<?php echo $row->background; ?>"
     data-zo2-id="<?php echo $row->id; ?>"
     data-zo2-visibility-xs="<?php echo $row->visibility->xs ? 1 : 0 ?>"
     data-zo2-visibility-sm="<?php echo $row->visibility->sm ? 1 : 0 ?>"
     data-zo2-visibility-md="<?php echo $row->visibility->md ? 1 : 0 ?>"
     data-zo2-visibility-lg="<?php echo $row->visibility->lg ? 1 : 0 ?>"
     data-zo2-fullwidth="<?php echo $row->fullwidth ? 1 : 0 ?>"
        >
    <div class="col-md-12 row-control">
        <div class="row-control-container dragger clearfix">
            <div class="row-name"><?php echo $row->name; ?></div>
            <div class="row-control-buttons">
                <i title="Drag row" class="fa fa-arrows row-control-icon dragger hasTooltip"></i>
                <i title="Row's settings" class="fa fa-cog row-control-icon settings hasTooltip"></i>
                <i title="Add new col" class="row-control-icon add-column fa fa-columns hasTooltip"></i>
                <i title="Remove row" class="row-control-icon delete fa fa-remove hasTooltip"></i>
            </div>
        </div>

        <div class="col-container zo2-row">
            <?php
            $columns = $row->children;
            if (count($columns) > 0)
            foreach ($columns as $column) {
            require 'layout_column.tpl';
            }
            ?>
        </div>
    </div>
</div>