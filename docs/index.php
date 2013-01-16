<!DOCTYPE html>
<html>
    <?php require "_head.php"; ?>
    <body>
        <page data-role="page" id="index">
            <header data-fixed="true">
                <h1>µMobi</h1>
            </header>
            <section data-role="content">
                <nav>
                    <ul data-role="listview" data-inset="true">
                        <?php require "_index.php"; ?>
                    </ul>
                </nav>
            </section>
            <footer data-fixed="true">
                <div>Footer</div>
            </footer>
        </page>
    </body>
</html>
