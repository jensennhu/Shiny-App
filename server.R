shinyServer(function(input, output){
    test<-reactive({
        outbreak%>%
          filter(year==input$year)%>%
          group_by(State)
               })
    output$eventsPlot1<- renderPlot({
      events_primarymode=outbreak%>%
        group_by(., Primary.Mode, year)%>%
        summarise(., num_events=n())
        ggplot(events_primarymode, aes(x=year, y=num_events)) + geom_col(aes(fill=Primary.Mode)) + ggtitle("Number of Outbreaks by Primary Mode of Transmission by Year (1998-2016)")
                                   })
    output$eventsPlot2<- renderPlot({
      outbreak%>%
        group_by(year)%>%
        summarise(num_outbreaks=n())%>%
        ggplot(aes(x=year, y=num_outbreaks))+geom_line()+geom_point()+geom_vline(xintercept =2009, linetype="dotted", color="blue", size=1.5) +ggtitle("Number of Outbreaks by Year (1998-2016)")
                                   })
    output$eventsPlot3<- renderDygraph({
      outbreak%>%
        group_by(Month)%>%
        summarise(num_outbreaks=n())%>%
        dygraph(main="Number of Outbreaks by Month (1998-2016 Aggregate)") %>%
        dyAxis("x", label="Month", independentTicks = TRUE)%>%
        dySeries("num_outbreaks", label = "Number of Outbreaks") %>%
        dyRangeSelector(height = 50)
                                   })
    output$datatable<-DT::renderDataTable({
      datatable(outbreak, rownames=FALSE)
                                   })
    
    output$map1 <- renderGvis({
      data <- test()%>%
        filter(Primary.Mode=="Food")%>%
        summarise(num_value=n())
      print("=================")
      print(data)
      print("=================")
      data %>% gvisGeoChart("State", "num_value", options=list(region="US", displayMode="Regions", resolution="provinces", width="auto", height="auto"))
      })
    output$map2 <- renderGvis({
      data <- test()%>%
        filter(Primary.Mode=="Water")%>%
        summarise(num_value=n())
      print("=================")
      print(data)
      print("=================")
      if(nrow(data) > 0) {
        data %>% gvisGeoChart("State", "num_value", options=list(region="US", displayMode="Regions", resolution="provinces", width="auto", height="auto"))
      }
      
      })
    output$map3 <- renderGvis({
      data <- test()%>%
        filter(Primary.Mode=="Person-to-person")%>%
        summarise(num_value=n())
      if(nrow(data) > 0){
        data %>% gvisGeoChart("State", "num_value", options=list(region="US", displayMode="Regions", resolution="provinces", width="auto", height="auto"))
      }
        
      })
    output$map4 <- renderGvis({
      data <- test()%>%
        filter(Primary.Mode=="Indeterminate/Other/Unknown")%>%
        summarise(num_value=n())
        if(nrow(data) > 0){
          data %>% gvisGeoChart("State", "num_value", options=list(region="US", displayMode="Regions", resolution="provinces", width="auto", height="auto"))
        }
      })
    output$map5 <- renderGvis({
      data<- test()%>%
        filter(Primary.Mode=="Environmental contamination other than food/water")%>%
        summarise(num_value=n())
        if(nrow(data) > 0){
          data %>% gvisGeoChart("State", "num_value", options=list(region="US", displayMode="Regions", resolution="provinces", width="auto", height="auto"))
        }
      })
    output$map6 <- renderGvis({
      data<-test()%>%
        filter(Primary.Mode=="Animal Contact")%>%
        summarise(num_value=n())
        if(nrow(data) > 0){
          data %>% gvisGeoChart("State", "num_value", options=list(region="US", displayMode="Regions", resolution="provinces", width="auto", height="auto"))
        }
      })
}
)
