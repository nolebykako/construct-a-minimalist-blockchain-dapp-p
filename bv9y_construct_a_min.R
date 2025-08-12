# Load required libraries
library(jsonlite)
library(RCurl)

# Blockchain API connection
api_url <- "https://api.blockcypher.com/v1/btc/main"
api_key <- "YOUR_API_KEY"

# Function to parse blockchain data
parse_blockchain_data <- function(block_height) {
  url <- paste0(api_url, "/blocks/", block_height)
  headers <- list(`Accept` = "application/json")
  response <- getURL(url, httpheader = headers, useragent = "R")
  block_data <- fromJSON(response)
  return(block_data)
}

# Function to extract transactions from block data
extract_transactions <- function(block_data) {
  transactions <- block_data$tx
  return(transactions)
}

# Function to extract metadata from transaction data
extract_metadata <- function(transactions) {
  metadata <- lapply(transactions, function(tx) {
    tx_id <- tx$tx_hash
    tx_value <- tx$value
    return(list(tx_id, tx_value))
  })
  return(metadata)
}

# Main function to fetch and parse blockchain data
fetch_and_parse <- function(block_height) {
  block_data <- parse_blockchain_data(block_height)
  transactions <- extract_transactions(block_data)
  metadata <- extract_metadata(transactions)
  return(metadata)
}

# Example usage
block_height <- 700000
metadata <- fetch_and_parse(block_height)
print(metadata)