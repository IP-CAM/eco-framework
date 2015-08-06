<?php
/******************************************************
 * @package Eco Framework
 * ------------------------------------------------------------------------------
 * @copyright    Copyright (C) 2008-2015 ZooExtension.com. All Rights Reserved.
 * @license      GNU General Public License version 2 or later;
 * @author       ZooExtension.com
 * @email        opencart@cleversoft.co
 *******************************************************/
/**
 * class ControllerModuleEcomegamenu
 */
class ControllerModuleEcomegamenu extends Controller {

	/**
	 * @var Array $error.
	 *
	 * @access private 
	 */
	private $error = array(); 

	/**
	 * @var Array $error.
	 *
	 * @access private 
	 */
	private $moduleName = 'pavmegamenu';

	public $mdata;
	/**
	 * Index Action 
	 */
	public function index() {   
		
		$this->language->load('module/ecomegamenu');
		
	
		$this->document->setTitle( strip_tags($this->language->get('heading_title')) );
		$this->document->addStyle('view/stylesheet/ecomegamenu/admin.styles.css');
        $this->document->addStyle('view/stylesheet/ecomegamenu/template.css');

		$this->document->addStyle('view/javascript/jquery/ui/jquery-ui.min.css');
		$this->document->addScript('view/javascript/jquery/ui/jquery-ui.min.js');

		$this->document->addScript('view/javascript/ecomegamenu/admin.megamenu.js');


		$this->load->model('menu/ecomegamenu');

		$this->model_menu_ecomegamenu->install();


        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->language->load('module/ecomegamenu');
            if (!$this->user->hasPermission('modify', 'module/ecomegamenu')) {
                die( $this->language->get('error_permission') );
            }

            $this->load->model('setting/setting');

            if( isset($this->request->post['import_categories']) &&  (string)$this->request->post['import_categories'] != '' ) {
                $this->model_menu_ecomegamenu->importCategories((int)$this->request->post['store_id']);
            } else {
                if( isset($this->request->post['menu_config']) ) {
                    $params = trim(html_entity_decode($this->request->post['menu_config']));

                    $this->model_setting_setting->editSetting('ecomegamenu_params', array('ecomegamenu_params'=> $params) );
                }
            }
        }


        /**  Build data to display on tempalte **/
        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');

        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_banner'] = $this->language->get('entry_banner');
        $data['entry_width'] = $this->language->get('entry_width');
        $data['entry_height'] = $this->language->get('entry_height');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }

        if (isset($this->error['width'])) {
            $data['error_width'] = $this->error['width'];
        } else {
            $data['error_width'] = '';
        }

        if (isset($this->error['height'])) {
            $data['error_height'] = $this->error['height'];
        } else {
            $data['error_height'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
        );

        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('module/carousel', 'token=' . $this->session->data['token'], 'SSL')
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('module/carousel', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
            );
        }

        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('module/ecomegamenu', 'token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link('module/ecomegamenu', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
        }

        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }



        $this->load->model('setting/store');
        $stores = $this->model_setting_store->getStores();
        $store_default = array(
            'store_id' => 0,
            'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
            'url'      => HTTP_CATALOG,
        );
        array_unshift($stores, $store_default);

        foreach ($stores as &$store) {
            $url = '';
            if ($store['store_id'] > 0 ) {
                $url = '&store_id='.$store['store_id'];
            }
            $store['option'] = $this->url->link('module/ecomegamenu', $url.'&token=' . $this->session->data['token'], 'SSL');
        }
        if (isset($this->request->get['store_id'])){
            $store_id = $this->request->get['store_id'];
        } else {
            $store_id = 0;
        }

        $data['store_id'] = $store_id;

        $data['stores'] = $stores;

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');

		$data['entry_banner'] = $this->language->get('entry_banner');
		$data['entry_dimension'] = $this->language->get('entry_dimension'); 
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $data['objlang'] = $this->language;


        // Menu
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $this->load->model('catalog/information');

        $data['categories'] = array();

        $this->load->model('setting/setting');
        $this->load->model('menu/ecomegamenu');
        $params = $this->model_setting_setting->getSetting( 'ecomegamenu_params' );


        if( isset($params['ecomegamenu_params']) && !empty($params['ecomegamenu_params']) ){
            $params = json_decode( $params['ecomegamenu_params'] );
        }

        $data['extensions'] = $this->_modulesInstalled();

        $store_param = isset($this->request->get['store_id'])?'&store_id='.$this->request->get['store_id']:'';

        $data['addmenu'] 	   = $this->url->link('module/ecomegamenu/ajaxmenu', 'root=1'.$store_param.'&token=' . $this->session->data['token'], 'SSL');

        $data['removemenu'] 	   = $this->url->link('module/ecomegamenu/deletemenu', 'root=1'.$store_param.'&token=' . $this->session->data['token'], 'SSL');

        $data['informations'] = $this->model_catalog_information->getInformations();

        $data['token'] = $this->session->data['token'];

        $data['treemenu'] = $this->model_menu_ecomegamenu->getTree( 1, true, $params, $store_id );

        $this->response->setOutput($this->load->view('module/ecomegamenu/ecomegamenu.tpl', $data));
	}

    public function ajaxmenu( ){

        $this->load->model('menu/ecomegamenu');

        $megamenu_id = $this->model_menu_ecomegamenu->insertMenu($this->request->post);

        echo $megamenu_id;
    }

    public function deletemenu( ){

        $this->load->model('menu/ecomegamenu');

        $this->model_menu_ecomegamenu->delete($this->request->post['id'],$this->request->post['store_id']);

        echo '1';
    }
	

	protected function hasPermssion(){
		return $this->user->hasPermission( 'modify', 'module/'.$this->moduleName );	
	}


    public function _modulesInstalled(){
        $this->load->model('extension/extension');
        $this->load->model('extension/module');
        $data['extensions'] = array();

        // Get a list of installed modules
        $extensions = $this->model_extension_extension->getInstalled('module');

        // Add all the modules which have multiple settings for each module
        foreach ($extensions as $code) {
            if( $code =='ecolayoutbuilder'){
                continue;
            }
            $this->load->language('module/' . $code);

            $module_data = array();

            $modules = $this->model_extension_module->getModulesByCode($code);

            foreach ($modules as $module) {
                $module_data[] = array(
                    'name' => strip_tags( $this->language->get('heading_title') ) . ' &gt; ' . $module['name'],
                    'code' => $code . '.' .  $module['module_id'],
                    'id' 	=>  $module['module_id']
                );
            }

            if( $modules  ){
                if ($this->config->has($code . '_status') || $module_data) {
                    $data['extensions'][$code] = array(
                        'name'   => strip_tags( $this->language->get('heading_title') ),
                        'code'   => $code,
                        'module' => $module_data

                    );
                }
            }
        }

        return $data['extensions'];
    }




 	
 	/**
 	 * Check Validation
 	 */
	protected function validate() {
	
		if (!$this->user->hasPermission('modify', 'module/ecomegamenu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}

	public function getLang( $text ){
		return $this->language->get($text);
	}
	

}
?>
