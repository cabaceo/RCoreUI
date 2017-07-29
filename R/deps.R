# Define the js and css files to be loaded in Shiny

loaded_css <- c(
    "css/font-awesome.css",
    "css/simple-line-icons.css",
    "css/shiny-bridge.css",
    "css/style.css"
)
loaded_js <- c(
    "js/app.js"
)

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
                htmlDependency("CoreUI",
                        as.character(utils::packageVersion("RCoreUI")), # version of RCoreUI
                        src = c(file = system.file("core-ui", package = "RCoreUI")),
                        script = loaded_js,
                        stylesheet = loaded_css
                )
        )

        appendDependencies(x, dashboardDeps)
}
