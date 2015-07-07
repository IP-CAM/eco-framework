<?php 

$objlang = $this->registry->get('language');
?>

<?php if( !isset($rows) ): ?>
<div id="eco-layoutbuilder<?php echo rand(1,90000); ?>" class="clearfix">
<?php $rows = $layouts; ?>
<?php endif; ?>

<?php foreach ( $rows as $row) : ?>
	    <?php if ( $row->level==1 ){	 ?>
	        <div class="eco-container">
	        	<div class="eco-inner">
	    <?php } ?>  
	    <div class="row row-level-<?php echo $row->level; ?> ">
            <div class="row-inner clearfix" >
                <?php foreach( $row->children as $col ) : ?>
                    <div class="col-lg-<?php echo $col->span;?> col-md-<?php echo $col->span;?> col-sm-12 col-xs-12 ">
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

