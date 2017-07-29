#!/usr/bin/env Rscript

# Re-load the current package
devtools::load_all(".")

shiny::shinyApp(
    ui = dashboardPage(
        dashboardHeader(),
        dashboardSidebar(),
        dashboardBody(),
        title = "Dashboard example"),
        server = function(input, output) { }
)
