<?php
class eco_ControllerCommonCart extends ControllerCommonCart {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/common/cart.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables
        $this->load->language( 'common/cart' );
        $data['text_recently_added_items'] = $this->language->get( 'text_recently_added_items' );
        $data['text_items_count'] = sprintf($this->language->get('text_items_count'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0));
            
        
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
}