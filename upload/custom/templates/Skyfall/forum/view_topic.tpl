{include file='header.tpl'} {include file='navbar.tpl'}
<div class="container">
    <ol class="breadcrumb">
        {foreach from=$BREADCRUMBS item=breadcrumb}
        <li{if isset($breadcrumb.active)} class="active" {/if}>{if !isset($breadcrumb.active)}<a class="white-link" href="{$breadcrumb.link}">{/if}{$breadcrumb.forum_title}{if !isset($breadcrumb.active)}</a>{/if}
            </li>
        {/foreach}
    </ol>
    <div class="row">
        <div class="col-md-12">
            <span class="float-right forum-btns">
            {if isset($CAN_REPLY)}
            <a {if isset($LOCKED) && !isset($CAN_MODERATE)} disabled="disabled" {else} href="#reply_section" {/if}
            class="btn btn-{if isset($LOCKED) && !isset($CAN_MODERATE)}theme disabled{else}theme{/if}" >{if isset($LOCKED) && !isset($CAN_MODERATE)}<i class="fa fa-lock" aria-hidden="true"></i>
            {/if}{$NEW_REPLY}</a>
            {/if}
            {if isset($UNFOLLOW)}
                <a class="btn btn-secondary" href="{$UNFOLLOW_URL}">{$UNFOLLOW}</a>
              {elseif isset($FOLLOW)}
                <a class="btn btn-theme" href="{$FOLLOW_URL}">{$FOLLOW}</a>
            {/if}
            <div class="btn-group">
            	<button type="button" class="btn dropdown-toggle btn-theme" data-toggle="dropdown" style="vertical-align:baseline;">{$SHARE} <span class="caret"></span></button>
            	    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                    <li><a target="_blank" class="dropdown-item" href="{$SHARE_TWITTER_URL}"><i class="fab fa-twitter"></i> {$SHARE_TWITTER}</a></li>
                    <li><a target="_blank" class="dropdown-item" href="{$SHARE_FACEBOOK_URL}"><i class="fab fa-facebook"></i> {$SHARE_FACEBOOK}</a></li>
            	</ul>
            </div>
            {if isset($CAN_MODERATE)}
            <div class="btn-group">
                <button type="button" class="btn dropdown-toggle btn-theme" data-toggle="dropdown">{$MOD_ACTIONS} <span class="caret"></span></button>
            	<ul class="dropdown-menu" role="menu">
                	<li><a class="dropdown-item" href="{$LOCK_URL}"><i class="fas fa-lock"></i> {$LOCK}</a></li>
                	<li><a class="dropdown-item" href="{$MERGE_URL}"><i class="fas fa-compress-arrows-alt"></i> {$MERGE}</a></li>
                	<li><a class="dropdown-item" href="" data-toggle="modal" data-target="#deleteModal"><i class="fas fa-trash"></i> {$DELETE}</a></li>
                	<li><a class="dropdown-item" href="{$MOVE_URL}"><i class="fas fa-arrow-right"></i> {$MOVE}</a></li>
                	<li><a class="dropdown-item" href="{$STICK_URL}"><i class="fas fa-thumbtack"></i> {$STICK}</a></li>
            	</ul>
            </div>
            {/if}
            </span>
        </div>
    </div>
{if isset($SESSION_SUCCESS_POST)}
<div class="alert alert-success">
    {$SESSION_SUCCESS_POST}
</div>
{/if} {if isset($SESSION_FAILURE_POST)}
<div class="alert alert-danger">
    {$SESSION_FAILURE_POST}
