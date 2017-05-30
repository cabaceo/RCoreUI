#' Dashboard page
#'
#' This creates a dashboard page for use in a Shiny app.
#'
#' @param header A header created by \code{dashboardHeader}.
#' @param sidebar A sidebar created by \code{dashboardSidebar}.
#' @param body A body created by \code{dashboardBody}.
#' @param title A title to display in the browser's title bar. If no value is
#'   provided, it will try to extract the title from the \code{dashboardHeader}.
#'
#' @seealso \code{\link{dashboardHeader}}, \code{\link{dashboardSidebar}},
#'   \code{\link{dashboardBody}}.
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' # Basic dashboard page template
#' library(shiny)
#' shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(),
#'     title = "Dashboard example"
#'   ),
#'   server = function(input, output) { }
#' )
#' }
#' @export
dashboardPage = function(header, sidebar, body, title = NULL) {

        # tagAssert(header, type = "header", class = "app-header navbar")
        # tagAssert(sidebar, type = "div", class = "sidebar")
        # tagAssert(body, type = "main", class = "main")

        extractTitle = function(header) {
                x = header$children[[2]]
                if (x$name == "span" && !is.null(x$attribs$class) &&
                    x$attribs$class == "logo" && length(x$children) != 0) {
                        x$children[[1]]
                } else { "" }
        }
        title = title %OR% extractTitle(header)

        app_body = div(class = "app-body", sidebar, body)
        content = div(class = "app", header, app_body)

        # if the sidebar has the attribute `data-collapsed = "true"`, it means
        # the user set the `collapsed` argument of `dashboardSidebar` to TRUE
        collapsed = findAttribute(sidebar, "data-collapsed", "true")

        addDeps(
                tags$body(
                        # the "sidebar-collapse" class on the body means that
                        # the sidebar should be collapsed (AdminLTE code)
                        class = if (collapsed) " sidebar-collapse",
                        style = "min-height: 611px;",
                        shiny::bootstrapPage(content, title = title)
                )
        )
}
