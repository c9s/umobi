<!DOCTYPE html>
<html>
    <?php require "_head.php"; ?>
    <body>
        <div data-role="page" id="index">
            <div data-role="header" data-fixed="true">
                <h1>µMobi: Buttons</h1>
            </div>
            <div data-role="content">

                <h2>Link buttons</h2>
                <a href="index.php">Normal Link</a>
                <a data-role="button" href="index.php">Link button</a>
                <a data-role="button" data-icon="search" href="index.php">Button with icon</a>
                <a data-role="button" data-mini="true" href="index.php">Mini button</a>

                <a data-role="button" data-icon="th" data-mini="true" href="index.php">Mini button</a>
                <a data-role="button" data-icon="th" data-iconpos="left" data-mini="true" href="index.php">Mini button</a>
                <a data-role="button" data-icon="th" data-iconpos="right" data-mini="true" href="index.php">Mini button</a>

                <p>
                <a data-role="button" data-icon="th" data-iconpos="top" data-inline="true" data-mini="true" href="index.php">Mini button</a>
                <a data-role="button" data-icon="th" data-iconpos="bottom" data-inline="true" data-mini="true" href="index.php">Mini button</a>
                </p>

                <h2>Button tag</h2>

                <h3>Normal button</h3>
                <button>Button Element</button>

                <h3>Mini buttons</h3>
                <button data-mini="true">Button Element</button>
                <button data-icon="th" data-mini="true">Button Element</button>
                <button data-icon="th" data-iconpos="right" data-mini="true">Button Element</button>
                <p>
                    <button data-icon="search" data-iconpos="bottom" data-mini="true">Button Element</button>
                </p>
                <p>
                    <button data-icon="search" data-iconpos="top" data-mini="true">Button Element</button>
                </p>

                <h3>Full-expanded buttons</h3>
                <button data-icon="search" data-iconpos="left">Button Element</button>
                <button data-icon="search" data-iconpos="right">Button Element</button>
                <button data-icon="search" data-iconpos="top">Button Element</button>
                <button data-icon="search" data-iconpos="bottom">Button Element</button>
                <button data-icon="search" data-mini="true" data-iconpos="notext">Button Element</button>

            </div>
        </div>
    </body>
</html>
