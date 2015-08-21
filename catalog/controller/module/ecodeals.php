<?php  
class ControllerModuleEcodeals extends Controller {
	public  function index($setting) {
		
		if(empty($setting)) {
			$data['permission'] = false;
		} else {
			$data['permission'] = true;
		}
		if($data['permission']) {
			$this->load->language('module/ecodeals');
		  //  $this->document->addScript('catalog/view/javascript/countdown.js');
			$this->document->addScript('catalog/view/javascript/jquery.plugin.js');
			$this->document->addScript('catalog/view/javascript/jquery.countdown.js');
			$this->document->addStyle('catalog/view/javascript/jquery.countdown.css');
            $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
            $this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/ecodeals.css')) {
                $this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/ecodeals.css');
            } else {
                $this->document->addStyle('catalog/view/theme/default/stylesheet/ecodeals.css');
            }
			$this->load->model('module/ecodeals');
		   $this->load->model('tool/image');
			$filter_data = array(
                'filter_categories' => $setting['product_category'],
				'sort'  => 'pd.name',
				'order' => 'ASC',
				'start' => 0,
				'limit' => $setting['limit']
			);
			$data['ecodeals_width'] = $setting['width'];
			$data['ecodeals_height'] = $setting['height'];
            $data['row'] = $setting['row'];
            $data['carousel'] = $setting['carousel'];
            $data['slideshow'] = $setting['slideshow'];
            $data['itemsperpage']   = (int)$setting['itemsperpage'];
            $data['heading_title'] = $setting['entry_heading_title'];
			$data['text_tax'] = $this->language->get('text_tax');
			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
            $data['objlang'] = $this->language;

			$results = $this->model_module_ecodeals->getTimeCountdown($filter_data);

			if ($results) {
				foreach ($results as $result) { 
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $data['ecodeals_width'], $data['ecodeals_height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $data['ecodeals_width'],$data['ecodeals_height']);
					}
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['orgprice'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					} 
					
					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['orgprice']);
					} else {
						$tax = false;
					}
					if ($result['date_start']!=null) {
						$date_start = $result['date_start'] ;
					} else {
						$date_start = false;
					} 
					if($result['date_end']!=null) {
						$date_end = $result['date_end'] ;
					 } else {
						$date_end = false;
					}
					
					if ($this->config->get('config_review_status')) {
						$rating = $result['rating'];
					} else {
						$rating = false;
					}
					if ((float)$result['special']) {
     $price2 = $this->tax->calculate($result['orgprice'],$result['tax_class_id'], $this->config->get('config_tax'));
                    
    }else {
						$price2 = false;
						
					}
					if ((float)$result['special']) {
     
                    $special2 = $this->tax->calculate($result['special'],$result['tax_class_id'], $this->config->get('config_tax'));
    }else {
						
						$special2 = false;
					}
					$data['products'][] = array(
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'orgprice'       => $price,
						'special'     => $special,
						'date_start'  => $date_start,
						'date_end'    =>  $date_end,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id']),
						 'price2'     => $price2,
						'special2'     => $special2,
					);
				}
			}
			
		}


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ecodeal.tpl')) {
					return $this->load->view($this->config->get('config_template').'/template/module/ecodeal.tpl', $data);
				} else {
					return $this->load->view('default/template/module/ecodeal.tpl',$data);
				}
		
	}
}

?>