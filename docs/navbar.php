<!DOCTYPE html>
<html>
    <?php require "_head.php"; ?>
    <body>
        <div data-role="page" id="index">
            <div data-role="header" data-fixed="true">
                <h1>µMobi</h1>
                <ul data-role="navbar">
                    <li>Button1</li>
                    <li>Button2</li>
                    <li>Button3</li>
                </ul>
            </div>
            <div data-role="content">
                <ul data-role="listview" data-inset="true">
                    <li><a href="pages.php">Pages</a></li>
                    <li><a href="buttons.php">Buttons</a></li>
                    <li><a href="forms.php">Form Widgets</a></li>
                    <li><a href="content_formatting.php">Content Formatting</a></li>
                    <li><a href="minified.php">With Minified JS/CSS</a></li>
                </ul>
            </div>
            <div data-role="footer" data-fixed="true">
                <div>Footer</div>
            </div>
        </div>
    </body>
</html>
