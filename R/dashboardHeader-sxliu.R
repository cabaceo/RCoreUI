dashboardHeader = function(..., title = NULL, titleWidth = NULL,
                           disable = FALSE, .list = NULL) {
        items = c(list(...), .list)

        # set up custom CSS for custom width.
        tags$html(tags$head(tags$link(href="inst/CoreUI/css/style.css",
                                      rel="stylesheet", type="text/css")),
    tags$body(class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden",
      tags$header(class = "app-header navbar",
    style = if (disable) "display: none;",
    tags$button(class="navbar-toggler mobile-sidebar-toggler d-lg-none","☰"),
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
        a(href="#",class="nav-link dropdown-toggle nav-link",role="button",
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

      )))


}