</div>
{/if} {foreach from=$REPLIES item=reply name=arr}
<div class="card">
    <div class="card-header text-white header-theme"><a href="{$reply.url}" class="white-text">{if count($TOPIC_LABELS)}{foreach from=$TOPIC_LABELS item=label}{$label} {/foreach}{/if}{if isset($LOCKED) && $smarty.foreach.arr.first}
         <span class="fas fa-lock"></span> {/if}{$reply.heading}</a>
    </div>
    <div class="card-body" id="post-{$reply.id}">
        <div class="row">
            <div class="col-md-2 col-inv forum-col">
                <center>
                    <img class="avatar-img" style="max-width:100px; max-height:100px;" src="{$reply.avatar}" />
                    <br/><br />
                    <strong><a style="{$reply.user_style}" href="{$reply.profile}" data-poload="{$USER_INFO_URL}{$reply.user_id}" data-html="true" data-placement="top">{$reply.username}</a></strong>
                    <br/> {foreach from=$reply.user_groups item=group} {$group}
                    <br/> {/foreach} {if $reply.user_title}
                    <br/>
                    <small>{$reply.user_title}</small> {/if}
                    <hr/> {$reply.user_posts_count}
                    <br/> {$reply.user_topics_count}
                    <br/>
                    <hr /> {if count($reply.fields)} {foreach from=$reply.fields item=field} {$field.name}: {$field.value}<br/> {/foreach} {/if}

							{* Badges Module *}
							{if isset($USER_BADGES_LIST)}
								{include file='badges/forum_bdg.tpl'}
							{/if}
							{* /Badges Module *}
                </center>
            </div>
            <div class="col-md-10">
                <span data-toggle="tooltip" data-trigger="hover" data-original-title="{$reply.post_date}">{$reply.post_date_rough}</span>
                <span class="float-right">
               {if isset($reply.buttons.edit)}
               <a class="btn btn-theme btn-sm" data-toggle="tooltip" data-trigger="hover" data-original-title="{$reply.buttons.edit.TEXT}" href="{$reply.buttons.edit.URL}"><i class="fas fa-pen fa-fw" aria-hidden="true"></i></a>
               {/if}
               {if isset($reply.buttons.quote)}
               <button class="btn btn-theme btn-sm" data-toggle="tooltip" data-trigger="hover" data-original-title="{$reply.buttons.quote.TEXT}" onclick="quote({$reply.id});"><i class="fa fa-quote-left fa-fw" aria-hidden="true"></i></button>
               {/if}
               {if isset($reply.buttons.report)}
               <button class="btn btn-theme btn-sm" rel="tooltip" data-trigger="hover" data-original-title="{$reply.buttons.report.TEXT}" data-toggle="modal" data-target="#report{$reply.id}Modal"><i class="fas fa-exclamation-triangle fa-fw" aria-hidden="true"></i></button>
               {/if}
               {if isset($reply.buttons.spam)}
               <button class="btn btn-theme btn-sm" rel="tooltip" data-trigger="hover" data-original-title="{$reply.buttons.spam.TEXT}" data-toggle="modal" data-target="#spam{$reply.id}Modal"><i class="fas fa-flag fa-fw" aria-hidden="true"></i></button>
               {/if}
               {if isset($reply.buttons.delete)}
               <button class="btn btn-theme btn-sm" rel="tooltip" data-trigger="hover" data-original-title="{$reply.buttons.delete.TEXT}" data-toggle="modal" data-target="#delete{$reply.id}Modal"><i class="fas fa-trash fa-fw" aria-hidden="true"></i></button>
               {/if}
               </span>
                <hr/>
                <div class="forum_post">
                    {$reply.content}
                </div><br/> {if $reply.edited !== null}
                <small><span rel="tooltip" data-toggle="hover"
                  data-original-title="{$reply.edited_full}">{$reply.edited}</span>
               </small>{/if} {if count($reply.post_reactions)}
                <span class="float-right" data-toggle="modal" data-target="#reactions{$reply.id}Modal">
               {foreach from=$reply.post_reactions name="reactions" item=reaction}
               {$reaction.html} x {$reaction.count}
               {if !($smarty.foreach.reactions.last)} | {/if}
               {/foreach}
               </span> {/if} {if $reply.user_id !== $USER_ID} {if isset($REACTIONS) && count($REACTIONS)}
                <br/>
                <div class="well">
                    {foreach from=$REACTIONS item=reaction}
                    <form class="inline-form" action="{$REACTIONS_URL}" method="post">
                        <input type="hidden" name="token" value="{$TOKEN}">
                        <input type="hidden" name="reaction" value="{$reaction->id}">
                        <input type="hidden" name="post" value="{$reply.id}">
                        <a href="#" onclick="$(this).closest('form').submit();" style="padding:10px;" rel="tooltip" data-toggle="hover" data-original-title="{$reaction->name}">{$reaction->html}</a>
                    </form>
                    {/foreach}
                </div>
                {else}
                <br/> {/if} {else}
                <br/> {/if}
                <hr/> {$reply.signature}
            </div>
        </div>
    </div>
