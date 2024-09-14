# Load required libraries
library(quantmod)
library(ggplot2)
library(dplyr)

# Function to fetch stock data
fetch_stock_data <- function(tickers, start_date, end_date) {
  stock_data <- list()
  for (ticker in tickers) {
    stock_data[[ticker]] <- getSymbols(ticker, src = "yahoo", 
                                       from = start_date, 
                                       to = end_date, 
                                       auto.assign = FALSE)
  }
  return(stock_data)
}

# Function to calculate returns
calculate_returns <- function(stock_data) {
  returns <- lapply(stock_data, function(x) {
    dailyReturn(x[,6])  # Using Adjusted closing price
  })
  return(returns)
}

# Function to calculate portfolio metrics
calculate_portfolio_metrics <- function(returns, weights) {
  # Combine returns into a single dataframe
  combined_returns <- do.call(cbind, returns)
  
  # Calculate portfolio return
  portfolio_return <- combined_returns %*% weights
  
  # Calculate annualized return
  ann_return <- mean(portfolio_return) * 252
  
  # Calculate annualized volatility
  ann_vol <- sd(portfolio_return) * sqrt(252)
  
  # Calculate Sharpe Ratio (assuming risk-free rate of 0.02)
  sharpe_ratio <- (ann_return - 0.02) / ann_vol
  
  return(list(
    annualized_return = ann_return,
    annualized_volatility = ann_vol,
    sharpe_ratio = sharpe_ratio
  ))
}

# Function to plot portfolio performance
plot_portfolio_performance <- function(stock_data, weights) {
  # Combine adjusted closing prices
  prices <- do.call(cbind, lapply(stock_data, function(x) Ad(x)))
  
  # Calculate portfolio value over time
  portfolio_value <- rowSums(prices * matrix(weights, nrow = nrow(prices), 
                                             ncol = ncol(prices), byrow = TRUE))
  
  # Create a data frame for plotting
  plot_data <- data.frame(
    Date = index(prices),
    Value = portfolio_value
  )
  
  # Create the plot
  ggplot(plot_data, aes(x = Date, y = Value)) +
    geom_line() +
    theme_minimal() +
    labs(title = "Portfolio Performance Over Time",
         x = "Date",
         y = "Portfolio Value")
}

# Main function
run_portfolio_analysis <- function() {
  # Get user input
  tickers <- strsplit(readline("Enter stock tickers (comma-separated): "), ",")[[1]]
  weights <- as.numeric(strsplit(readline("Enter corresponding weights (comma-separated): "), ",")[[1]])
  start_date <- readline("Enter start date (YYYY-MM-DD): ")
  end_date <- readline("Enter end date (YYYY-MM-DD): ")
  
  # Fetch stock data
  stock_data <- fetch_stock_data(tickers, start_date, end_date)
  
  # Calculate returns
  returns <- calculate_returns(stock_data)
  
  # Calculate portfolio metrics
  metrics <- calculate_portfolio_metrics(returns, weights)
  
  # Print results
  cat("Annualized Return:", metrics$annualized_return, "\n")
  cat("Annualized Volatility:", metrics$annualized_volatility, "\n")
  cat("Sharpe Ratio:", metrics$sharpe_ratio, "\n")
  
  # Plot portfolio performance
  plot <- plot_portfolio_performance(stock_data, weights)
  print(plot)
}

# Run the analysis
run_portfolio_analysis()