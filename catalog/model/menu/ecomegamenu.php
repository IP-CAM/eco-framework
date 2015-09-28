<?php
/******************************************************
 * @package Eco Framework
 * ------------------------------------------------------------------------------
 * @copyright    Copyright (C) 2008-2015 ZooExtension.com. All Rights Reserved.
 * @license      GNU General Public License version 2 or later;
 * @author       ZooExtension.com
 * @email        opencart@cleversoft.co
 *******************************************************/

class ModelMenuEcoMegamenu extends Model {
	
	/**
	 *
	 */
	private $_editString = '';

	/**
	 *
	 */
	private $children;
	
	/**
	 *
	 */
	private $shopUrl ;

	/**
	 *
	 */
	private $megaConfig = array();

	private $_editStringCol = '';

	/**
	 *
	 */
	public function getChilds( $id=null, $store_id=0 ){
		$sql = ' SELECT m.*, md.title FROM ' . DB_PREFIX . 'megamenu m LEFT JOIN '
								.DB_PREFIX.'megamenu_description md ON m.megamenu_id=md.megamenu_id AND language_id='.(int)$this->config->get('config_language_id') ;
		$sql .= ' WHERE m.`published`=1 ';
                $sql .= ' AND store_id='.(int)$store_id;
		if( $id != null ) {						
			$sql .= ' AND parent_id='.(int)$id;						
		}
		$sql .= ' ORDER BY `position`  ';
		$query = $this->db->query( $sql );						
		return $query->rows;
	}
	
	/**
	 *
	 */
	public function hasChild( $id ){
		return isset($this->children[$id]);
	}	
	
	/**
	 *
	 */
	public function getNodes( $id ){
		return $this->children[$id];
	}
	
	/**
	 *
	 */
	public function getTree( $parent=1 , $edit=false, $params, $store_id = 0){
		
		$this->parserMegaConfig( $params );
		if( $edit ){
			$this->_editString  = ' data-id="%s" data-group="%s"  data-class="%s" data-subclass="%s"  data-align="%s" data-subwidth="%s" ';
		}
		$this->_editStringCol = ' data-colwidth="%s" data-class="%s" ' ;


		$childs = $this->getChilds( null, $store_id );
		foreach($childs as $child ){
			$child['megaconfig'] = $this->hasMegaMenuConfig( $child );

			$this->children[$child['parent_id']][] = $child;
		}

		$parent = 0 ;
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->shopUrl = $this->config->get('config_ssl') ;
		} else {
			$this->shopUrl = $this->config->get('config_url') ;
		}
	 	$output  = '';
		if( $this->hasChild($parent) ){
			$data = $this->getNodes( $parent );

			// render menu at level 0
			$output = '<ul class="nav navbar-nav megamenu">';
			foreach( $data as $menu ){
 
				
				if( isset($menu['megaconfig']->align) ){
                    $menu['menu_class'] .= ' align-'.$menu['megaconfig']->align;
                }

				if( isset($menu['megaconfig']->class) ){
					$menu['menu_class'] .= ' '.$menu['megaconfig']->class;
				}

				if( $this->hasChild($menu['megamenu_id']) ){
					$output .= '<li class="level0 parent dropdown '.$menu['menu_class'].'" >
					<a class="dropdown-toggle" data-toggle="dropdown" href="'.$this->getLink( $menu ).'">';

					$output .= '<span class="menu-title">'.$menu['title']."</span>";
					$output .= "<b class=\"caret\"></b>";
					$output .= '</a>';
					if($menu['megamenu_id'] > 1) {
						$output .= $this->genTree( $menu['megamenu_id'], 1, $menu );	
					}
					
					$output .= '</li>';
				} else if ( !$this->hasChild($menu['megamenu_id']) && $menu['megaconfig'] && isset($menu['megaconfig']->rows) ){
					$output .= $this->genMegaMenuByConfig( $menu['megamenu_id'], 1, $menu );
				}else {
					$output .= '<li class="level0 '.$menu['menu_class'].'" >
								<a href="'.$this->getLink( $menu ).'">';
					$output .= '<span  class="menu-title">'.$menu['title']."</span>";
					$output .= '</a></li>';
				}
			}
			$output .= '</ul>';
			
		}

