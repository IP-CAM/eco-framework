<?php
class ModelEcothemeEcothemecontrol extends Model
{
   private $color_themes = array(
        'theme1' => array(
            'g_bg_color'                    => 'ffffff',
            'g_text_color_1' 				=> '000000',
			'g_text_color_2' 				=> '888888',
			'g_text_color_3' 				=> 'F21324',
			'g_text_color_4' 				=> 'F21324',
            
			'h_bg_color'             		=> '191919',
            'h_color_cart'        			=> 'DF0314',
            'h_color_cur_lang_1'        	=> '313131',
            'h_color_cur_lang_2'        	=> '5C5C5C',
            'h_color_1'        				=> 'ffffff',
            'h_color_2'        				=> '8F8F8F',
            'h_color_3'        				=> 'C0C0C0',
            'h_color_4'        				=> 'EA0112',
			
			'f_bg_color'                    => '060606',
            'f_color_1'                  	=> 'd4d4d4',
            'f_color_2'        				=> 'b2b2b2',
            'f_color_3'        				=> 'ffffff',
            'f_color_hover'        			=> 'EA0112',
			
            'm_bg_normal_color'             => '292929',
            'm_text_normal_color'           => 'ffffff',
            'm_text_hover_color'            => 'ffffff',
            'mdrop_bg_color'             	=> 'ffffff',
            'm_text_normal_color_1'        	=> '000000',
            'm_text_hover_color_1'       	=> 'EA0112',
            'm_text_normal_color_2' 		=> '888888',
			'm_text_hover_color_2'          => 'EA0112',
			
            's_color_1'              		=> 'ffffff',
			's_color_2'                    	=> 'ffffff',
			
            'p_name_color'         			=> '000000',
            'p_name_hover_color'   			=> 'EA0112',
            'p_des_color'        			=> '888888',
            'p_price_color'              	=> '000000',
            'p_spec_color'                  => '888888',
            'p_but_normal_color'            => 'FF1B35',
            'p_but_hover_color'     		=> 'c00917',
            'p_but_normal_color_2'          => 'ffffff',
            'p_but_hover_color_2'     		=> 'fafafa',
			'p_border_normal_color_2'		=> 'cccccc',			
			'p_border_hover_color_2'		=> '333333',
            'p_but_normal_color_3'            => '525252',
            'p_but_hover_color_3'     		=> '353535',
            'p_text_but_normal_color'       => 'ffffff',
			'p_text_but_hover_color'        => 'ffffff',
            'p_text_but_normal_color_2'       => '545454',
			'p_text_but_hover_color_2'        => '545454',
            'p_text_but_normal_color_3'       => 'ffffff',
			'p_text_but_hover_color_3'        => 'ffffff',
			
            't_page_color'                  => '000000',
            't_block_color'         		=> '545454',
			't_block_color_bg'				=> 'EAEAEA',
			't_block_color_boder'			=> 'c6c6c6',
			't_color_homefilter_text' 		=> 'ffffff',
			't_color_homefilter_bg' 		=> 'FF1B35',
			't_color_homefilter_bg_border' 	=> 'FF1B35',
            't_bread_normal_color_1'        => '888888',
            't_bread_hover_color_1'         => 'EA0112',
            't_bread_normal_color_2'        => '000000'
        ),
        'theme2' => array(
            'g_bg_color'                    => 'ffffff',
            'g_text_color_1' 				=> '000000',
			'g_text_color_2' 				=> '888888',
			'g_text_color_3' 				=> 'F21324',
			'g_text_color_4' 				=> 'F21324',
            
			'h_bg_color'             		=> 'ec1010',
            'h_color_cart'        			=> '171717',
            'h_color_cur_lang_1'        	=> 'c90000',
            'h_color_cur_lang_2'        	=> 'ff2f2f',
            'h_color_1'        				=> 'ffffff',
            'h_color_2'        				=> 'ffc7c7',
            'h_color_3'        				=> 'ffffff',
            'h_color_4'        				=> 'ffe400',		
			
			'f_bg_color'                    => 'ec1010',
            'f_color_1'                  	=> 'ffffff',
            'f_color_2'        				=> 'ffffff',
            'f_color_3'        				=> 'ffffff',
            'f_color_hover'        			=> 'ffe400',
			
            'm_bg_normal_color'             => '292929',
            'm_text_normal_color'           => 'ffffff',
            'm_text_hover_color'            => 'ffffff',
            'mdrop_bg_color'             	=> 'ffffff',
            'm_text_normal_color_1'        	=> '000000',
            'm_text_hover_color_1'       	=> 'EA0112',
            'm_text_normal_color_2' 		=> '888888',
			'm_text_hover_color_2'          => 'EA0112',
			
            's_color_1'              		=> 'ffffff',
			's_color_2'                    	=> 'ffffff',
			
            'p_name_color'         			=> '000000',
            'p_name_hover_color'   			=> 'EA0112',
            'p_des_color'        			=> '888888',
            'p_price_color'              	=> '000000',
            'p_spec_color'                  => '888888',
            'p_but_normal_color'            => 'FF1B35',
            'p_but_hover_color'     		=> 'c00917',
            'p_but_normal_color_2'          => 'ffffff',
            'p_but_hover_color_2'     		=> 'fafafa',
			'p_border_normal_color_2'		=> 'cccccc',			
			'p_border_hover_color_2'		=> '333333',
            'p_but_normal_color_3'            => '525252',
            'p_but_hover_color_3'     		=> '353535',
            'p_text_but_normal_color'       => 'ffffff',
			'p_text_but_hover_color'        => 'ffffff',
            'p_text_but_normal_color_2'       => '545454',
			'p_text_but_hover_color_2'        => '545454',
            'p_text_but_normal_color_3'       => 'ffffff',
			'p_text_but_hover_color_3'        => 'ffffff',
			
            't_page_color'                  => '000000',
            't_block_color'         		=> '545454',
			't_block_color_bg'				=> 'EAEAEA',
			't_block_color_boder'			=> 'c6c6c6',
			't_color_homefilter_text' 		=> 'ffffff',
			't_color_homefilter_bg' 		=> 'ff1b35',
			't_color_homefilter_bg_border' 	=> 'ff1b35',
            't_bread_normal_color_1'        => '888888',
            't_bread_hover_color_1'         => 'EA0112',
            't_bread_normal_color_2'        => '000000'
        ),
        'theme3' => array(
            'g_bg_color'                    => 'ffffff',
            'g_text_color_1' 				=> '000000',
			'g_text_color_2' 				=> '888888',
			'g_text_color_3' 				=> '699d03',
			'g_text_color_4' 				=> '699d03',
            
			'h_bg_color'             		=> '720648',
            'h_color_cart'        			=> '85c603',
            'h_color_cur_lang_1'        	=> '1e1e1e',
            'h_color_cur_lang_2'        	=> '616161',
            'h_color_1'        				=> 'ffffff',
            'h_color_2'        				=> '888888',
            'h_color_3'        				=> 'ffffff',
            'h_color_4'        				=> 'ffe400',
			
			'f_bg_color'                    => '720648',
            'f_color_1'                  	=> 'ffffff',
            'f_color_2'        				=> 'ffffff',
            'f_color_3'        				=> 'ffffff',
            'f_color_hover'        			=> 'ffe400',
			
            'm_bg_normal_color'             => '292929',
            'm_text_normal_color'           => 'ffffff',
            'm_text_hover_color'            => 'ffffff',
            'mdrop_bg_color'             	=> 'ffffff',
            'm_text_normal_color_1'        	=> '000000',
            'm_text_hover_color_1'       	=> '699d03',
            'm_text_normal_color_2' 		=> '888888',
			'm_text_hover_color_2'          => '699d03',
			
            's_color_1'              		=> 'ffffff',
			's_color_2'                    	=> 'ffffff',
			
            'p_name_color'         			=> '000000',
            'p_name_hover_color'   			=> '699d03',
            'p_des_color'        			=> '888888',
            'p_price_color'              	=> '000000',
            'p_spec_color'                  => '888888',
            'p_but_normal_color'            => '91d803',
            'p_but_hover_color'     		=> '699d03',
            'p_but_normal_color_2'          => 'ffffff',
            'p_but_hover_color_2'     		=> 'fafafa',
			'p_border_normal_color_2'		=> 'cccccc',			
			'p_border_hover_color_2'		=> '333333',
            'p_but_normal_color_3'            => '525252',
            'p_but_hover_color_3'     		=> '353535',
            'p_text_but_normal_color'       => 'ffffff',
			'p_text_but_hover_color'        => 'ffffff',
            'p_text_but_normal_color_2'       => '545454',
			'p_text_but_hover_color_2'        => '545454',
            'p_text_but_normal_color_3'       => 'ffffff',
			'p_text_but_hover_color_3'        => 'ffffff',
			
            't_page_color'                  => '000000',
            't_block_color'         		=> '545454',
			't_block_color_bg'				=> 'EAEAEA',
			't_block_color_boder'			=> 'c6c6c6',
			't_color_homefilter_text' 		=> 'ffffff',
			't_color_homefilter_bg' 		=> '91d803',
			't_color_homefilter_bg_border' 	=> '91d803',
            't_bread_normal_color_1'        => '888888',
            't_bread_hover_color_1'         => '699d03',
            't_bread_normal_color_2'        => '000000'
        )
    );
	
