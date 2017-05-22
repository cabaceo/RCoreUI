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
#' @export
dashboardHeader <- function(..., title = NULL, titleWidth = NULL, disable = FALSE, .list = NULL) {
  items <- c(list(...), .list)
  lapply(items, tagAssert, type = "li", class = "dropdown")

  titleWidth <- validateCssUnit(titleWidth)

  # Set up custom CSS for custom width.
  custom_css <- NULL
  if (!is.null(titleWidth)) {
    # This CSS is derived from the header-related instances of '230px' (the
    # default sidebar width) from inst/AdminLTE/AdminLTE.css. One change is that
    # instead making changes to the global settings, we've put them in a media
    # query (min-width: 768px), so that it won't override other media queries
    # (like max-width: 767px) that work for narrower screens.
    custom_css <- tags$head(tags$style(HTML(gsub("_WIDTH_", titleWidth, fixed = TRUE, '
      @media (min-width: 768px) {
        .app-header.navbar {
          margin-left: _WIDTH_;
        }
        .app-header.navbar .navbar-brand {
          width: _WIDTH_;
        }
      }
    '))))
  }

  tags$header(class = "app-header navbar",
    custom_css,
    style = if (disable) "display: none;",
    button(class="navbar-toggler mobile-sidebar-toggler d-lg-none","☰"),
    a(href="#",class="navbar-brand"),
    tags$ul(class="nav navbar-nav d-md-down-none",
      tags$li(class="nav-item",
        a(href="#",class="nav-link navbar-toggler sidebar-toggler")),
        tags$li(class="nav-item px-3",
        a(href="#",class="nav-link","Dashboard")),
        tags$li(class="nav-item px-3",
        a(href="#",class="nav-link","Users")),
        tags$li(class="nav-item px-3",
        a(href="#",class="nav-link","Settings"))
      ),
    tags$ul(class="nav navbar-nav ml-auto",
      tags$li(class="nav-item d-md-down-none",
        a(href="#",class="nav-link",
          tags$i(class="icon-bell"),
          span(class="badge badge-pill badge-danger","5"))),
        tags$li(class="nav-item d-md-down-none",
        a(href="#",class="nav-link",tags$i(class="icon-list"))),
        tags$li(class="nav-item d-md-down-none",
        a(href="#",class="nav-link",tags$i(class="con-location-pin"))),
        tags$li(class="nav-item dropdown",
        a(href="#",class="nav-link dropdown-toggle nav-link",data-toggle="dropdown",role="button",aria-haspopup="true",aria-expanded="false",
          tags$img(src="img/avatars/6.jpg",class="img-avatar",alt="admin@bootstrapmaster.com"),
          span(class="d-md-down-none","admin")),
        div(class="dropdown-menu dropdown-menu-right",
          div(class="dropdown-header text-center",
            tags$strong("Account")),
          a(class="dropdown-item",href="#",
            tags$i(class="fa fa-bell-o"),"Updates",
            span(class="badge badge-info","42")),
          a(class="dropdown-item",href="#",
            tags$i(class="fa fa-envelope-o"),"Messages",
            span(class="badge badge-success","42")),
          a(class="dropdown-item",href="#",
            tags$i(class="fa fa-bell-o"),"Tasks",
            span(class="badge badge-danger","42")),
          a(class="dropdown-item",href="#",
            tags$i(class="fa fa-comments"),"Comments",
            span(class="badge badge-warning","42")))),
        tags$li(class="av-item d-md-down-none",
        a(href="#",class="nav-link navbar-toggler aside-menu-toggler","☰"))

        )

      )

}


