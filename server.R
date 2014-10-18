library(shiny)
library(googleVis)
library(zoo)
library(lubridate)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$repaymentPlot <- renderGvis({
        annualInterest <- input$annualInterest
        annualIncrease <- input$annualIncrease
        startValue <-input$startValue
        startYear <- input$startYear
        startSalary <- input$startSalary
        month <- 1:301
        minSalary <-16910
        monthlyIncrease <- ((annualIncrease/100)+1)^(1/12)
        monthlyInterest <- ((annualInterest/100)+1)^(1/12) -1
        balance <- 0
        monthlyPayments <- 0
        monthlyPayments[month] <- (startSalary*(monthlyIncrease^(month)) - 21000)*0.09/12
        monthlyPayments[monthlyPayments < 0] <- 0
        monthlyPayments[1:8] <- 0
        total <- 0
        
        balance[1] <- startValue
        for(i in 2:length(month))
        {
            balance[i] <- balance[i-1] + monthlyInterest*balance[i-1] - monthlyPayments[i]
            total <- total + max(monthlyInterest*balance[i-1],0)
        }
        balance <- balance[balance > 0]
        monthlyPayments<-monthlyPayments[1:length(balance)]
        df=data.frame(years=round((index(balance)-1)/12,2), Balance=round(balance), Payments=round(monthlyPayments))
        
        output$time <- renderText({length(balance)})
        output$total <- renderText({paste("£",as.character(round(total)),sep="")})
        
        startDate <- as.POSIXct(strptime(paste("01-09-",startYear, sep=""), "%d-%m-%Y"))
        endDate <- startDate
        month(endDate) <- month(endDate) + length(balance)
        output$finalMonth <- renderText({paste(as.character(endDate, format="%B %Y"),".",sep="")})
                                             
        gvisLineChart(df, 
                      xvar="years", 
                      yvar=c("Balance","Payments"), 
                      options=list(
                          width=600,
                          height=250,
                          #title="Outstanding Balance and Monthly Payments",
                          hAxes="[{title:'Time in Employment (Years)'}]",
                          series="[{targetAxisIndex: 0},{targetAxisIndex:1}]",
                          vAxes="[{title:'Balance (£)'}, {title:'Monthly Payments (£)'}]"
                          ))                                        
     })
    
    
    
})