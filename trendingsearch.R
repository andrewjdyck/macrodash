
library(gtrendsR)


gt <- gtrends("construction", gprop = "web", geo = 'CA-SK', time = "all")


library(httr)

req <- GET(
  url = 'https://trends.google.com/trends/api/dailytrends'
)

req <- POST(
  url = 'https://trends.google.com/trends/hottrends/hotItems',
  body =  "{'ajax': 1, 'pn': 'p1', 'htd': '', 'htv': 'l'}"
)

forms = {'ajax': 1, 'pn': pn, 'htd': '', 'htv': 'l'}
req_json = self._get_data(
  url=TrendReq.TRENDING_SEARCHES_URL,
  method=TrendReq.POST_METHOD,
  data=forms,
)['trendsByDateList']