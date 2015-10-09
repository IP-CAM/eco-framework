<?php 

$objlang = $this->registry->get('language');
?>

<?php if( !isset($rows) ): ?>
<div id="eco-layoutbuilder<?php echo rand(1,90000); ?>" class="clearfix">
<?php $rows = $layouts; ?>
<?php endif; ?>
<?php foreach ( $rows as $row) : ?>
    <?php
        $r_hidden_class = $container_class ='';
        $r_hidden_class .= ($row->visibility->xs == false) ? "hidden-xs " : "";
        $r_hidden_class .= ($row->visibility->sm == false) ? "hidden-sm " : "";
        $r_hidden_class .= ($row->visibility->md == false) ? "hidden-md " : "";
        $r_hidden_class .= ($row->visibility->lg == false) ? "hidden-lg " : "";
        $background_url = $url.'image/'.$row->background;
    ?>
	    <?php if ( $row->level==1 ){	 ?>
	        <div class="eco-container <?php echo $row->customClass; ?> <?php echo $r_hidden_class; ?>" style="background: url('<?php echo $background_url; ?>') no-repeat fixed center;">
	        	<div class="container">
	    <?php } ?>  
	    <div class="row row-level-<?php echo $row->level; ?> <?php if ( $row->level!=1 ) { echo $row->customClass;  echo $r_hidden_class; }	 ?>">
            <div class="row-inner clearfix" >
                <?php foreach( $row->children as $col ) : ?>
                <?php
                    $hidden_class = '';
                    $hidden_class .= ($col->visibility->xs == false) ? "hidden-xs " : "";
                    $hidden_class .= ($col->visibility->sm == false) ? "hidden-sm " : "";
                    $hidden_class .= ($col->visibility->md == false) ? "hidden-md " : "";
                    $hidden_class .= ($col->visibility->lg == false) ? "hidden-lg " : "";
                 ?>
                    <div class="col-lg-<?php echo $col->span;?> col-md-<?php echo $col->span;?> col-sm-12 col-xs-12 <?php echo $col->customClass; ?> <?php echo $hidden_class; ?>">
                        <div class="col-inner ">
                            <?php if($col->type == 'col'): ?>
                                <?php echo $col->content; ?>
                            <?php endif; ?>
                            <?php if(isset( $col->children )) : ?>
                                <?php
                                    $rows = $col->children;
                                    include(  DIR_TEMPLATE.$template );
                                ?>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endforeach; ?>
	        </div>
        </div>
	    <?php if ($row->level==1 ) { ?>
	            </div>
	        </div>
	    <?php } ?>
<?php endforeach; ?>
<?php if( !isset($rows) ): ?>
</div>
<?php endif; ?>

