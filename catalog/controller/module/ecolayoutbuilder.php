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

	private $url = '';
	/**
	 * index action 
	 */
	public function index($setting) {
		$this->load->model('tool/image');
		$this->load->model('design/banner');
		$this->load->model('extension/module');
		$d = array("banner_layout" => 1, "prefix" => '');
		$setting = array_merge($d, $setting);
		$data['objimg'] = $this->model_tool_image;
		$layouts = ( trim($setting['layout']) );
		$data['layouts'] = $layouts;

		$tpl = 'ecolayoutbuilder.tpl';

		if( isset($setting['template']) ){
			$tpl = 'pavhomebuilder/'.$setting['template'].'.tpl'; 
		}	
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/homebuilder.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/homebuilder.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/homebuilder.css');
		}
		$this->url = $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url');

		$layout = json_decode( $layouts );

        $layouts = $this->buildLayoutData( $layout,  1 );



		$data['layouts'] = $layouts;
		$data['url'] =  $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url');
		
 		$data['class'] = isset($setting['class'])?$setting['class']:'';
 		$data['heading'] = isset($setting['heading'])?$setting['heading']:'';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/'.$tpl)) {
			$template = $this->config->get('config_template') . '/template/module/'.$tpl;
		} else {
			$template = 'default/template/module/'.$tpl;
		}
		$data['template'] = $template;

		return $this->load->view($template, $data);
	}
	

	/**
	 * looping render layout structures and module content inside cols and rows.
	 *
	 * @return Array $layout
	 */
    public function buildLayoutData( $rows , $rl=1 ){ 
        foreach( $rows as $rkey =>  $row ){
            $row->level=$rl;
            foreach( $row->children as $ckey => $child ){
               if( isset($child->position) ){
                   $child->content = $this->renderModule( array('code'=>$child->position) );
               }
                if( isset($child->children) ){
                    $child->children = $this->buildLayoutData( $child->children, $rl+1 );
                }
                $row->children[$ckey] = $child;
            }

            $rows[$rkey] = $row;
        }

        return $rows;
    }

    /**
	 * direct rendering content of module by code
	 * 
	 * @return HTML Stream
	 */
	protected function renderModule( $module  ){
		$part = explode('.', $module['code']);
			
		if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
			return $this->load->controller('module/' . $part[0]);
		}
		
		if (isset($part[1])) {
			$setting_info = $this->model_extension_module->getModule($part[1]);
			
			if ($setting_info && $setting_info['status']) {
				return $this->load->controller('module/' . $part[0], $setting_info);
			}
		}
		return ;
	}
}
?>