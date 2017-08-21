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


