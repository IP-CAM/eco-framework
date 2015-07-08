<?php
/******************************************************
 * @package Eco Framework
 * ------------------------------------------------------------------------------
 * @copyright    Copyright (C) 2008-2015 ZooExtension.com. All Rights Reserved.
 * @license      GNU General Public License version 2 or later;
 * @author       ZooExtension.com
 * @email        opencart@cleversoft.co
*******************************************************/

class ControllerModuleecolayoutbuilder extends Controller {
	private $error = array();

	public function index() {
        $this->load->language('module/ecolayoutbuilder');

        $this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module');
		$this->load->model('tool/image');
		$this->document->setTitle( strip_tags( $this->language->get('heading_title') ) );
		 
		$this->document->addStyle('view/javascript/jquery/ui/jquery-ui.min.css');
		$this->document->addScript('view/javascript/jquery/ui/jquery-ui.min.js');

		
		$this->document->addScript('view/javascript/ecolayoutbuilder/admin.layoutbuilder.js');

		$this->document->addStyle('view/stylesheet/ecolayoutbuilder/admin.styles.css');
        $this->document->addStyle('view/stylesheet/ecolayoutbuilder/template.css');

		if( isset($this->request->get['module_id']) && isset($this->request->get['delete']) ){
			$this->model_extension_module->deleteModule( $this->request->get['module_id'] );
			$this->response->redirect($this->url->link('module/ecolayoutbuilder', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$action = $this->request->post['action'];
            unset($this->request->post['action']);

            $data = $this->request->post;
            $data['layout'] = htmlspecialchars_decode($data['layout']);
//			if( empty($data['name']) ){
//				$this->error['warning'] = $this->language->get('error_permission');
//				$this->response->redirect($this->url->link('module/ecolayoutbuilder', 'token=' . $this->session->data['token'], 'SSL'));
//			}

		 	if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('ecolayoutbuilder', $data );
			} else {
				$this->model_extension_module->editModule( $this->request->get['module_id'], $data );
			}	
	
 

			$this->session->data['success'] = $this->language->get('text_success');
			if($action == "save_stay"){
				if( isset($this->request->get['module_id']) ) {
					$this->response->redirect($this->url->link('module/ecolayoutbuilder', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL'));
				}else{
					$this->response->redirect($this->url->link('module/ecolayoutbuilder', 'token=' . $this->session->data['token'], 'SSL'));
				}
			}else{
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}

		}

        $default = array(
            'name' => '',
            'layout' => '',
            'status' => 0
        );


        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
            $data['action'] = $this->url->link('module/ecolayoutbuilder', 'module_id='.$this->request->get['module_id'].'&token=' . $this->session->data['token'], 'SSL');
        }else {
            $module_info = $default;
            $data['action'] = $this->url->link('module/ecolayoutbuilder', 'token=' . $this->session->data['token'], 'SSL');
        }

       if($module_info['layout'])
            $data['layout_data'] = json_decode($module_info['layout']);



        $data['button_save'] = $this->language->get('button_save');
        $data['button_save_stay'] = $this->language->get('button_save_stay');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }

        $data['heading_title'] = $this->language->get('heading_title');


        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        //Breadcrumbs
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
                'href' => $this->url->link('module/ecolayoutbuilder', 'token=' . $this->session->data['token'], 'SSL')
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('module/ecolayoutbuilder', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
            );
        }

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
            $data['status'] = $module_info['status'];
        } else {
            $data['name'] = '';
        }

        $data['extensions'] = $this->_modulesInstalled();
        $data['objlang'] = $this->language;
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


        $template = 'module/ecolayoutbuilder/layout.tpl';
		$this->response->setOutput($this->load->view($template, $data));
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


	public function _getStores(){

		$this->load->model('setting/store');

		$action = array();
		$action[] = array(
			'text' => $this->language->get('text_edit'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL')
		);
		$store_default = array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
			'url'      => HTTP_CATALOG,
		);
		$stores = $this->model_setting_store->getStores();
		array_unshift($stores, $store_default);
		
		foreach ($stores as &$store) {
			$url = '';
			if ($store['store_id'] > 0 ) {
				$url = '&store_id='.$store['store_id'];
			}
			$store['option'] = $this->url->link('module/pavcustom', $url.'&token=' . $this->session->data['token'], 'SSL');
		}
		return $stores;
	}

	public function _getLanguage(){
		$data['objlang'] = $this->language;

		$data['heading_title'] = $this->language->get('heading_banner_title');
		$data['tab_module'] = $this->language->get('tab_module');
		// Text
		$data['prefix_class'] = $this->language->get('prefix_class');
		// Button
		$data['button_save'] = $this->language->get('button_save');
		$data['button_save_stay'] = $this->language->get('button_save_stay');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		// Entry
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_tabs'] = $this->language->get('entry_tabs');
		$data['entry_banner_layouts'] = $this->language->get('entry_banner_layouts');
		$data['entry_caption'] = $this->language->get('entry_caption');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_enabled'] = $this->language->get('text_enabled');
 	
 		$data['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);	

		// Token
		$data['token'] = $this->session->data['token'];

		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/ecolayoutbuilder')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
?>
