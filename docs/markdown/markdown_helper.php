<?php
require "markdown.php";

function md_start()
{
    ob_start();
}

function md_end()
{
    $content = ob_get_contents();
    ob_end_clean();
    echo '<div class="markdown">';
    echo Markdown($content);
    echo '</div>';
}
