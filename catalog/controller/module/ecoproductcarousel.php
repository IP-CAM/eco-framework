<?php
class ControllerModuleEcoproductcarousel extends Controller {

	private $data;

	public function index($setting) {
		static $module = 0;

		$this->load->model('catalog/product');
		$this->load->model('ecoproductcarousel/product');
		$this->load->model('tool/image');
		$this->load->language('module/ecoproductcarousel');

		$data['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/ecoproductcarousel.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/ecoproductcarousel.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/ecoproductcarousel.css');
		}
		
		$default = array(
			'latest' => 1,
			'limit' => 9
		);


	 	$a = array('interval'=> 8000,'auto_play'=>0 );
		$setting = array_merge( $a, $setting );

		$data['prefix'] = isset($setting['prefix'])?$setting['prefix']:'';
		$data['width'] = $setting['width'];
		$data['height'] = $setting['height'];
		$data['auto_play'] = $setting['auto_play']?"true":"false";
		$data['auto_play_mode'] = $setting['auto_play'];
		$data['interval'] = (int)$setting['interval'];
		$data['cols']   = (int)$setting['cols'];
		$data['itemsperpage']   = (int)$setting['itemsperpage'];

		$data['tooltip']   = isset($setting['tooltip'])?(int)$setting['tooltip']:0;
		$data['tooltip_placement'] = isset($setting['tooltip_placement'])?$setting['tooltip_placement']:'top';
		$data['tooltip_show'] = isset($setting['tooltip_show'])?(int)$setting['tooltip_show']:100;
		$data['tooltip_hide'] = isset($setting['tooltip_hide'])?(int)$setting['tooltip_hide']:100;

		$data['tooltip_width'] = isset($setting['tooltip_width'])?(int)$setting['tooltip_width']:200;
		$data['tooltip_height'] = isset($setting['tooltip_height'])?(int)$setting['tooltip_height']:200;

		$data['show_button'] = isset($setting['btn_view_more'])?$setting['btn_view_more']:0;

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');



		$currenttab = reset($setting['tabs']);
		$button_link = '';
		if($currenttab == 'latest') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/latest');
		} elseif($currenttab == 'featured') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/featured');
		} elseif($currenttab == 'bestseller') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/bestseller');
		} elseif($currenttab == 'special') {
			$button_link = $this->url->link('product/special');
		} elseif($currenttab == 'mostviewed') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/mostviewed');
		} else {
			 $button_link = $this->url->link('product/product');
		}

		$data['type_product'] = $currenttab;


		$data['button_link'] = $button_link;

		$data['view_more'] = $this->language->get('label_btn_view_more');

		$data['tabs'] = array();

		$sortData = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);


		 $setting['tabs'] = array_flip(  $setting['tabs'] );

		$tabs = array(
			'latest' 	 => array(),
			'featured'   => array( ),
			'bestseller' => array(),
			'special'    => array(),
			'mostviewed' => array(),
			'toprating' => array()
		);
		if( isset($setting['description'][$this->config->get('config_language_id')]) ) {
			$data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		}else {
			$data['message'] = '';
		}
		if(isset($setting['tabs']['featured'])){
			$products = $this->getProducts( $this->getFeatured($sortData), $setting );
			$data['heading_title'] = $this->language->get('text_featured');
		}
		if( isset($setting['tabs']['latest']) ){
			$products = $this->getProducts( $this->model_catalog_product->getProducts( $sortData ), $setting );
			$data['heading_title'] = $this->language->get('text_latest');
	 	}
		if( isset($setting['tabs']['bestseller']) ){
			$products = $this->getProducts( $this->model_catalog_product->getBestSellerProducts( $sortData['limit'] ), $setting );
			$data['heading_title'] = $this->language->get('text_bestseller');
	 	}
		if( isset($setting['tabs']['special']) ){
			$products = $this->getProducts( $this->model_catalog_product->getProductSpecials( $sortData ), $setting );
			$data['heading_title'] = $this->language->get('text_special');
		}
		if( isset($setting['tabs']['mostviewed']) ){
			$products = $this->getProducts( $this->model_ecoproductcarousel_product->getMostviewedProducts( $sortData['limit'] ), $setting );
			$data['heading_title'] = $this->language->get('text_mostviewed');
		}
		if( isset($setting['tabs']['toprating']) ){
			$products = $this->getProducts( $this->model_ecoproductcarousel_product->getTopRatingProducts( $sortData['limit'] ), $setting );
			$data['heading_title'] = $this->language->get('text_toprating');
		}

		$data['objlang'] = $this->language;

		$data['products'] = $products;
		$data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ecoproductcarousel.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/ecoproductcarousel.tpl', $data);
		} else {
			return $this->load->view('default/template/module/ecoproductcarousel.tpl', $data);
		}
	}
	private function getFeatured($option = array()){
		$products = explode(',', $this->config->get('featured_product'));
		$return = array();
		if(!empty($products)){
			$limit = (isset($option['limit']) && !empty($option['limit']))?$option['limit']: 5;
			$products = array_slice($products, 0, (int)$limit);
			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
				$return[] = $product_info;
			}
		}
		return $return;
	}
	private function getProducts( $results, $setting ){
		$products = array();
		$tooltip_width = isset($setting['tooltip_width'])?(int)$setting['tooltip_width']:200;
		$tooltip_height = isset($setting['tooltip_height'])?(int)$setting['tooltip_height']:200;
		//$tooltip_image = '';
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				$product_images = $this->model_catalog_product->getProductImages($result['product_id']);
				if(isset($product_images) && !empty($product_images)) {
					$thumb2 = $this->model_tool_image->resize($product_images[0]['image'], $setting['width'], $setting['height']);
				}
			} else {
				$image = false;
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				$discount = floor((($result['price']-$result['special'])/$result['price'])*100);
			} else {
				$special = false;
			}

			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}

			$products[] = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'thumb2'   	 => isset($thumb2)?$thumb2:'',
				'date_added'  => $result['date_added'],
				//'tooltip_img'=> $tooltip_image,
				'discount'   => isset($discount)?'-'.$discount.'%':'',
				'name'    	 => $result['name'],
				'price'   	 => $price,
				'special' 	 => $special,
				'rating'     => $rating,
				'description'=> (html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')),
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}
		return $products;
	}
}
?>
