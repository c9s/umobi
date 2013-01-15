<?php require "_init.php"; ?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>µMobi (uMobi)</title>
        <meta name="apple-touch-fullscreen" content="yes" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>

        <script src="../js/jquery.js"> </script>
        <script src="../compiled/umobi.js"> </script>
        <link href="../compiled/umobi.min.css" rel="stylesheet" type="text/css"/>
        <link href="../compiled/customfont/fontawesome.min.css" rel="stylesheet" type="text/css"/>
        <!-- requirejs, which is too slow -->
        <!--
        <script data-main="../js/umobi" src="../js/require.js"></script>
        -->
    </head>
    <body>
        <div data-role="page" id="index">
            <div data-role="header" data-fixed="true">
                <h1>µMobi: For Production</h1>
            </div>
            <div data-role="content">

<?php md_start(); ?>
# µMobi for production

This is a testing page for compiled umobi js/css

## Usage


    <head>
        <script src="../js/jquery.js"> </script>
        <link href="../css/customfont/fontawesome.css" rel="stylesheet" type="text/css"/>
        <link href="../compiled/umobi.min.css" rel="stylesheet" type="text/css"/>
        <script src="../compiled/umobi.min.js"> </script>
    </head>

To load css structure and theme separately:

    <link href="../compiled/umobi.structure.css" rel="stylesheet" type="text/css"/>
    <link href="../compiled/umobi.theme.css" rel="stylesheet" type="text/css"/>


<?php md_end(); ?>
                <h1>Testing samples</h2>
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
        </div>
    </body>
</html>
