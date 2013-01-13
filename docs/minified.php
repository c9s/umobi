<!DOCTYPE html>
<html>
    <?php require "_head.php"; ?>
    <body>
        <div data-role="page" id="index">
            <div data-role="header" data-fixed="true">
                <h1>µMobi</h1>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <label for="text-field">Text Field</label>
                    <input type="text" id="text-field"/>
                </div>

                <div data-role="fieldcontain">
                    <label for="password">Password</p>
                    <input type="password" id="text-field"/>
                </div>

                <p>Radio Input</p>

                <input type="radio" name="radio" value="1"/>
                <input type="radio" name="radio" value="2"/>

                <p>Range input</p>
                <input type="range" name="radio" value="2"/>

                <input type="text" name="" value="Text Input"/>

                <textarea rows="10" name="textarea"></textarea>

            </div>
            <div data-role="footer" data-fixed="true">
                <div>Footer</div>
            </div>
        </div>

        <div data-role="page" id="content-formatting">
            <div data-role="header">
                <h1>Content Formatting</h1>
            </div>
            <div data-role="content">
                <h1>Header 1 h1</h1>
                <h2>Header 2 h2</h2>
                <h3>Header 3 h3</h3>
                <h4>Header 4 h4</h4>
                <p>Content here</p>
            </div>
            <div data-role="footer">
                <div>Footer</div>
            </div>
        </div>


        <div data-role="page" id="page2">
            <div data-role="header">
                <h1>umobi project: page2</h1>
            </div>
            <div data-role="content">
                <p>Content here, page2</p>
                <p><a href="#index">Back to index</a></p>
            </div>
            <div data-role="footer" data-fixed="true">
                <div>Footer</div>
            </div>
        </div>
    </body>
</html>
