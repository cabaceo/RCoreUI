#' Create a message item to place in a dropdown message menu
#'
#' @param from Who the message is from.
#' @param message Text of the message.
#' @param icon An icon tag, created by \code{\link[shiny]{icon}}.
#' @param time String representing the time the message was sent. Any string may
#'   be used. For example, it could be a relative date/time like "5 minutes",
#'   "today", or "12:30pm yesterday", or an absolute time, like "2014-12-01 13:45".
#'   If NULL, no time will be displayed.
#' @param href An optional URL to link to.
#'
#' @family menu items
#' @seealso \code{\link{dashboardHeader}} for example usage.
#' @export
messageItem <- function(from, message, icon = shiny::icon("user"), time = NULL,
                        href = NULL) {
        tagAssert(icon, type = "i")
        if (is.null(href)) href <- "#"

        tags$li(
                a(class = "dropdown-item", href = href, icon,
                  h4(from,
                     if (!is.null(time)) tags$small(shiny::icon("clock-o"), time)),
                  p(message)
                )
        )
}
