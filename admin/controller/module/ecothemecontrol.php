<?php
class ControllerModuleEcothemecontrol extends Controller {
	private $error = array(); 
	private $moduleName = 'ecothemecontrol';
	public function tabModules() {
		$data['elayout_default'] = 1;
		if( isset($this->request->get['elayout_id']) ){
			$data['elayout_default'] = $this->request->get['elayout_id'];	
		}
		$data['layout_modules'] = $this->getModules( $data['elayout_default'] );
	}
	
	public function getModules( $layout_id ){
		
		$this->load->model('ecotheme/ecothemecontrol');
		$extensions = $this->model_ecotheme_ecothemecontrol->getExtensions('module');		
		$module_data = array();
		foreach ($extensions as $extension) {
			$modules = $this->config->get($extension['code'] . '_module');
			$this->language->load('module/'.$extension['code']);	
			if ($modules) {
				foreach ($modules as $index => $module) {  
					if( $module['layout_id'] == $layout_id || $module['layout_id'] == 9999){
						$module_data[$module['position']][] = array(
							'title'      => ($this->language->get('heading_title')),
							'code'       => $extension['code'],
							'setting'    => $module,
							'sort_order' => $module['sort_order'],
							'status'     => $module['status'],
							'index'      => $index
						);				
					}
				}
			}
		}
		foreach( $module_data as $position => $modules ){
			$sort_order = array(); 
			foreach ($modules as $key => $value) {
			
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $module_data[$position]);
		}
		return $module_data;
		
		//
	}
	
	public function getLang( $key ){
		return $this->language->get( $key ); 
	}
	
	public function ajaxsave(){
		$this->load->model('setting/setting');
		if( isset($this->request->post['modules']) ){
			$modules = $this->request->post['modules'];
			
			foreach( $modules  as $position => $mods ){	
				echo $position."<br>";
				foreach( $mods as $index => $module ){
					$tmp = explode("-",$module);
					if( count($tmp)== 2 ){
						$code = $tmp[0];
						$modindex = $tmp[1];
						$data = array();
						$dbmods = $this->config->get( $code  . '_module');
						if( is_array($dbmods ) ) {
						
							foreach( $dbmods as $dbidx => $dbmod ){
								
								if( $dbidx == $modindex ){
									$dbmod['position'] = $position;
									$dbmod['sort_order'] = $index+1;
									$dbmods[$dbidx] = $dbmod ;
									break;
								}
							}
							$data = $this->model_setting_setting->getSetting( $code );
							if(  is_array($data) ){
								$data[$code."_module"] = $dbmods;
								$this->model_setting_setting->editSetting( $code, $data );	 
							}
						}
					}
				}
			}
		}
	}
	
