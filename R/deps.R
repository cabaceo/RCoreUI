# Add an html dependency, without overwriting existing ones
appendDependencies <- function(x, value) {
  if (inherits(value, "html_dependency"))
    value <- list(value)

  old <- attr(x, "html_dependencies", TRUE)

  htmlDependencies(x) <- c(old, value)
  x
}

# Add dashboard dependencies to a tag object
addDeps <- function(x) {
  coreUI_js <- c("app.js", "charts.js","main.js","widgets.js")
  coreUI_css <- c("style.css", "simple-line-icons.css","font-awesome.min.css","font-awesome.css")
 
  dashboardDeps <- list(
    htmlDependency("CoreUI",
      c(file = system.file("CoreUI", package = "CoreUI")),
      script = coreUI_js,
      stylesheet = coreUI_css
    ),
    htmlDependency("CoreUI",
      as.character(utils::packageVersion("CoreUI")),
      c(file = system.file(package = "CoreUI")),
      script = "CoreUI.js",
      stylesheet = "CoreUI.css"
    )
  )

  appendDependencies(x, dashboardDeps)
}
