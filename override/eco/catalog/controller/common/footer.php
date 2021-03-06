<?php
class eco_ControllerCommonFooter extends ControllerCommonFooter {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/common/footer.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables
        $this->load->language( 'common/footer' );
        $data['text_contact_us'] = $this->language->get( 'text_contact_us' );
        $data['text_newsletter_info'] = $this->language->get( 'text_newsletter_info' );
        $data['home'] = $this->url->link('common/home');

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


        $this->load->model('setting/setting');
        $aThemeSettings = $this->model_setting_setting->getSetting('ecothemecontrol',0);
        if(isset($aThemeSettings['ecothemecontrol'])){
            $part = explode('.', $aThemeSettings['ecothemecontrol']['layout_module']);
        }

        if (isset($part[1])) {
            $setting_info = $this->model_extension_module->getModule($part[1]);

            if ($setting_info) {
                $data['layout_footer'] = $this->load->controller('module/' . $part[0], $setting_info);
            }
        }
        else
        {
            $data['layout_footer'] = "";
        }


        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
}