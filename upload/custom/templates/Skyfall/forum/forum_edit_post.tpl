{include file='header.tpl'} {include file='navbar.tpl'}
<div class="container">
    <div class="card">
        <div class="card-header header-theme">{$EDITING_POST}</div>
        <div class="card-body">
            <div class="container">
                {if isset($ERRORS)}
                <div class="alert alert-danger">
                    {foreach from=$ERRORS item=error} {$error}
                    <br /> {/foreach}
                </div>
                {/if}
                <form action="" method="post">
                    {if isset($EDITING_TOPIC)}
                    <div class="form-group">
                        <input type="text" class="form-control form-control-lg" name="title" value="{$TOPIC_TITLE}">
                    </div>
                    {if count($LABELS)}
                    <div class="form-group">
                        {foreach from=$LABELS item=label}
                        <label for="{$label.id}">{$label.html}</label>
                        <input type="checkbox" name="topic_label[]" id="{$label.id}" value="{$label.id}"{if $label.active} checked="checked"{/if}> {/foreach}
                    </div>
                    {/if} {/if} {if isset($MARKDOWN)}
                    <div class="form-group">
                        <textarea class="form-control" style="width:100%" id="markdown" name="content" rows="20"></textarea>
                        <span class="float-right"><i data-toggle="popover" data-placement="top" data-html="true" data-content="{$MARKDOWN_HELP}" class="fa fa-question-circle text-info" aria-hidden="true"></i></span>
                    </div>
                    {else}
                    <div class="form-group">
                        <textarea name="content" id="editor" rows="20">{$CONTENT}</textarea>
                    </div>
                    {/if}
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <button type="submit" class="btn btn-theme">{$SUBMIT}</button>
                    <a class="btn btn-secondary" href="{$CANCEL_LINK}" onclick="return confirm('{$CONFIRM_CANCEL}')">{$CANCEL}</a>
                </form>
            </div>
        </div>
    </div>
</div>
{include file='footer.tpl'}