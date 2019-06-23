
library(statscanr)
library(dplyr)
library(tidyr)

# cansimId <- '2820087'
# productId <- read_cansim_product_mapping(cansimId = cansimId)

# Labour force characteristics, monthly, seasonally adjusted and trend-cycle, last 5 months
productId <- 14100287
# meta <- get_product_metadata(productId)

# Sask.UnemploymentRate.BothSexes.15YearsAndOver.Estimate.SeasonallyAdjusted
# coord1 <- '9.7.1.1.1.1'
coord2 <- '9.7.1.1.1.1.0.0.0.0'

# vectorId <- get_series_info(productId = productId, coordinateId = coord2)$vectorId
# vectorId <- 2064327

unemp <- get_coordinate_data(productId, coord2, 12*30)
# unemp$date <- as.Date(t1$refPer, '%Y-%m-%d')


# Gross domestic product, expenditure-based, provincial and territorial, annual (x 1,000,000)
# Table: 36-10-0222-01 (formerly CANSIM 384-0038)
productId <- 36100222
# sask gdp at market prices
# coord1 <- '9.1.38'
coord2 <- '9.1.38.0.0.0.0.0.0.0'
# meta <- get_product_metadata(productId)
# sapply(1:54, function(x) meta$dimension[[3]]$member[[x]]$memberNameEn)
gdp <- get_coordinate_data(productId, coord2, 30)
plot(as.Date(gdp$refPer, '%Y-%m-%d'), gdp$value, type='l')

# Creating a table for presenting the stats
df <- gdp[, c('refPer', 'value')] %>%
  rename(gdp = value) %>%
  left_join(unemp[, c('refPer', 'value')]) %>%
  rename(unemp = value, date = refPer) %>%
  mutate(date = as.Date(date, '%Y-%m-%d')) %>%
  arrange(desc(date)) %>%
  select(-date) %>%
  slice(1) %>%
  gather(variable, value)
  
  