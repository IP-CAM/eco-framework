<div class="widget widget-category">
    <h3 class="widget-title">
        <span><?php echo $heading_title; ?></span>
    </h3>
    <div class="widget-content">
        <ul>
              <?php foreach ($categories as $category) { ?>
                  <?php if ($category['category_id'] == $category_id) { ?>
                        <li class="list-children">
                            <a href="<?php echo $category['href']; ?>" ><?php echo $category['name']; ?></a>

                            <?php if ($category['children']) { ?>
                                <ul class="children">
                                    <?php foreach ($category['children'] as $child) { ?>
                                            <?php if ($child['category_id'] == $child_id) { ?>
                                                <li class="list-item">
                                                    <a href="<?php echo $child['href']; ?>" >&nbsp;&nbsp;&nbsp;<?php echo $child['name']; ?></a>
                                                </li>
                                            <?php }
                                            else { ?>
                                                <li class="list-item">
                                                    <a href="<?php echo $child['href']; ?>" >&nbsp;&nbsp;&nbsp;<?php echo $child['name']; ?></a>
                                                </li>
                                            <?php } ?>
                                    <?php } ?>
                                </ul>
                            <?php } ?>
                        </li>
                  <?php }
                  else { ?>
                        <li class="list-item">
                            <a href="<?php echo $category['href']; ?>" ><?php echo $category['name']; ?></a>
                        </li>
                  <?php } ?>
              <?php } ?>
        </ul>
    </div>
</div>