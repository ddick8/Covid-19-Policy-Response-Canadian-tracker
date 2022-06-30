# CovidPolicy-Canada
A timeline of Covid-19 mitigation policy in Canada

CovidPolicy-Canada gathers information on public health measures for each province and territory in Canada. This information can assist in understanding government responses in every province across Canada. Public policies implemented by governments were recorded on a scale from 0 to 3 to reflect the degrees of restrictions in 3 different environments: school, workplace and other which are denoted as C1, C2, and C3 respectively. For full descriptions of the restrictions and their corresponding values refer to our [Data Dictionary](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Data%20Dictionary.md). 

The population in each province/territory is divided by 16 age groups. [Populations.csv file](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Data/Populations.csv) records the population of each age group as well as the total population in each province/territory and CA.

Information on public health measures in each province/territory was gathered using government and news websites. [Mitigation Implementations Timelines](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Mitigation%20implementations%20timelines.xlsx) reports timelines of restrictions for every province. This document can be used to validate the coding. Using the timelines and data dictionary, master CSV file was created. [Provincial CSV file](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Provincial.csv) reports the degree of restrictions the government implemented on each province/territory on a daily basis beginning on January 1, 2020 until the end of March 2022. Note that Provincial.CSV file provides an estimate for the degree of restrictions in Canada and Atlantic Bubble. 

Since April 2022, [Provincial_Data.CSV file](https://github.com/ddick8/CovidPolicy-Canada/blob/Shirin-Amiraslani-introduction/Provincial_Data.csv) was created which records the degree of restrictions for each province/territory and calculates the degree of restrictions in Canada and Atlantic Bubble based on [Weighted_Average](https://github.com/ddick8/CovidPolicy-Canada/blob/Shirin-Amiraslani-introduction/Weighted_Average.m). For convenience, provinces/territories in [Provincial_Data.CSV](https://github.com/ddick8/CovidPolicy-Canada/blob/Shirin-Amiraslani-introduction/Provincial_Data.csv) were rearranged to match the order used in [Populations.csv](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Data/Populations.csv).

Please be aware that in [Provincial CSV file](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Provincial.csv) and [Provincial_Data.CSV](https://github.com/ddick8/CovidPolicy-Canada/blob/Shirin-Amiraslani-introduction/Provincial_Data.csv),  school (C1), workplace(C2) and other(C3), are arranged as C1, C3, C2. 

In addition, the degree of restrictions and the news were updated every 2-3 weeks. 

Format for Data Dictionary and CSV file on this page was adapted from Oxford COVID-19 Government Response Tracker, Blavatnik School of Government, University of Oxford. CSV file has dates in the following format: YYYY - MM - DD. 

Additionally, our dataset was compared to dataset from Oxford COVID-19 Government Response Tracker. Side by side comparison can be found under [Dataset Comparison](https://github.com/ddick8/CovidPolicy-Canada/blob/main/Dataset%20comparison.xls)

