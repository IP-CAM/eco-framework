<?php
class eco_ControllerProductProduct extends ControllerProductProduct {

    public function index() {
    $this->document->addScript('catalog/view/theme/eco/js/jquery.elevateZoom-3.0.8.min.js');
    $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
    // call parent method
    return parent::index();
}
}