<?php require "_init.php"; ?>
<head>
    <meta charset="utf-8">
    <title>µMobi (uMobi)</title>
    <meta name="apple-touch-fullscreen" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>

    <link href="../css/structure/umobi.css" rel="stylesheet" type="text/css"/>
    <link href="../css/themes/default/umobi.css" rel="stylesheet" type="text/css"/>
    <link href="../css/customfont/fontawesome.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="../src/jquery.js"></script>

<?php if ( file_exists("../src/umobi.compiled.js") ): ?>
    <script type="text/javascript" src="../src/jquery.js"></script>
    <script type="text/javascript" src="../src/umobi.compiled.js"></script>
<?php else: ?>
    <script type="text/javascript" src="../src/jquery.js"></script>
    <script type="text/javascript" src="../compiled/umobi.min.js"></script>
<?php endif ?>


</head>
