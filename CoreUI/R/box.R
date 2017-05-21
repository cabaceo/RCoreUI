#' Create a box for the main body of a dashboard
#'
#' Boxes can be used to hold content in the main body of a dashboard.
#'
#' @param title Optional title.
#' @param footer Optional footer text.
#' @param status The status of the item This determines the item's background
#'   color. Valid statuses are listed in \link{validStatuses}.
#' @param solidHeader Should the header be shown with a solid color background?
#' @param background If NULL (the default), the background of the box will be
#'   white. Otherwise, a color string. Valid colors are listed in
#'   \link{validColors}.
#' @param width The width of the box, using the Bootstrap grid system. This is
#'   used for row-based layouts. The overall width of a region is 12, so the
#'   default valueBox width of 4 occupies 1/3 of that width. For column-based
#'   layouts, use \code{NULL} for the width; the width is set by the column that
#'   contains the box.
#' @param height The height of a box, in pixels or other CSS unit. By default
#'   the height scales automatically with the content.
#' @param collapsible If TRUE, display a button in the upper right that allows
#'   the user to collapse the box.
#' @param collapsed If TRUE, start collapsed. This must be used with
#'   \code{collapsible=TRUE}.
#' @param ... Contents of the box.
#'
#' @family boxes
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#'
#'
#' @export
box <- function(..., title = NULL, subtitle="docs", footer = NULL,
                solidHeader = FALSE, background = NULL, width = 6,
                height = NULL, collapsible = FALSE, collapsed = FALSE) {
        
        boxClass <- "card"
        if (solidHeader || !is.null(background)) {
                boxClass <- paste(boxClass, "box-solid")
        }
        if (!is.null(status)) {
                validateStatus(status)
                boxClass <- paste0(boxClass, " box-", status)
        }
        if (collapsible && collapsed) {
                boxClass <- paste(boxClass, "collapsed-box")
        }
        if (!is.null(background)) {
                validateColor(background)
                boxClass <- paste0(boxClass, " bg-", background)
        }
        
        style <- NULL
        if (!is.null(height)) {
                style <- paste0("height: ", validateCssUnit(height))
        }
        
        titleTag <- NULL
        if (!is.null(title)) {
                titleTag <- h3(class = "box-title", title)
        }
        
        collapseTag <- NULL
        if (collapsible) {
                buttonStatus <- status %OR% "default"
                
                collapseIcon <- if (collapsed) "plus" else "minus"
                
                collapseTag <- div(class = "box-tools pull-right",
                                   tags$button(class = paste0("btn btn-box-tool"),
                                               `data-widget` = "collapse",
                                               shiny::icon(collapseIcon)
                                   )
                )
        }
        
        
        html(head(),body(div(class = boxClass,style="position: relative;display: flex; flex-direction: column; background-color: #fff; border: 1px solid #cfd8dc;",
            div(class="card-header", style="padding: 0.75rem 1.25rem; margin-bottom: 0; background-color: #eceff1; border-bottom: 1px solid #cfd8dc;",title,
                div(class="card-actions",
                    a(href="http://www.chartjs.org",
                        h4(class="text-muted",subtitle)))),
            div(class="card-block",style="flex: 1 1 auto; padding: 1.25rem;",
                div(class="chart-wrapper",...))
            )
          )
        ）
        
}