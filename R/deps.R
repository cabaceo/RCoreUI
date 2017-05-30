## It seems addDeps() is used to create a dashboard page in a Shiny app, NOT
## used for any of the dashboard elements themselves.

# add a html dependency without overwriting existing ones
appendDependencies = function(x, value) {
        if (inherits(value, "html_dependency")) value = list(value)

        old = attr(x, "html_dependencies", TRUE)

        htmlDependencies(x) = c(old, value)
        x
}

# add dashboard dependencies to a tag object
addDeps = function(x) {
        dashboardDeps = list(

                htmlDependency("bootstrap",
                        as.character(utils::packageVersion("RCoreUI")), # version of RCoreUI
                        src = c(file = system.file("bootstrap", package = "RCoreUI")),
                        script = "js/bootstrap.min.js",
                        stylesheet = "css/bootstrap.min.css"
                        # meta = list(viewport = "width=device-width, initial-scale=1")
                ),

                htmlDependency("CoreUI",
                        as.character(utils::packageVersion("RCoreUI")), # version of RCoreUI
                        src = c(file = system.file("CoreUI", package = "RCoreUI")),
                        script = "js/app.js",
                        stylesheet = c("css/style.css",
                                       "css/simple-line-icons.css",
                                       "css/font-awesome.min.css") # , "font-awesome.css"
                )


        )

        appendDependencies(x, dashboardDeps)
}
