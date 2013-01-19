<?php
header("Content-type: text/coffeescript; charset=UTF-8");
$files = file("../js.manifest");
$baseDir = "../src";
foreach( $files as $file ) {
    if( preg_match('/^\s*#/',$file) )
        continue;
    $file = preg_replace('/#.*/','',$file);
    if( strrpos($file,".coffee") !== false ) {
        $path = trim($baseDir . "/" . $file);
        echo file_get_contents($path);
    }
}
