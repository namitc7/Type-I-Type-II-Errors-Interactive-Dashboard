# ============================================================
# Type I and Type II Errors Interactive Tool
# R Shiny Version - HTML-like Layout
# ============================================================

# install.packages(c("shiny", "plotly"))
# install.packages("rsconnect")


library(shiny)
library(plotly)

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
      body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
      }

      .main-container {
        background-color: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        max-width: 1200px;
        margin: 20px auto;
      }

      h1 {
        color: #006747;
        text-align: center;
        margin-bottom: 10px;
        font-weight: bold;
        font-size: 34px;
      }

      .subtitle {
        text-align: center;
        color: #666;
        margin-bottom: 25px;
        font-size: 14px;
      }

      .controls {
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 5px;
        margin-bottom: 20px;
      }

      .control-label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
        color: #333;
        font-size: 16px;
      }

      .test-button-row {
        display: flex;
        gap: 10px;
        margin-bottom: 22px;
        width: 100%;
      }

      .test-button {
        flex: 1;
        padding: 10px;
        border: 2px solid #006747;
        background-color: white;
        color: #006747;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        font-size: 14px;
        text-align: center;
      }

      .test-button-active {
        background-color: #006747 !important;
        color: white !important;
      }

      .slider-row {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 24px;
      }

      .slider-container {
        flex: 1;
      }

      .value-box {
        font-family: monospace;
        background-color: white;
        padding: 7px 12px;
        border-radius: 3px;
        border: 1px solid #ddd;
        min-width: 80px;
        text-align: center;
        font-size: 15px;
        color: black;
      }

      /* Make Shiny sliders look more like the HTML sliders */
      .irs {
        height: 35px !important;
      }

      .irs-line {
        height: 8px !important;
        top: 22px !important;
        background: #e6e6e6 !important;
        border: 1px solid #ccc !important;
        border-radius: 5px !important;
      }

      .irs-bar {
        height: 8px !important;
        top: 22px !important;
        background: #007bff !important;
        border-top: 1px solid #007bff !important;
        border-bottom: 1px solid #007bff !important;
      }

      .irs-handle {
        top: 17px !important;
        width: 18px !important;
        height: 18px !important;
        border-radius: 50% !important;
        background: #007bff !important;
        border: 1px solid #007bff !important;
        cursor: pointer !important;
      }

      .irs-handle i {
        display: none !important;
      }

      .irs-single,
      .irs-min,
      .irs-max,
      .irs-grid {
        display: none !important;
      }

      .form-group {
        margin-bottom: 0px !important;
      }

      .stat-card {
        background-color: #f9f9f9;
        padding: 15px;
        border-radius: 5px;
        border: 1px solid #ddd;
        min-height: 115px;
      }

      .stat-card h4 {
        margin: 0 0 10px 0;
        color: #006747;
        font-size: 14px;
        font-weight: bold;
      }

      .stat-value {
        font-size: 24px;
        font-weight: bold;
        color: #333;
      }

      .stat-label {
        font-size: 12px;
        color: #666;
        margin-top: 5px;
      }

      .info-box {
        background-color: #e8f5e9;
        border-left: 4px solid #006747;
        padding: 15px;
        margin-top: 20px;
        border-radius: 3px;
      }

      .info-box h3 {
        margin-top: 0;
        color: #006747;
        font-weight: bold;
      }

      #error_plot {
        margin-top: 20px;
      }
    ")),
    
    tags$script(HTML("
      Shiny.addCustomMessageHandler('update_buttons', function(message) {
        if (message.type === 'one') {
          document.getElementById('one_btn').classList.add('test-button-active');
          document.getElementById('two_btn').classList.remove('test-button-active');
        } else {
          document.getElementById('two_btn').classList.add('test-button-active');
          document.getElementById('one_btn').classList.remove('test-button-active');
        }
      });
    "))
  ),
  
  div(
    class = "main-container",
    
    h1("Type I and Type II Errors Visualization"),
    
    div(
      class = "subtitle",
      "Interactive demonstration of hypothesis testing errors with standard normal distributions (μ=0, σ=1)"
    ),
    
    div(
      class = "controls",
      
      div(class = "control-label", "Test Type:"),
      
      div(
        class = "test-button-row",
        tags$button(
          id = "one_btn",
          class = "test-button test-button-active",
          onclick = "Shiny.setInputValue('test_type_click', 'one', {priority: 'event'});",
          "One-Tailed (Right)"
        ),
        tags$button(
          id = "two_btn",
          class = "test-button",
          onclick = "Shiny.setInputValue('test_type_click', 'two', {priority: 'event'});",
          "Two-Tailed"
        )
      ),
      
      div(class = "control-label", "Significance Level (α):"),
      
      div(
        class = "slider-row",
        div(
          class = "slider-container",
          sliderInput(
            inputId = "alpha",
            label = NULL,
            min = 0.01,
            max = 0.20,
            value = 0.05,
            step = 0.01,
            ticks = FALSE,
            width = "100%"
          )
        ),
        div(class = "value-box", textOutput("alpha_value_box"))
      ),
      
      div(class = "control-label", "Effect Size (μ₁ - μ₀):"),
      
      div(
        class = "slider-row",
        div(
          class = "slider-container",
          sliderInput(
            inputId = "effect",
            label = NULL,
            min = 0,
            max = 10,
            value = 2,
            step = 0.01,
            ticks = FALSE,
            width = "100%"
          )
        ),
        div(class = "value-box", textOutput("effect_value_box"))
      )
    ),
    
    plotlyOutput("error_plot", height = "560px"),
    
    br(),
    
    fluidRow(
      column(
        width = 4,
        div(
          class = "stat-card",
          h4("Type I Error (α)"),
          div(class = "stat-value", textOutput("alpha_display")),
          div(class = "stat-label", "Probability of rejecting H₀ when H₀ is true")
        )
      ),
      
      column(
        width = 4,
        div(
          class = "stat-card",
          h4("Type II Error (β)"),
          div(class = "stat-value", textOutput("beta_display")),
          div(class = "stat-label", "Probability of not rejecting H₀ when H₁ is true")
        )
      ),
      
      column(
        width = 4,
        div(
          class = "stat-card",
          h4("Statistical Power (1 - β)"),
          div(class = "stat-value", textOutput("power_display")),
          div(class = "stat-label", "Probability of correctly rejecting H₀")
        )
      )
    ),
    
    div(
      class = "info-box",
      
      h3("Understanding the Visualization"),
      
      tags$ul(
        tags$li(HTML("<strong style='color: blue;'>Blue Distribution (H₀):</strong> Null hypothesis distribution - assumes no effect (μ₀ = 0, σ = 1)")),
        tags$li(HTML("<strong style='color: red;'>Red Distribution (H₁):</strong> Alternative hypothesis distribution - assumes true effect exists (μ₁ = μ₀ + effect size)")),
        tags$li(HTML("<strong style='color: rgba(0, 0, 255, 0.6);'>Blue Shaded Region:</strong> Type I Error (α) - incorrectly rejecting H₀ when it is true")),
        tags$li(HTML("<strong style='color: rgba(255, 0, 0, 0.6);'>Red Shaded Region:</strong> Type II Error (β) - failing to reject H₀ when H₁ is true")),
        tags$li(HTML("<strong>Vertical Dashed Line(s):</strong> Critical value(s) - the boundary for rejecting H₀"))
      ),
      
      h3("Key Insights"),
      
      tags$ul(
        tags$li("As α increases, β decreases, and vice versa. There is a trade-off between the two types of errors."),
        tags$li("Larger effect sizes decrease β and increase statistical power."),
        tags$li("Two-tailed tests split α between both tails, requiring stronger evidence to reject H₀.")
      )
    )
  )
)

