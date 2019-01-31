
library(statscanr)

# cansimId <- '2820087'
# productId <- read_cansim_product_mapping(cansimId = cansimId)

# Labour force characteristics, monthly, seasonally adjusted and trend-cycle, last 5 months
productId <- 14100287
# meta <- get_product_metadata(productId)

# Sask.UnemploymentRate.BothSexes.15YearsAndOver.Estimate.SeasonallyAdjusted
# coord1 <- '9.7.1.1.1.1'
coord2 <- '9.7.1.1.1.1.0.0.0.0'

t1 <- get_coordinate_data(productId, coord2, 12*30)

plot(as.Date(t1$refPer, '%Y-%m-%d'), t1$value, type='l')

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
