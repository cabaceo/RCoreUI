#' Create a header for a dashboard page
#'
#' A dashboard header can be left blank, or it can include dropdown menu items
#' on the right side.
#'
#' @param title An optional title to show in the header bar.. By default, this
#'   will also be used as the title shown in the browser's title bar. If you
#'   want that to be different from the text in the dashboard header bar, set
#'   the \code{title} in \code{\link{dashboardPage}}.
#' @param titleWidth The width of the title area. This must either be a number
#'   which specifies the width in pixels, or a string that specifies the width
#'   in CSS units.
#' @param disable If \code{TRUE}, don't display the header bar.
#' @param ... Items to put in the header. Should be \code{\link{dropdownMenu}}s.
#' @param .list An optional list containing items to put in the header. Same as
#'   the \code{...} arguments, but in list format. This can be useful when
#'   working with programmatically generated items.
#'
#' @seealso \code{\link{dropdownMenu}}
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#'
#' # A dashboard header with 3 dropdown menus
#' header = dashboardHeader(
#'   title = "Dashboard Demo",
#'
#'   # Dropdown menu for messages
#'   dropdownMenu(type = "messages", badgeStatus = "success",
#'     messageItem("Support Team",
#'       "This is the content of a message.",
#'       time = "5 mins"
#'     ),
#'     messageItem("Support Team",
#'       "This is the content of another message.",
#'       time = "2 hours"
#'     ),
#'     messageItem("New User",
#'       "Can I get some help?",
#'       time = "Today"
#'     )
#'   ),
#'
#'   # Dropdown menu for notifications
#'   dropdownMenu(type = "notifications", badgeStatus = "warning",
#'     notificationItem(icon = icon("users"), status = "info",
#'       "5 new members joined today"
#'     ),
#'     notificationItem(icon = icon("warning"), status = "danger",
#'       "Resource usage near limit."
#'     ),
#'     notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
#'       status = "success", "25 sales made"
#'     ),
#'     notificationItem(icon = icon("user", lib = "glyphicon"),
#'       status = "danger", "You changed your username"
#'     )
#'   ),
#'
#'   # Dropdown menu for tasks, with progress bar
#'   dropdownMenu(type = "tasks", badgeStatus = "danger",
#'     taskItem(value = 20, color = "aqua",
#'       "Refactor code"
#'     ),
#'     taskItem(value = 40, color = "green",
#'       "Design new layout"
#'     ),
#'     taskItem(value = 60, color = "yellow",
#'       "Another task"
#'     ),
#'     taskItem(value = 80, color = "red",
#'       "Write documentation"
#'     )
#'   )
#' )
#'
#' shinyApp(
#'   ui = dashboardPage(
#'     header,
#'     dashboardSidebar(),
#'     dashboardBody()
#'   ),
#'   server = function(input, output) { }
#' )
#' }
#' @export
dashboardHeader = function(..., title = NULL, titleWidth = NULL,
                           disable = FALSE, .list = NULL) {
        items = c(list(...), .list)
        lapply(items, tagAssert, type = "li", class = "dropdown")

        ## TASK: implement custom titleWidth

        ## TASK: implement title and logo display (upper left corner)

        tags$header(class = "app-header navbar",
                    style = if (disable) "display: none;",

                    tags$button(class="navbar-toggler mobile-sidebar-toggler d-lg-none", "☰"),
                    a(href="#", class="navbar-brand"),
                    tags$ul(class="nav navbar-nav d-md-down-none",
                            tags$li(class="nav-item",
                                    a(href="#", class="nav-link navbar-toggler sidebar-toggler")),
                            tags$li(class="nav-item px-3",
                                    a(href="#",class="nav-link","Dashboard")),
                            tags$li(class="nav-item px-3",
                                    a(href="#",class="nav-link","Users")),
                            tags$li(class="nav-item px-3",
                                    a(href="#",class="nav-link","Settings"))
                    ),
                    
                    # tags$ul(class="nav navbar-nav d-md-down-none",
                    #         tags$li(class="nav-item",
                    #                 a(href="#", class="nav-link navbar-toggler sidebar-toggler"))
                    # ),

                    tags$ul(class="nav navbar-nav ml-auto",
                            items
                    )
        )

}



