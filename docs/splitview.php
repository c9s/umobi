<!DOCTYPE html>
<html>
    <?php require "_head.php"; ?>
    <body>

        <div data-role="splitview">
            <aside data-role="content-secondary">
                <div data-role="page">
                    <div data-role="header"><h1>Side Content</h1></div>
                    <div data-role="content">
                        <ul data-role="listview">
                            <li><a href="pages.php">Pages</a></li>
                            <li><a href="buttons.php">Buttons</a></li>
                            <li><a href="forms.php">Form Widgets</a></li>
                            <li><a href="content_formatting.php">Content Formatting</a></li>
                        </ul>
                    </div>
                </div>
            </aside>
            <div data-role="content-primary">
                <div data-role="page">
                    <div data-role="header"><h1>Primary Content</h1></div>
                    <div data-role="content">
                        <p>Splitview sample code:</p>
<pre>&lt;div data-role="splitview"&gt;
    &lt;aside data-role="content-secondary"&gt;
        &lt;div data-role="page"&gt;
            &lt;div data-role="header"&gt;&lt;h1&gt;Side Content&lt;/h1&gt;&lt;/div&gt;
            &lt;div data-role="content"&gt;
                &lt;ul data-role="listview"&gt;
                    &lt;li&gt;&lt;a href="pages.php"&gt;Pages&lt;/a&gt;&lt;/li&gt;
                    &lt;li&gt;&lt;a href="buttons.php"&gt;Buttons&lt;/a&gt;&lt;/li&gt;
                    &lt;li&gt;&lt;a href="forms.php"&gt;Form Widgets&lt;/a&gt;&lt;/li&gt;
                    &lt;li&gt;&lt;a href="content_formatting.php"&gt;Content Formatting&lt;/a&gt;&lt;/li&gt;
                    &lt;li&gt;&lt;a href="minified.php"&gt;With Minified JS/CSS&lt;/a&gt;&lt;/li&gt;
                &lt;/ul&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/aside&gt;
    &lt;div data-role="content-primary"&gt;
        &lt;div data-role="page"&gt;
            &lt;div data-role="header"&gt;&lt;h1&gt;Primary Content&lt;/h1&gt;&lt;/div&gt;
            &lt;div data-role="content"&gt;
                &lt;p&gt;Primary Content Here.&lt;/p&gt;
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;</pre>



                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