		 return $output;
	
	}
	
	/**
	 *
	 */
	public function genMegaMenuByConfig( $parentId, $level,$menu  ){

		$attrw = '';
		$class = $level > 1 ? "dropdown-submenu":"dropdown";
		$output = '<li class="'.$menu['menu_class'].' parent '.$class.' " >
					<a href="'.$this->getLink( $menu ).'" class="dropdown-toggle" data-toggle="dropdown">';
					$output .= '<span class="menu-title">'.$menu['title']."</span>";
					$output .= "<b class=\"caret\"></b></a>";

		if( isset($menu['megaconfig']->subwidth) &&  $menu['megaconfig']->subwidth ){
			$attrw .= ' style="width:'.$menu['megaconfig']->subwidth.'px"' ;
		}

		$class  = 'dropdown-menu ';

		if( isset($menu['megaconfig']->subclass) &&  $menu['megaconfig']->subclass ){
			$class .= $menu['megaconfig']->subclass ;
		}

		$output .= '<div class="'.$class.'" '.$attrw.' ><div class="dropdown-menu-inner">';

		foreach( $menu['megaconfig']->rows  as $row ){
		
			$output .= '<div class="row">';
				foreach( $row->cols as $col ){
					$colclass = isset($col->class)? $col->class:'';
					 $output .= '<div class="mega-col col-xs-12 col-sm-12 col-md-'.$col->colwidth.' '.$colclass.'" > <div class="mega-col-inner">';
					 	$output .= $this->renderModuleContent( $col );
					 $output .= '</div></div>';
				}
			$output .= '</div>';
		}
		unset($colclass);

		$output .= '</div></div>';
		$output .= '</li>';
		return $output; 
	}

    public function renderModuleContent( $col )
    {
        if( is_object($col) && isset($col->module_id)  ){
            $part = explode('.', $col->module_id);

            if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
                return $this->load->controller('module/' . $part[0]);
            }

            if (isset($part[1])) {
                $setting_info = $this->model_extension_module->getModule($part[1]);
                if ($setting_info && $setting_info['status']) {
                    return $this->load->controller('module/' . $part[0], $setting_info);
                }
            }
        }
    }



	/**
	 *
	 */
	public function parserMegaConfig( $params ){
		if( !empty($params) ) { 
			foreach( $params as $param ){
				if( $param  && isset($param->id) ){
					$this->megaConfig[$param->id] = $param;
				}
			}	
		}
	}
	
	public function hasMegaMenuConfig( $menu ){
		$id = $menu['megamenu_id'];
		return isset( $this->megaConfig[$id] )?$this->megaConfig[$id] :array(); 
	}
	/**
	 *
	 */
	public function genTree( $parentId, $level,$parent, $store_id = 0){
		 
	 
		$attrw = '';
		$class = "dropdown-menu ";
		
		if( isset($parent['megaconfig']->subwidth) &&  $parent['megaconfig']->subwidth ){
			$attrw .= ' style="width:'.$parent['megaconfig']->subwidth.'px"' ;
		}

		if( isset($parent['megaconfig']->subclass) &&  $parent['megaconfig']->subclass ){
			$class .= $parent['megaconfig']->subclass ;
		}

		if( $this->hasChild($parentId) ){
			
			$data = $this->getNodes( $parentId );			
			if( !empty($parent['megaconfig']->rows) ) {
				$output = '<div class="'.$class.' level'.$level.'" '.$attrw.' ><div class="dropdown-menu-inner">';
				foreach( $parent['megaconfig']->rows as $rows ){
					foreach( $rows as $rowcols ){
						$output .='<div class="row">';
						foreach( $rowcols as $col ) {
							$colwidth = isset($col->colwidth)?$col->colwidth:'';
							$colExtClass = isset($col->class)?$col->class:'';
							if( isset($col->type) && $col->type == 'menu' ){

								$scol = '<div class="' . $colExtClass . ' mega-col col-xs-12 col-sm-12 col-md-'.$colwidth.'"><div class="mega-col-inner">';
								$scol .= '<ul>';
								$menulist = trim($col->menulist,',');
								$aList = explode(',',$menulist);
								foreach( $data as $menu ){
									if(!in_array($menu['megamenu_id'], $aList)) continue;
									$scol .= $this->renderMenuContent( $menu , $level+1 );
								}
								$scol .= '</ul>';

							}else {
								$scol = '<div class="' . $colExtClass . ' mega-col col-xs-12 col-sm-12 col-md-'.$colwidth.'"  ><div class="mega-col-inner">';
								$scol .= $this->renderModuleContent( $col );
							}
							$scol .= '</div></div>';
							$output .= $scol;
						}
						$output .= '</div>';
					}

				}$output .= '</div></div>';
			} else {
				$output = '<div class="'.$class.' level'.$level.'" '.$attrw.' ><div class="dropdown-menu-inner">';
				$row = '<div class="row"><div class="col-sm-12 mega-col"><div class="mega-col-inner"><ul>';
				foreach( $data as $menu ){
					$row .= $this->renderMenuContent( $menu , $level+1 );
				}
				$row .= '</ul></div></div></div>';

				$output .= $row;

			}

			return $output;

		}
		return ;
	}


	/**
	 *
	 */
	public function renderMenuContent( $menu , $level ){

		$output = '';
		$class = isset($menu['megaconfig']->class) ? $menu['megaconfig']->class :"";
		$menu['menu_class'] = ' '.$class;

		if( $this->hasChild($menu['megamenu_id']) ){

			$output .= '<li class="parent dropdown-submenu'.$menu['menu_class'].'">';
			if( $menu['show_title'] ){
				$output .= '<a class="dropdown-toggle" data-toggle="dropdown" href="'.$this->getLink( $menu ).'">';
				$output .= '<span class="menu-title">'.$menu['title']."</span>";

				$output .= "<b class=\"caret\"></b>";

				$output .= '</a>';
			}	
			if($menu['megamenu_id'] > 1) {
				$output .= $this->genTree( $menu['megamenu_id'], $level, $menu );
			}
			$output .= '</li>';

		}else if (  $menu['megaconfig'] && isset($menu['megaconfig']->rows) ){
			$output .= $this->genMegaMenuByConfig( $menu['megamenu_id'], $level, $menu );
		}else {
			$output .= '<li class="'.$menu['menu_class'].'" >';
			if( $menu['show_title'] ){ 
				$output .= '<a href="'.$this->getLink( $menu ).'">';
				$output .= '<span class="menu-title">'.$menu['title']."</span>";
				$output .= '</a>';
			}
			$output .= '</li>';
		}
		return $output;
	}
	
	public function getParentCategory($id_child){
		$result = $this->db->query("SELECT `parent_id` FROM `" . DB_PREFIX . "category` WHERE `category_id` = '".$id_child."'");
 		return $result->row;
	}

	/**
	 *
	 */
	public function getLink( $menu ){
		$id = (int)$menu['item'];
		switch( $menu['type'] ){
			case 'category':
				$parent = $this->getParentCategory($id);
				if( $parent && isset($parent['parent_id']) && $parent['parent_id'] ){  
					$id = $parent['parent_id'].'_'.$id;
				}
				return $this->url->link('product/category', 'path=' . $id);
			case 'product':
				return  $this->url->link('product/product', 'product_id=' . $id);
			case 'information':
				return   $this->url->link('information/information', 'information_id=' . $id);
			case 'manufacturer':
				return  $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $id);
			default:
				if(!preg_match('/^http:\/\//',$menu['url'])) return 'http://' . $menu['url'];
				else return $menu['url'];
		}
	}

}
?>