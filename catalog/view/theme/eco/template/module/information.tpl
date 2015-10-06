<div class="widget widget-information ">
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>

    <div class="widget-content">
        <ul>
            <?php foreach ($informations as $information) { ?>
                <li>
                    <a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a>
                </li>
            <?php } ?>
            <li>
                <a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a>
            </li>

            <li>
                <a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a>
            </li>
        </ul>
    </div>
</div>