<?php
/*
 *	Made by Coldfire - https://coldfiredzn.com
 *
 *  Skyfall Template Settings
 */

$skyfall_language = new Language(ROOT_PATH . '/custom/templates/Skyfall/template_settings/language', LANGUAGE);

require(ROOT_PATH . '/custom/templates/Skyfall/template_settings/vars.php');

if (Input::exists()) {
    if (Token::check()) {
        $cache->setCache('skyfall_template');

        foreach ($skyfall_settings_array as $value) {
            if (isset($_POST[$value[0]])) {
                $cache->store($value[0], $_POST[$value[0]]);
            }
        }

        if (!empty($_FILES['skyfall-update']['name'])) {
            updateSkyfall();
        }

        Session::flash('admin_templates', $language->get('admin', 'successfully_updated'));
    } else {
        $errors = array($language->get('general', 'invalid_token'));
    }
}

$cache->setCache('skyfall_template');

foreach ($skyfall_settings_array as $value) {
    $setting_name = $value[0];
    if ($cache->isCached($value[0])) {
        $$setting_name = $cache->retrieve($value[0]);
    } else {  
        $$setting_name = $value[1];
        $cache->store($value[0], $value[1]);
    }
}

$current_template->addJSFiles(array(
    (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/core/assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js' => array(),
    (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/core/assets/plugins/switchery/switchery.min.js' => array()
));

$current_template->addCSSFiles(array(
    (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/core/assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css' => array(),
    (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/core/assets/plugins/switchery/switchery.min.css' => array()
));

$current_template->addJSScript('
    $(\'.color\').colorpicker({ format: \'hex\', autoInputFallback: false, color: "'. $p_color .'" });
	var elems = Array.prototype.slice.call(document.querySelectorAll(\'.js-switch\'));
	elems.forEach(function(elem) {
		var switchery = new Switchery(elem, {color: \'#23923d\', secondaryColor: \'#e56464\'});
    });
    
    function switchToSubmit() {
        if ($("#skyfall-update").val()) {
            $("#skyfall-update-label").addClass("d-none");
            $("#skyfall-submit").removeClass("d-none");
        }
    }
');

foreach ($skyfall_settings_array as $value) {
    $first_value = strtoupper($value[0]) . "_VALUE";
    $output_value = $value[0];
    
    $smarty->assign($first_value, $$output_value);
    
    $output_lang = strtoupper($value[0]);
    if ($value[0] == 'ts') {
        $smarty->assign('TS_PANEL', $skyfall_language->get('language', 'ts_panel'));

    } elseif ($value[0] == 'slider1_link_open' || $value[0] == 'slider2_link_open' || $value[0] == 'slider3_link_open' || $value[0] == 'slider4_link_open' || $value[0] == 'slider5_link_open') {

    } else {
        $smarty->assign($output_lang, $skyfall_language->get('language', $value[0]));
    }
}

$smarty->assign(array(
    'SUPPORT_URL' => $support_url,
    'LOCAL_VERSION' => $skyfall_local_version,
    'OPTIMIZE_TAB' => $skyfall_language->get('language', 'optimize_tab'),
    'OPTIMIZE_INFO' => $skyfall_language->get('language', 'optimize_info'),
    'FONT_3' => $skyfall_language->get('language', 'font_3'),
    'HOME' => $skyfall_language->get('language', 'home'),
    'GENERAL' => $skyfall_language->get('language', 'general'),
    'COLORS' => $skyfall_language->get('language', 'colors'),
    'STYLING' => $skyfall_language->get('language', 'styling'),
    'HEADER' => $skyfall_language->get('language', 'header'),
    'WB' => $skyfall_language->get('language', 'wb'),
    'NEWS' => $skyfall_language->get('language', 'news'),
    'SLIDER' => $skyfall_language->get('language', 'slider'),
    'ELR' => $skyfall_language->get('language', 'elr'),
    'FOOTER' => $skyfall_language->get('language', 'footer'),
    'PORTAL' => $skyfall_language->get('language', 'portal'),
    'UPDATE' => $skyfall_language->get('language', 'update'),
    'NAVBAR_TAB' => $skyfall_language->get('language', 'navbar_tab'),
    'TS_WIDGET' => $skyfall_language->get('language', 'ts_widget'),
    'TS_BOTTOM_WIDGET' => $skyfall_language->get('language', 'ts_bottom_widget'),
    'TS_US' => $skyfall_language->get('language', 'ts_us'),
    'TS_ICON' => $skyfall_language->get('language', 'ts_icon'),
    'TS_NODISPLAY' => $skyfall_language->get('language', 'ts_nodisplay'),
    'BG_TAB' => $skyfall_language->get('language', 'bg_tab'),
    'LOGO_TAB' => $skyfall_language->get('language', 'logo_tab'),
    'HOME_1' => $skyfall_language->get('language', 'home_1'),
    'HOME_2' => $skyfall_language->get('language', 'home_2'),
    'HOME_3' => $skyfall_language->get('language', 'home_3'),
    'UPDATE_1' => $skyfall_language->get('language', 'update_1'),
    'UPDATE_2' => $skyfall_language->get('language', 'update_2'),
    'UPDATE_3' => $skyfall_language->get('language', 'update_3'),
    'UPDATE_4' => $skyfall_language->get('language', 'update_4'),
    'UPDATE_5' => $skyfall_language->get('language', 'update_5'),
    'UPDATE_6' => $skyfall_language->get('language', 'update_6'),
    'UPDATE_7' => $skyfall_language->get('language', 'update_7'),
    'UPDATE_8' => $skyfall_language->get('language', 'update_8'),
    'UPDATE_9' => $skyfall_language->get('language', 'update_9'),
    'FONT_1' => $skyfall_language->get('language', 'font_1'),
    'FONT_2' => $skyfall_language->get('language', 'font_2'),
    'DS_TEXTS_TAB' => $skyfall_language->get('language', 'ds_texts_tab'),
    'NAVBAR_1' => $skyfall_language->get('language', 'navbar_1'),
    'NAVBAR_2' => $skyfall_language->get('language', 'navbar_2'),
    'NAVBAR_3' => $skyfall_language->get('language', 'navbar_3'),
    'COVERLAY_1' => $skyfall_language->get('language', 'coverlay_1'),
    'DISCORD_SERVER_1' => $skyfall_language->get('language', 'discord_server_1'),
    'BUTTONS_TAB' => $skyfall_language->get('language', 'buttons_tab'),
    'SKINS_TAB' => $skyfall_language->get('language', 'skins_tab'),
    'WB_T_1' => $skyfall_language->get('language', 'wb_t_1'),
    'NEWS_LINK_1' => $skyfall_language->get('language', 'news_link_1'),
    'SLIDER1' => $skyfall_language->get('language', 'slider1'),
    'SLIDER2' => $skyfall_language->get('language', 'slider2'),
    'SLIDER3' => $skyfall_language->get('language', 'slider3'),
    'SLIDER4' => $skyfall_language->get('language', 'slider4'),
    'SLIDER5' => $skyfall_language->get('language', 'slider5'),
    'BLANK' => $skyfall_language->get('language', 'blank'),
    'SLIDER1_1' => $skyfall_language->get('language', 'slider1_1'),
    'SLIDER2_1' => $skyfall_language->get('language', 'slider2_1'),
    'SLIDER3_1' => $skyfall_language->get('language', 'slider3_1'),
    'SLIDER4_1' => $skyfall_language->get('language', 'slider4_1'),
    'SLIDER5_1' => $skyfall_language->get('language', 'slider5_1'),
    'SLIDER_LINK_OPEN' => $skyfall_language->get('language', 'slider_link_open'),
    'BACKGROUNDS_TAB' => $skyfall_language->get('language', 'backgrounds_tab'),
    'ABOUT_SECTION_TAB' => $skyfall_language->get('language', 'about_section_tab'),
    'OTHER_SECTION_TAB' => $skyfall_language->get('language', 'other_section_tab'),
    'IMAGE1_TAB' => $skyfall_language->get('language', 'image1_tab'),
    'IMAGE2_TAB' => $skyfall_language->get('language', 'image2_tab'),
    'IMAGE3_TAB' => $skyfall_language->get('language', 'image3_tab'),
    'LINKS_WGH' => $skyfall_language->get('language', 'links_wgh'),
    'LINKS_GWH' => $skyfall_language->get('language', 'links_gwh'),
    'SKYFALL' => $skyfall_language->get('language', 'skyfall_title'),
    'YES' => $skyfall_language->get('language', 'yes'),
    'NO' => $skyfall_language->get('language', 'no'),
    'EXT_UPDATE_INFO' => $skyfall_language->get('language', 'ext_update_info'),
    'NAVBAR_SIZE_1' => $skyfall_language->get('language', 'navbar_size_1'),
    'SMALL' => $skyfall_language->get('language', 'small'),
    'MEDIUM' => $skyfall_language->get('language', 'medium'),
    'LARGE' => $skyfall_language->get('language', 'large'),
    'SUBMIT' => $language->get('general', 'submit'),
    'SETTINGS_TEMPLATE' => ROOT_PATH . '/custom/templates/Skyfall/template_settings/settings.tpl'
));

// External Updater

if ($ext_update == "yes") {
    if (!$cache->isCached('version')) {
        $skyfall_api = file_get_contents('https://cdn.coldfiredzn.com/skyfall/updater.json');
        $skyfall_api_decode = json_decode($skyfall_api, true);
        $skyfall_version = $skyfall_api_decode["skyfall_version"];
        $cache->store('version', $skyfall_version, 1800);
    } else {
        $skyfall_version = $cache->retrieve('version');
    }

    $smarty->assign('SKYFALL_VERSION', $skyfall_version);
}

// Skyfall Easy Updater
// Made by Skyrowl for Skyfall Theme
function updateSkyfall()
{
    $skyfall_language = new Language(ROOT_PATH . '/custom/templates/Skyfall/template_settings/language', LANGUAGE);

    $currentDirectory2 = getcwd();
    $sfpath = $currentDirectory2.'/custom/templates/Skyfall';
    chmod_r($sfpath);

    $currentDirectory = getcwd();
    $uploadDirectory = $currentDirectory . '/uploads/';
    $skyfallDir = $currentDirectory.'/custom/templates/Skyfall';
    $skyfallTempDir = $uploadDirectory . 'skyfall';

    $errors = array();

    $fileExtensionsAllowed = ['zip'];

    $fileName = $_FILES['skyfall-update']['name'];
    $fileSize = $_FILES['skyfall-update']['size'];
    $fileTmpName = $_FILES['skyfall-update']['tmp_name'];
    $fileExtension = strtolower(end(explode('.', $fileName)));
    $uploadPath = $uploadDirectory . basename($fileName);

    $responseTemplate = '<style>
                          .hidden {
                              visibility: hidden;
                              opacity: 0;
                              transition: visibility 0s 1s, opacity 1s linear;
                            }
                          </style>
                          <div class="position-fixed w-100 h-100" style="top:0;left:0;z-index:50000;" id="updateBackground">
                            <div class="d-flex flex-column h-100 text-center">
                              <div class="mx-auto my-auto d-flex flex-column" style="color:#f0f0f0">
                                <div class="d-flex flex-column mx-auto my-auto" id="updateResponse"></div>
                                <btn class="btn btn-secondary mt-5 mx-auto" onclick="dismiss(); window.location.reload();" style="width:max-content;">' . $skyfall_language->get('language', 'ez_msg_3') . '</btn>
                              </div>
                            </div>
                          </div>
                          <script>
                            var container = document.getElementById("updateResponse");
                            responseIcon.style.fontSize = "6rem";
                            container.appendChild(responseIcon);
                            var responseMessageNode = document.createElement("h3");
                            container.appendChild(responseMessageNode.appendChild(responseMessage));
                            var background = document.getElementById("updateBackground");
                            background.style.background = backgroundColor;
                            function dismiss() {
                              background.classList.add("hidden");
                            }
                            if ( window.history.replaceState ) {
                                window.history.replaceState( null, null, window.location.href );
                            }
                          </script>';

    if (!in_array($fileExtension, $fileExtensionsAllowed)) {
        array_push($errors, $skyfall_language->get('language', 'ez_msg_1'));
    }
    if ($fileSize > 15000000) {
        array_push($errors, $skyfall_language->get('language', 'ez_msg_2'));
    }
    if (empty($errors)) {
        if (move_uploaded_file($fileTmpName, $uploadPath)) {
            $zip = new ZipArchive;
            if ($zip->open($uploadPath)) {
                deleteDirectory($skyfallDir);
                mkdir($skyfallTempDir);
                $zip->extractTo($skyfallTempDir);
                $zip->close();
                rename($skyfallTempDir.'/upload/custom/templates/Skyfall', $skyfallDir);
                deleteDirectory($skyfallTempDir);
                echo '<script>
                        var responseIcon = document.createElement("i");
                        responseIcon.classList.add("fas", "fa-check-circle")
                        var responseMessage = document.createTextNode("' . $skyfall_language->get('language', 'ez_msg_4') . '");
                        var backgroundColor = "rgba(40, 167, 69, 0.8)";
                      </script>';
            } else {
                echo '<script>
                      var responseIcon = document.createElement("i");
                      responseIcon.classList.add("fas", "fa-times-circle");
                      var responseMessage = document.createTextNode("' . $skyfall_language->get('language', 'ez_msg_5') . '");
                      var backgroundColor = "rgba(220, 53, 69, 0.8)";
                    </script>';
            }
            unlink($uploadPath);
        } else {
            echo '<script>
                  var responseIcon = document.createElement("i");
                  responseIcon.classList.add("fas", "fa-times-circle");
                  var responseMessage = document.createTextNode("' . $skyfall_language->get('language', 'ez_msg_6') . '");
                  var backgroundColor = "rgba(220, 53, 69, 0.8)";
                </script>';
        }
    } else {
        echo '<script>
              var responseIcon = document.createElement("i");
              responseIcon.classList.add("fas", "fa-times-circle");
              var backgroundColor = "rgba(220, 53, 69, 0.8)";
              var responseMessage = document.createTextNode("' . $skyfall_language->get('language', 'ez_msg_7') . '");
            </script>';
    }
    echo $responseTemplate;
}

function chmod_r($path) {
    $dir = new DirectoryIterator($path);
    foreach ($dir as $item) {
        chmod($item->getPathname(), 0777);
        if ($item->isDir() && !$item->isDot()) {
            chmod_r($item->getPathname());
        }
    }
}

function deleteDirectory($dir)
{
    if (!file_exists($dir)) {
        return true;
    }
    if (!is_dir($dir)) {
        return unlink($dir);
    }
    foreach (scandir($dir) as $item) {
        if ($item == '.' || $item == '..') {
            continue;
        }
        if (!deleteDirectory($dir . DIRECTORY_SEPARATOR . $item)) {
            return false;
        }
    }

    return rmdir($dir);
}