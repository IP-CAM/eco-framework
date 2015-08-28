<?php
class eco_ControllerProductProduct extends ControllerProductProduct {

    public function index() {
    $this->document->addScript('catalog/view/theme/eco/js/jquery.elevateZoom.js');
        //$this->document->addScript('catalog/view/theme/eco/stylesheet/cloud-zoom.css');
    $this->document->addScript('catalog/view/theme/eco/js/jquery.flexslider.js');
    $this->document->addStyle('catalog/view/theme/eco/stylesheet/flexslider.css');

    $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
    $this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
    // call parent method
    return parent::index();
}
} 