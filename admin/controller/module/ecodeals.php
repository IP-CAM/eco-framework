<?php

class ControllerModuleEcodeals extends Controller {
	private $error = array();
    public function install() {
        $this->load->model('setting/setting');
        $data = array(
             'status'   => 1,
             'width'   => 200,
             'height'   => 200,
        );
        $this->model_setting_setting->editSetting('ecodeals',$data,0);
    }

	public function index() {

        $this->load->language('module/ecodeals');
        $this->document->setTitle(strip_tags($this->language->get('heading_title')));
        $this->load->model('setting/setting');
		$this->load->model('extension/module');
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule('ecodeals', $this->request->post);
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
            }
			
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }



		$data['heading_title'] = $this->language->get('heading_title');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['text_ecodeals_width'] = $this->language->get('text_ecodeals_width');
		$data['text_ecodeals_height'] = $this->language->get('text_ecodeals_height');
		$data['text_ecodeals_page'] = $this->language->get('text_ecodeals_page');
		$data['text_ecodeals_id'] = $this->language->get('text_ecodeals_id');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
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
		
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

        // Carousel
        if (isset($this->request->post['carousel'])) {
            $data['carousel'] = $this->request->post['carousel'];
        } elseif (!empty($module_info)) {
            $data['carousel'] = $module_info['carousel'];
        } else {
            $data['carousel'] = 1;
        }
		
		if (isset($this->request->post['width'])) {
			$data['width'] = $this->request->post['width'];
		} elseif (!empty($module_info)) {
			$data['width'] = $module_info['width'];
		} else {
			$data['width'] = 200;
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

        // row
        if (isset($this->request->post['row'])) {
            $data['entry_heading_title'] = $this->request->post['entry_heading_title'];
        } elseif (!empty($module_info)) {
            $data['entry_heading_title'] = $module_info['entry_heading_title'];
        } else {
            $data['entry_heading_title'] = '';
        }
		
		if (isset($this->request->post['height'])) {
			$data['height'] = $this->request->post['height'];
		} elseif (!empty($module_info)) {
			$data['height'] = $module_info['height'];
		} else {
			$data['height'] = 200;
		}

        //Categories
        if (isset($this->request->post['product_categories'])) {
            $categories = $this->request->post['product_categories'];
        } elseif (!empty($module_info)) {
            $categories = isset($module_info['product_category'])?$module_info['product_category']:array();
        } else {
            $categories = array();
        }

        // Categories
        $this->load->model('catalog/category');

        $data['product_categories'] = array();

        foreach ($categories as $category_id) {
            $category_info = $this->model_catalog_category->getCategory($category_id);

            if ($category_info) {
                $data['product_categories'][] = array(
                    'category_id' => $category_info['category_id'],
                    'name' => ($category_info['path']) ? $category_info['path'] . ' &gt; ' . $category_info['name'] : $category_info['name']
                );
            }
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
			'href'      => $this->url->link('module/ecodeals', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		if(isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/ecodeals', 'token=' . $this->session->data['token'] , 'SSL'). '&module_id='.$this->request->get['module_id'];
		} else {
			$data['action'] = $this->url->link('module/ecodeals', 'token=' . $this->session->data['token'] , 'SSL');
		}





        $data['token'] = $this->session->data['token'];
        $data['objlang'] = $this->language;
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['modules'] = array();
		
		$this->load->model('design/layout');
		$data['layouts'] = $this->model_design_layout->getLayouts();
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('module/ecodeals/ecodeals.tpl', $data));
	}

	public  function validate() {
		if (!$this->user->hasPermission('modify', 'module/ecodeals')) {
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