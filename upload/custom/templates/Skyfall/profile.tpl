{include file='header.tpl'} {include file='navbar.tpl'}
<div class="container">
    {if !isset($CAN_VIEW) || (isset($CAN_VIEW) && $CAN_VIEW eq true)} {if isset($LOGGED_IN)} {if isset($ERROR)}
        <div class="alert alert-danger">
            {$ERROR}
        </div>
        {/if} {if isset($SUCCESS)}
        <div class="alert alert-success">
            {$SUCCESS}
        </div>
        {/if} {/if}
        <div class="row">

        {if count($WIDGETS_LEFT)}
            <div class="col-md-3">
                {foreach from=$WIDGETS_LEFT item=widget}
                    {$widget}
                {/foreach}
            </div>
        {/if}

    <div class="{if count($WIDGETS_LEFT) && count($WIDGETS_RIGHT)}col-md-6{elseif count($WIDGETS_LEFT) || count($WIDGETS_RIGHT)}col-md-9{else}col-md-12{/if}">
            <div class="jumbotron" style="background-image:url('{$BANNER}');background-size:cover;">
                <div class="row">
                    <div class="col-md-7">
                        <h2>
                            <img class="avatar-img" style="height:60px;width:60px;" src="{$AVATAR}" />
                            <strong{if $USERNAME_COLOUR !=false} style="{$USERNAME_COLOUR}" {/if}>{$NICKNAME}</strong>
                            {foreach from=$GROUPS item=group} {$group}{/foreach}
                        </h2>
                    </div>
                    <div class="col-md-5">
                        <span class="float-right">
                            {nocache}
                            {if isset($LOGGED_IN)}
                                {if !isset($SELF)}
                                    <div class="btn-group">
                                        <!--<a href="{$FOLLOW_LINK}" class="btn btn-primary btn-lg"><i class="fa fa-users fa-fw"></i> {$FOLLOW}</a>-->
                                        {if $MOD_OR_ADMIN ne true}<a href="#" data-toggle="modal" data-target="#blockModal" class="btn btn-danger btn-lg"><i class="fa fa-ban fa-fw"></i></a>{/if}
                                        <a href="{$MESSAGE_LINK}" class="btn btn-success btn-lg" rel="tooltip" data-title="Message {$NICKNAME}"><i class="fa fa-envelope fa-fw"></i></a>
                                        {if isset($RESET_PROFILE_BANNER)}
                                            <a href="{$RESET_PROFILE_BANNER_LINK}" class="btn btn-danger btn-lg" rel="tooltip" data-title="{$RESET_PROFILE_BANNER}">
                                                <i class="far fa-image"></i>
                                            </a>
                                        {/if}
                                    </div>
                                {else}
                                    <div class="btn-group">
                                        <a href="{$SETTINGS_LINK}" class="btn btn-success btn-lg"><i class="fa fa-cogs fa-fw"></i></a>
                                        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#imageModal"><i class="far fa-image"></i></button>
                                    </div>
                                {/if}
                            {/if}
                            {/nocache}
                        </span>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header header-theme">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="user-tab" data-toggle="tab" href="#user" role="tab" aria-controls="user" aria-selected="true">{$FEED}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="about-tab" data-toggle="tab" href="#about" role="tab" aria-controls="about" aria-selected="false">{$ABOUT}</a>
                        </li>
                        {foreach from=$TABS key=key item=tab}
                            <li class="nav-item">
                                <a class="nav-link" id="{$key}-tab" data-toggle="tab" href="#{$key}" role="tab" aria-controls="{$key}" aria-selected="false">{$tab.title}</a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
                <div class="card-body">
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane show active" id="user" role="tabpanel" aria-labelledby="user-tab">
                            {if isset($LOGGED_IN)}
                                <form action="" method="post">
                                    <div class="form-group">
                                        <textarea name="post" class="form-control" placeholder="{$POST_ON_WALL}"></textarea>
                                    </div>
                                    <input type="hidden" name="action" value="new_post">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <button type="submit" class="btn btn-theme">{$SUBMIT}</button>
                                </form>
                                <br /> {/if} {if count($WALL_POSTS)}
                                <div class="timeline">
                                    <div class="line text-muted"></div>
                                    {foreach from=$WALL_POSTS item=post}
                                        <article class="panel panel-theme" id="post-id-{$post.id}">
                                            <div class="panel-heading icon">
                                                <img class="avatar-img" style="height:40px; width:40px;" src="{$post.avatar}" />
                                            </div>
                                            <div class="panel-heading">
                                                <h2 class="panel-title panel-title-inline"><a href="{$post.profile}" style="{$post.user_style}" data-poload="{$USER_INFO_URL}{$post.user_id}" data-html="true" data-placement="top">{$post.nickname}</a></h2>
                                                <span class="pull-right" rel="tooltip" data-original-title="{$post.date}">{$post.date_rough}</span>
                                            </div>
                                            <div class="panel-body">
                                                <div class="forum_post">
                                                    {$post.content}
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <a href="{if $post.reactions_link ne " # "}{$post.reactions_link}{else}#{/if}" class="grey-link" data-content='{if isset($post.reactions.reactions)} {foreach from=$post.reactions.reactions item=reaction name=reactions}<a href="{$reaction.profile}" style="{$reaction.style}"><img class="avatar-img" src="{$reaction.avatar}" alt="{$reaction.username}" style="max-height:30px; max-width:30px;" /> {$reaction.nickname}</a>{if !$smarty.foreach.reactions.last}<br />{/if}{/foreach} {else}{$post.reactions.count}{/if}'>
                                                    <i class="fa fa-thumbs-up"></i> {$post.reactions.count} </a> | <a class="grey-link" href="#" data-toggle="modal" data-target="#replyModal{$post.id}"><i class="fa fa-comments"></i> {$post.replies.count}</a>
                                                <span class="float-right">
                                                    {if (isset($CAN_MODERATE) && $CAN_MODERATE eq 1) || $post.self eq 1}
                                                        <form action="" method="post" id="delete{$post.id}" style="display:none">
                                                            <input type="hidden" name="post_id" value="{$post.id}">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="token" value="{$TOKEN}">
                                                        </form>
                                                        <a class="grey-link" href="#" data-toggle="modal" data-target="#editModal{$post.id}">{$EDIT}</a> | <a class="grey-link" href="#" onclick="deletePost({$post.id})">{$DELETE}</a>
                                                    {/if}
                                                </span>
                                            </div>
                                        </article>
                                        {if (isset($CAN_MODERATE) && $CAN_MODERATE eq 1) || $post.self eq 1}
                                            <!-- Post editing modal -->
                                            <div class="modal fade" id="editModal{$post.id}" tabindex="-1" role="dialog" aria-labelledby="editModal{$post.id}Label" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <span class="modal-title" id="editModal{$post.id}Label">{$EDIT_POST}</span>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="" method="post">
                                                                <div class="form-group">
                                                                    <textarea class="form-control" name="content">{$post.content}</textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="hidden" name="token" value="{$TOKEN}">
                                                                    <input type="hidden" name="post_id" value="{$post.id}">
                                                                    <input type="hidden" name="action" value="edit">
                                                                    <button type="submit" class="btn btn-theme">{$SUBMIT}</button>
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CLOSE}</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            {/if} {if $post.reactions_link ne "#"}
                                            <!-- Reaction modal -->
                                            <div class="modal fade" id="reactModal{$post.id}" tabindex="-1" role="dialog" aria-labelledby="reactModal{$post.id}Label" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <span class="modal-title" id="reactModal{$post.id}Label">{$REACTIONS_TITLE}</span>
                                                        </div>
                                                        <div class="modal-body">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CLOSE}</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                        <!-- Replies modal -->
                                        <div class="modal fade" id="replyModal{$post.id}" tabindex="-1" role="dialog" aria-labelledby="replyModal{$post.id}Label" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <span class="modal-title" id="replyModal{$post.id}Label">{$REPLIES_TITLE}</span>
                                                    </div>
                                                    <div class="modal-body">
                                                        {if isset($post.replies.replies)} {foreach from=$post.replies.replies name=replies item=reply}
                                                            <img src="{$reply.avatar}" alt="{$reply.username}" style="max-height:20px; max-width:20px;" class="avatar-img" /> <a href="{$reply.profile}" style="{$reply.style}">{$reply.nickname}</a>
                                                            <span class="pull-right">
                                                                <span rel="tooltip" title="{$reply.time_full}">{$reply.time_friendly}</span>
                                                            </span>
                                                            <div class="reply-spacer"></div>
                                                            <div class="forum_post">
                                                                {$reply.content}
                                                            </div>
                                                            {if (isset($CAN_MODERATE) && $CAN_MODERATE eq 1) || $reply.self eq 1}
                                                                <form action="" method="post" id="deleteReply{$reply.id}">
                                                                    <input type="hidden" name="action" value="deleteReply">
                                                                    <input type="hidden" name="token" value="{$TOKEN}">
                                                                    <input type="hidden" name="post_id" value="{$reply.id}">
                                                                </form>
                                                            <br /><a class="grey-link" href="#" onclick="deleteReply({$reply.id})">{$DELETE}</a>{/if}
                                                        <hr />{/foreach}
                                                    {else}
                                                        <p>{$NO_REPLIES}</p>
                                                        {/if} {if isset($LOGGED_IN)}
                                                        <form action="" method="post">
                                                            <div class="form-group">
                                                                <textarea class="form-control" name="reply" placeholder="{$NEW_REPLY}"></textarea>
                                                            </div>
                                                            <div class="form-group">
                                                                <input type="hidden" name="token" value="{$TOKEN}">
                                                                <input type="hidden" name="post" value="{$post.id}">
                                                                <input type="hidden" name="action" value="reply">
                                                                <button type="submit" class="btn btn-theme">{$SUBMIT}</button>
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CLOSE}</button>
                                                            </div>
                                                        </form>
                                                    {else}
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CLOSE}</button> {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                            {$PAGINATION} {else}
                            <div class="alert alert-info">{$NO_WALL_POSTS}</div>{/if}
                        </div>
                        <div class="tab-pane" id="about" role="tabpanel" aria-labelledby="about-tab">
                            <strong>{$ABOUT_FIELDS.registered.title}</strong> <span rel="tooltip" title="{$ABOUT_FIELDS.registered.tooltip}">{$ABOUT_FIELDS.registered.value}</span><br />
                            <strong>{$ABOUT_FIELDS.last_seen.title}</strong> <span rel="tooltip" title="{$ABOUT_FIELDS.last_seen.tooltip}">{$ABOUT_FIELDS.last_seen.value}</span><br />
                            <strong>{$ABOUT_FIELDS.profile_views.title}</strong> {$ABOUT_FIELDS.profile_views.value}<br />
                            <hr />
                            {if count($ABOUT_FIELDS)}
                                {foreach from=$ABOUT_FIELDS key=key item=field name=about_foreach}
                                    {if is_numeric($key)}
                                        <div class="card server">
                                        <div class="card-body" style="padding: 0rem">
                                        <span class="profile-field" style="padding: 0.75rem; display: inline-block; font-weight: bold; text-transform: uppercase; background-color: rgb(255,255,255,0.05) !important">{$field.title}</span>
                                        <span style="padding: 0.75rem; display: inline-block;"{if $field.tooltip} rel="tooltip" title="{$field.tooltip}"{/if}>{$field.value}</span>
                                        </div>
                                        </div>
                                    {/if}
                                {/foreach}
                            {else}
                                <div class="alert alert-info">{$NO_ABOUT_FIELDS}</div>
                            {/if}
                        </div>
                        {foreach from=$TABS key=key item=tab}
                            <div class="tab-pane" id="{$key}" role="tabpanel" aria-labelledby="{$key}-tab">{include file=$tab.include}</div>
                        {/foreach}
                    </div>
                </div>
            </div>
            </div>
            
            {if count($WIDGETS_RIGHT)}
                <div class="col-md-3">
                    {foreach from=$WIDGETS_RIGHT item=widget}
                        {$widget}
                    {/foreach}
                </div>
            {/if}

        </div>
</div>
{else}
<div class="alert alert-danger" role="alert">
    {$PRIVATE_PROFILE}
</div>
{/if}
{if isset($LOGGED_IN)}
    {if isset($SELF)}
        <!-- Change background image modal -->
        <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span class="modal-title" id="imageModalLabel">{$CHANGE_BANNER}</span>
                    </div>
                    <div class="modal-body">
                        <form class="inline-form" action="" name="updateBanner" method="post">
                            <select name="banner" class="image-picker show-html">
                                {foreach from=$BANNERS item=banner}
                                    <option data-img-src="{$banner.src}" value="{$banner.name}" {if $banner.active==true} selected{/if}>{$banner.name}</option>
                                {/foreach}
                            </select>
                            <input type="hidden" name="token" value="{$TOKEN}">
                            <input type="hidden" name="action" value="banner">
                        </form>
                        {if isset($PROFILE_BANNER)}
                            <hr />
                            <strong>{$UPLOAD_PROFILE_BANNER}</strong>
                            <form class="inline-form" action="{$UPLOAD_BANNER_URL}" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label class="btn btn-secondary upload-banner-btn">{$BROWSE}<input type="file" name="file" hidden /></label>
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="hidden" name="type" value="profile_banner">
                                    <button type="submit" class="btn btn-theme">{$UPLOAD}</button>
                                </div>
                            </form>
                            <hr />
                        {/if}
                        <button type="button" onclick="document.updateBanner.submit()" class="btn btn-theme">{$SUBMIT}</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CANCEL}</button>
                    </div>
                </div>
            </div>
        </div>
    {else}
        {if $MOD_OR_ADMIN ne true}
            <!-- Block user modal -->
            <div class="modal fade" id="blockModal" tabindex="-1" role="dialog" aria-labelledby="blockModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <span class="modal-title" id="blockModalLabel">{if isset($BLOCK_USER)}{$BLOCK_USER}{else}{$UNBLOCK_USER}{/if}</span>
                        </div>
                        <form class="inline-form" action="" method="post">
                            <div class="modal-body">
                                <p>{if isset($CONFIRM_BLOCK_USER)}{$CONFIRM_BLOCK_USER}{else}{$CONFIRM_UNBLOCK_USER}{/if}</p>
                                <input type="hidden" name="token" value="{$TOKEN}">
                                <input type="hidden" name="action" value="block">
                                <button type="submit" class="btn btn-theme">{$CONFIRM}</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CANCEL}</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        {/if}
    {/if}
{/if}
{include file='footer.tpl'}
{if isset($LOGGED_IN)}
    <script type="text/javascript">
        function deletePost(post) {
            if(confirm("{$CONFIRM_DELETE}")){
            document.getElementById("delete" + post).submit();
        }
        }
    </script>
    <script type="text/javascript">
        function deleteReply(post) {
            if(confirm("{$CONFIRM_DELETE}")){
            document.getElementById("deleteReply" + post).submit();
        }
        }
    </script>
{/if}