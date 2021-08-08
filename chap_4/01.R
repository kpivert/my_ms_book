# * Chap. 4 Case Study ----------------------------------------------------


# Hadley's Code for Creating NEISS Dataset --------------------------------

# dir.create("neiss")
# 
# download <- function(name) {
#   url <- "https://github.com/hadley/mastering-shiny/raw/master/neiss"
#   download.file(paste0(url, name), paste0("neiss/", name), quiet = TRUE)
# }
# 
# download("injuries.tsv.gz")
# download("population.tsv")
# download("products.tsv")

# * Load Packages ---------------------------------------------------------

require(shiny)
require(vroom)
require(tidyverse)

# * Load Injury Data ------------------------------------------------------

injuries <- vroom::vroom(
  here::here("chap_4", "injuries.tsv")
  )

skimr::skim(injuries)
glimpse(injuries)

injuries

# * Load Product and Population Data --------------------------------------

products <- tibble::tribble(
  ~prod_code,                                     ~title,
  464L,         "knives, not elsewhere classified",
  474L,                "tableware and accessories",
  604L,        "desks, chests, bureaus or buffets",
  611L,                      "bathtubs or showers",
  649L,                                  "toilets",
  676L,           "rugs or carpets, not specified",
  679L, "sofas, couches, davenports, divans or st",
  1141L,                "containers, not specified",
  1200L,  "sports or recreational activity, n.e.c.",
  1205L, "basketball (activity, apparel or equip.)",
  1211L,   "football (activity, apparel or equip.)",
  1233L,                              "trampolines",
  1242L,                 "slides or sliding boards",
  1244L, "monkey bars or other playground climbing",
  1267L,     "soccer (activity, apparel or equip.)",
  1333L,                              "skateboards",
  1615L,                                 "footwear",
  1616L,                                  "jewelry",
  1807L,             "floors or flooring materials",
  1817L,  "porches, balconies, open-side floors or",
  1819L,            "nails, screws, tacks or bolts",
  1842L,                          "stairs or steps",
  1871L,                    "fences or fence posts",
  1884L, "ceilings and walls (part of completed st",
  1893L,            "doors, other or not specified",
  1894L, "windows & window glass, excl storm windo",
  3265L, "weight lifting (activity, apparel or equ",
  3274L, "swimming (activity, apparel or equipment",
  3299L, "exercise (activity or apparel, w/o equip",
  4014L,                 "furniture, not specified",
  4056L, "cabinets, racks, room dividers and shelv",
  4057L,         "tables, not elsewhere classified",
  4074L,           "chairs, other or not specified",
  4076L,     "beds or bedframes, other or not spec",
  4078L,          "ladders, other or not specified",
  5034L, "softball (activity, apparel or equipment",
  5040L,  "bicycles and accessories (excl mountain",
  5041L, "baseball (activity, apparel or equipment"
)

