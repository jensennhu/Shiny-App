shinyUI(dashboardPage(skin="green",
  dashboardHeader(title="Outbreak Data from 1998-2016", titleWidth = 320),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "Introduction", icon = icon("address-card")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem("Plots", tabName = "graphs", icon = icon("database")),
      menuItem("Map", tabName = "map", icon = icon("map"))),
    selectizeInput(inputId = "year",
                   label = "Year",
                   choices = sort(unique(outbreak$year), decreasing=TRUE))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Introduction",
              fluidRow(
                box(
                  h1("Introduction"),
                  "This Shiny App Project was created to visualize the Centers for Disease 
                  Control and Preventions' National Outbreak Dataset. The app contains information
                  related to the number of outbreaks, primary modes of transmission, and geographic areas affected. 
                  The app is a subset of the original dataset, consisting of only confirmed etiology status. 
                  Majority of etiology values have been brought to the genus level for simplicity."),
                box(
                  h1("Surveillance Data Flow"),
                  img(src="https://www.cdc.gov/nors/images/about-nors.jpg", width="100%")))),
      tabItem(tabName = "data",
              fluidRow(
                box(DT::dataTableOutput("datatable"), width="100%"))),
      tabItem(tabName = "graphs",
              fluidRow(
                column(6, plotOutput("eventsPlot2")),
                column(6, plotOutput("eventsPlot1"))),
              fluidRow(
                column(12, dygraphOutput("eventsPlot3")))),
      tabItem(tabName = "map",
              fluidRow(
                box(
                  title = "Number of Outbreaks in the US due to Food", width = 4, solidHeader = TRUE,
                  htmlOutput("map1")),
                box(
                  title = "Number of Outbreaks in the US due to Water", width = 4, solidHeader = TRUE,
                  htmlOutput("map2")),
                box(
                  title = "Number of Outbreaks in the US due to Person-to-person contact", width = 4, solidHeader = TRUE,
                  htmlOutput("map3"))
               ),
              fluidRow(
                box(
                  title = "Number of Outbreaks in the US due to Indeterminate/Other/Unknown", width = 4, solidHeader = TRUE,
                  htmlOutput("map4")),
                box(
                  title = "Number of Outbreaks in the US due to Environmental contamination other than food/water", width = 4, solidHeader = TRUE,
                  htmlOutput("map5")),
                box(
                  title = "Number of Outbreaks in the US due to Animal Contact", width = 4, solidHeader = TRUE,
                  htmlOutput("map6"))
            )))
    )
  )
)