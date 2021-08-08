         
# NEISS Datasets for Shiny Case Study ----
         
# products: Lookup table for product codes
         
# population: 2017 US Population by age and sex

# * Load Packages ---------------------------------------------------------

require(shiny)
require(vroom)
require(tidyverse)

# * Load Injury Data ------------------------------------------------------

injuries <- vroom::vroom(
  here::here('chap_4', 'injuries.tsv')
  )        
         
products <-
structure(list(prod_code = c(464L, 474L, 604L, 611L, 649L, 676L, 
679L, 1141L, 1200L, 1205L, 1211L, 1233L, 1242L, 1244L, 1267L, 
1333L, 1615L, 1616L, 1807L, 1817L, 1819L, 1842L, 1871L, 1884L, 
1893L, 1894L, 3265L, 3274L, 3299L, 4014L, 4056L, 4057L, 4074L, 
4076L, 4078L, 5034L, 5040L, 5041L), title = c("knives, not elsewhere classified", 
"tableware and accessories", "desks, chests, bureaus or buffets", 
"bathtubs or showers", "toilets", "rugs or carpets, not specified", 
"sofas, couches, davenports, divans or st", "containers, not specified", 
"sports or recreational activity, n.e.c.", "basketball (activity, apparel or equip.)", 
"football (activity, apparel or equip.)", "trampolines", "slides or sliding boards", 
"monkey bars or other playground climbing", "soccer (activity, apparel or equip.)", 
"skateboards", "footwear", "jewelry", "floors or flooring materials", 
"porches, balconies, open-side floors or", "nails, screws, tacks or bolts", 
"stairs or steps", "fences or fence posts", "ceilings and walls (part of completed st", 
"doors, other or not specified", "windows & window glass, excl storm windo", 
"weight lifting (activity, apparel or equ", "swimming (activity, apparel or equipment", 
"exercise (activity or apparel, w/o equip", "furniture, not specified", 
"cabinets, racks, room dividers and shelv", "tables, not elsewhere classified", 
"chairs, other or not specified", "beds or bedframes, other or not spec", 
"ladders, other or not specified", "softball (activity, apparel or equipment", 
"bicycles and accessories (excl mountain", "baseball (activity, apparel or equipment"
)), row.names = c(NA, -38L), class = c("tbl_df", "tbl", "data.frame"
))
population <-
structure(list(age = c(0L, 0L, 1L, 1L, 2L, 2L, 3L, 3L, 4L, 4L, 
5L, 5L, 6L, 6L, 7L, 7L, 8L, 8L, 9L, 9L, 10L, 10L, 11L, 11L, 12L, 
12L, 13L, 13L, 14L, 14L, 15L, 15L, 16L, 16L, 17L, 17L, 18L, 18L, 
19L, 19L, 20L, 20L, 21L, 21L, 22L, 22L, 23L, 23L, 24L, 24L, 25L, 
25L, 26L, 26L, 27L, 27L, 28L, 28L, 29L, 29L, 30L, 30L, 31L, 31L, 
32L, 32L, 33L, 33L, 34L, 34L, 35L, 35L, 36L, 36L, 37L, 37L, 38L, 
38L, 39L, 39L, 40L, 40L, 41L, 41L, 42L, 42L, 43L, 43L, 44L, 44L, 
45L, 45L, 46L, 46L, 47L, 47L, 48L, 48L, 49L, 49L, 50L, 50L, 51L, 
51L, 52L, 52L, 53L, 53L, 54L, 54L, 55L, 55L, 56L, 56L, 57L, 57L, 
58L, 58L, 59L, 59L, 60L, 60L, 61L, 61L, 62L, 62L, 63L, 63L, 64L, 
64L, 65L, 65L, 66L, 66L, 67L, 67L, 68L, 68L, 69L, 69L, 70L, 70L, 
71L, 71L, 72L, 72L, 73L, 73L, 74L, 74L, 75L, 75L, 76L, 76L, 77L, 
77L, 78L, 78L, 79L, 79L, 80L, 80L, 81L, 81L, 82L, 82L, 83L, 83L, 
84L, 84L), sex = c("female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male", "female", "male", "female", 
"male", "female", "male", "female", "male", "female", "male", 
"female", "male", "female", "male"), population = c(1924145L, 
2015150L, 1943534L, 2031718L, 1965150L, 2056625L, 1956281L, 2050474L, 
1953782L, 2042001L, 1956268L, 2045050L, 1976331L, 2069201L, 1979376L, 
2063003L, 1980666L, 2062172L, 2043456L, 2128715L, 2051237L, 2140682L, 
2034143L, 2123819L, 2029693L, 2116260L, 2035757L, 2119558L, 2022552L, 
2104753L, 2015751L, 2098809L, 2066782L, 2155909L, 2098704L, 2197871L, 
2071758L, 2169468L, 2078174L, 2178434L, 2089336L, 2187409L, 2104329L, 
2213975L, 2150615L, 2270148L, 2196524L, 2318784L, 2228689L, 2358826L, 
2295484L, 2413370L, 2350352L, 2443974L, 2351456L, 2432679L, 2260383L, 
2335023L, 2210555L, 2277184L, 2174279L, 2236352L, 2183649L, 2241759L, 
2204770L, 2248948L, 2142863L, 2168114L, 2177520L, 2193958L, 2179052L, 
2185895L, 2157640L, 2156347L, 2190170L, 2204181L, 2063849L, 2056619L, 
2025301L, 2012943L, 2009156L, 1985267L, 1948683L, 1927055L, 2003193L, 
1987507L, 1947353L, 1916102L, 1981873L, 1937184L, 2066554L, 2025025L, 
2183846L, 2136737L, 2201202L, 2169762L, 2089271L, 2050739L, 2046810L, 
2003912L, 2053593L, 1997485L, 2089015L, 2032379L, 2214239L, 2148966L, 
2261664L, 2175762L, 2262401L, 2165590L, 2258814L, 2154452L, 2290060L, 
2171286L, 2303341L, 2190232L, 2232903L, 2102988L, 2222318L, 2081562L, 
2202546L, 2047375L, 2128409L, 1963253L, 2111180L, 1938979L, 2032205L, 
1843702L, 1956079L, 1763974L, 1878995L, 1688983L, 1825058L, 1626011L, 
1778116L, 1583631L, 1723919L, 1527330L, 1700425L, 1503913L, 1765955L, 
1558707L, 1307666L, 1136177L, 1290521L, 1108765L, 1255382L, 1066091L, 
1280269L, 1077532L, 1115294L, 923942L, 1019726L, 827432L, 959502L, 
769612L, 894185L, 713055L, 853738L, 664775L, 782413L, 596081L, 
741699L, 552132L, 706475L, 510165L, 626409L, 441701L, 599235L, 
408980L)), row.names = c(NA, -170L), class = c("tbl_df", "tbl", 
"data.frame"))