server <- function(input, output, session) {
  
  test_type <- reactiveVal("one")
  
  observeEvent(input$test_type_click, {
    test_type(input$test_type_click)
    session$sendCustomMessage("update_buttons", list(type = input$test_type_click))
  })
  
  calculations <- reactive({
    
    alpha <- input$alpha
    effect <- input$effect
    
    mu0 <- 0
    sd <- 1
    mu1 <- mu0 + effect
    
    x_min <- mu0 - 4 * sd
    x_max <- mu1 + 4 * sd
    
    x <- seq(x_min, x_max, length.out = 500)
    
    h0 <- dnorm(x, mean = mu0, sd = sd)
    h1 <- dnorm(x, mean = mu1, sd = sd)
    
    if (test_type() == "one") {
      
      z_crit <- qnorm(1 - alpha)
      critical_values <- mu0 + z_crit * sd
      
      beta_lower <- -Inf
      beta_upper <- critical_values
      
      beta <- pnorm(beta_upper, mean = mu1, sd = sd) -
        pnorm(beta_lower, mean = mu1, sd = sd)
      
    } else {
      
      z_crit <- qnorm(1 - alpha / 2)
      critical_values <- c(mu0 - z_crit * sd, mu0 + z_crit * sd)
      
      beta_lower <- critical_values[1]
      beta_upper <- critical_values[2]
      
      beta <- pnorm(beta_upper, mean = mu1, sd = sd) -
        pnorm(beta_lower, mean = mu1, sd = sd)
    }
    
    power <- 1 - beta
    
    list(
      alpha = alpha,
      effect = effect,
      mu0 = mu0,
      mu1 = mu1,
      sd = sd,
      x = x,
      h0 = h0,
      h1 = h1,
      critical_values = critical_values,
      beta_lower = beta_lower,
      beta_upper = beta_upper,
      beta = beta,
      power = power
    )
  })
  
  output$alpha_value_box <- renderText({
    sprintf("%.2f", input$alpha)
  })
  
  output$effect_value_box <- renderText({
    sprintf("%.2f", input$effect)
  })
  
  output$alpha_display <- renderText({
    sprintf("%.3f", calculations()$alpha)
  })
  
  output$beta_display <- renderText({
    sprintf("%.3f", calculations()$beta)
  })
  
  output$power_display <- renderText({
    sprintf("%.3f", calculations()$power)
  })
  
  output$error_plot <- renderPlotly({
    
    calc <- calculations()
    
    x <- calc$x
    h0 <- calc$h0
    h1 <- calc$h1
    alpha <- calc$alpha
    beta <- calc$beta
    
    plot_title <- ifelse(
      test_type() == "one",
      "One-Tailed Test (Right-Tailed)",
      "Two-Tailed Test"
    )
    
    p <- plot_ly()
    
    p <- p %>%
      add_trace(
        x = x,
        y = h0,
        type = "scatter",
        mode = "lines",
        name = "H₀ (Null)",
        line = list(color = "blue", width = 3),
        hovertemplate = "x: %{x:.2f}<br>Density: %{y:.4f}<extra></extra>"
      ) %>%
      add_trace(
        x = x,
        y = h1,
        type = "scatter",
        mode = "lines",
        name = "H₁ (Alternative)",
        line = list(color = "red", width = 3),
        hovertemplate = "x: %{x:.2f}<br>Density: %{y:.4f}<extra></extra>"
      )
    
    if (test_type() == "one") {
      
      cv <- calc$critical_values
      
      x_alpha <- x[x >= cv]
      y_alpha <- dnorm(x_alpha, mean = calc$mu0, sd = calc$sd)
      
      p <- p %>%
        add_trace(
          x = x_alpha,
          y = y_alpha,
          type = "scatter",
          mode = "lines",
          fill = "tozeroy",
          fillcolor = "rgba(0, 0, 255, 0.3)",
          line = list(width = 0),
          name = paste0("Type I Error (α = ", sprintf("%.2f", alpha), ")"),
          hovertemplate = "x: %{x:.2f}<br>Density: %{y:.4f}<extra></extra>"
        )
      
    } else {
      
      cv_left <- calc$critical_values[1]
      cv_right <- calc$critical_values[2]
      
      x_alpha_right <- x[x >= cv_right]
      y_alpha_right <- dnorm(x_alpha_right, mean = calc$mu0, sd = calc$sd)
      
      x_alpha_left <- x[x <= cv_left]
      y_alpha_left <- dnorm(x_alpha_left, mean = calc$mu0, sd = calc$sd)
      
      p <- p %>%
        add_trace(
          x = x_alpha_right,
          y = y_alpha_right,
          type = "scatter",
          mode = "lines",
          fill = "tozeroy",
          fillcolor = "rgba(0, 0, 255, 0.3)",
          line = list(width = 0),
          name = paste0("Type I Error (α/2 = ", sprintf("%.3f", alpha / 2), ")"),
          hovertemplate = "x: %{x:.2f}<br>Density: %{y:.4f}<extra></extra>"
        ) %>%
        add_trace(
          x = x_alpha_left,
          y = y_alpha_left,
          type = "scatter",
          mode = "lines",
          fill = "tozeroy",
          fillcolor = "rgba(0, 0, 255, 0.3)",
          line = list(width = 0),
          name = "",
          showlegend = FALSE,
          hovertemplate = "x: %{x:.2f}<br>Density: %{y:.4f}<extra></extra>"
        )
    }
    
    x_beta <- x[x >= calc$beta_lower & x <= calc$beta_upper]
    y_beta <- dnorm(x_beta, mean = calc$mu1, sd = calc$sd)
    
    p <- p %>%
      add_trace(
        x = x_beta,
        y = y_beta,
        type = "scatter",
        mode = "lines",
        fill = "tozeroy",
        fillcolor = "rgba(255, 0, 0, 0.3)",
        line = list(width = 0),
        name = paste0("Type II Error (β = ", sprintf("%.3f", beta), ")"),
        hovertemplate = "x: %{x:.2f}<br>Density: %{y:.4f}<extra></extra>"
      )
    
    max_y <- max(c(h0, h1)) * 1.1
    
    for (i in seq_along(calc$critical_values)) {
      
      cv <- calc$critical_values[i]
      
      p <- p %>%
        add_trace(
          x = c(cv, cv),
          y = c(0, max_y),
          type = "scatter",
          mode = "lines",
          line = list(color = "black", width = 2, dash = "dash"),
          name = ifelse(i == 1, "Critical Value(s)", ""),
          showlegend = ifelse(i == 1, TRUE, FALSE),
          hovertemplate = paste0("Critical Value: ", sprintf("%.2f", cv), "<extra></extra>")
        )
    }
    
    p <- p %>%
      layout(
        title = list(
          text = plot_title,
          font = list(size = 18, color = "#006747"),
          x = 0.5,
          y = 0.98,
          xanchor = "center",
          yanchor = "top"
        ),
        margin = list(t = 110, b = 60, l = 70, r = 30),
        xaxis = list(
          title = "Test Statistic Value",
          gridcolor = "#e0e0e0"
        ),
        yaxis = list(
          title = "Probability Density",
          gridcolor = "#e0e0e0"
        ),
        legend = list(
          x = 0.02,
          y = 0.95,
          bgcolor = "rgba(255,255,255,0.8)",
          bordercolor = "#ccc",
          borderwidth = 1
        ),
        hovermode = "closest",
        plot_bgcolor = "#fafafa",
        paper_bgcolor = "white"
      ) %>%
      config(
        responsive = TRUE,
        displayModeBar = TRUE,
        displaylogo = FALSE,
        modeBarButtonsToRemove = list("pan2d", "lasso2d", "select2d")
      )
    
    p
  })
}

shinyApp(ui = ui, server = server)