	private $background = array(
            'g_bg_image_1'       => 'back_1.png',
            'g_bg_image_2'       => 'back_2.png',
            'g_bg_image_3'       => 'back_3.png',
            'g_bg_image_4'       => 'back_4.png',
            'g_bg_image_5'       => 'back_5.png',
            'g_bg_image_6'       => 'back_6.png',
			'g_bg_image_7'       => 'back_7.png',
            'g_bg_image_8'       => 'back_8.png',
            'g_bg_image_9'       => 'back_9.png',
            'g_bg_image_10'       => 'back_10.png',
            'g_bg_image_11'       => 'back_11.png',
            'g_bg_image_12'       => 'back_12.png',
			'g_bg_image_13'       => 'back_13.png',
            'g_bg_image_14'       => 'back_14.png',
            'g_bg_image_15'       => 'back_15.png'
    );

    private $theme_name;
	

    private $theme_names = array(
        'theme1' => 'Black',
        'theme2' => 'Red',
        'theme3' => 'Violet'
    );

    public function setThemeName($theme_name)
    {
        $this->theme_name = $theme_name;
    }

   
    public function getThemeNames()
    {
        return $this->theme_names;
    }

    public function getColorThemes()
    {
        return $this->color_themes;
    }
	
	public function getBackgrounds()
    {
        return $this->background;
    }
	
	function getExtensions($type) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = '" . $this->db->escape($type) . "'");

		return $query->rows;
	}

}