</div>
{if count($reply.post_reactions)}
<div class="modal fade" id="reactions{$reply.id}Modal" tabindex="-1" role="dialog" aria-labelledby="reactions{$reply.id}ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title" id="reactions{$reply.id}ModalLabel">{$REACTIONS_TEXT}</span>
            </div>
            <div class="modal-body">
                {foreach from=$reply.post_reactions name=reactions item=reaction}
                <strong>{$reaction.html} x {$reaction.count}:</strong>
                <br />{foreach from=$reaction.users item=user}
                <a style="{$user.style}" href="{$user.profile}"><img src="{$user.avatar}" class="avatar-img" style="height:20px;width:20px;" alt="{$user.username}"/> {$user.nickname}</a>
                <br/> {/foreach} {if !($smarty.foreach.reactions.last)}
                <hr/> {/if} {/foreach}
            </div>
        </div>
    </div>
</div>
{/if} {if isset($reply.buttons.report)}
<div class="modal fade" id="report{$reply.id}Modal" tabindex="-1" role="dialog" aria-labelledby="report{$reply.id}ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title" id="report{$reply.id}ModalLabel">{$reply.buttons.report.TEXT}</span>
            </div>
            <form action="{$reply.buttons.report.URL}" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="InputReason">{$reply.buttons.report.REPORT_TEXT} </label>
                        <textarea class="form-control" id="InputReason" name="reason"></textarea>
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CANCEL}</button>
                    <input type="hidden" name="post" value="{$reply.id}">
                    <input type="hidden" name="topic" value="{$TOPIC_ID}">
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <button type="submit" class="btn btn-theme">{$reply.buttons.report.TEXT}</button>
                </div>
            </form>
        </div>
    </div>
</div>
{/if} {if isset($CAN_MODERATE)}
<div class="modal fade" id="spam{$reply.id}Modal" tabindex="-1" role="dialog" aria-labelledby="spam{$reply.id}ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title" id="spam{$reply.id}ModalLabel">{$MARK_AS_SPAM}</span>
            </div>
            <div class="modal-body">
                {$CONFIRM_SPAM_POST}
                <form action="{$reply.buttons.spam.URL}" method="post">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CANCEL}</button>
                    <input type="hidden" name="post" value="{$reply.id}">
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <button type="submit" class="btn btn-theme">{$MARK_AS_SPAM}</button>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="delete{$reply.id}Modal" tabindex="-1" role="dialog" aria-labelledby="delete{$reply.id}ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title" id="delete{$reply.id}ModalLabel">{$CONFIRM_DELETE_SHORT}</span>
            </div>
            <div class="modal-body">
                {$CONFIRM_DELETE_POST}<br /><br />
                <form action="{$reply.buttons.delete.URL}" method="post">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CANCEL}</button>
                    <input type="hidden" name="tid" value="{$TOPIC_ID}">
                    <input type="hidden" name="number" value="{$reply.buttons.delete.NUMBER}">
                    <input type="hidden" name="pid" value="{$reply.id}">
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <button type="submit" class="btn btn-theme">{$reply.buttons.delete.TEXT}</button>
                </form>
            </div>
        </div>
    </div>
</div>
{/if} {/foreach} {$PAGINATION} {if isset($TOPIC_LOCKED_NOTICE)}
<div class="alert alert-info">{$TOPIC_LOCKED_NOTICE}</div>
{/if} {if isset($CAN_REPLY)}
<div class="card">
    <div class="card-header header-theme">{$NEW_REPLY}</div>
    <div class="card-body">
        <div id="reply_section">
            <form action="" method="post">

                {if isset($MARKDOWN)}
                    <div class="form-group">
                      <textarea class="form-control" name="content" id="markdown" >{$CONTENT}</textarea>
                    </div>
                {else}
                    <div class="form-group">
                      <textarea class="form-control" name="content" id="quickreply">{$CONTENT}</textarea>
                    </div>
                {/if}

                <br/>
                <input type="hidden" name="token" value="{$TOKEN}">
                <button type="submit" class="btn btn-theme">{$SUBMIT}</button>
                <button type="button" class="btn btn-secondary" id="quoteButton" onclick="insertQuotes();">
               {$INSERT_QUOTES}
               </button>
            </form>
        </div>
    </div>
</div>
{/if}
</div>
</div>
</div>
</div>
{if isset($CAN_MODERATE)}
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title" id="deleteModalLabel">{$CONFIRM_DELETE_SHORT}</span>
            </div>
            <div class="modal-body">
                {$CONFIRM_DELETE}<br /><br />
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{$CANCEL}</button>
                <a href="{$DELETE_URL}" class="btn btn-theme">{$DELETE}</a>
            </div>
        </div>
    </div>
</div>
{/if} {include file='footer.tpl'}