<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <title>Webkit-frame</title>
        <style>
@-webkit-keyframes resize {
  0% { -webkit-transform: translate3d(0, -100px, 0); }
  25% { -webkit-transform: translate3d(0, -50px, 0); }
  50% { -webkit-transform: translate3d(0, -100px, 0); }
  75% { -webkit-transform: translate3d(0, -30px, 0); }
  100% { -webkit-transform: translate3d(0, -100px, 0); }
}

#box {
    background: red; 
    float: left;
    width: 200px;
    height: 200px;
    position: absolute;
    left: 0;
    top: 100px;
}

#box:hover {
  -webkit-animation-name: resize;
  -webkit-animation-duration: 1s;
  -webkit-animation-iteration-count: 1;
  -webkit-animation-direction: alternate;

  /*
  -moz-animation-name: resize;
  -moz-animation-duration: 1s;
  -moz-animation-iteration-count: 4;
  -moz-animation-direction: alternate;

  -o-animation-name: resize;
  -o-animation-duration: 1s;
  -o-animation-iteration-count: 4;
  -o-animation-direction: alternate;

  animation-name: resize;
  animation-duration: 1s;
  animation-iteration-count: 4;
  animation-direction: alternate;
  */
}

        </style>
    </head>
    <body>
        <div id="box"> content </div>
    </body>
</html>
