<?php
class eco_ControllerCommonHeader extends ControllerCommonHeader {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/common/header.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables


            $this->load->language( 'common/header' );
            $data['text_welcome'] = $this->language->get( 'text_welcome' );
            $data['text_call'] = $this->language->get( 'text_call' );
            $data['text_menu_home'] = $this->language->get( 'text_menu_home' );


         
       $data['text_welcome'] = sprintf($this->language->get('text_welcome'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
       $data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));
       $data['text_wishlist'] = (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0);

        if (isset($this->request->get['category_id'])) {
        $data['category_id'] = $this->request->get['category_id'];
        } else {
        $data['category_id'] = 0;
        }

       $this->load->model('catalog/category');
       $this->load->model('catalog/product');

            $data['categories1'] = array();

        $categories_1 = $this->model_catalog_category->getCategories(0);
          
          foreach ($categories_1 as $category_1) {
            if($category_1['top']){
             $level_2_data = array();
             
             $categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
             
             foreach ($categories_2 as $category_2) {
                $level_3_data = array();
                
                $categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);
                
                foreach ($categories_3 as $category_3) {
                   $level_3_data[] = array(
                      'name' => $category_3['name'],
                                           'column'   => $category_3['column'] ? $category_3['column'] : 1,
                      'href' => $this->url->link('product/category', 'path=' . $category_1['category_id'] . '_' . $category_2['category_id'] . '_' . $category_3['category_id']),
                      'category_id'=> $category_3['category_id']
                   );
                }
                
                $level_2_data[] = array(
                   'name'     => $category_2['name'],
                   'children' => $level_3_data,
                   'href'     => $this->url->link('product/category', 'path=' . $category_1['category_id'] . '_' . $category_2['category_id']),
                   'category_id'=> $category_2['category_id']   
                );               
             }
             
             $data['categories1'][] = array(
                'name'     => $category_1['name'],
                'children' => $level_2_data,
                'column'   => $category_1['column'] ? $category_1['column'] : 1,
                'href'     => $this->url->link('product/category', 'path=' . $category_1['category_id']),
                'category_id'=> $category_1['category_id']
             );
          } }


              $this->load->model('catalog/product');

    $this->load->model('tool/image');

    $data['products'] = array();

    $results = $this->model_catalog_product->getBestSellerProducts(3);

    if ($results) {
      foreach ($results as $result) {
        if ($result['image']) {
          $image = $this->model_tool_image->resize($result['image'], 166, 200);
        } else {
          $image = $this->model_tool_image->resize('placeholder.png', 166, 200);
        }

        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
          $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
        } else {
          $price = false;
        }

        if ((float)$result['special']) {
          $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
        } else {
          $special = false;
        }

        if ($this->config->get('config_tax')) {
          $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
        } else {
          $tax = false;
        }

        if ($this->config->get('config_review_status')) {
          $rating = $result['rating'];
        } else {
          $rating = false;
        }
        $data['footer'] = $this->load->controller('module/ecomegamenu');
        $data['products'][] = array(
          'product_id'  => $result['product_id'],
          'thumb'       => $image,
          'name'        => $result['name'],
          'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
          'price'       => $price,
          'special'     => $special,
          'tax'         => $tax,
          'rating'      => $rating,
          'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id']),
        );
      }
    }

    
         
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
}