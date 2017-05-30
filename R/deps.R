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
                # htmlDependency is a function in htmltools
                htmlDependency(
                        "CoreUI", "0.0.0.9000", # version of RCoreUI
                        src = c(href = "CoreUI",
                                file = system.file("CoreUI", package = "RCoreUI")
                                ),
                        script = "js/app.js"
                ),
                htmlDependency(
                        "CoreUI", "0.0.0.9000", # version of RCoreUI
                        src = c(href = "CoreUI",
                                file = system.file("CoreUI", package = "RCoreUI")
                                ),
                        stylesheet = c("css/style.css",
                                       "css/simple-line-icons.css",
                                       "css/font-awesome.min.css") # , "font-awesome.css"
                )
        )

        appendDependencies(x, dashboardDeps)
}