population <- tibble::tribble(
  ~age,     ~sex, ~population,
  0L, "female",    1924145L,
  0L,   "male",    2015150L,
  1L, "female",    1943534L,
  1L,   "male",    2031718L,
  2L, "female",    1965150L,
  2L,   "male",    2056625L,
  3L, "female",    1956281L,
  3L,   "male",    2050474L,
  4L, "female",    1953782L,
  4L,   "male",    2042001L,
  5L, "female",    1956268L,
  5L,   "male",    2045050L,
  6L, "female",    1976331L,
  6L,   "male",    2069201L,
  7L, "female",    1979376L,
  7L,   "male",    2063003L,
  8L, "female",    1980666L,
  8L,   "male",    2062172L,
  9L, "female",    2043456L,
  9L,   "male",    2128715L,
  10L, "female",    2051237L,
  10L,   "male",    2140682L,
  11L, "female",    2034143L,
  11L,   "male",    2123819L,
  12L, "female",    2029693L,
  12L,   "male",    2116260L,
  13L, "female",    2035757L,
  13L,   "male",    2119558L,
  14L, "female",    2022552L,
  14L,   "male",    2104753L,
  15L, "female",    2015751L,
  15L,   "male",    2098809L,
  16L, "female",    2066782L,
  16L,   "male",    2155909L,
  17L, "female",    2098704L,
  17L,   "male",    2197871L,
  18L, "female",    2071758L,
  18L,   "male",    2169468L,
  19L, "female",    2078174L,
  19L,   "male",    2178434L,
  20L, "female",    2089336L,
  20L,   "male",    2187409L,
  21L, "female",    2104329L,
  21L,   "male",    2213975L,
  22L, "female",    2150615L,
  22L,   "male",    2270148L,
  23L, "female",    2196524L,
  23L,   "male",    2318784L,
  24L, "female",    2228689L,
  24L,   "male",    2358826L,
  25L, "female",    2295484L,
  25L,   "male",    2413370L,
  26L, "female",    2350352L,
  26L,   "male",    2443974L,
  27L, "female",    2351456L,
  27L,   "male",    2432679L,
  28L, "female",    2260383L,
  28L,   "male",    2335023L,
  29L, "female",    2210555L,
  29L,   "male",    2277184L,
  30L, "female",    2174279L,
  30L,   "male",    2236352L,
  31L, "female",    2183649L,
  31L,   "male",    2241759L,
  32L, "female",    2204770L,
  32L,   "male",    2248948L,
  33L, "female",    2142863L,
  33L,   "male",    2168114L,
  34L, "female",    2177520L,
  34L,   "male",    2193958L,
  35L, "female",    2179052L,
  35L,   "male",    2185895L,
  36L, "female",    2157640L,
  36L,   "male",    2156347L,
  37L, "female",    2190170L,
  37L,   "male",    2204181L,
  38L, "female",    2063849L,
  38L,   "male",    2056619L,
  39L, "female",    2025301L,
  39L,   "male",    2012943L,
  40L, "female",    2009156L,
  40L,   "male",    1985267L,
  41L, "female",    1948683L,
  41L,   "male",    1927055L,
  42L, "female",    2003193L,
  42L,   "male",    1987507L,
  43L, "female",    1947353L,
  43L,   "male",    1916102L,
  44L, "female",    1981873L,
  44L,   "male",    1937184L,
  45L, "female",    2066554L,
  45L,   "male",    2025025L,
  46L, "female",    2183846L,
  46L,   "male",    2136737L,
  47L, "female",    2201202L,
  47L,   "male",    2169762L,
  48L, "female",    2089271L,
  48L,   "male",    2050739L,
  49L, "female",    2046810L,
  49L,   "male",    2003912L,
  50L, "female",    2053593L,
  50L,   "male",    1997485L,
  51L, "female",    2089015L,
  51L,   "male",    2032379L,
  52L, "female",    2214239L,
  52L,   "male",    2148966L,
  53L, "female",    2261664L,
  53L,   "male",    2175762L,
  54L, "female",    2262401L,
  54L,   "male",    2165590L,
  55L, "female",    2258814L,
  55L,   "male",    2154452L,
  56L, "female",    2290060L,
  56L,   "male",    2171286L,
  57L, "female",    2303341L,
  57L,   "male",    2190232L,
  58L, "female",    2232903L,
  58L,   "male",    2102988L,
  59L, "female",    2222318L,
  59L,   "male",    2081562L,
  60L, "female",    2202546L,
  60L,   "male",    2047375L,
  61L, "female",    2128409L,
  61L,   "male",    1963253L,
  62L, "female",    2111180L,
  62L,   "male",    1938979L,
  63L, "female",    2032205L,
  63L,   "male",    1843702L,
  64L, "female",    1956079L,
  64L,   "male",    1763974L,
  65L, "female",    1878995L,
  65L,   "male",    1688983L,
  66L, "female",    1825058L,
  66L,   "male",    1626011L,
  67L, "female",    1778116L,
  67L,   "male",    1583631L,
  68L, "female",    1723919L,
  68L,   "male",    1527330L,
  69L, "female",    1700425L,
  69L,   "male",    1503913L,
  70L, "female",    1765955L,
  70L,   "male",    1558707L,
  71L, "female",    1307666L,
  71L,   "male",    1136177L,
  72L, "female",    1290521L,
  72L,   "male",    1108765L,
  73L, "female",    1255382L,
  73L,   "male",    1066091L,
  74L, "female",    1280269L,
  74L,   "male",    1077532L,
  75L, "female",    1115294L,
  75L,   "male",     923942L,
  76L, "female",    1019726L,
  76L,   "male",     827432L,
  77L, "female",     959502L,
  77L,   "male",     769612L,
  78L, "female",     894185L,
  78L,   "male",     713055L,
  79L, "female",     853738L,
  79L,   "male",     664775L,
  80L, "female",     782413L,
  80L,   "male",     596081L,
  81L, "female",     741699L,
  81L,   "male",     552132L,
  82L, "female",     706475L,
  82L,   "male",     510165L,
  83L, "female",     626409L,
  83L,   "male",     441701L,
  84L, "female",     599235L,
  84L,   "male",     408980L
)


