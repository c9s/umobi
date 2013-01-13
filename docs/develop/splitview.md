splitview
=========

a split view may contains a main menu and the main content.


## Display

- for large screens, a split view shows:
    - a main menu in the left-hand side.
    - primary content in the right-hand side.

    |----------------------------------|
    |  Sidebar  |  Primary Content     |
    |----------------------------------|

- for narrow screens, a split view shows:
    - primary content takes up the whole screen. 
    - a menu button in the left-top corner.
    - the main menu can be toggled from the menu button.

    |----------------------|
    |  Sidebar menu button |
    |----------------------|
    |  Primary     Content |
    |----------------------|

## Behavior

- to update primary content area, a link should be specified 
  with a specific link target to the primary content.
  
- without link target, the link will update the page to the sidebar view itself.

- when initializing a page with a splitview:

    1. find the splitview container.
    2. find the secondary content container inside the splitview container.
        1. initialize pages inside the secondary content container.
        2. initialize links with target (should support target)
    3. find the primary content container inside the splitview container.
        1. initialize pages inside the primary content container.
        2. shows the index page (of primary content)
        3. initialize links with target (should support target)

## HTML Template

a "secondary-content" role or "primary-content" role is actually a
page container.

a simple splitview example:

    <div data-role="splitview">
        <div data-role="view-secondary">
            <div data-role="page">
                <ul data-role="listview">
                    <li><a data-target="primary-contnet" href="">Item1</a></li>
                    <li><a data-target="primary-content" href="">Item1</a></li>
                    <li><a href="folderlist.php">Folder</a></li>
                    <li><a href="folderlist.php">Folder</a></li>
                </ul>
            </div>
        </div>
        <div data-role="view-primary">

        </div>
    </div>

load primary content and secondary content via Ajax, by using "data-href"
attribute:

    <div data-role="splitview">
        <div data-role="primary-content" data-href="link"> </div>
        <div data-role="secondary-content" data-href="link"> </div>
    </div>

