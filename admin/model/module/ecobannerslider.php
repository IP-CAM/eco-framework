<?php
class ModelModuleEcobannerslider extends Model {
	public function getInfo($module_id) {
		$ecobannerslider_image_data = array();

		$ecobannerslider_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE module_id = '" . (int)$module_id . "' ");
        $info = $ecobannerslider_image_query->rows;
        $ecobannerslider = unserialize($info[0]['setting']);
		foreach ($ecobannerslider['ecobannerslider_image'] as $ecobannerslider_image) {

			foreach ($ecobannerslider_image['ecobannerslider_image_description'] as $key => $value) {
				$description[$key]=array('description'=>$value['description']);
				}
			foreach ($ecobannerslider_image['ecobannerslider_image_title'] as $key => $value) {
			$title[$key]=array('title'=>$value['title']);
			}	

			$ecobannerslider_image_data[] = array(
				'ecobannerslider_image_title'       => $title,
				'link'                          => $ecobannerslider_image['link'],
				'image'                         => $ecobannerslider_image['image'],
				'ecobannerslider_image_description' => $description
			);
		}

		return $ecobannerslider_image_data;
	}
}?>