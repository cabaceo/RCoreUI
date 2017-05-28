# add a html dependency without overwriting existing ones
appendDependencies = function(x, value) {
        if (inherits(value, "html_dependency")) value = list(value)

        old = attr(x, "html_dependencies", TRUE)

        htmlDependencies(x) = c(old, value)
        x
}

# add dashboard dependencies to a tag object
addDeps = function(x) {
        CoreUI_js  = RCoreUI_js = "app.js"
        CoreUI_css = RCoreUI_css = c("style.css", "simple-line-icons.css",
                                     "font-awesome.min.css") # , "font-awesome.css"

        dashboardDeps = list(
                # htmlDependency is a function in htmltools
                htmlDependency("CoreUI", "1.0.0-alpha.5",
                               src = c(file = system.file("CoreUI", package = "RCoreUI")),
                               script = CoreUI_js,
                               stylesheet = CoreUI_css),
                htmlDependency("RCoreUI",
                               as.character(utils::packageVersion("RCoreUI")),
                               src = c(file = system.file(package = "RCoreUI")),
                               script = RCoreUI_js,
                               stylesheet = RCoreUI_css)
        )

        appendDependencies(x, dashboardDeps)
}
