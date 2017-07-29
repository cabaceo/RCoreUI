# Source folder for UI framework

## Current UI Framework

**[Core UI](http://coreui.io/)** - a Bootstrap Template built as framework.

> Github: https://github.com/mrholek/CoreUI-Free-Bootstrap-Admin-Template

## Source Code

The source code under this folder is from the part "**Static_Full_Project_GULP**" inside the CoreUI code repo.

## Modifications

### Shiny Bridge CSS

If the UI framework uses a different version of **Bootstrap** than Shiny uses, CSS style may have certain conflict.
In order to neutralize this impact, adding a special CSS file `shiny-beidge.css` to reset the CSS style if needed.

> NOTE: This file should be loaded **before** the actual CSS style file of the UI framework.

Add this file here to utilize the building system that the UI framework usually provides.

