
var ZO2AdminMegamenu = window.ZO2AdminMegamenu || {};
!function($) {
    var currentSelected = null,
        megamenu, nav_items, nav_subs, nav_cols, nav_all;
    $.fn.megamenuAdmin = function(options) {
        var defaultOptions = {
        };
        var options = $.extend(defaultOptions, options);
        megamenu = $(this).find('.zo2-megamenu');
        nav_items = megamenu.find('ul[class*="level"]>li>:first-child');
        nav_subs = megamenu.find('.menu-child');
        nav_cols = megamenu.find('[class*="span"]');
        nav_all = nav_items.add(nav_subs).add(nav_cols);
        nav_all = nav_all.add('#zo2-admin-mm-container');
        // hide sub
        nav_items.each(function() {
            var a = $(this),
                liitem = a.closest('li');
            if (liitem.data('hidesub') === 1) {
                var sub = liitem.find('.menu-child:first');
                // check if have menu-items in sub
                sub.css('display', 'none');
                a.removeClass('dropdown-toggle').data('toggle', '');
                liitem.removeClass('dropdown dropdown-submenu mega');
            }
        });

        // hide toolbox
        hide_toolbox(true);
        // bind events for all selectable elements
        bindEvents(nav_all);
        // unbind all events for toolbox actions & inputs
        $('.toolbox-action, .toolbox-toggle, .toolbox-input').unbind("focus blur click change keydown");
        // stop popup event when click in toolbox area
        $('.zo2-admin-mm-row').click(function(event) {
            event.stopPropagation();
            // return false;
        });



        // deselect when click outside menu
        $(document.body).click(function(event) {
            hide_toolbox(true);
            $('.popover').popover('hide', function() {
                $('.popover').remove();
            });
            if($('#editMenuName').length)
            {
                $('#editMenuName').parent().text($('#editMenuName').val());
                $('#editMenuName').remove();
            }
            //event.stopPropagation();
        });
        // bind event for action
        $('.toolbox-action').click(function(event) {
            var action = $(this).data('action');
            if (action) {
                actions.datas = $(this).data();
                actions.datas = $.extend(options,actions.datas);
                actions[action]();
            }
            event.stopPropagation();
            return false;
        });
        $('.toolbox-toggle').change(function(event) {
            var action = $(this).data('action');
            if (action) {
                actions.datas = $(this).data();
                actions[action]();
            }
            event.stopPropagation();
            return false;
        });
        // ignore events
        $('.toolbox-input').bind('focus blur click', function(event) {
            event.stopPropagation();
            return false;
        });
        $('.toolbox-input').bind('keydown', function(event) {
            if (event.keyCode === 13) {
                apply_toolbox(this);
                event.preventDefault();
            }
        });
        $('.toolbox-input').change(function(event) {
            apply_toolbox(this);
            event.stopPropagation();
            return false;
        });
        return this;
    };
    // Actions
    var actions = {};
    actions.toggleSub = function() {
        if (!currentSelected)
            return;
        var liitem = currentSelected.closest('li'),
            sub = liitem.find('.menu-child:first');
        if (liitem.data('group'))
            return; // not allow do with group
        if (sub.length === 0 || sub.css('display') === 'none') {
            // add sub
            if (sub.length === 0) {
                sub = $('<div class="menu-child  dropdown-menu"><div class="mega-dropdown-inner"><div class="row-fluid"><div class="span12" data-colwidth="12"><div class="mega-inner"></div></div></div></div></div>').appendTo(liitem);
                bindEvents(sub.find('[class*="span"]'));
                liitem.addClass('mega');
            } else {
                // sub.attr('style', '');
                sub.css('display', '');
                liitem.data('hidesub', 0);
            }
            liitem.data('group', 0);
            currentSelected.addClass('dropdown-toggle').data('toggle', 'dropdown');
            liitem.addClass(liitem.data('level') === 1 ? 'dropdown' : 'dropdown-submenu');
            bindEvents(sub);
        } else {
            unbindEvents(sub);
            // check if have menu-items in sub
            if (liitem.find('ul.level' + liitem.data('level')).length > 0) {
                sub.css('display', 'none');
                liitem.data('hidesub', 1);
            } else {
                // just remove it
                sub.remove();
            }
            liitem.data('group', 0);
            currentSelected.removeClass('dropdown-toggle').data('toggle', '');
            liitem.removeClass('dropdown dropdown-submenu mega');
        }
        // update toolbox status
        update_toolbox();
    };

    actions.addMenu = function() {
        if (!currentSelected)
            return;

        if(currentSelected.attr('id') == 'zo2-admin-mm-container'){
            var menuInput = $('#zo2-admin-mm-toolmenu'),
                parentId = 0;

        } else {
            var menuInput = $('#zo2-admin-mm-toolcol'),
                parentId = currentSelected.closest('li').data('id');
        }

        var menuType = menuInput.find('.toolmenu-type:first').val();
        if(menuInput.find('.toolmenu-name:first').val() == ''){alert('Name cannot be empty'); return ; }
        if(menuType == ''){  alert('Type cannot be empty'); return ; }
        switch (menuType)
        {
            case 'url':
                var url = menuInput.find('input[name="toolmenu-url"]').val(),
                    itemId = null;
                break;
            case 'category':
                var itemId = menuInput.find('input[name="toolmenu-category"]').data('id'),
                    url = null;
                break;
            case 'information':
                var itemId = menuInput.find('select[name="toolmenu-information"]').val(),
                    url = null;
                break;
        }

        var menuName = menuInput.find('.toolmenu-name:first').val(),
            storeId = $('#stores').val();

        $.ajax({
            url : options.add_menu,
            data : {name : menuName, item_id : itemId, type: menuType, store_id : storeId, parent_id : parentId, url : url},
            dataType : 'json',
            type : 'POST'
        }).done(function(data){
            if(currentSelected.find('ul').is('ul'))
            {
                var menuHtml = '<li data-subwidth="" data-subclass="" data-class="" data-align="left"  data-group="0" data-id="' + data + '" class="">'
                    + '<a href="#" class=""><span class="menu-title">' + menuInput.find('.toolmenu-name:first').val() + '</span></a></li>';
                var  $menu = $(menuHtml).appendTo(currentSelected.find('ul:first'));
            }else{
                var menuHtml = '<ul><li data-subwidth="" data-subclass="" data-class="" data-align="left"  data-group="0" data-id="' + data + '" class="">'
                    + '<a href="#" class=""><span class="menu-title">' + menuInput.find('.toolmenu-name:first').val() + '</span></a></li></ul>';
                var  $menu = $(menuHtml).appendTo(currentSelected.find('.mega-inner'));
            }
            $menu.closest('[class*="span"]').data('type','menu');
            var menulist = $menu.closest('[class*="span"]').data('menulist') ? $menu.closest('[class*="span"]').data('menulist') : "";
            menulist += data + ",";
            $menu.closest('[class*="span"]').removeData('menulist').data('menulist',menulist);
            bindEvents($menu.find('a:first'));
            // update toolbox status
            $('.popover').remove();
            currentSelected = null;
            show_toolbox($menu.find('a:first'));
        });
    };

    actions.removeMenu = function() {
        if (!currentSelected)
            return;
        if(confirm('Are you sure want to delete?')){

            $.ajax({
                url : options.remove_menu,
                data : {id : currentSelected.closest('li').data('id'), store_id : $('#stores').val()},
                dataType : 'json',
                type : 'POST'
            }).done(function(){
                currentSelected.closest('li').remove();
            });

        }
    };

    actions.toggleGroup = function() {
        if (!currentSelected)
            return;
        var liitem = currentSelected.parent(),
            sub = liitem.find('.menu-child:first');
        if (liitem.data('level') === 1)
            return; // ignore for top level
        if (liitem.data('group')) {
            liitem.data('group', 0);
            liitem.removeClass('mega-group').addClass('dropdown-submenu');
            currentSelected.addClass('dropdown-toggle').data('toggle', 'dropdown');
            sub.removeClass('mega-group-content').addClass('dropdown-menu mega-dropdown-menu');
            sub.css('width', sub.data('width'));
            rebindEvents(sub);
        } else {
            currentSelected.removeClass('dropdown-toggle').data('toggle', '');
            liitem.data('group', 1);
            liitem.removeClass('dropdown-submenu').addClass('mega-group');
            sub.removeClass('dropdown-menu mega-dropdown-menu').addClass('mega-group-content');
            sub.css('width', '');
            rebindEvents(sub);
        }
        // update toolbox status
        update_toolbox();
    };


    actions.addRow = function() {
        if (!currentSelected)
            return;
        var $row = $('<div class="row-fluid"><div class="span12" data-colwidth="12"><div class="mega-inner"></div></div></div>').appendTo(currentSelected.find('.mega-dropdown-inner:first')),
            $col = $row.children();
        // bind event
        bindEvents($col);
        currentSelected = null;
        // switch selected to new column
        show_toolbox($col);
    };

    actions.alignment = function() {
        var liitem = currentSelected.closest('li');
        liitem.removeClass('mega-align-left mega-align-center mega-align-right mega-align-justify').addClass('mega-align-' + actions.datas.align);
        if (actions.datas.align === 'justify') {

            currentSelected.addClass('span12');
            currentSelected.css('width', '');
        } else {
            currentSelected.removeClass('span12');
            if (currentSelected.data('width'))
                currentSelected.css('width', currentSelected.data('width'));
        }
        liitem.data('align', actions.datas.align);
        update_toolbox();
    };

    actions.addColumn = function() {
        if (!currentSelected)
            return;
        var $cols = currentSelected.parent().children('[class*="span"]'),
            colcount = $cols.length + 1,
            colwidths = defaultColumnsWidth(colcount);
        // add new column
        var $col = $('<div><div class="mega-inner"></div></div>');
        if (actions.datas.addfirst)
            $col.prependTo(currentSelected.parent());
        else {
            $col.insertAfter(currentSelected);
        }
        $cols = $cols.add($col);
        // bind event
        bindEvents($col);
        // update width
        $cols.each(function(i) {
            $(this).removeClass('span' + $(this).data('colwidth')).addClass('span' + colwidths[i]).data('colwidth', colwidths[i]);
        });
        // switch selected to new column
        show_toolbox($col);
    };

    actions.removeColumn = function() {
        if (!currentSelected) {
            return;
        }
        var $col = currentSelected,
            $row = $col.parent(),
            $rows = $row.parent().children('[class*="row"]'),
            $allcols = $rows.children('[class*="span"]'),
            $allmenucols = $allcols.filter(function() {
                return !$(this).data('module_id');
            }),
            $haspos = $allcols.filter(function() {
                return $(this).data('module_id');
            }).length,
            $cols = $row.children('[class*="span"]'),
            colcount = $cols.length - 1,
            colwidths = defaultColumnsWidth(colcount),
            type_menu = $col.data('module_id') ? false : true;
        if ((type_menu && ((!$haspos && $allmenucols.length === 1) || ($haspos && $allmenucols.length === 0)))
            ) {
            // if this is the only one column left
            return;
        }

        if($col.data('type') == 'menu')
        {
            var menulist = $col.data('menulist');

            $.ajax({
                url : options.remove_menu,
                data : {id : menulist, store_id : $('#stores').val()},
                dataType : 'json',
                type : 'POST'
            })
        }

        // remove column
        // check and move content to other column
        if (type_menu) {
            var colidx = $allmenucols.index($col),
                tocol = colidx === 0 ? $allmenucols[1] : $allmenucols[colidx - 1];
            $col.find('ul:first > li').appendTo($(tocol).find('ul:first'));
        }
        
        var colidx = $allcols.index($col),
            nextActiveCol = colidx === 0 ? $allcols[1] : $allcols[colidx - 1];
        if (colcount < 1) {
            if($allcols.length <= 1){ $row.parent().parent().parent().removeClass('mega');  $row.parent().parent().remove();  }
            else $row.remove();
        } else {
            $cols = $cols.not($col);
            // update width
            $cols.each(function(i) {
                $(this).removeClass('span' + $(this).data('colwidth')).addClass('span' + colwidths[i]).data('colwidth', colwidths[i]);
            });
            // remove col
            $col.remove();
        }

        show_toolbox($(nextActiveCol));
    };

    actions.hideWhenCollapse = function() {
        if (!currentSelected)
            return;
        var type = toolbox_type();
        if (type === 'sub') {
            var liitem = currentSelected.closest('li');
            if (liitem.data('hidewcol')) {
                liitem.data('hidewcol', 0);
                liitem.removeClass('sub-hidden-collapse');
            } else {
                liitem.data('hidewcol', 1);
                liitem.addClass('sub-hidden-collapse');
            }
        } else if (type === 'col') {
            if (currentSelected.data('hidewcol')) {
                currentSelected.data('hidewcol', 0);
                currentSelected.removeClass('hidden-collapse');
            } else {
                currentSelected.data('hidewcol', 1);
                currentSelected.addClass('hidden-collapse');
            }
        }
        update_toolbox();
    };

    toolbox_type = function() {
        if(currentSelected.attr('id') == 'zo2-admin-mm-container') return 'menu';
        return currentSelected.hasClass('menu-child') ? 'sub' : (currentSelected.length > 0 && currentSelected[0].tagName === 'DIV' ? 'col' : 'item');
    };

    hide_toolbox = function(show_intro) {
        $('#zo2-admin-mm-tb .admin-toolbox, #zo2-admin-mm-tb  .admin-hide').hide();
        currentSelected = null;
        if (megamenu && megamenu.data('nav_all'))
            megamenu.data('nav_all').removeClass('selected');
        megamenu.find('li').removeClass('open');
        $('#zo2-admin-mm-container').removeClass('selected');
        if (show_intro) {
            $('#zo2-admin-mm-intro').show();
        } else {
            $('#zo2-admin-mm-intro').hide();
        }
    };

    show_toolbox = function(selected) {
        hide_toolbox(false);
        if (selected)
            currentSelected = selected;
        // remove class open for other
        megamenu.find('ul[class*="level"] > li').each(function() {
            if (!$(this).has(currentSelected).length > 0)
                $(this).removeClass('open');
            else
                $(this).addClass('open');
        });
        // set selected
        megamenu.data('nav_all').removeClass('selected');
        currentSelected.addClass('selected');
        //Clear default data
        $('input[class*="toolmenu"], select[class*="toolmenu"]').val('');
        var type = toolbox_type();
        $('#zo2-admin-mm-tool' + type).show();
        update_toolbox(type);
        $('#zo2-admin-mm-tb').show();


    };

    edit_menu = function(Selected){
        if(!currentSelected) currentSelected = Selected;


        if(currentSelected.prop("tagName") != 'A') return;

        var oldName = currentSelected.find('span').text();

        if($('#editMenuName').length)
        {
            $('#editMenuName').parent().text($('#editMenuName').val());
            $('#editMenuName').remove();
        }
        currentSelected.find('span').text('');
        currentSelected.find('span').append('<input type="text" value="' + oldName + '" id="editMenuName"/>')

        if(currentSelected.attr('id') != 'zo2-admin-mm-container'){
            $('.popover').popover('hide', function() {
                $('.popover').remove();
            });
            currentSelected.popover({
                html: true,
                placement: 'top',
                trigger: 'manual',
                content: function() {
                    return '<button type="button" id="button-image" data-toggle="modal" data-target="#menuModal" class="btn btn-primary btn-lg"><i class="fa fa-save"></i></button>';
                }
            });
            currentSelected.popover('show');


            $('#button-image').on('click', function(event) {
                $.ajax({
                    url : options.edit_menu,
                    data : {name : $('#editMenuName').val(), menu_id : currentSelected.closest('li').data('id')},
                    dataType : 'json',
                    type : 'POST'
                }).done(function(){
                    currentSelected.find('span').text($('#editMenuName').val());
                    $('#editMenuName').remove();
                });



                currentSelected.popover('hide', function() {
                    $('.popover').remove();
                });

                event.stopPropagation();
            });

        }
    };

    update_toolbox = function(type) {
        if (!type)
            type = toolbox_type();
        // remove all disabled status
        $('#zo2-admin-mm-tb .disabled').removeClass('disabled');
        $('#zo2-admin-mm-tb .active').removeClass('active');
        switch (type) {
            case 'item':
                // value for toggle
                var liitem = currentSelected.closest('li'),
                    liparent = liitem.parent().closest('li'),
                    sub = liitem.find('.menu-child:first');
                $('.toolitem-exclass').attr('value', liitem.data('class') || '');
                $('.toolitem-xicon').attr('value', liitem.data('xicon') || '');
                $('.toolitem-caption').attr('value', liitem.data('caption') || '');
                // toggle Submenu
                var toggle = $('.toolitem-sub');
                toggle.find('label').removeClass('active btn-success btn-danger btn-primary');
                if (liitem.data('group')) {
                    // disable the toggle
                    $('.toolitem-sub').addClass('disabled');
                } else if (sub.length === 0 || sub.css('display') === 'none') {
                    // sub disabled
                    update_toggle(toggle, 0);
                } else {
                    // sub enabled
                    update_toggle(toggle, 1);
                }

                // toggle Group
                var toggle = $('.toolitem-group');
                toggle.find('label').removeClass('active btn-success btn-danger btn-primary');
                if (liitem.data('level') === 1 || sub.length === 0 || liitem.data('hidesub') === 1) {
                    // disable the toggle
                    $('.toolitem-group').addClass('disabled');
                } else if (liitem.data('group')) {
                    // Group off
                    update_toggle(toggle, 1);
                } else {
                    // Group on
                    update_toggle(toggle, 0);
                }

                // move left/right column action: disabled if this item is not in a mega submenu
                if (!liparent.length || !liparent.hasClass('mega')) {
                    $('.toolitem-moveleft, .toolitem-moveright').addClass('disabled');
                }

                break;
            case 'sub':
                var liitem = currentSelected.closest('li');
                if(currentSelected.hasClass('menu-child')) $('.toolsub-exclass').attr('value', liitem.data('subclass') || '');
                else $('.toolsub-exclass').attr('value', currentSelected.data('subclass') || '');

                if (liitem.data('group')) {
                    $('.toolsub-width').attr('value', '').addClass('disabled');
                    // disable alignment
                    $('.toolitem-alignment').addClass('disabled');
                } else {
                    $('.toolsub-width').attr('value', liitem.data('subwidth') || '');
                    // if not top level, allow align-left & right only
                    if (liitem.data('level') > 1) {
                        $('.toolsub-align-center').addClass('disabled');
                        $('.toolsub-align-justify').addClass('disabled');
                    }

                    // active align button
                    if (liitem.data('align')) {
                        $('.toolsub-align-' + liitem.data('align')).addClass('active');
                        if (liitem.data('align') === 'justify') {
                            $('.toolsub-width').addClass('disabled');
                        }
                    }
                }

                // toggle hidewhencollapse
                var toggle = $('.toolsub-hidewhencollapse');
                toggle.find('label').removeClass('active btn-success btn-danger btn-primary');
                if (liitem.data('hidewcol')) {
                    // toggle enable
                    update_toggle(toggle, 1);
                } else {
                    // toggle disable
                    update_toggle(toggle, 0);
                }

                break;
            case 'col':
                $('.toolcol-exclass').attr('value', currentSelected.data('class') || '');
                //$('.toolcol-module').attr('value', currentSelected.data ('module_id') || '');
                //$('.toolcol-width').attr('value', currentSelected.data ('width') || '');
                $('.toolcol-module').val(currentSelected.data('module_id') || '').trigger("liszt:updated");
                $('.toolcol-width').val(currentSelected.data('width') || '').trigger("liszt:updated");
                /* enable/disable module chosen */
                //if (currentSelected.find('.mega-nav').length > 0) {
                //    $('.toolcol-module').parent().addClass('disabled');
                //}else{
                //    $('.toolmenu-category').parent().addClass('disabled');
                //    $('.toolmenu-url').parent().addClass('disabled');
                //    $('.toolmenu-information').parent().addClass('disabled');
                //}
                // disable choose width if signle column
                if (currentSelected.parent().children().length === 1) {
                    $('.toolcol-width').parent().addClass('disabled');
                }

                // toggle hidewhencollapse
                var toggle = $('.toolcol-hidewhencollapse');
                toggle.find('label').removeClass('active btn-success btn-danger btn-primary');
                if (currentSelected.data('hidewcol')) {
                    // toggle enable
                    update_toggle(toggle, 1);
                } else {
                    // toggle disable
                    update_toggle(toggle, 0);
                }

                break;
        }
    };

    update_toggle = function(toggle, val) {
        var $input = toggle.find('input[value="' + val + '"]');
        $input.attr('checked', 'checked');
        $input.trigger('update');
    };

    apply_toolbox = function(input) {
        var name = $(input).data('name'),
            value = input.value,
            type = toolbox_type();
        switch (name) {
            case 'width':
                if (type === 'sub') {
                    currentSelected.width(value);
                }
                if (type === 'col') {
                    currentSelected.removeClass('span' + currentSelected.data('col'+name)).addClass('span' + value);
                }
                currentSelected.data('col'+name, value);
                currentSelected.parent().data('subwidth', value);
                break;
            case 'class':
                if (type === 'item') {
                    var item = currentSelected.closest('li');
                    item.data('class', value);
                }else if(type === 'sub') {
                    currentSelected.parent().data('subclass', value);
                }
                else {
                    var item = currentSelected;
                    item.data('class', value);
                }
                item.removeClass(item.data(name) || '').addClass(value);
                break;
            case 'xicon':
                if (type === 'item') {
                    currentSelected.closest('li').data(name, value);
                    currentSelected.find('i').remove();
                    if (value)
                        currentSelected.prepend($('<i class="' + value + '"></i>'));
                }
                break;
            case 'caption':
                if (type === 'item') {
                    currentSelected.closest('li').data(name, value);
                    currentSelected.find('span.mega-caption').remove();
                    if (value)
                        currentSelected.append($('<span class="mega-caption">' + value + '</span>'));
                }
                break;
            case 'module_id':
                // replace content if this is not menu-items type
                if (currentSelected.find('ul[class*="level"]').length === 0) {
                    // get module content
                    var mudule_name = $(input).find("option:selected").text();

                    if(currentSelected.find('.mega-inner').html() != ''){
                        if(confirm('Do you want to replace')) currentSelected.find('.mega-inner').html('');
                    }
                    currentSelected.find('.mega-inner').append('<div>'+ mudule_name +'</div>');
                    currentSelected.data(name, value);
                    currentSelected.data('module_name', mudule_name);
                }
                break;
            case 'menu_type':
                $('#zo2-admin-mm-tb .admin-hide').hide();
                if(currentSelected.find('ul.mega-nav').length > 0){
                    if(value == 'module') return;
                }else
                {
                    if(value != 'module' && currentSelected.data('module_id')) return;
                }

                if(currentSelected.attr('id') != 'zo2-admin-mm-container'){
                    $('#zo2-admin-mm-toolcol .toolmenu-'+value).closest('li').show();
                    if(value != 'module'){ $('#zo2-admin-mm-toolcol > ul:last').show(); $('#zo2-admin-mm-toolcol > ul:eq(6)').show();}
                }
                else {
                    $('#zo2-admin-mm-toolmenu .toolmenu-'+value).closest('li').show();
                }
                break;
        }
    };

    defaultColumnsWidth = function(count) {
        if (count < 1)
            return null;
        var total = 12,
            min = Math.floor(total / count),
            widths = [];
        for (var i = 0; i < count; i++) {
            widths[i] = min;
        }
        widths[count - 1] = total - min * (count - 1);
        return widths;
    };

    bindEvents = function(els) {
        if (megamenu.data('nav_all'))
            megamenu.data('nav_all', megamenu.data('nav_all').add(els));
        else
            megamenu.data('nav_all', els);
        els.mouseover(function(event) {
            megamenu.data('nav_all').removeClass('hover');
            $this = $(this);
            clearTimeout(megamenu.data('hovertimeout'));
            megamenu.data('hovertimeout', setTimeout("$this.addClass('hover')", 100));
            event.stopPropagation();
        });
        els.mouseout(function(event) {
            clearTimeout(megamenu.data('hovertimeout'));
            $(this).removeClass('hover');
        });
        els.click(function(event) {
            show_toolbox($(this));
            event.stopPropagation();
            return false;
        });

        els.dblclick(function(event) {
            edit_menu($(this));
            event.stopPropagation();
            return false;
        });
    };

    clearDefaultData = function(){

    };

    unbindEvents = function(els) {
        megamenu.data('nav_all', megamenu.data('nav_all').not(els));
        els.unbind('mouseover').unbind('mouseout').unbind('click');
    };

    rebindEvents = function(els) {
        unbindEvents(els);
        bindEvents(els);
    };
}(jQuery);
/**
 * Zo2 Megamenu event handler
 * @param {object} w Window pointer
 * @param {object} z Zo2 pointer
 * @param {object} $ jQuery pointer
 * @returns {undefined}
 */
