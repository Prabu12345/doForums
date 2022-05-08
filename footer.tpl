<div class="container">
    {if (isset($SKYFALL_VERSION) && $SKYFALL_VERSION|count_characters > 0) && ($SKYFALL_VERSION != $THEME_LOCAL_VERSION) && ($THEME_EXT_UPDATE eq "yes")}
        {if isset($LOGGED_IN_USER)}
            <button type="button" onClick="return false;" data-toggle="tooltip" data-placement="left" data-html="true" class="btn btn-danger btn-lg update-btn" id="update-btn" title="{$UPDATE_BTN} coldfiredzn.com/discord"><i class="fas fa-exclamation-triangle"></i></button>
        {/if}
    {/if}
    <a class="btn btn-secondary" href="#" id="scroll" {if isset($THEME_TS) && $THEME_TS eq 'icon'}style="right: 80px; display: none;"{else}style="right: 30px; display: none;"{/if}><i class="fas fa-arrow-up"></i></a>
    {if isset($THEME_TS) && $THEME_TS eq 'icon'}<button class="btn btn-secondary ts-icon" style="right: 30px;" id="theme-switch" onclick="themeFunction()"><i class="fas fa-palette"></i></button>{/if}
    <div class="chatbox" id="chatbox-bottom"></div>
</div>
{if isset($GLOBAL_WARNING_TITLE)}
<div class="modal fade show-punishment" data-keyboard="false" data-backdrop="static" id="acknowledgeModal" tabindex="-1" role="dialog" aria-labelledby="acknowledgeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="acknowledgeModalLabel">{$GLOBAL_WARNING_TITLE}</h4>
            </div>
            <div class="modal-body">
                {$GLOBAL_WARNING_REASON}
            </div>
            <div class="modal-footer">
                <a href="{$GLOBAL_WARNING_ACKNOWLEDGE_LINK}" class="btn btn-warning">{$GLOBAL_WARNING_ACKNOWLEDGE}</a>
            </div>
        </div>
    </div>
</div>
{/if}
<br />
<footer class="footer-text-bar pull-left">
    <div class="container">
        <div class="row">
            <div class="col-6">
                <p class="footer-text">{if isset($THEME_TS) && $THEME_TS eq 'footer'}<a href="" class="social" id="theme-switch" onclick="themeFunction()">{$TS_BUTTON}</a>{else}&copy; {$SITE_NAME} {'Y'|date}{/if}</p>
            </div>
            <div class="col-6 footer-icons-row">
		{if $PAGE_LOAD_TIME}
                <a class="float-right" href="#" onClick="return false;" data-toggle="tooltip" id="page_load_tooltip" title="Page loading.."><i class="fas fa-tachometer-alt fa-2x social"></i></a> {/if}
		{if !empty($SOCIAL_MEDIA_ICONS)}
                {foreach from=$SOCIAL_MEDIA_ICONS item=icon}
                <a href="{$icon.link}" target="_blank" class="float-right"><i id="social-{$icon.short}" class="{if $icon.long neq 'envelope'}fab{else}fas{/if} fa-{$icon.long}-square fa-2x social"></i></a>
                {/foreach}
                {/if}
            </div>
        </div>
    </div>
</footer>
<footer class="footer-theme">
    <div class="container">
        <div class="row">
            <div class="col-md-4 footer-col footer-about">
                <span class="footer-text-header">{$ABOUT_TITLE}</span>
                <p>{$THEME_ABOUT}</p>
                <br />
            </div>
            <div class="col-md-4 footer-col">
                <span class="footer-text-header">{$FOOTER_LINKS}</span><br />
                <a class="footer-link" href="{$TERMS_LINK}">{$TERMS_TEXT}</a><br />
                <a class="footer-link" href="{$PRIVACY_LINK}">{$PRIVACY_TEXT}</a><br /> {foreach from=$FOOTER_NAVIGATION key=name item=item} {if isset($item.items)}
                <a class="dropdown-toggle footer-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">{$item.icon} {$item.title}</a>
                <div class="dropdown-menu">
                    {foreach from=$item.items item=dropdown}
                    <a href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon} {$dropdown.title}</a> {/foreach}
                </div>
                {else}
                <a class="footer-link" href="{$item.link}" target="{$item.target}">{$item.icon} {$item.title}</a><br /> {/if} {/foreach}
                <br /><br />
            </div>
            <div class="col-md-4 footer-col">
                <span class="footer-text-header">{$THEME_OTHER_T}</span>
                <p>{$THEME_OTHER_D}</p>
                <a href="{$THEME_OTHER_BL}" class="btn btn-block other-btn">{$THEME_OTHER_BT}</a>
                <br /><br />
            </div>
        </div>
    </div>
</footer>
<footer class="footer-text-bar pull-left">
    <div class="container">
        <div class="row">
            <div class="col-10">
		        <p class="footer-text">{if isset($THEME_TS) && $THEME_TS eq 'footer'}&copy; {$SITE_NAME} {'Y'|date} &bull; {/if}{$FOOTER_CREDIT_2} <a class="footer-link" href="https://namelessmc.com">NamelessMC</a></p>
	        </div>
            <div class="col-2">
		        <a href="{$THEME_COLDFIRE_URL}" rel="noopener" target="_blank">
                    <svg version="1.0" xmlns="http://www.w3.org/2000/svg" class="cf-footer float-right" height="20px" viewBox="0 0 236.000000 252.000000" preserveAspectRatio="xMidYMid meet">
                        <g transform="translate(0.000000,252.000000) scale(0.100000,-0.100000)" fill="#FFF" stroke="none">
                            <path d="M1175 2479 c-175 -11 -283 -39 -427 -110 -124 -60 -213 -123 -315 -222 -100 -97 -189 -210 -178 -227 4 -7 193 -10 558 -10 604 0 632 -2 749 -59
72 -34 167 -123 193 -181 10 -21 23 -41 29 -43 10 -4 202 127 288 196 15 12
63 47 107 77 44 30 82 61 85 68 5 12 -19 68 -35 82 -3 3 -13 16 -22 29 -61 90
-229 227 -354 290 -179 89 -413 127 -678 110z"/>
                            <path d="M86 1521 c-3 -5 -11 -44 -17 -87 -13 -94 -6 -266 16 -382 44 -230
174 -477 339 -644 308 -312 694 -425 1138 -333 229 47 445 155 583 292 66 65
157 198 153 222 -3 14 -500 321 -519 321 -4 0 -21 -24 -37 -54 -55 -96 -184
-187 -307 -217 -77 -18 -230 -15 -300 5 -172 51 -314 201 -377 400 -28 87 -35
295 -14 395 8 40 13 78 10 82 -7 12 -661 12 -668 0z"/>
                        </g>
                    </svg>
                </a>
	        </div>
	    </div>
    </div>
</footer>
{foreach from=$TEMPLATE_JS item=script}
	{$script}
{/foreach}
{if isset($NEW_UPDATE)}
	{if $NEW_UPDATE_URGENT ne true}
		<script>
            	$(document).ready(function(){
                $('#closeUpdate').click(function(event){
                    event.preventDefault();
                    let expiry = new Date();
                    let length = 3600000;
                    expiry.setTime(expiry.getTime() + length);
                    $.cookie('update-alert-closed', 'true', { path: '/', expires: expiry });
                });
                if($.cookie('update-alert-closed') === 'true'){
                    $('#updateAlert').hide();
                }
            });
		</script>
	{/if}
{/if}

{if !isset($EXCLUDE_END_BODY)}
  </body>
  </html>
{/if}