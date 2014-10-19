library(shiny)

shinyUI(fluidPage(theme = "css/bootstrap.css",
                  
    titlePanel("UK Student Loan Repayment Estimator by Michael Stanhope"),
    p("This calculator can be used to estimate the repayment period for a UK student loan. It is designed for UK nationals who started university in 2006.",
      "The source code can be found ",a("here",href="http://github.com/michaelstanhope/shiny-examples"),"."),
    h4("How to use this application"),
    p("It's easy - just enter your loan amount, graduation year and assumptions on the left of the page. The text and chart in the results section will change accordingly. See the ",a("documentation",href="https://github.com/michaelstanhope/shiny-examples/blob/master/README.md")," for more information."),
    p("The calculator assumes that the student starts permanent employment in the Sepetember of their graduation year and starts repaying their loan no earlier than the following April. Salary increases and interest payments are applied each month so ",
      strong("do not attempt to derive an accurate final payment date using this tool!", inline=TRUE),
      " In reality, interest is calculated daily and most of us get bigger, less frequent pay rises."),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(width=3,
            sliderInput("startValue",
                        "Initial Loan Amount (£):",
                        min = 3000,
                        max = 50000,
                        value = 25000,
                        step = 100),
            sliderInput("startSalary",
                        "Starting Salary (£):",
                        min = 10000,
                        max = 100000,
                        value = 25000,
                        step = 100),
            sliderInput("annualInterest",
                        "Annual Interest Rate (%):",
                        min = 0,
                        max = 5,
                        value = 1.5,
                        step = 0.5,
                        round = -2),
            sliderInput("annualIncrease",
                        "Annual Salary Increase (%):",
                        min = 0,
                        max = 100,
                        value = 4,
                        step = 1),
            sliderInput("startYear",
                        "Graduation Year:",
                        min = 2009,
                        max = 2011,
                        value = 2010,
                        step = 1,
                        format = "####")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h4("Results"),
            div("Using these assumptions, you can expect to pay off your loan  after approximately ",
                strong(textOutput("time", inline=TRUE)), 
                strong(" monthly paydays,"), 
                " giving you a final repayment date of",
                strong(textOutput("finalMonth", inline=TRUE)),
                " You will pay approximately ",
                strong(textOutput("total", inline=TRUE)),
                " in interest over the period (doh!)."
                ),
            div(htmlOutput("repaymentPlot")),
            h4("How is this calculated?"),
            div("You will start repaying your loan at the beginning of the tax year following your graduation,",
                " assuming your earn at least ",
                strong("£16910", inline=TRUE),
                " per year. Your annual payments will be ",
                strong("9%", inline=TRUE),
                " of anything above this amount. ",
                "If you have not repaid the balance within ",
                strong("25 years", inline=TRUE),
                " of graduating, the loan will be written-off.")
        )       
    )
))
