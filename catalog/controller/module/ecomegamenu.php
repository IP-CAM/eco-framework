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

	public function index() {

		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		$this->load->model( 'menu/ecomegamenu' );
		
		$this->language->load('module/ecomegamenu');

		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/megamenu.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/megamenu.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/megamenu.css');
		}

		$this->load->model('setting/setting');
		$params = $this->model_setting_setting->getSetting( 'ecomegamenu_params' );

		 
		if( isset($params['ecomegamenu_params']) && !empty($params['ecomegamenu_params']) ){
	 		$params = json_decode( $params['ecomegamenu_params'] );
	 	}
		
		//get store
		$store_id = $this->config->get('config_store_id');
		$data['store_id'] = $store_id;

		$parent = '1';
		$data['treemenu'] = $this->model_menu_ecomegamenu->getTree( $parent, true, $params, $store_id);

        if($data['treemenu'] == '') return '';
			
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ecomegamenu.tpl')) {
			$template = $this->config->get('config_template') . '/template/module/ecomegamenu.tpl';
		} else {
			$template = 'default/template/module/ecomegamenu.tpl';
		}
		return $this->load->view($template, $data);
	}


}
?>