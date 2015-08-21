<?php
/******************************************************
 * @package Eco Framework
 * ------------------------------------------------------------------------------
 * @copyright    Copyright (C) 2008-2015 ZooExtension.com. All Rights Reserved.
 * @license      GNU General Public License version 2 or later;
 * @author       ZooExtension.com
 * @email        opencart@cleversoft.co
 *******************************************************/

class ModelMenuEcoverticalmenu extends Model {

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

    private $_isLiveEdit = true;
    /**
     *
     */
    public function getChilds( $id=null, $store_id = 0 ){
        $sql = ' SELECT m.*, md.title,md.description FROM ' . DB_PREFIX . 'verticalmenu m LEFT JOIN '
            .DB_PREFIX.'verticalmenu_description md ON m.verticalmenu_id=md.verticalmenu_id AND language_id='.(int)$this->config->get('config_language_id') ;
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
     * get get all  Menu Childrens by Id
     */
    public function getChild( $id=null, $store_id = 0){
        $sql = ' SELECT m.*, md.title,md.description FROM ' . DB_PREFIX . 'verticalmenu m LEFT JOIN '
            .DB_PREFIX.'verticalmenu_description md ON m.verticalmenu_id=md.verticalmenu_id AND language_id='.(int)$this->config->get('config_language_id') ;

        $sql .= ' WHERE store_id='.(int)$store_id;
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
     * delete mega menu data by id
     */
    public function delete( $id, $store_id){
        $childs = $this->getChild( null, $store_id );
        foreach($childs as $child ){
            $this->children[$child['parent_id']][] = $child;
        }
        $this->recursiveDelete($id, $store_id);
    }
    /**
     * recursive delete tree
     */
    public function recursiveDelete($parent_id, $store_id)
    {
        $sql = " DELETE FROM ".DB_PREFIX ."verticalmenu_description WHERE verticalmenu_id=".(int)$parent_id .";";
        $this->db->query($sql);
        $sql = " DELETE FROM ".DB_PREFIX ."verticalmenu WHERE store_id = ".$store_id." AND verticalmenu_id=".(int)$parent_id .";";
        $this->db->query($sql);

        if( $this->hasChild($parent_id) ){
            $data = $this->getNodes( $parent_id );
            foreach( $data as $menu ){
                if($menu['verticalmenu_id'] > 1) {
                    $this->recursiveDelete( $menu['verticalmenu_id'], $store_id );
                }
            }
        }
    }

    /**
     *
     */
    public function getTree( $parent=1 , $edit=false, $params, $store_id = 0 ){


        $this->parserMegaConfig( $params );
        if( $edit ){
            $this->_editString  = ' data-id="%s" data-group="%s"  data-cols="%s" data-level="%s" data-align="%s" data-subwidth="%s" ';
        }
        $this->_editStringCol = ' data-colwidth="%s" data-class="%s" ' ;


        $childs = $this->getChilds( null, $store_id );
        foreach($childs as $child ){
            $child['megaconfig'] = $this->hasMegaMenuConfig( $child );
            if( isset($child['megaconfig']->group) ){
                $child['is_group'] = $child['megaconfig']->group;
            }

            if( isset($child['megaconfig']->submenu) && $child['megaconfig']->submenu == 0){
                $child['menu_class'] = $child['menu_class'] .' disable-menu';
            }

            $child['menu_subwidth'] = isset($child['megaconfig']->subwidth) ? $child['megaconfig']->subwidth : '';

            $child['menu_align'] = isset($child['megaconfig']->align) ? $child['megaconfig']->align : 'left';

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
        $output = '';
        if( $this->hasChild($parent) ){
            $data = $this->getNodes( $parent );

            // render menu at level 0
            foreach( $data as $menu ){

                if( isset($menu['megaconfig']->align) ){
                    $menu['menu_class'] .= ' mega-align-'.$menu['megaconfig']->align;
                }
                $menu['menu_level'] = 1;
                if( $this->hasChild($menu['verticalmenu_id']) || $menu['type_submenu'] == 'html'){
                    $output .= '<li class="mega dropdown '.$menu['menu_class'].'" '.$this->renderAttrs($menu).'>
					<a class="dropdown-toggle" data-toggle="dropdown" href="'.$this->getLink( $menu ).'">';

                    if( $menu['image']){ $output .= '<span class="menu-icon" style="background:url(\''.$this->shopUrl."image/".$menu['image'].'\') no-repeat;">';	}

                    $output .= '<span class="menu-title">'.$menu['title']."</span>";
                    if( $menu['description'] ){
                        $output .= '<span class="menu-desc">' . $menu['description'] . "</span>";
                    }
                    $output .= "<b class=\"caret\"></b></a>";
                    if( $menu['image']){  $output .= '</span>'; }

                    $output .= $this->genTree( $menu['verticalmenu_id'], 1, $menu );
                    $output .= '</li>';
                } else if ( !$this->hasChild($menu['verticalmenu_id']) && $menu['megaconfig'] && $menu['megaconfig']->rows ){
                    $output .= $this->genMegaMenuByConfig( $menu['verticalmenu_id'], 1, $menu );
                }else {
                    $output .= '<li class="'.$menu['menu_class'].'" '.$this->renderAttrs($menu).'>
					<a href="'.$this->getLink( $menu ).'">';

                    if( $menu['image']){ $output .= '<span class="menu-icon" style="background:url(\''.$this->shopUrl."image/".$menu['image'].'\') no-repeat;">';	}

                    $output .= '<span class="menu-title">'.$menu['title']."</span>";
                    if( $menu['description'] ){
                        $output .= '<span class="menu-desc">' . $menu['description'] . "</span>";
                    }
                    if( $menu['image']){ $output .= '</span>';	}
                    $output .= '</a></li>';
                }
            }

        }

        return $output;

    }

    /**
     *
     */
    public function genMegaMenuByConfig( $parentId, $level,$menu  ){

        $attrw = '';
        $class = $level > 1 ? "dropdown-submenu":"dropdown";
        $output = '<li class="mega '.$menu['menu_class'].' parent '.$class.' " '.$this->renderAttrs($menu).'>
					<a href="'.$this->getLink( $menu ).'" class="dropdown-toggle" data-toggle="dropdown">';

        if( $menu['image']){ $output .= '<span class="menu-icon" style="background:url(\''.$this->shopUrl."image/".$menu['image'].'\') no-repeat;">';	}

        $output .= '<span class="menu-title">'.$menu['title']."</span>";
        if( $menu['description'] ){
            $output .= '<span class="menu-desc">' . $menu['description'] . "</span>";
        }
        if( $menu['image']){ $output .= '</span>';	}
        $output .= "<b class=\"caret\"></b></a>";

        if( isset($menu['megaconfig']->subwidth) &&  $menu['megaconfig']->subwidth ){
            $attrw .= ' style="width:'.$menu['megaconfig']->subwidth.'px"' ;
        }
        $class  = 'menu-child  dropdown-menu';
        $output .= '<div class="'.$class.'" '.$attrw.' ><div class="mega-dropdown-inner">';

        foreach( $menu['megaconfig']->rows  as $row ){

            $output .= '<div class="row-fluid">';
            foreach( $row->cols as $col ){
                $output .= '<div class="span'. $col->colwidth .' mega-col col-sm-'.$col->colwidth.'" '.$this->getColumnDataConfig( $col ).'> <div class="mega-inner">';
                $output .= $col->module_name;
                $output .= '</div></div>';
            }
            $output .= '</div>';
        }

        $output .= '</div></div>';
        $output .= '</li>';
        return $output;
    }

    public function getColumnDataConfig( $col ){
        $output = '';
        if( is_object($col)  && $this->_isLiveEdit ){
            $vars = get_object_vars($col);
            foreach( $vars as $key => $var ){
                $output .= ' data-'.$key.'="'.$var . '" ' ;
            }
        }
        return $output;
    }

    /**
     *
     */
    public function parserMegaConfig( $params ){
        if( !empty($params) ) {
            foreach( $params as $param ){
                if( $param && isset($param->id) ){
                    $this->megaConfig[$param->id] = $param;
                }
            }
        }
    }

    public function hasMegaMenuConfig( $menu ){
        $id = $menu['verticalmenu_id'];
        return isset( $this->megaConfig[$id] )?$this->megaConfig[$id] :array();
    }
    /**
     *
     */
    public function genTree( $parentId, $level,$parent  ){


        $attrw = '';
        $class = 'menu-child ' . ($parent['is_group']?"dropdown-mega":"dropdown-menu");
        if( isset($parent['megaconfig']->subwidth) &&  $parent['megaconfig']->subwidth ){
            $attrw .= ' style="width:'.$parent['megaconfig']->subwidth.'px"' ;
        }


        if( $this->hasChild($parentId) ){

            $data = $this->getNodes( $parentId );
            $parent['colums'] = (int)$parent['colums'];
            if( $parent['colums'] > 1  ){

                if( !empty($parent['megaconfig']->rows) ) {

                    $cols   = array_chunk( $data, ceil(count($data)/$parent['colums'])  );
                    $output = '<div class="'.$class.' level'.$level.'" '.$attrw.' ><div class="mega-dropdown-inner">';
                    foreach( $parent['megaconfig']->rows as $rows ){
                        foreach( $rows as $rowcols ){
                            $output .='<div class="row-fluid">';

                            foreach( $rowcols as $key => $col ) {
                                $col->colwidth = isset($col->colwidth)?$col->colwidth:6;
                                if( isset($col->type) && $col->type == 'menu' && isset($cols[$key]) ){
                                    $scol = '<div class="span'. $col->colwidth .' mega-col col-sm-'.$col->colwidth.'" data-type="menu" '.$this->getColumnDataConfig( $col ).'><div class="mega-inner">';
                                    $scol .= '<ul class="mega-nav level'. $level .'">';
                                    foreach( $cols[$key] as $menu ) {
                                        $scol .= $this->renderMenuContent( $menu, $level+1 );
                                    }
                                    $scol .='</ul></div></div>';
                                }else {
                                    $scol = '<div class="mega-col col-sm-'.$col->colwidth.'"  '.$this->getColumnDataConfig( $col ).'><div class="mega-inner">';

                                    $scol .= '</div></div>';
                                }
                                $output .= $scol;
                            }

                            $output .= '</div>';
                        }
                    }
                    $output .= '</div></div>';

                }else {
                    $output = '<div class="'.$class.' mega-cols cols'.$parent['colums'].'" '.$attrw.' ><div class="mega-dropdown-inner"><div class="row">';
                    $cols   = array_chunk( $data, ceil(count($data)/$parent['colums'])  );

                    $oSpans = $this->getColWidth( $parent, (int)$parent['colums'] );

                    foreach( $cols as $i =>  $menus ){

                        $output .='<div class="mega-col '.$oSpans[$i+1].' col-'.($i+1).'" data-type="menu"><div class="mega-inner"><ul class="mega-nav level'. $level .'">';
                        foreach( $menus as $menu ) {
                            $output .= $this->renderMenuContent( $menu, $level+1 );
                        }
                        $output .='</ul></div></div>';
                    }

                    $output .= '</div></div></div>';
                }
                return $output;
            }else {

                if( !empty($parent['megaconfig']->rows) ) {
                    $output = '<div class="'.$class.' level'.$level.'" '.$attrw.' ><div class="mega-dropdown-inner">';
                    foreach( $parent['megaconfig']->rows as $rows ){
                        foreach( $rows as $rowcols ){
                            $output .='<div class="row-fluid">';
                            foreach( $rowcols as $col ) {

                                if( isset($col->type) && $col->type == 'menu' ){
                                    $colwidth = isset($col->colwidth)?$col->colwidth:'';
                                    $scol = '<div class="span'. $colwidth .' mega-col col-sm-'.$colwidth.'" data-type="menu" '.$this->getColumnDataConfig( $col ).'><div class="mega-inner">';
                                    $scol .= '<ul class="mega-nav level'. $level .'">';
                                    foreach( $data as $menu ){
                                        $scol .= $this->renderMenuContent( $menu , $level+1 );
                                    }
                                    $scol .= '</ul>';

                                }else {
                                    $scol = '<div class="span'. $col->colwidth .' mega-col col-sm-'.$col->colwidth.'"  '.$this->getColumnDataConfig( $col ).'><div class="mega-inner">';
                                    $scol .= $col->module_name;
                                }

                                $scol .= '</div></div>';
                                $output .= $scol;
                            }
                            $output .= '</div>';
                        }

                    }$output .= '</div></div>';
                } else {
                    $output = '<div class="'.$class.' level'.$level.'" '.$attrw.' ><div class="mega-dropdown-inner">';
                    $row = '<div class="row-fluid"><div class="span12 col-sm-12 mega-col" data-colwidth="12" data-type="menu" ><div class="mega-inner"><ul class="mega-nav level'. $level .'">';
                    foreach( $data as $menu ){
                        $row .= $this->renderMenuContent( $menu , $level+1 );
                    }
                    $row .= '</ul></div></div></div>';

                    $output .= $row;

                }

            }

            return $output;

        }
        return ;
    }

    /**
     *
     */
    public function renderAttrs( $menu ){
        $t = sprintf( $this->_editString, $menu['verticalmenu_id'], $menu['is_group'], $menu['colums'], $menu['menu_level'], $menu['menu_align'], $menu['menu_subwidth']  );
        return $t;
    }

    /**
     *
     */
    public function renderMenuContent( $menu , $level ){

        $output = '';
        $class = $menu['is_group']?"mega-group":"";
        $menu['menu_class'] = ' '.$class;
        $menu['menu_level'] = $level-1;
        if( $menu['type'] == 'html' ){
            $output .= '<li class="'.$menu['menu_class'].'" '.$this->renderAttrs($menu).'>';
            $output .= '<div class="menu-content">'.html_entity_decode($menu['content_text']).'</div>';
            $output .= '</li>';
            return $output;
        }
        if( $this->hasChild($menu['verticalmenu_id']) ){

            $output .= '<li class="parent dropdown-submenu'.$menu['menu_class'].'" '.$this->renderAttrs($menu). '>';
            if( $menu['show_title'] ){
                $output .= '<a class="dropdown-toggle" data-toggle="dropdown" href="'.$this->getLink( $menu ).'">';
                $t = '%s';
                if( $menu['image']){ $output .= '<span class="menu-icon" style="background:url(\''.$this->shopUrl."image/".$menu['image'].'\') no-repeat;">';	}
                $output .= '<span class="menu-title">'.$menu['title']."</span>";
                if( $menu['description'] ){
                    $output .= '<span class="menu-desc">' . $menu['description'] . "</span>";
                }
                $output .= "<b class=\"caret\"></b>";
                if( $menu['image']){
                    $output .= '</span>';
                }
                $output .= '</a>';
            }
            $output .= $this->genTree( $menu['verticalmenu_id'], $level, $menu );
            $output .= '</li>';

        } else if (  $menu['megaconfig'] && $menu['megaconfig']->rows ){
            $output .= $this->genMegaMenuByConfig( $menu['verticalmenu_id'], $level, $menu );
        }else {
            $output .= '<li class="'.$menu['menu_class'].'" '.$this->renderAttrs($menu).'>';
            if( $menu['show_title'] ){
                $output .= '<a href="'.$this->getLink( $menu ).'">';

                if( $menu['image']){ $output .= '<span class="menu-icon" style="background:url(\''.$this->shopUrl."image/".$menu['image'].'\') no-repeat;">';	}
                $output .= '<span class="menu-title">'.$menu['title']."</span>";
                if( $menu['description'] ){
                    $output .= '<span class="menu-desc">' . $menu['description'] . "</span>";
                }
                if( $menu['image']){
                    $output .= '</span>';
                }

                $output .= '</a>';
            }
            $output .= '</li>';
        }
        return $output;
    }

    /**
     *
     */
    public function getLink( $menu ){
        $id = (int)$menu['item'];
        switch( $menu['type'] ){
            case 'category'     :
                return $this->url->link('product/category', 'path=' . $id);
            case 'product'      :
                return  $this->url->link('product/product', 'product_id=' . $id);
            case 'information'  :
                return   $this->url->link('information/information', 'information_id=' . $id);
            case 'manufacturer' :
                return  $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $id);
            default:
                return $menu['url'];
        }
    }

    /**
     *
     */
    public function getColWidth( $menu, $cols ){
        $output = array();

        $split = preg_split('#\s+#',$menu['submenu_colum_width'] );
        if( !empty($split) && !empty($menu['submenu_colum_width']) ){
            foreach( $split as $sp ) {
                $tmp = explode("=",$sp);
                if( count($tmp) > 1 ){
                    $output[trim(preg_replace("#col#","",$tmp[0]))]=(int)$tmp[1];
                }
            }
        }
        $tmp = array_sum($output);
        $spans = array();
        $t = 0;
        for( $i=1; $i<= $cols; $i++ ){
            if( array_key_exists($i,$output) ){
                $spans[$i] = 'col-sm-'.$output[$i];
            }else{
                if( (12-$tmp)%($cols-count($output)) == 0 ){
                    $spans[$i] = "col-sm-".((12-$tmp)/($cols-count($output)));
                }else {
                    if( $t == 0 ) {
                        $spans[$i] = "col-sm-".( ((11-$tmp)/($cols-count($output))) + 1 ) ;
                    }else {
                        $spans[$i] = "col-sm-".( ((11-$tmp)/($cols-count($output))) + 0 ) ;
                    }
                    $t++;
                }
            }
        }
        return $spans;
    }



    public function importCategories($store_id = 0){
        $sql = "SELECT cd.`name`,c.* FROM ".DB_PREFIX ."category c
				LEFT JOIN ".DB_PREFIX ."category_description cd ON c.category_id = cd.category_id
				WHERE  cd.language_id = '" . (int)$this->config->get('config_language_id') . "'
				ORDER BY parent_id ASC";
        $query = $this->db->query( $sql );
        if($query->num_rows){
            $categories = $query->rows;
        }
        $this->load->model('catalog/category');
        foreach ($categories as &$category){
            $category['language'] = $this->model_catalog_category->getCategoryDescriptions($category['category_id']);

            if($this->checkExitItemMenu($category, $store_id) == 0){
                if((int)$category['parent_id'] > 0){
                    $query1 = $this->db->query("SELECT verticalmenu_id FROM ".DB_PREFIX."verticalmenu WHERE store_id = ".$store_id." AND `type`='category' AND item='".$category['parent_id']."'");
                    $str = "SELECT verticalmenu_id FROM ".DB_PREFIX."verticalmenu WHERE store_id = ".(int)$store_id." AND `type`='category' AND item='".$category['parent_id']."'";

                    if($query1->num_rows){
                        $megamenu_parent_id = (int)$query1->row['megamenu_id'];
                    }
                } else {
                    $megamenu_parent_id = 1;
                }
                $this->insertCategory($category, $megamenu_parent_id, $store_id);
            }
        }
    }

    public function insertMenu(array $dataInput = array()){
        $data = array();

        $data['megamenu']['position'] = 99;
        $data['megamenu']['item'] = $dataInput['item_id'];
        $data['megamenu']['published'] = 1;
        $data['megamenu']['parent_id'] = $dataInput['parent_id'];
        $data['megamenu']['show_title'] = 1;
        $data['megamenu']['widget_id'] = 1;
        $data['megamenu']['type_submenu'] = 'menu';
        $data['megamenu']['type'] = $dataInput['type'];
        $data['megamenu']['colums'] = 1;
        $data['megamenu']['url'] = $dataInput['url'];
        $data['megamenu']['store_id'] = $dataInput['store_id'];
        $data['megamenu']['is_group'] = 0;

        $sql = "INSERT INTO ".DB_PREFIX . "verticalmenu ( `";
        $tmp = array();
        $vals = array();
        foreach( $data["megamenu"] as $key => $value ){
            $tmp[] = $key;
            $vals[]=$this->db->escape($value);
        }
        $sql .= implode("` , `",$tmp)."`) VALUES ('".implode("','",$vals)."') ";
        $this->db->query( $sql );
        $data['megamenu']['verticalmenu_id'] = $this->db->getLastId();

        $sql = " DELETE FROM ".DB_PREFIX ."verticalmenu_description WHERE verticalmenu_id=".(int)$data["megamenu"]['verticalmenu_id'] ;
        $this->db->query( $sql );

        $sql = "INSERT INTO ".DB_PREFIX ."verticalmenu_description(`language_id`, `verticalmenu_id`,`title`)
							VALUES('1','".$data['megamenu']['verticalmenu_id']."','".$this->db->escape($dataInput['name'])."') ";
        $this->db->query( $sql );

        return $data['megamenu']['verticalmenu_id'];
    }


    public function insertCategory($category = array(), $megamenu_parent_id, $store_id = 0){
        $data = array();
        $data['megamenu']['position'] = 99;
        $data['megamenu']['item'] = $category['category_id'];
        $data['megamenu']['published'] = 1;
        $data['megamenu']['parent_id'] = $megamenu_parent_id;
        $data['megamenu']['show_title'] = 1;
        $data['megamenu']['widget_id'] = 1;
        $data['megamenu']['type_submenu'] = 'menu';
        $data['megamenu']['type'] = 'category';
        $data['megamenu']['colums'] = 1;
        $data['megamenu']['store_id'] = $store_id;
        $data['megamenu']['is_group'] = 0;

        $sql = "INSERT INTO ".DB_PREFIX . "verticalmenu ( `";
        $tmp = array();
        $vals = array();
        foreach( $data["megamenu"] as $key => $value ){
            $tmp[] = $key;
            $vals[]=$this->db->escape($value);
        }
        $sql .= implode("` , `",$tmp)."`) VALUES ('".implode("','",$vals)."') ";
        $this->db->query( $sql );
        $data['megamenu']['verticalmenu_id'] = $this->db->getLastId();

        $sql = " DELETE FROM ".DB_PREFIX ."verticalmenu_description WHERE verticalmenu_id=".(int)$data["megamenu"]['verticalmenu_id'] ;

        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();

        if( isset($category["language"]) ){
            $sql = " DELETE FROM ".DB_PREFIX ."verticalmenu_description WHERE verticalmenu_id=".(int)$data["megamenu"]['verticalmenu_id'] ;
            $this->db->query( $sql );

            foreach( $category["language"] as $key => $categorydes ){

                $sql = "INSERT INTO ".DB_PREFIX ."verticalmenu_description(`language_id`, `verticalmenu_id`,`title`)
							VALUES(".$key.",'".$data['megamenu']['verticalmenu_id']."','".$this->db->escape($categorydes['name'])."') ";
                $this->db->query( $sql );
            }
        }
    }

    public function checkExitItemMenu($category, $store_id){
        $query = $this->db->query("SELECT verticalmenu_id FROM ".DB_PREFIX."verticalmenu WHERE store_id = ".$store_id." AND `type`='category' AND item=".$category['category_id']);
        return $query->num_rows;
    }

    /**
     * Automatic checking installation to whethere creating tables and data sample, configuration of modules.
     */
    public function install(){
        $sql = " SHOW TABLES LIKE '".DB_PREFIX."verticalmenu'";
        $query = $this->db->query( $sql );

        if( count($query->rows) <=0 ){
            $sql = array();
            $sql[]  = "
				CREATE TABLE IF NOT EXISTS `".DB_PREFIX."verticalmenu` (
				  `verticalmenu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
				  `image` varchar(255) NOT NULL DEFAULT '',
				  `parent_id` int(11) NOT NULL DEFAULT '0',
				  `is_group` smallint(6) NOT NULL DEFAULT '2',
				  `width` varchar(255) DEFAULT NULL,
				  `submenu_width` varchar(255) DEFAULT NULL,
				  `colum_width` varchar(255) DEFAULT NULL,
				  `submenu_colum_width` varchar(255) DEFAULT NULL,
				  `item` varchar(255) DEFAULT NULL,
				  `colums` varchar(255) DEFAULT '1',
				  `type` varchar(255) NOT NULL,
				  `is_content` smallint(6) NOT NULL DEFAULT '2',
				  `show_title` smallint(6) NOT NULL DEFAULT '1',
				  `type_submenu` varchar(10) NOT NULL DEFAULT '1',
				  `level_depth` smallint(6) NOT NULL DEFAULT '0',
				  `published` smallint(6) NOT NULL DEFAULT '1',
				  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0',
				  `position` int(11) unsigned NOT NULL DEFAULT '0',
				  `show_sub` smallint(6) NOT NULL DEFAULT '0',
				  `url` varchar(255) DEFAULT NULL,
				  `target` varchar(25) DEFAULT NULL,
				  `privacy` smallint(5) unsigned NOT NULL DEFAULT '0',
				  `position_type` varchar(25) DEFAULT 'top',
				  `menu_class` varchar(25) DEFAULT NULL,
				  `description` text,
				  `content_text` text,
				  `submenu_content` text,
				  `level` int(11) NOT NULL,
				  `left` int(11) NOT NULL,
				  `right` int(11) NOT NULL,
				  `widget_id` int(11) DEFAULT '0',
				  PRIMARY KEY (`verticalmenu_id`)
				) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;
			";
            $sql[] = "
						CREATE TABLE IF NOT EXISTS `".DB_PREFIX."verticalmenu_description` (
						  `verticalmenu_id` int(11) NOT NULL,
						  `language_id` int(11) NOT NULL,
						  `title` varchar(255) NOT NULL,
						  `description` text NOT NULL,
						  PRIMARY KEY (`verticalmenu_id`,`language_id`),
						  KEY `name` (`title`)
						) ENGINE=MyISAM DEFAULT CHARSET=utf8;

			";


            foreach( $sql as $q ){
                $this->db->query( $q );
            }
        }

    }
}
?>