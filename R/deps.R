# add a html dependency without overwriting existing ones
appendDependencies <- function(x, value) {
        if (inherits(value, "html_dependency")) value <- list(value)

        old <- attr(x, "html_dependencies", TRUE)

        htmlDependencies(x) <- c(old, value)
        x
}

# add dashboard dependencies to a tag object
addDeps <- function(x) {
        coreUI_js <- c("app.js", "charts.js", "main.js", "widgets.js")
        coreUI_css <- c("style.css", "simple-line-icons.css",
                        "font-awesome.min.css", "font-awesome.css")

        dashboardDeps <- list(
                htmlDependency("CoreUI", "1.0.0-alpha.5",
                               c(file = system.file("CoreUI", package = "RCoreUI")),
                               script = coreUI_js,
                               stylesheet = coreUI_css)
                # htmlDependency("shinydashboard",
                #                as.character(utils::packageVersion("shinydashboard")),
                #                c(file = system.file(package = "shinydashboard")),
                #                script = shinydashboard_js,
                #                stylesheet = "shinydashboard.css")
        )

        appendDependencies(x, dashboardDeps)
}
