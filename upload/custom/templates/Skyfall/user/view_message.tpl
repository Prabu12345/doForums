{include file='header.tpl'} {include file='navbar.tpl'}
<div class="container">
    {if isset($ERROR)}
        <div class="alert alert-danger">
            {$ERROR}
        </div>
    {/if} {if isset($MESSAGE_SENT)}
        <div class="alert alert-success">
            {$MESSAGE_SENT}
        </div>
    {/if}
    <div class="row">
        <div class="col-md-3">
            {include file='user/navigation.tpl'}
        </div>
        <div class="col-md-9">
            <div class="card">
                <div class="card-header header-theme">{$MESSAGE_TITLE}</div>
                <div class="card-body">
                    {$PARTICIPANTS_TEXT}: <span class="message-people">{$PARTICIPANTS}</span>
                    <span class="float-right">
		    	<a href="{$BACK_LINK}" class="btn btn-theme">{$BACK}</a>
			<a href="{$LEAVE_CONVERSATION_LINK}" class="btn btn-secondary" onclick="return confirm('{$CONFIRM_LEAVE}');">{$LEAVE_CONVERSATION}</a>
		    </span>
                    <br /><br />
		    {foreach from=$MESSAGES item=message}
                            <hr /><div class="row">
                                <div class="col-md-3">
                                    <center>
                                        <img class="avatar-img" style="width:75px; height:75px;" src="{$message.author_avatar}" alt="{$message.author_username}" />
                                        <br /><br />
                                        <strong><a style="{$message.author_style}" href="{$message.author_profile}">{$message.author_username}</a></strong>
                                        <br /> {foreach from=$message.author_groups item=group} {$group}
                                        <br /> {/foreach}
                                    </center>
                                </div>
                                <div class="col-md-9">
                                    <div class="forum_post">
                                        {$message.content}
                                    </div>
                                    <br />
                                    <span data-toggle="tooltip" data-trigger="hover" data-original-title="{$message.message_date_full}">{$message.message_date}</span>
                                </div>
                            </div>
                    {/foreach}<br /><hr /> {$PAGINATION}
                </div>
            </div>
            <div class="card">
                <div class="card-header header-theme">{$NEW_REPLY}</div>
                <div class="card-body">
                    <form action="" method="post">
                        {if !isset($MARKDOWN)}
                        <div class="form-group">
                            <textarea style="width:100%" name="content" id="reply" rows="15">{$CONTENT}</textarea>
                        </div>
                        {else}
                        <div class="form-group">
                            <textarea class="form-control" style="width:100%" id="markdown" name="content" rows="15">{$CONTENT}</textarea>
                            <span class="float-right"><i data-toggle="popover" data-placement="top" data-html="true" data-content="{$MARKDOWN_HELP}" class="fa fa-question-circle text-info" aria-hidden="true"></i></span>
                        </div>
                        {/if}
                        <div class="form-group">
                            <input type="hidden" name="token" value="{$TOKEN}">
                            <button type="submit" class="btn btn-theme">{$SUBMIT}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
{include file='footer.tpl'}