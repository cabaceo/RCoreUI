#' Create a dashboard sidebar.
#'
#' A dashboard sidebar typically contains a \code{\link{sidebarMenu}}, although
#' it may also contain a \code{\link{sidebarSearchForm}}, or other Shiny inputs.
#'
#' @param ... Items to put in the sidebar.
#' @param disable If \code{TRUE}, the sidebar will be disabled.
#' @param width The width of the sidebar. This must either be a number which
#'   specifies the width in pixels, or a string that specifies the width in CSS
#'   units.
#' @param collapsed If \code{TRUE}, the sidebar will be collapsed on app startup.
#'
#' @seealso \code{\link{sidebarMenu}}
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' header = dashboardHeader()
#'
#' sidebar = dashboardSidebar(
#'   sidebarUserPanel("User Name",
#'     subtitle = a(href = "#", icon("circle", class = "text-success"), "Online"),
#'     # Image file should be in www/ subdir
#'     image = "userimage.png"
#'   ),
#'   sidebarSearchForm(label = "Enter a number", "searchText", "searchButton"),
#'   sidebarMenu(
#'     # Setting id makes input$tabs give the tabName of currently-selected tab
#'     id = "tabs",
#'     menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
#'     menuItem("Widgets", icon = icon("th"), tabName = "widgets", badgeLabel = "new",
#'              badgeColor = "green"),
#'     menuItem("Charts", icon = icon("bar-chart-o"),
#'       menuSubItem("Sub-item 1", tabName = "subitem1"),
#'       menuSubItem("Sub-item 2", tabName = "subitem2")
#'     )
#'   )
#' )
#'
#' body = dashboardBody(
#'   tabItems(
#'     tabItem("dashboard",
#'       div(p("Dashboard tab content"))
#'     ),
#'     tabItem("widgets",
#'       "Widgets tab content"
#'     ),
#'     tabItem("subitem1",
#'       "Sub-item 1 tab content"
#'     ),
#'     tabItem("subitem2",
#'       "Sub-item 2 tab content"
#'     )
#'   )
#' )
#'
#' shinyApp(
#'   ui = dashboardPage(header, sidebar, body),
#'   server = function(input, output) { }
#' )
#' }
#' @export
dashboardSidebar = function(..., disable = FALSE, width = NULL, collapsed = FALSE) {

        # If we're restoring a bookmarked app, this holds the value of whether
        # or not the sidebar was collapsed. If this is not the case, the default
        # is whatever the user specified in the `collapsed` argument.
        dataValue = shiny::restoreInput(id = "sidebarCollapsed", default = collapsed)
        if (disable) dataValue = TRUE # this is a workaround to fix #209
        dataValueString = if (dataValue) ".sidebar-hidden" else ""

        # The expanded/collapsed state of the sidebar is actually set by adding a
        # class to the body (not to the sidebar). However, it makes sense for the
        # `collapsed` argument to belong in this function. So this information is
        # just passed through (as the `data-collapsed` attribute) to the
        # `dashboardPage()` function
        div(class = "sidebar",
            `data-collapsed` = dataValueString,
            tags$nav(class = "sidebar-nav",
                     `data-disable` = if (disable) 1 else NULL,
                     tags$ul(class = "nav",
                             list(...)
                             )
                     )
            )
}
