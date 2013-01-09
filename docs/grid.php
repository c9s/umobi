<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>µMobi (uMobi)</title>
        <meta name="apple-touch-fullscreen" content="yes"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
        <link href="../css/structure/umobi.css" rel="stylesheet" type="text/css"/>
        <link href="../css/themes/default/umobi.css" rel="stylesheet" type="text/css"/>
        <script src="../js"></script>
    </head>
    <body>
        <div data-role="page">
            <div data-role="header" data-fixed="true">
                <h1>µMobi: Grid System</h1>
            </div>
            <div data-role="content">


                <h2>grid 1/3 x 3</h2>
                <div class="clearfix" style="border: 1px dashed #ccc;">
                    <div class="column grid-3-1">a</div>
                    <div class="column grid-3-1">b</div>
                    <div class="column grid-3-1">c</div>
                </div>

                <h2>grid 1/3 + 2/3</h2>
                <div class="clearfix" style="border: 1px dashed #ccc;">
                    <div class="column grid-3-1">a</div>
                    <div class="column grid-3-2">b</div>
                </div>
                
                <h2>grid 1/5 x 5</h2>
                <div class="clearfix" style="border: 1px dashed #ccc;">
                    <div class="column grid-5-1">a</div>
                    <div class="column grid-5-1">b</div>
                    <div class="column grid-5-1">c</div>
                    <div class="column grid-5-1">d</div>
                    <div class="column grid-5-1">e</div>
                </div>

                <h2>grid 2/5 + 3/5</h2>
                <div class="clearfix" style="border: 1px dashed #ccc;">
                    <div class="column grid-5-2">a</div>
                    <div class="column grid-5-3">b</div>
                </div>
            </div>
        </div>
    </body>
</html>
