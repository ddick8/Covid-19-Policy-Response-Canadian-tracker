library(tidyverse)
library(readxl)
library(readr)
library(pals)

# set working directory
setwd("~/PhD/COVID_France/CovidPolicy-Canada/Data")

# load data
NPI_raw <- read_excel("Canada_PH_measures_IG.xlsx")
NPI_raw$Date <- as.Date(NPI_raw$Date, format = "%m/%d/%Y")

# Extract list of measures and provinces
list_NPI <- unique(NPI_raw$Code_measure) %>% na.omit %>% sort
list_provinces <- unique(NPI_raw$Province) %>% sort

list_date <- seq(as.Date("2020-03-02"),as.Date("2022-01-01"), by = "days")

# Create empty regional NPI dataframe
empty_NPI <- matrix(0,ncol = length(c("Prov","date",list_NPI)),
                    nrow = length(list_date),
                    dimnames = list(NULL,c("Prov","date",list_NPI))) %>% 
  as.data.frame() %>% mutate(date = list_date)

# Fill NPI dataframe from NPI_raw
NPI_all_prov <- empty_NPI[0,]

for(i in 1:length(list_provinces)){
  
  province <- list_provinces[i]
  NPI_prov <- empty_NPI
  NPI_prov$Prov <- province
  
  for(j in 1:length(list_NPI)){
    
    measure <- list_NPI[j]
    
    measureXprov <- filter(NPI_raw, Province == province & Code_measure == measure & !is.na(Value_set_to)) %>% arrange(Date)
    if(nrow(measureXprov) !=0){
      for(k in 1:nrow(measureXprov)){ 
        NPI_prov[NPI_prov$date >= measureXprov$Date[k],measure] <- as.numeric(measureXprov$Value_set_to[k])
      }
    }
  }
  
  NPI_prov[,-(1:2)] <- lapply(NPI_prov[,-(1:2)], as.numeric)
  assign(paste("NPI_",province, sep = ""), NPI_prov)
  
  NPI_all_prov <- rbind(NPI_all_prov,NPI_prov)
}

# quality control with plots for each province
for(i in 1:length(list_provinces)){
  NPI_provX_long <- filter(NPI_all_prov, Prov == list_provinces[i]) %>%
    pivot_longer(cols = 3:15, names_to = "NPI", values_to = "val")
  
  plot <- ggplot(NPI_provX_long, aes(x = date, y = val)) +
    geom_line() +
    facet_wrap(~NPI, scales = "free_y") +
    labs(x = "", y = "", title = paste0("NPIs in ", list_provinces[i]))
  print(plot)
}

# save file
write.csv(NPI_all_prov, paste(Sys.Date(), "NPIs_CA.csv", sep = "_"), row.names = FALSE)


# recode NPIs into 0/1 format 
NPI_all_prov2 <- NPI_all_prov %>%
  mutate(school_closing_4 = case_when(C1_School_closing < 4 ~ 0, 
                                      C1_School_closing == 4 ~ 1),
         workplace_closing_2 = case_when(C2_Workplace_closing < 2 ~ 0, 
                                         C2_Workplace_closing == 2 ~ 1), 
         public_events_5000 = case_when(C3_Cancel_public_events == 0 ~ 0, 
                                        C3_Cancel_public_events > 0 ~ 1),
         public_events_1000 = case_when(C3_Cancel_public_events < 2 ~ 0, 
                                        C3_Cancel_public_events >= 2 ~ 1),
         public_events_all = case_when(C3_Cancel_public_events < 3 ~ 0, 
                                       C3_Cancel_public_events == 3 ~ 1),
         gatherings_100 = case_when(C4_Restrictions_on_gatherings < 1 ~ 0, 
                                    C4_Restrictions_on_gatherings >= 1 ~ 1),
         gatherings_10 = case_when(C4_Restrictions_on_gatherings < 2 ~ 0, 
                                   C4_Restrictions_on_gatherings >= 2 ~ 1),
         gatherings_6 = case_when(C4_Restrictions_on_gatherings < 3 ~ 0, 
                                  C4_Restrictions_on_gatherings == 3 ~ 1),
         bars_restaurants_1 = case_when(Closed_bars_restaurants == 0 ~ 0, 
                                        Closed_bars_restaurants > 0 ~ 1),
         entertainment_1 = case_when(Closed_entertainment_venues == 0 ~ 0, 
                                     Closed_entertainment_venues > 0 ~ 1),
         shops = case_when(Closed_shops == 0 ~ 0, 
                           Closed_shops > 0 ~ 1),
         curfew_8 = case_when(Curfew %in% c(0,3) ~ 0, 
                              Curfew %in% c(1,2) ~ 1),
         masks_1 = case_when(mandatory_mask_wearing_policies == 0 ~ 0,
                             mandatory_mask_wearing_policies > 0 ~ 1), 
         lockdown1 = case_when(Lockdown1 == 0 ~ 0, 
                               Lockdown1 > 0 ~ 1),
         lockdown2_1 = case_when(Lockdown2 != 0 ~ 1, 
                                 Lockdown2 == 0 ~ 0), 
         lockdown3_1 = case_when(Lockdown3 == 0 ~ 0, 
                                 Lockdown3 > 0 ~ 1)) %>%
  select(Prov, date, school_closing_4:lockdown3_1)

# pivot into long format and create NPI/province values for plotting
NPI_long <- NPI_all_prov2 %>%
  pivot_longer(cols = school_closing_4:lockdown3_1, names_to = "NPI", values_to = "val") %>%
  mutate(Prov = factor(Prov, levels = c("BC", "Alberta", "Saskatchewan", "Manitoba", "Ontario",
                                        "Quebec", "NB", "NS", "NL"), 
                       labels = c("British Columbia", "Alberta", "Saskatchewan", "Manitoba", "Ontario",
                                  "Quebec", "New Brunswick", "Nova Scotia", "Newfoundland and Labrator")), 
         NPI = factor(NPI, levels = c("lockdown1", "lockdown2_1", "lockdown3_1", "school_closing_4", "workplace_closing_2", 
                                      "shops", "masks_1", "bars_restaurants_1", "entertainment_1", "curfew_8",
                                      "public_events_5000", "public_events_1000", "public_events_all", 
                                      "gatherings_100", "gatherings_10", "gatherings_6"), 
                      labels = c("lockdown1", "lockdown2", "lockdown3", "school_closing", "workplace_closing", 
                                 "shops", "masks", "bars_restaurants", "entertainment", "curfew",
                                 "public_events_5000", "public_events_1000", "public_events_all", 
                                 "gatherings_100", "gatherings_10", "gatherings_6")), 
         val_NPI = -as.numeric(NPI)*1.2 + val - 1, 
         val_Prov = -as.numeric(Prov)*1.2 + val - 1,)

# plots
ggplot(NPI_long, aes(x = date, y = val_NPI, col = NPI)) + 
  geom_line(size = 1) +
  facet_wrap(~Prov, scales = "free_y") +
  theme_bw() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = "", col ="NPIs") +
  scale_color_manual(values = as.vector(cols25(16)))


ggplot(NPI_long, aes(x = date, y = val_Prov, col = Prov)) + 
  geom_line(size = 1) +
  facet_wrap(~NPI, scales = "free_y") +
  theme_bw() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = "", col = "Province")
