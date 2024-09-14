# Stock Portfolio Analysis Tool

This is a Shiny web application for analyzing stock portfolios. It allows users to input stock tickers, weights, and date ranges to calculate key portfolio metrics and visualize portfolio performance.

## Features

- Input multiple stock tickers and their corresponding weights
- Select date range for analysis
- Calculate annualized return, annualized volatility, and Sharpe ratio
- Visualize portfolio performance over time

## Prerequisites

To run this application, you need to have R installed on your system. You can download R from the [official R website](https://www.r-project.org/).

## Required R Packages

- shiny
- quantmod
- ggplot2
- dplyr

You can install these packages using the following R command:

```r
install.packages(c("shiny", "quantmod", "ggplot2", "dplyr"))
```

## Running the Application

1. Clone this repository or download the `app.R` file.
2. Open R or RStudio.
3. Set your working directory to the location of the `app.R` file.
4. Run the following command:

```r
shiny::runApp("app.R")
```

The application should open in your default web browser.

## Usage

1. Enter the stock tickers separated by commas (e.g., "AAPL,MSFT,GOOGL").
2. Enter the corresponding weights for each stock, also separated by commas (e.g., "0.4,0.3,0.3").
3. Select the start and end dates for your analysis.
4. Click the "Analyze Portfolio" button.
5. View the calculated metrics and performance chart.

## Contributing

Feel free to fork this repository and submit pull requests with any enhancements.

## License

This project is open source and available under the [MIT License](LICENSE).
