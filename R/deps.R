# add a html dependency without overwriting existing ones
appendDependencies = function(x, value) {
        if (inherits(value, "html_dependency")) value = list(value)
        old = attr(x, "html_dependencies", TRUE)
        htmlDependencies(x) = c(old, value)
        x
}

# add dashboard dependencies to a tag object
addDeps = function(x) {
        if (getOption("shiny.minified", TRUE)) {
                coreUI_js = "js/app.min.js" # self-created using http://www.minifier.org
                shinydashboard_js = "shinydashboard/shinydashboard.min.js"
                coreUI_css = c("css/font-awesome.min.css",
                               "css/simple-line-icons.min.css", # self-created using http://www.minifier.org
                               "css/style.min.css" # self-created using http://www.minifier.org
                               )
        } else {
                coreUI_js = "js/app.js"
                shinydashboard_js = "shinydashboard/shinydashboard.js"
                coreUI_css = c("css/font-awesome.css",
                               "css/simple-line-icons.css",
                               "css/style.css"
                               )
        }
        
        dashboardDeps = list(

                # htmlDependency("bootstrap",
                #         as.character(utils::packageVersion("RCoreUI")), # version of RCoreUI
                #         src = c(file = system.file("bootstrap", package = "RCoreUI")),
                #         script = "js/bootstrap.min.js",
                #         stylesheet = "css/bootstrap.min.css"
                #         # meta = list(viewport = "width=device-width, initial-scale=1")
                # ),

                htmlDependency("CoreUI",
                        as.character(utils::packageVersion("RCoreUI")), # version of RCoreUI
                        src = c(file = system.file("CoreUI", package = "RCoreUI")),
                        script = coreUI_js,
                        stylesheet = coreUI_css
                )

                # htmlDependency("shinydashboard",
                #                as.character(utils::packageVersion("RCoreUI")), # version of RCoreUI
                #                src = c(file = system.file("shinydashboard",
                #                                           package = "RCoreUI")),
                #                script = shinydashboard_js,
                #                stylesheet = "shinydashboard/shinydashboard.css"
                # )
        )

        appendDependencies(x, dashboardDeps)
}
