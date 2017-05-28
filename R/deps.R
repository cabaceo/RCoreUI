# add a html dependency without overwriting existing ones
appendDependencies = function(x, value) {
        if (inherits(value, "html_dependency")) value = list(value)

        old = attr(x, "html_dependencies", TRUE)

        htmlDependencies(x) = c(old, value)
        x
}

# add dashboard dependencies to a tag object
addDeps = function(x) {
        dir_CoreUI_js = system.file("CoreUI/js", package = "RCoreUI")
        dir_CoreUI_css = system.file("CoreUI/css", package = "RCoreUI")
        CoreUI_js  = "app.js"
        CoreUI_css = c("style.css", "simple-line-icons.css",
                       "font-awesome.min.css") # , "font-awesome.css"

        dashboardDeps = list(
                # htmlDependency is a function in htmltools
                htmlDependency("CoreUI", "1.0.0-alpha.5",
                               src = c(file = dir_CoreUI_js),
                               script = CoreUI_js),
                htmlDependency("CoreUI", "1.0.0-alpha.5",
                               src = c(file = dir_CoreUI_css),
                               stylesheet = CoreUI_css)
        )

        appendDependencies(x, dashboardDeps)
}
