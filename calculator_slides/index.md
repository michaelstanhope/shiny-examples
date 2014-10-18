---
title       : My Student Loan Repayment Estimator
subtitle    : Now with horrible slides
author      : Michael Stanhope
job         : Consultant, Rittman Mead
logo        : cat.jpg
framework   : mike       # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## 2. Introduction

UK students typically take out a loan to cover the costs of their studies. This loan is repaid after completion of the degree. The amount of time that it will take for a given graduate to repay their loan will depend on many factors such as:
* The starting balance
* The graduate's starting salary after entering employment
* The rate of interest applied to the loan and
* The average annual increase in the graduate's salary

I have developed an [application](https://michaelstanhope.shinyapps.io/shiny-examples/) that can be used to estimate the amount of time that it will take for a graduate to repay their loan. A user can input values for the above factors and the application will compute estimates for:
* The time that it will take to repay the loan
* The total amount of interest payments over the period

--- .class #id 
## 3. Sample output
![width](assets/img/app.png)


```r
gvisLineChart(df,
              xvar="years", 
              yvar=c("Balance","Payments"), 
              options=list(
                  width=600,
                  height=250,
                  #title="Outstanding Balance and Monthly Payments",
                  hAxes="[{title:'Time in Employment (Years)'}]",
                  series="[{targetAxisIndex: 0},{targetAxisIndex:1}]",
                  vAxes="[{title:'Balance (£)'}, {title:'Monthly Payments (£)'}]"))
```



--- .class #id 
## 4. How it works

```r
sliderInput("startValue", "Initial Loan Amount (£):", 
            min = 3000, max = 50000, value = 25000, step = 100)
# This is an example of a UI widget
```


```r
# The server code receives the values from the UI widgets
output$repaymentPlot <- renderGvis({
        annualInterest <- input$annualInterest # input taken from the UI
        startValue <-input$startValue
```


```r
# The server code then does a bunch of computation (this is just a sample)
for(i in 2:length(month))
    {
        balance[i] <- balance[i-1] + monthlyInterest*balance[i-1] - monthlyPayments[i]
        total <- total + max(monthlyInterest*balance[i-1],0)
    }
```

--- .class #id 
## 5. How it works (continued)


```
## Warning: package 'googleVis' was built under R version 3.1.1
```

```
## 
## Welcome to googleVis version 0.5.6
## 
## Please read the Google API Terms of Use
## before you start using the package:
## https://developers.google.com/terms/
## 
## Note, the plot method of googleVis will by default use
## the standard browser to display its output.
## 
## See the googleVis package vignettes for more details,
## or visit http://github.com/mages/googleVis.
## 
## To suppress this message use:
## suppressPackageStartupMessages(library(googleVis))
```

```
## Error: could not find function "index"
```


```r
# The UI code receives the computed results via the output object and uses them
div(htmlOutput("repaymentPlot")) # A snipet of UI code
```


```r
length(balance) # Gives the total repayment time (months)
```

```
## [1] 239
```


```r
total # Gives the total amount of interest accumulated
```

```
## [1] 5217
```


```r
head(balance, 5) # Gives a running balance
```

```
## [1] 25000 25031 25062 25093 25124
```




