#' Create a dropdown menu to place in a dashboard header.
#'
#' @param type Menu type: "messages", "notifications", or "tasks".
#' @param badgeStatus The status of the badge. It displays the number of items
#'   in the menu and also determines the badge's color. Valid statuses are listed
#'   in \link{validStatuses}. A value of \code{NULL} means to not display a
#'   badge.
#' @param ... Items to put in the menu. Typically, message menus should contain
#'   \code{\link{messageItem}}s, notification menus should contain
#'   \code{\link{notificationItem}}s, and task menus should contain
#'   \code{\link{taskItem}}s.
#' @param icon Menu icon. By default, the icon is automatically selected
#'   depending on \code{type}, but it can be overriden with this argument.
#' @param headerText An optional text argument used for the header of the
#'   dropdown menu (this is only visible when the menu is expanded). If none is
#'   provided by the user, the default is "You have \code{x} messages," where
#'   \code{x} is the number of items in the menu. If the \code{type} is
#'   "notifications" or "tasks," the text shows "You have \code{x} notifications"
#'   or "You have \code{x} tasks" respectively.
#' @param .list An optional list containing items to put in the menu. Same as the
#'   \code{...} arguments, but in list format. This can be useful when working
#'   with programmatically generated items.
#'
#' @seealso \code{\link{dashboardHeader}} for example usage.
#'
#' @export
dropdownMenu <- function(..., type = c("messages", "notifications", "tasks"),
                         badgeStatus = "primary", icon = NULL, headerText = NULL,
                         .list = NULL) {
        type <- match.arg(type)
        if (!is.null(badgeStatus)) validateStatus(badgeStatus)
        items <- c(list(...), .list)

        # Make sure the items are li tags
        lapply(items, tagAssert, type = "li")

        if (is.null(icon)) {
                icon <- switch(type,
                               messages = shiny::icon("envelope"),
                               notifications = shiny::icon("warning"),
                               tasks = shiny::icon("tasks")
                )
        }

        numItems <- length(items)
        if (is.null(badgeStatus)) {
                badge <- NULL
        } else {
                # html code translated, theme dependent
                badge <- span(class = paste0("badge badge-", badgeStatus), numItems)
        }

        if (is.null(headerText)) {
                headerText <- paste("You have", numItems, type)
        }

        tags$li(class = "nav-item dropdown",
                a(class = "nav-link dropdown-toggle nav-link",
                  `data-toggle` = "dropdown", href = "#", role = "button",
                  `aria-haspopup` = "true", `aria-expanded` = "false",
                  icon, badge),
                div(class = "dropdown-menu dropdown-menu-right",
                    div(class="dropdown-header text-center",
                        strong(headerText)),
                    items
                )
        )
}
