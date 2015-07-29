<?php
/******************************************************
 * @package Eco Framework
 * ------------------------------------------------------------------------------
 * @copyright    Copyright (C) 2008-2015 ZooExtension.com. All Rights Reserved.
 * @license      GNU General Public License version 2 or later;
 * @author       ZooExtension.com
 * @email        opencart@cleversoft.co
 *******************************************************/

class ControllerModuleEcomegamenu extends Controller {

	public $data;
	public function index($setting) {
		static $module = 0;
			
		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		$this->load->model( 'menu/ecomegamenu' );
		
		$this->language->load('module/ecomegamenu');
	
		$this->data['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/ecomegamenu/style.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/ecomegamenu/style.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/ecomegamenu/style.css');
		}
		
		if ( !file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/bootstrap.css') ) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/ecomegamenu/css/bootstrap.css');
			$this->document->addScript('catalog/view/theme/default/stylesheet/ecomegamenu/js/bootstrap.js');
		}

 
		$params = $this->config->get( 'params' );
	 	
		$this->load->model('setting/setting');
		$params = $this->model_setting_setting->getSetting( 'ecomegamenu_params' );

		 
		if( isset($params['ecomegamenu_params']) && !empty($params['ecomegamenu_params']) ){
	 		$params = json_decode( $params['ecomegamenu_params'] );
	 	}
		
		//get store
		$store_id = $this->config->get('config_store_id');
		$this->data['store_id'] = $store_id;

		$parent = '1';
		$this->data['treemenu'] = $this->model_menu_ecomegamenu->getTree( $parent, true, $params, $store_id);
 
			
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ecomegamenu.tpl')) {
			$template = $this->config->get('config_template') . '/template/module/ecomegamenu.tpl';
		} else {
			$template = 'default/template/module/ecomegamenu.tpl';
		}
		return $this->load->view($template, $this->data);
	}


}
?>