# * Exploration -----------------------------------------------------------

# selected <- injuries %>% filter(prod_code == 1842)
selected <- injuries %>% filter(prod_code == 649)

dim(selected)

selected %>% 
  count(location, wt = weight, sort = TRUE)

selected %>% 
  count(diag, wt = weight, sort = TRUE)

selected %>% 
  count(body_part, wt = weight, sort = TRUE)

selected %>% 
  group_by(body_part) %>% 
  count(sort = TRUE)

selected %>% 
  count(location, wt = weight, sort = TRUE)

summary <- selected %>% 
  count(age, sex, wt = weight)

summary

summary %>% 
  ggplot(aes(age, n, color = sex)) +
  geom_line() +
  labs(y = "Estimated number of injuries")

summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(pop, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

summary

summary %>% 
  ggplot(
    aes(age, rate, color = sex)
  ) +
  geom_line(na.rm = TRUE) +
  labs(y = "Injuries per 10,000 people")


# ?sample_n -> slice_sample
# ?pull -> returns vector

selected %>% 
  slice_sample(n = 10) %>% 
  pull(narrative)

injuries %>% 
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>% 
  group_by(diag) %>% 
  summarize(n = as.integer(sum(weight)))

count_top <- function(df, var, n = 5) {
  df %>% 
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>% 
    group_by({{ var }}) %>% 
    summarize(n = as.integer(sum(weight)))
}


# * Work through advance/rewind -------------------------------------------

num_nar <- selected %>% nrow()

cntr <- vector("integer", nrow(selected))

adv <- function(cntr) {
  n <- selected %>% nrow()
  cntr[1] <- cntr[1] + 1
  return(
    selected %>% 
      pull(narrative) %>% 
      pluck(cntr[1])
  )
}



adv <- function(selected) {
  n <- nrow(df)
  
}

# want counter to reset to 1 when new code selected
# plucks narrative = counter
# counter increments up by 1 on input$adv
# counter decrements down by 1 on input$rew

observeEvent(input$code, {
  values$dat_index <- input$rew + 1000
})


x <- 1:5

at_end <- function(x, y) {
  if_else(
    (y > length(x)),
    
  )
}



# 6.0 SAVING AND SOURCING FUNCTIONS ----

# 6.1 Create folder and file ----

# fs::dir_create("00_scripts/")

path <- here::here("chap_4", "neiss_data.R")

fs::file_create(path)

# 6.2 Build and add header ----

file_header_text <- str_glue("
         
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
         
")


write_lines(file_header_text, file = path)

# 6.3 Add functions with dump() ----

c("products", "population") %>% 
  dump(file = path,
       append = TRUE)