	public function index() {   
		$this->language->load('module/ecothemecontrol');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('ecothemecontrol', $this->request->post);	

			$this->cache->delete('ecothemecontrol');
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('module/ecothemecontrol', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_browse'] = $this->language->get('text_browse');
        $data['text_clear'] = $this->language->get('text_clear');
        $data['text_image_manager'] = $this->language->get('text_image_manager');
		
		$data['text_list'] = $this->language->get('text_list');
        $data['text_grid'] = $this->language->get('text_grid');
		$data['text_menu_default'] = $this->language->get('text_menu_default');
        $data['text_menu_mega'] = $this->language->get('text_menu_mega');
		$data['text_extra'] = $this->language->get('text_extra');
        $data['text_large'] = $this->language->get('text_large');
		$data['text_medium1'] = $this->language->get('text_medium1');
        $data['text_medium2'] = $this->language->get('text_medium2');
		$data['text_small'] = $this->language->get('text_small');
		$data['text_custom'] = $this->language->get('text_custom');
		$data['text_upload_image'] = $this->language->get('text_upload_image');
		$data['text_repeat'] = $this->language->get('text_repeat');
		$data['text_no_repeat'] = $this->language->get('text_no_repeat');
		$data['text_repeat_x'] = $this->language->get('text_repeat_x');
		$data['text_repeat_y'] = $this->language->get('text_repeat_y');
		$data['text_left_top'] = $this->language->get('text_left_top');
		$data['text_right_top'] = $this->language->get('text_right_top');
		$data['text_center_top'] = $this->language->get('text_center_top');
		$data['text_center_center'] = $this->language->get('text_center_center');
		$data['text_color'] = $this->language->get('text_color');
		$data['text_link_color'] = $this->language->get('text_link_color');
		$data['text_normal'] = $this->language->get('text_normal');
		$data['text_hover'] = $this->language->get('text_hover');
		$data['text_border_color'] = $this->language->get('text_border_color');
		$data['text_color_g_1'] = $this->language->get('text_color_g_1');
		$data['text_color_g_2'] = $this->language->get('text_color_g_2');
		$data['text_color_g_3'] = $this->language->get('text_color_g_3');
		$data['text_color_h_1'] = $this->language->get('text_color_h_1');
		$data['text_color_h_2'] = $this->language->get('text_color_h_2');
		$data['text_color_h_3'] = $this->language->get('text_color_h_3');
		$data['text_color_f_1'] = $this->language->get('text_color_f_1');
		$data['text_color_f_2'] = $this->language->get('text_color_f_2');
		$data['text_color_f_3'] = $this->language->get('text_color_f_3');
		$data['text_color_m_1'] = $this->language->get('text_color_m_1');
		$data['text_color_m_2'] = $this->language->get('text_color_m_2');
		$data['text_button_color'] = $this->language->get('text_button_color');
		$data['text_color_s_1'] = $this->language->get('text_color_s_1');
		$data['text_color_s_2'] = $this->language->get('text_color_s_2');
		$data['text_color_s_3'] = $this->language->get('text_color_s_3');
		$data['text_reset'] = $this->language->get('text_reset');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_font_style'] = $this->language->get('text_font_style');
		$data['text_font_size'] = $this->language->get('text_font_size');
		$data['text_font_weight'] = $this->language->get('text_font_weight');
		$data['text_transform'] = $this->language->get('text_transform');
		$data['text_test'] = $this->language->get('text_test');
		
		//entry
		$data['entry_show'] = $this->language->get('entry_show');
		$data['entry_modecss'] = $this->language->get('entry_modecss');
		$data['entry_modecss_set'] = $this->language->get('entry_modecss_set');
        $data['entry_box'] = $this->language->get('entry_box');
        $data['entry_wide'] = $this->language->get('entry_wide');
		$data['entry_respon_set'] = $this->language->get('entry_respon_set');
        $data['entry_respon_allow'] = $this->language->get('entry_respon_allow');
		$data['entry_product_set'] = $this->language->get('entry_product_set');
        $data['entry_product_allow'] = $this->language->get('entry_product_allow');
		$data['entry_menu_set'] = $this->language->get('entry_menu_set');
        $data['entry_menu_allow'] = $this->language->get('entry_menu_allow');
		$data['entry_layout_set'] = $this->language->get('entry_layout_set');
        $data['entry_product_view'] = $this->language->get('entry_product_view');
		$data['entry_template_set'] = $this->language->get('entry_template_set');
        $data['entry_template'] = $this->language->get('entry_template');
		$data['entry_g_color'] = $this->language->get('entry_g_color');
		$data['entry_back_color'] = $this->language->get('entry_back_color');
        $data['entry_back_image'] = $this->language->get('entry_back_image');
		$data['entry_repeat'] = $this->language->get('entry_repeat');
		$data['entry_position_image'] = $this->language->get('entry_position_image');
		$data['entry_h_color'] = $this->language->get('entry_h_color');
		$data['entry_f_color'] = $this->language->get('entry_f_color');
		$data['entry_m_color'] = $this->language->get('entry_m_color');
		$data['entry_back_color_drop'] = $this->language->get('entry_back_color_drop');
		$data['entry_back_image_drop'] = $this->language->get('entry_back_image_drop');
		$data['entry_s_color'] = $this->language->get('entry_s_color');
		$data['entry_p_color'] = $this->language->get('entry_p_color');
		$data['entry_p_name_color'] = $this->language->get('entry_p_name_color');
		$data['entry_p_des_color'] = $this->language->get('entry_p_des_color');
		$data['entry_p_price_color'] = $this->language->get('entry_p_price_color');
		$data['entry_p_text_price_color'] = $this->language->get('entry_p_text_price_color');
		$data['entry_p_spec_price_color'] = $this->language->get('entry_p_spec_price_color');
		$data['entry_p_text_spec_price_color'] = $this->language->get('entry_p_text_spec_price_color');
		$data['entry_p_button_color'] = $this->language->get('entry_p_button_color');
		$data['entry_p_text_button_color'] = $this->language->get('entry_p_text_button_color');
		$data['entry_t_color'] = $this->language->get('entry_t_color');
		$data['entry_t_page_color'] = $this->language->get('entry_t_page_color');
		$data['entry_t_block_color'] = $this->language->get('entry_t_block_color');
		$data['entry_t_bread_color'] = $this->language->get('entry_t_bread_color');
		$data['entry_t_bread_1_color'] = $this->language->get('entry_t_bread_1_color');
		$data['entry_t_bread_2_color'] = $this->language->get('entry_t_bread_2_color');
		$data['entry_g_font'] = $this->language->get('entry_g_font');
		$data['entry_h_font'] = $this->language->get('entry_h_font');
		$data['entry_h_font_1'] = $this->language->get('entry_h_font_1');
		$data['entry_h_font_2'] = $this->language->get('entry_h_font_2');
		$data['entry_f_font'] = $this->language->get('entry_f_font');
		$data['entry_f_font_1'] = $this->language->get('entry_f_font_1');
		$data['entry_f_font_2'] = $this->language->get('entry_f_font_2');
		$data['entry_m_font'] = $this->language->get('entry_m_font');
		$data['entry_m_font_1'] = $this->language->get('entry_m_font_1');
		$data['entry_m_font_2'] = $this->language->get('entry_m_font_2');
		$data['entry_s_font'] = $this->language->get('entry_s_font');
		$data['entry_s_font_1'] = $this->language->get('entry_s_font_1');
		$data['entry_s_font_2'] = $this->language->get('entry_s_font_2');
		$data['entry_p_font'] = $this->language->get('entry_p_font');
		$data['entry_p_font_name'] = $this->language->get('entry_p_font_name');
		$data['entry_p_font_des'] = $this->language->get('entry_p_font_des');
		$data['entry_p_font_price'] = $this->language->get('entry_p_font_price');
		$data['entry_p_font_cart'] = $this->language->get('entry_p_font_cart');
		$data['entry_t_font'] = $this->language->get('entry_t_font');
		$data['entry_t_font_page'] = $this->language->get('entry_t_font_page');
		$data['entry_t_font_block'] = $this->language->get('entry_t_font_block');
		$data['entry_t_font_bread'] = $this->language->get('entry_t_font_bread');
		$data['entry_custom_css'] = $this->language->get('entry_custom_css');
		$data['entry_custom_java'] = $this->language->get('entry_custom_java');
		
		//tab
		$data['tab_setting'] = $this->language->get('tab_setting');
		$data['tab_font'] = $this->language->get('tab_font');
		$data['tab_css'] = $this->language->get('tab_css');
		$data['tab_custom_css'] = $this->language->get('tab_custom_css');
		$data['tab_custom_java'] = $this->language->get('tab_custom_java');
		$data['tab_color'] = $this->language->get('tab_color');
		$data['tab_g_setting'] = $this->language->get('tab_g_setting');
		$data['tab_g_layout'] = $this->language->get('tab_g_layout');
		$data['tab_general_color'] = $this->language->get('tab_general_color');
		$data['tab_header_color'] = $this->language->get('tab_header_color');
		$data['tab_footer_color'] = $this->language->get('tab_footer_color');
		$data['tab_menu_color'] = $this->language->get('tab_menu_color');
		$data['tab_slide_color'] = $this->language->get('tab_slide_color');
		$data['tab_product_color'] = $this->language->get('tab_product_color');
		$data['tab_title_color'] = $this->language->get('tab_title_color');
		$data['tab_general_font'] = $this->language->get('tab_general_font');
		$data['tab_header_font'] = $this->language->get('tab_header_font');
		$data['tab_footer_font'] = $this->language->get('tab_footer_font');
		$data['tab_menu_font'] = $this->language->get('tab_menu_font');
		$data['tab_slide_font'] = $this->language->get('tab_slide_font');
		$data['tab_product_font'] = $this->language->get('tab_product_font');
		$data['tab_title_font'] = $this->language->get('tab_title_font');
		$data['tab_layout'] = $this->language->get('tab_layout');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/ecothemecontrol', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['module'] = array(
						'block_footer_top'=>'',
						'block_footer_center' => '',
						'block_footer_bottom'=>''					
		);
		
		$data['action'] = $this->url->link('module/ecothemecontrol', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['ajax_modules_position'] = $this->url->link('module/'.$this->moduleName."/ajaxsave", 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->load->model('ecotheme/ecothemecontrol');
		
		$data['bg_images'] = $this->model_ecotheme_ecothemecontrol->getBackgrounds();
		
		$data['temp_setting_arr'] = $this->model_ecotheme_ecothemecontrol->getColorThemes();
        
        $data['temp_name_arr'] = $this->model_ecotheme_ecothemecontrol->getThemeNames();
        
        $colors_data = $data['temp_setting_arr'];
        
        $data['colors_data'] = json_encode($colors_data);
		
		$this->load->model('tool/image');
		
		$data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 50, 50);
		
		$data['b_Color_Data'] = array();
		
		if (isset($this->request->post['b_Color_Data'])) {
            $b_Color_Data = $this->request->post['b_Color_Data'];
		} elseif ($this->config->get('b_Color_Data')) { 
            $b_Color_Data = $this->config->get('b_Color_Data');
		} else{
			$b_Color_Data = '';
		}
		
		$data['b_Color_Data'] = $b_Color_Data;
		
		$data['b_Font_Data'] = array();
		
		if (isset($this->request->post['b_Font_Data'])) {
            $b_Font_Data = $this->request->post['b_Font_Data'];
		} elseif ($this->config->get('b_Font_Data')) { 
            $b_Font_Data = $this->config->get('b_Font_Data');
		} else{
			$b_Font_Data = '';
		}
		
		$data['b_Font_Data'] = $b_Font_Data;
		
		$data['b_Setting'] = array();
		
		if (isset($this->request->post['b_Setting'])) {
            $b_Setting = $this->request->post['b_Setting'];
		} elseif ($this->config->get('b_Setting')) { 
            $b_Setting = $this->config->get('b_Setting');
		} else{
			$b_Setting = '';
		}
		
		$data['b_Setting'] = $b_Setting;
		
		$data['customcode'] = array();
		
		if (isset($this->request->post['customcode'])) {
            $customcode = $this->request->post['customcode'];
		} elseif ($this->config->get('customcode')) { 
            $customcode = $this->config->get('customcode');
		} else{
			$customcode = '';
		}
		
		$data['customcode'] = $customcode;
		
		if (isset($this->request->post['b_General_Show'])) {
			$data['b_General_Show'] = $this->request->post['b_General_Show'];
		} else {
			$data['b_General_Show'] = $this->config->get('b_General_Show');
		}
		
		if (isset($this->request->post['b_Mode_CSS'])) {
			$data['b_Mode_CSS'] = $this->request->post['b_Mode_CSS'];
		} else {
			$data['b_Mode_CSS'] = $this->config->get('b_Mode_CSS');
		}
		
		if (isset($this->request->post['b_General_Respon'])) {
			$data['b_General_Respon'] = $this->request->post['b_General_Respon'];
		} else {
			$data['b_General_Respon'] = $this->config->get('b_General_Respon');
		}
		
		if (isset($this->request->post['b_General_P_Display'])) {
			$data['b_General_P_Display'] = $this->request->post['b_General_P_Display'];
		} else {
			$data['b_General_P_Display'] = $this->config->get('b_General_P_Display');
		}
		
		if (isset($this->request->post['b_General_Menu'])) {
			$data['b_General_Menu'] = $this->request->post['b_General_Menu'];
		} else {
			$data['b_General_Menu'] = $this->config->get('b_General_Menu');
		}
		
		if (isset($this->request->post['b_Layout_Setting'])) {
			$data['b_Layout_Setting'] = $this->request->post['b_Layout_Setting'];
		} else {
			$data['b_Layout_Setting'] = $this->config->get('b_Layout_Setting');
		}
		
		if (isset($this->request->post['b_Layout_Setting'])) {
			$b_Layout_Settings = explode(',', $this->request->post['b_Layout_Setting']);
		} else {		
			$b_Layout_Settings = explode(',', $this->config->get('b_Layout_Setting'));
		}
		
		$data['modules'] = array();
		
		if (isset($this->request->post['ecothemecontrol_module'])) {
			$data['modules'] = $this->request->post['ecothemecontrol_module'];
		} elseif ($this->config->get('ecothemecontrol_module')) { 
			$data['modules'] = $this->config->get('ecothemecontrol_module');
		}	
		
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		$this->tabModules();
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
						
		$this->template = 'module/ecothemecontrol/ecothemecontrol.tpl';

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view($this->template, $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/ecothemecontrol')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function install() {
        $data = array(
            'b_General_Respon'  =>1,
			'b_General_Show'  => 1,
            'b_General_P_Display'   =>'grid',
            'b_General_Menu'  =>1,
			'b_Mode_CSS' => 'boxed',
			'b_Layout_Setting' => '25,100-75-50,25-33-50',
            'b_Setting'   => Array ('temp_setting' => 'custom' ),
			'b_Color_Data' => Array (
				'g_bg_image' => 'default',
				'g_upload_bg_image' => '',
				'g_bg_image_repeat' => 'repeat',
				'g_bg_image_position' => 'left top',
				'h_bg_image' => 'default',
				'h_upload_bg_image' =>'',
				'h_bg_image_repeat' => 'repeat',
				'h_bg_image_position' => 'left top',
				'f_bg_image' => 'default',
				'f_upload_bg_image' => '',
				'f_bg_image_repeat' => 'repeat',
				'f_bg_image_position' => 'left top',
				'm_bg_image' => 'default',
				'm_upload_bg_image' => '',
				'm_bg_image_repeat' => 'repeat',
				'm_bg_image_position' => 'left top',
				'mdrop_bg_image' => 'default',
				'mdrop_upload_bg_image' => '',
				'mdrop_bg_image_repeat' => 'repeat',
				'mdrop_bg_image_position' => 'left top',
				's_bg_image' => 'default',
				's_upload_bg_image' => '',
				's_bg_image_repeat' => 'repeat',
				's_bg_image_position' => 'left top' ),
				'ecothemecontrol_module' => array(0 => array ('layout_id' => 9999, 'position' => 'footer', 'status' => 1, 'sort_order' => 0))
        );
        
        $this->load->model('setting/setting');
        
        $this->model_setting_setting->editSetting('ecothemecontrol', $data);
 	}
}
?>