(function(w, $) {
    $.extend(ZO2AdminMegamenu, {
        // put megamenu admin panel into right place
        prepare: function(options) {
            // var panel = $('#jform_params_mm_panel-lbl').closest ('.control-group').find('.controls');
            var panel = $('#jform_params_mm_type').closest('.controls');
            panel.append($('#zo2-admin-megamenu').removeClass('hidden'));
            // first load
            if ($('#jform_params_nav_type').val() === 'megamenu') {
                setTimeout(function() { //wait for page ready
                    $('#jform_params_menu_type').trigger('change.less');
                }, 500);
            } else {

                // handle event for enable megamenu
                $('#jform_params_nav_type').on('change', function(e) {
                    if ($(this).val() === 'megamenu') {
                        $('#jform_params_menu_type').trigger('change.less');
                    }
                });
            }

            $('#zo2-admin-mm-container').megamenuAdmin(options).find(':input').removeAttr('name');

        },

        initRadioGroup: function() {

            var zo2_admin = $('.zo2-admin-megamenu');
            zo2_admin.find('.radio.btn-group label').addClass('btn');
            zo2_admin.find('.btn-group label').unbind('click').click(function() {
                var label = $(this),
                    input = $('#' + label.attr('for'));
                if (!input.prop('checked')) {
                    label.closest('.btn-group')
                        .find('label')
                        .removeClass('active btn-success btn-danger btn-primary');
                    label.addClass('active ' + (input.val() === '' ? 'btn-primary' : (input.val() === '0' ? 'btn-danger' : 'btn-success')));
                    input.prop('checked', true).trigger('change');
                }
            });
            zo2_admin.on('update', 'input[type=radio]', function() {
                if (this.checked) {
                    $(this)
                        .closest('.btn-group')
                        .find('label').removeClass('active btn-success btn-danger btn-primary')
                        .filter('[for="' + this.id + '"]')
                        .addClass('active ' + ($(this).val() === '' ? 'btn-primary' : ($(this).val() === '0' ? 'btn-danger' : 'btn-success')));
                }
            });
            zo2_admin.find('.btn-group input[checked=checked]').each(function() {
                if ($(this).val() === '') {
                    $('label[for=' + $(this).attr('id') + ']').addClass('active btn-primary');
                } else if ($(this).val() === 0) {
                    $('label[for=' + $(this).attr('id') + ']').addClass('active btn-danger');
                } else {
                    $('label[for=' + $(this).attr('id') + ']').addClass('active btn-success');
                }
            });
        }
    });


    $(document).ready(function() {
        //ZO2AdminMegamenu.prepare();
        ZO2AdminMegamenu.initRadioGroup();


        /**
         * Generate JSON settings
         * @returns {unresolved}
         */
        function generateZo2SettingJson () {
            var output = [];
            megamenu = $('#zo2-admin-mm-container').find('.zo2-megamenu');
            var config = {},
                items = megamenu.find('ul[class*="level"] > li');
            items.each(function() {
                var $this = $(this),
                     data = $(this).data();
                if ($this.hasClass('mega')) {
                    var $sub = $this.find('.menu-child:first');

                    data.rows = new Array();
                    // build row
                    var $rows = $sub.find('[class*="row"]:first').parent().children('[class*="row"]');

                    $rows.each(function() {
                        var $cols = $(this).children('[class*="span"]');
                        var row =  new Object();
                        row.cols = new Array();
                        $cols.each(function() {
                            $(this).removeData('bs.popover')
                            row.cols.push( $(this).data() );
                        });
                        data.rows.push(row);
                    });
                }

                output.push(data);
            });
            var menutype = $('#jform_params_menu_type').val(),
                jmmconfig = $('#jform_params_menu_config'),
                curconfig = null;
            try {
                curconfig = jmmconfig.val() ? $.parseJSON(jmmconfig.val()) : {};
            } catch (e) {
                curconfig = {};
            }

            if ($.isArray(curconfig) && curconfig.length === 0) {
                curconfig = {};
            }
            curconfig['menutype'] = config;

            return JSON.stringify(output);
        }

        /**
         * add event triggers to operator in form of selected column and selected row
         */
        function triggerSaveForm(){
            $( "#form-megamenu" ).submit( function(){
                var $input = $('#jform_params_menu_config');

                $input.val(generateZo2SettingJson());

                return true;
            } );
        }

        triggerSaveForm();
    });
})(window, jQuery);