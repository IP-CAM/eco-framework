<?php
class ControllerModuleEcoproductcarousel extends Controller {
	private $error = array();
	private $data;

	public function index() {

		$this->language->load('module/ecoproductcarousel');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('ecoproductcarousel', $this->request->post);
				$this->response->redirect($this->url->link('module/ecoproductcarousel', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
				$this->response->redirect($this->url->link('module/ecoproductcarousel', 'token=' . $this->session->data['token'].'&module_id='.$this->request->get['module_id'], 'SSL'));
			}

			$this->session->data['success'] = $this->language->get('text_success');
		}
		// COMMON
		$language = $this->_language();
        $alert = $this->_alert();
        $breadcrumbs = $this->_breadcrumbs();

 		// DATA
        $aData = $this->_data();
        $data = array_merge($aData, $language, $alert, $breadcrumbs);
		// RENDER
		$template = 'module/ecoproductcarousel.tpl';
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view($template, $data));
	}

	public function _data(){
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/ecoproductcarousel', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/ecoproductcarousel', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		// GET DATA SETTING
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		// NAME
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		// STATUS
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = 1;
		}

        // STATUS
        if (isset($this->request->post['carousel'])) {
            $data['carousel'] = $this->request->post['carousel'];
        } elseif (!empty($module_info)) {
            $data['carousel'] = $module_info['carousel'];
        } else {
            $data['carousel'] = 1;
        }


        // column
        if (isset($this->request->post['slideshow'])) {
            $data['slideshow'] = $this->request->post['slideshow'];
        } elseif (!empty($module_info)) {
            $data['slideshow'] = $module_info['slideshow'];
        } else {
            $data['slideshow'] = 0;
        }

        // row
        if (isset($this->request->post['row'])) {
            $data['row'] = $this->request->post['row'];
        } elseif (!empty($module_info)) {
            $data['row'] = $module_info['row'];
        } else {
            $data['row'] = '';
        }

		// CLASS
		if (isset($this->request->post['tabs'])) {
			$data['tabs'] = $this->request->post['tabs'];
		} elseif (!empty($module_info)) {
			$data['tabs'] = $module_info['tabs'];
		} else {
			$data['tabs'] = array(1=>'featured');
		}

		// width
		if (isset($this->request->post['width'])) {
			$data['width'] = $this->request->post['width'];
		} elseif (!empty($module_info)) {
			$data['width'] = $module_info['width'];
		} else {
			$data['width'] = '600';
		}

		//feature product
		$this->load->model('catalog/product');

		$data['products'] = array();

		if (isset($this->request->post['product'])) {
			$products = $this->request->post['product'];
		} elseif (!empty($module_info)) {
			$products = $module_info['product'];
		} else {
			$products = array();
		}

		if(is_array($products)){
			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					$data['products'][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name']
					);
				}
			}
		}


		
		// height
		if (isset($this->request->post['height'])) {
			$data['height'] = $this->request->post['height'];
		} elseif (!empty($module_info)) {
			$data['height'] = $module_info['height'];
		} else {
			$data['height'] = '666';
		}

		// itemsperpage
		if (isset($this->request->post['itemsperpage'])) {
			$data['itemsperpage'] = $this->request->post['itemsperpage'];
		} elseif (!empty($module_info)) {
			$data['itemsperpage'] = $module_info['itemsperpage'];
		} else {
			$data['itemsperpage'] = '4';
		}


		// limit
		if (isset($this->request->post['limit'])) {
			$data['limit'] = $this->request->post['limit'];
		} elseif (!empty($module_info)) {
			$data['limit'] = $module_info['limit'];
		} else {
			$data['limit'] = '4';
		}

        return $data;
	}

	public function _breadcrumbs(){
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
			'href'      => $this->url->link('module/ecoproductcarousel', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

        return $data;
	}

	public function _language(){
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');

		$data['entry_banner'] = $this->language->get('entry_banner');
		$data['entry_dimension'] = $this->language->get('entry_dimension');
		$data['entry_carousel'] = $this->language->get('entry_carousel');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_module_add'] = $this->language->get('button_module_add');
		$data['button_remove'] = $this->language->get('button_remove');

		$data['yesno'] = array(
			0=>$this->language->get('text_no'),
			1=>$this->language->get('text_yes')
		);

		$data['entry_tabs'] = $this->language->get('entry_tabs');

		$tmptabs = array(
			'featured' => $this->language->get('text_featured'),
			'latest' 	 => $this->language->get('text_latest'),
			'bestseller' => $this->language->get('text_bestseller'),
			'special'   => $this->language->get('text_special'),
			'mostviewed' => $this->language->get('text_mostviewed'),
			'toprating' => $this->language->get('text_toprating'),
		);
		$data['tmptabs'] = $tmptabs;

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['objlang'] = $this->language;

        return $data;
	}

	public function _alert(){
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

        return $data;
	}

	public function redirect( $url ){
		return $this->response->redirect( $url );
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/ecoproductcarousel')) {
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
