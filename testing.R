
library(statscanr)
library(gtrendsR)
library(dplyr)

# cansimId <- '2820087'
# productId <- read_cansim_product_mapping(cansimId = cansimId)

# Labour force characteristics, monthly, seasonally adjusted and trend-cycle, last 5 months
productId <- 14100287
# meta <- get_product_metadata(productId)

# Sask.UnemploymentRate.BothSexes.15YearsAndOver.Estimate.SeasonallyAdjusted
# coord1 <- '9.7.1.1.1.1'
coord2 <- '9.7.1.1.1.1.0.0.0.0'

# vectorId <- get_series_info(productId = productId, coordinateId = coord2)$vectorId
vectorId <- 2064327

t1 <- get_coordinate_data(productId, coord2, 12*30)
t1$date <- as.Date(t1$refPer, '%Y-%m-%d')
gt <- gtrends(c("job"), gprop = "web", geo = 'CA-SK', time = "all")[[1]]

df <- t1[, c('date', 'value')] %>%
  left_join(gt[, c('date', 'hits')], by_x='date', by_y='date') %>%
  filter(!is.na(hits))

train <- df[1:160,]
test <- df[161:181,]

m <- lm(value ~ hits, data=train)
test$fit <- predict(m, test)



plot(df$date, df$hits, type='l')
lines(df$date, df$value, type='l')

# Gross domestic product, expenditure-based, provincial and territorial, annual (x 1,000,000)
# Table: 36-10-0222-01 (formerly CANSIM 384-0038)
productId <- 36100222
# sask gdp at market prices
# coord1 <- '9.1.38'
coord2 <- '9.1.38.0.0.0.0.0.0.0'
meta <- get_product_metadata(productId)
# sapply(1:54, function(x) meta$dimension[[3]]$member[[x]]$memberNameEn)
t2 <- get_coordinate_data(productId, coord2, 30)
plot(as.Date(t2$refPer, '%Y-%m-%d'), t2$value, type='l')

# Final demand
coord2 <- '9.1.39.0.0.0.0.0.0.0'
t3 <- get_coordinate_data(productId, coord2, 30)
plot(as.Date(t3$refPer, '%Y-%m-%d'), t3$value, type='l')
