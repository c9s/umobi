<!DOCTYPE html>
<html>
<?php require "_head.php"; ?>
<body>
    <div data-role="page" id="index">
        <div data-role="header" data-fixed="true">
            <h1>µMobi</h1>
        </div>
        <div data-role="content">
            <h2>Field Contain</h2>
            <div data-role="fieldcontain">
                <label for="text-field">Text Field</label>
                <input type="text" id="text-field"/>
            </div>

            <div data-role="fieldcontain">
                <label for="password">Password</p>
                <input type="password" id="text-field"/>
            </div>

            <h2>Mini Text Input</h2>
            <input data-mini="true" type="text" id="text-field"/>

            <h2>Button</h2>

            <p>
                Text <button data-mini="true">Inline Button</button> Text
            </p>

            <button>Button</button>

    <h2>Radio Input</h2>
            <p></p>
            <input type="radio" name="radio" id="radio1" value="female"/>
    <label for="radio1">Female</label>
            <input type="radio" name="radio" id="radio2" value="male"/>
    <label for="radio2">Male</label>

    <h2>Date Input</h2>
    <input type="date" name="date"/>

    <h2>DateTime Input</h2>
    <input type="datetime" name="datetime" value="1996-12-19T16:39:57-08:00"/>
    <p>DateTime input is not supported in Google Chrome yet</p>

    <h2>Time Input</h2>
    <input type="time" name="time">

            <h2>Range input</h2>
            <input type="range" name="radio" value="2"/>

            <h2>Text Input</h2>
            <input type="text" name="" value="Text Input"/>

    <h2>Textarea</h2>
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
