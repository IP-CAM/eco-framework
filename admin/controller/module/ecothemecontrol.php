<?php
class ControllerModuleEcothemecontrol extends Controller {
    private $error = array(); // This is used to set the errors, if any.

    public function index() {
        // Loading the language file of ecothemecontrol
        $this->load->language('module/ecothemecontrol');

        // Set the title of the page to the heading title in the Language file i.e., Hello World
        $this->document->setTitle(strip_tags($this->language->get('heading_title')));

        // Load the Setting Model  (All of the OpenCart Module & General Settings are saved using this Model )
        $this->load->model('setting/setting');

        // Start If: Validates and check if data is coming by save (POST) method
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            // Parse all the coming data to Setting Model to save it in database.

            $this->model_setting_setting->editSetting('ecothemecontrol', array('ecothemecontrol' => $this->request->post));

            // To display the success text on data save
            $this->session->data['success'] = $this->language->get('text_success');

            // Redirect to the Module Listing
            $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        // Assign the language data for parsing it to view
        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit']    = $this->language->get('text_edit');
        $data['text_yes']    = $this->language->get('text_yes');
        $data['text_no']    = $this->language->get('text_no');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_content_top'] = $this->language->get('text_content_top');
        $data['text_content_bottom'] = $this->language->get('text_content_bottom');
        $data['text_column_left'] = $this->language->get('text_column_left');
        $data['text_column_right'] = $this->language->get('text_column_right');

        $data['entry_code'] = $this->language->get('entry_code');
        $data['entry_layout'] = $this->language->get('entry_layout');
        $data['entry_position'] = $this->language->get('entry_position');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_add_module'] = $this->language->get('button_add_module');
        $data['button_remove'] = $this->language->get('button_remove');



        // This Block returns the warning if any
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        // This Block returns the error code if any
        if (isset($this->error['code'])) {
            $data['error_code'] = $this->error['code'];
        } else {
            $data['error_code'] = '';
        }

        // Making of Breadcrumbs to be displayed on site
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
            'href'      => $this->url->link('module/ecothemecontrol', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $data['action'] = $this->url->link('module/ecothemecontrol', 'token=' . $this->session->data['token'], 'SSL'); // URL to be directed when the save button is pressed

        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'); // URL to be redirected when cancel button is pressed

        // This block checks, if the hello world text field is set it parses it to view otherwise get the default
        // hello world text field from the database and parse it

        $config_data = array(

            'eco_address',
            'eco_phone',
            'eco_email',
            'eco_fb',
            'eco_twitter',
            'eco_gglplus',
            'eco_rss',
            'eco_pinterest',
            'eco_linkedin',
            'eco_youtube',
            'eco_powerby',
            'eco_home_option',
            'eco_quickview_button',
            'eco_scroll_totop',
            'eco_sale_label',
            'eco_sale_labeltitle',
            'eco_sale_labelcolor',
            'eco_menubar_cb',
            'eco_menubar_cbtitle',
            'eco_menubar_cbcontent',
            'eco_vmenubar_cb',
            'eco_vmenubar_cbtitle',
            'eco_vmenubar_cbcontent',
            'eco_product_ct',
            'eco_product_cttitle',
            'eco_product_ctcontent',
            'eco_product_ct2',
            'eco_product_ct2title',
            'eco_product_ct2content',
            'eco_newsletter',
            'eco_newslettercontent',
            'eco_footer_cb',
            'eco_footer_cbcontent',
            'eco_body_bg',
            'eco_body_bg_ed',
            'eco_fontcolor',
            'eco_fontcolor_ed',
            'eco_linkcolor',
            'eco_linkcolor_ed',
            'eco_linkhovercolor',
            'eco_linkhovercolor_ed',
            'eco_headerbg',
            'eco_headerbg_ed',
            'eco_headerlinkcolor',
            'eco_headerlinkcolor_ed',
            'eco_headerlinkhovercolor',
            'eco_headerlinkhovercolor_ed',
            'eco_headerclcolor',
            'eco_headerclcolor_ed',
            'eco_mmbgcolor',
            'eco_mmbgcolor_ed',
            'eco_mmlinkscolor',
            'eco_mmlinkscolor_ed',
            'eco_mmlinkshovercolor',
            'eco_mmlinkshovercolor_ed',
            'eco_mmslinkscolor',
            'eco_mmslinkscolor_ed',
            'eco_mmslinkshovercolor',
            'eco_mmslinkshovercolor_ed',
            'eco_buttoncolor',
            'eco_buttoncolor_ed',
            'eco_buttonhovercolor',
            'eco_buttonhovercolor_ed',
            'eco_pricecolor',
            'eco_pricecolor_ed',
            'eco_oldpricecolor',
            'eco_oldpricecolor_ed',
            'eco_newpricecolor',
            'eco_newpricecolor_ed',
            'eco_footerbg',
            'eco_footerbg_ed',
            'eco_footerlinkcolor',
            'eco_footerlinkcolor_ed',
            'eco_footerlinkhovercolor',
            'eco_footerlinkhovercolor_ed',
            'eco_powerbycolor',
            'eco_powerbycolor_ed',
            'eco_fonttransform',
            'eco_productpage_cb',
            'eco_productpage_cbcontent',
            'eco_ffb_ed',
            'eco_ffb_content',
            'eco_maintenancedate',
            'eco_animation_effects'
        );

        foreach ($config_data as $conf) {
            if (isset($this->request->post[$conf])) {
                $data[$conf] = $this->request->post[$conf];

            } else {
                $data[$conf] = $this->config->get($conf);

            }
        }
        $aThemeSettings = $this->model_setting_setting->getSetting('ecothemecontrol',0);
        if(isset($aThemeSettings['ecothemecontrol'])) $data = array_merge($data,$aThemeSettings['ecothemecontrol']);

        $this->load->model('tool/image');
        if (isset($this->request->post['image']) && is_file(DIR_IMAGE . $this->request->post['image'])) {
            $data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
        } elseif (!empty($aThemeSettings['ecothemecontrol']) && is_file(DIR_IMAGE . $aThemeSettings['ecothemecontrol']['image'])) {
            $data['thumb'] = $this->model_tool_image->resize($aThemeSettings['ecothemecontrol']['image'], 100, 100);
        } else {
            $data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }


        $this->load->model('extension/extension');

        $this->load->model('extension/module');

        $data['extensions'] = array();

        // Get a list of installed modules
        $extensions = $this->model_extension_extension->getInstalled('module');

        // Add all the modules which have multiple settings for each module
        foreach ($extensions as $code) {
            $this->load->language('module/' . $code);

            $module_data = array();

            $modules = $this->model_extension_module->getModulesByCode($code);

            foreach ($modules as $module) {
                $module_data[] = array(
                    'name' => $this->language->get('heading_title') . ' &gt; ' . $module['name'],
                    'code' => $code . '.' .  $module['module_id']
                );
            }

            if ($this->config->has($code . '_status') || $module_data) {
                $data['extensions'][] = array(
                    'name'   => $this->language->get('heading_title'),
                    'code'   => $code,
                    'module' => $module_data
                );
            }
        }

        if (isset($this->request->post['layout_module']) ) {
            $data['module_code'] = $this->request->post['layout_module'];
        } else {
            $data['module_code'] = $aThemeSettings['ecothemecontrol']['layout_module'];
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');


        $this->response->setOutput($this->load->view('module/ecothemecontrol/ecothemecontrol.tpl', $data));

    }

    /* Function that validates the data when Save Button is pressed */
    protected function validate() {

        // Block to check the user permission to manipulate the module
        if (!$this->user->hasPermission('modify', 'module/ecothemecontrol')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        /* End Block*/

        // Block returns true if no error is found, else false if any error detected
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
?>