<header id="eco-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="logo" class="text-center">
                    <?php if ($logo) { ?>
                        <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
                    <?php } else { ?>
                        <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
</header>
