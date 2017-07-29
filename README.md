# RCoreUI

R ShinyDashboard implementation of the [CoreUI theme](https://github.com/mrholek/CoreUI-Free-Bootstrap-Admin-Template/tree/master/Static_Full_Project_GULP). 

The [doc](http://coreui.io/docs/getting-started/static-version) for the CoreUI theme. 

[ShinyDashboard default theme](https://rstudio.github.io/shinydashboard/).


## Development Guide

### Prep UI Framework

When firstly checked out the source code, run the following "CMDs" to get all dependencies ready. It includes two parts:

- Gulp dependencies - support the normal Gulp tasks.
- UI Framework dependencies - support the running of the UI framework.

#### Gulp

Stay in the **root** folder of the project, run `npm install` to install all "dev" dependencies.

```
npm install
```

#### UI Framework

Go into the source code folder, and run `bower install` to get the dependencies.

```
cd srcjs
bower install
```

### Dev and Preview on UI Framework part

The UI framework embedded in the project provides a complete environment for development. You can use it to "customize" the
framework as well as preview the UI framework if needed.

Simply run `gulp` in the command line to start the HTTP server to view the UI framework in the browser. It also watches
any change you made and refresh the web page automatically.

### Dev on R part

Before you start to write the R functions, do the following to get the UI elements ready:

- Run `gulp build` to build the JS and CSS files from UI framework to `inst` folder.
- Modify the file `deps.R` to specify the JS and CSS files you want to load into Shiny app.



