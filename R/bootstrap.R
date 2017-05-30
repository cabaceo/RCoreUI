#' Create a Bootstrap page
#'
#' Create a Shiny UI page that loads the CSS and JavaScript for
#' \href{http://getbootstrap.com/}{Bootstrap}, and has no content in the page
#' body (other than what you provide).
#'
#' This function is primarily intended for users who are proficient in HTML/CSS,
#' and know how to lay out pages in Bootstrap. Most applications should use
#' \code{\link{fluidPage}} along with layout functions like
#' \code{\link{fluidRow}} and \code{\link{sidebarLayout}}.
#'
#' @param ... The contents of the document body.
#' @param title The browser window title (defaults to the host URL of the page)
#' @param responsive This option is deprecated; it is no longer needed with
#'   Bootstrap 4.
#' @param theme Alternative Bootstrap stylesheet (normally a css file within the
#'   www directory, e.g. \code{www/bootstrap.css})
#'
#' @return A UI defintion that can be passed to the \link{shinyUI} function.
#'
#' @note The \code{basicPage} function is deprecated, you should use the
#'   \code{\link{fluidPage}} function instead.
#'
#' @seealso \code{\link{fluidPage}}, \code{\link{fixedPage}}
#' @export
bootstrapPage1 <- function(..., title = NULL, responsive = NULL, theme = NULL) {

  if (!is.null(responsive)) {
    shinyDeprecated("The 'responsive' argument is no longer used with Bootstrap 4.")
  }

  attachDependencies(
    tagList(
      if (!is.null(title)) tags$head(tags$title(title)),
      if (!is.null(theme)) {
        tags$head(tags$link(rel="stylesheet", type="text/css", href = theme))
      },

      # remainder of tags passed to the function
      list(...)
    ),
    bootstrapLib1()
  )
}

#' Bootstrap libraries
#'
#' This function returns a set of web dependencies necessary for using Bootstrap
#' components in a web page.
#'
#' It isn't necessary to call this function if you use
#' \code{\link{bootstrapPage}} or others which use \code{bootstrapPage}, such
#' \code{\link{basicPage}}, \code{\link{fluidPage}}, \code{\link{fillPage}},
#' \code{\link{pageWithSidebar}}, and \code{\link{navbarPage}}, because they
#' already include the Bootstrap web dependencies.
#'
#' @inheritParams bootstrapPage1
#' @export
bootstrapLib1 <- function(theme = NULL) {
        htmlDependency(
                "bootstrap", "0.0.0.9000", # version of RCoreUI
                src = c(href = "bootstrap",
                        file = system.file("bootstrap", package = "RCoreUI")
                        ),
                script = "js/bootstrap.min.js",
                stylesheet = if (is.null(theme)) "css/bootstrap.min.css",
                meta = list(viewport = "width=device-width, initial-scale=1")
        )
}

