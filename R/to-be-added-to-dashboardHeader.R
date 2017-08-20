#' Create a dropdown menu to place in a dashboard header.
#'
#' @param type Menu type: "messages", "notifications", or "tasks".
#' @param badgeStatus The status of the badge which displays the number of items
#'   in the menu. This determines the badge's color. Valid statuses are listed
#'   in \link{validStatuses}. A value of \code{NULL} means to not display a
#'   badge.
#' @param ... Items to put in the menu. Typically, message menus should contain
#'   \code{\link{messageItem}}s, notification menus should contain
#'   \code{\link{notificationItem}}s, and task menus should contain
#'   \code{\link{taskItem}}s.
#' @param icon An icon to display in the header. By default, the icon is
#'   automatically selected depending on \code{type}, but it can be overriden
#'   with this argument.
#' @param headerText An optional text argument used for the header of the
#'   dropdown menu (this is only visible when the menu is expanded). If none is
#'   provided by the user, the default is "You have \code{x} messages," where
#'   \code{x} is the number of items in the menu (if the \code{type} is
#'   specified to be "notifications" or "tasks," the default text shows "You
#'   have \code{x} notifications" or  "You have \code{x} tasks," respectively).
#' @param .list An optional list containing items to put in the menu Same as the
#'   \code{...} arguments, but in list format. This can be useful when working
#'   with programmatically generated items.
#'
#' @seealso \code{\link{dashboardHeader}} for example usage.
#'
#' @export
dropdownMenu <- function(...,
                         type = c("messages", "notifications", "tasks"),
                         badgeStatus = "primary", icon = NULL, headerText = NULL,
                         .list = NULL)
{
        type <- match.arg(type)
        if (!is.null(badgeStatus)) validateStatus(badgeStatus)
        items <- c(list(...), .list)

        # Make sure the items are li tags
        lapply(items, tagAssert, type = "li")

        dropdownClass <- paste0("dropdown ", type, "-menu")

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
                badge <- span(class = paste0("label label-", badgeStatus), numItems)
        }

        if (is.null(headerText)) {
                headerText <- paste("You have", numItems, type)
        }

        tags$li(class = dropdownClass,
                a(href = "#", class = "dropdown-toggle", `data-toggle` = "dropdown",
                  icon,
                  badge
                ),
                tags$ul(class = "dropdown-menu",
                        tags$li(class = "header", headerText),
                        tags$li(
                                tags$ul(class = "menu",
                                        items
                                )
                        )
                        # TODO: This would need to be added to the outer ul
                        # tags$li(class = "footer", a(href="#", "View all"))
                )
        )

}



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
                        href = NULL)
{
        tagAssert(icon, type = "i")
        if (is.null(href)) href <- "#"

        tags$li(
                a(href = href,
                  icon,
                  h4(
                          from,
                          if (!is.null(time)) tags$small(shiny::icon("clock-o"), time)
                  ),
                  p(message)
                )
        )
}


#' Create a notification item to place in a dropdown notification menu
#'
#' @param text The notification text.
#' @param icon An icon tag, created by \code{\link[shiny]{icon}}.
#' @param status The status of the item This determines the item's background
#'   color. Valid statuses are listed in \link{validStatuses}.
#' @param href An optional URL to link to.
#'
#' @family menu items
#' @seealso \code{\link{dashboardHeader}} for example usage.
#' @export
notificationItem <- function(text, icon = shiny::icon("warning"),
                             status = "success", href = NULL)
{
        tagAssert(icon, type = "i")
        validateStatus(status)
        if (is.null(href)) href <- "#"

        # Add the status as another HTML class to the icon
        icon <- tagAppendAttributes(icon, class = paste0("text-", status))

        tags$li(
                a(href = href, icon, text)
        )
}


#' Create a task item to place in a dropdown task menu
#'
#' @param text The task text.
#' @param value A percent value to use for the bar.
#' @param color A color for the bar. Valid colors are listed in
#'   \link{validColors}.
#' @param href An optional URL to link to.
#'
#' @family menu items
#' @seealso \code{\link{dashboardHeader}} for example usage.
#' @export
taskItem <- function(text, value = 0, color = "aqua", href = NULL) {
        validateColor(color)
        if (is.null(href)) href <- "#"

        tags$li(
                a(href = href,
                  h3(text,
                     tags$small(class = "pull-right", paste0(value, "%"))
                  ),
                  div(class = "progress xs",
                      div(
                              class = paste0("progress-bar progress-bar-", color),
                              style = paste0("width: ", value, "%"),
                              role = "progressbar",
                              `aria-valuenow` = value,
                              `aria-valuemin` = "0",
                              `aria-valuemax` = "100",
                              span(class = "sr-only", paste0(value, "% complete"))
                      )
                  )
                )
        )
}


