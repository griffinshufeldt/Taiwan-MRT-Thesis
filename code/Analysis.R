library(dplyr)
library(stargazer)
library(ggplot2)
install.packages("rdrobust")
install.packages("rdensity")
install.packages("modelsummary")
library(rdrobust) 
library(rddensity) 
library(haven)
library(modelsummary)

taipei <- read_dta("~/master.dta")

#Creating a new variable, oldest age that is the max of household member ages
taipei <- taipei %>%
  rowwise() %>%
  mutate(oldest_age = max(b4_1, b4_2, b4_3, b4_4, 
                          b4_5, b4_6, b4_7, b4_8, b4_9,
                          b4_10, b4_11, b4_12, b4_13, b4_14,
                          b4_15, b4_16, b4_17, b4_18, b4_19,
                          na.rm = TRUE))

min_age <- 40
max_age <- 80

#Filtering by max and min age
taipei_bounded <- taipei %>%
  filter(oldest_age >= min_age & oldest_age <= max_age) 

#Creating dummy variables for each age
for (age in min_age:max_age) {
  var_name <- paste0("age_", age)
  taipei_bounded <- taipei_bounded %>%
    mutate(!!var_name := as.numeric(oldest_age == age))
}

#Creating averages on outcomes by age
taipei_bounded <- taipei_bounded %>%
  group_by(oldest_age) %>%
  mutate(avg_itm1122 = mean(itm1122, na.rm = TRUE)) %>%
  mutate(avg_itm1110 = mean(itm1110, na.rm = TRUE)) %>%
  mutate(avg_itm1113 = mean(itm1113, na.rm = TRUE)) %>%
  mutate(avg_itm1114 = mean(itm1114, na.rm = TRUE)) %>%
  mutate(avg_itm1121 = mean(itm1121, na.rm = TRUE)) %>% 
  mutate(avg_itm1123 = mean(itm1123, na.rm = TRUE)) %>%
  mutate(avg_itm1111 = mean(itm1111, na.rm = TRUE))

#Strict data set has less years but more specific outcomes
taipei_bounded_strict <- taipei_bounded %>%
  filter(year > 2010)

###Graphs, average outcome by age
figure_transport_expenditure <- ggplot(taipei_bounded, aes(x = oldest_age, y = log(avg_itm1110))) +
  geom_line() +
  geom_point() +
  labs(x = "Oldest household age", y = "Average itm1110", title = "Average transport expenditures by Age")
figure_transport_expenditure

figure_transport_services_expenditure <- ggplot(taipei_bounded, aes(x = oldest_age, y = avg_itm1113)) +
  geom_line() +
  geom_point() +
  labs(x = "Oldest household age", y = "Average itm1113", title = "Average transport service expenditures by Age")
figure_transport_services_expenditure

figure_gas_expenditure <- ggplot(taipei_bounded, aes(x = oldest_age, y = avg_itm1123)) +
  geom_line() +
  geom_point() +
  labs(x = "Oldest household age", y = "Average itm1123", title = "Average gas expenditures by Age")
figure_gas_expenditure

###Graphs End

##Regressions, not controlling for empl

#Transport
transit_reg <- lm(itm1110 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded)
stargazer(transit_reg, type="text")

ggplot(taipei_bounded, aes(x=oldest_age, y=log(itm1110), color = oldest_age >= 65)) + geom_jitter(size = 0.5, alpha = 0.2) +
  geom_smooth(data=filter(taipei_bounded, oldest_age < 65),
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  geom_smooth(data=filter(taipei_bounded, oldest_age >= 65), 
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  ## Bandwidth 10
  geom_smooth(data=filter(taipei_bounded, oldest_age < 65, oldest_age >= 55),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded, oldest_age >= 65, oldest_age <= 75),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  ## Bandwidth 5 
  geom_smooth(data=filter(taipei_bounded, oldest_age < 65, oldest_age >= 60),
              method = 'lm', se = FALSE, color='purple',linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded, oldest_age >= 65, oldest_age <= 70),
              method = 'lm', se = FALSE, color = 'purple',linetype = 'solid', size = 1) 

transit_reg <- lm(itm1110 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded)
stargazer(transit_reg, type="text")

#Transport Services
ggplot(taipei_bounded_strict, aes(x=oldest_age, y=log(itm1113), color = oldest_age >= 65)) + geom_jitter(size = 0.5, alpha = 0.2) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65),
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65), 
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  ## Bandwidth 10
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 55),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 75),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  ## Bandwidth 5 
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 60),
              method = 'lm', se = FALSE, color='purple',linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 70),
              method = 'lm', se = FALSE, color = 'purple',linetype = 'solid', size = 1)  

transit_reg <- lm(itm1113 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded)
stargazer(transit_reg, type="text")

#Total of this year's purchase fees of transportation means
ggplot(taipei_bounded_strict, aes(x=oldest_age, y=log(itm1121), color = oldest_age >= 65)) + geom_jitter(size = 0.5, alpha = 0.2) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65),
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65), 
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  ## Bandwidth 10
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 55),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 75),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  ## Bandwidth 5 
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 60),
              method = 'lm', se = FALSE, color='purple',linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 70),
              method = 'lm', se = FALSE, color = 'purple',linetype = 'solid', size = 1) 

transit_reg <- lm(itm1121 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded)
stargazer(transit_reg, type="text")

#Total repair and maintenance fees of transportation means
ggplot(taipei_bounded_strict, aes(x=oldest_age, y=log(itm1122), color = oldest_age >= 65)) + geom_jitter(size = 0.5, alpha = 0.2) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65),
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65), 
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  ## Bandwidth 10
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 55),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 75),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  ## Bandwidth 5 
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 60),
              method = 'lm', se = FALSE, color='purple',linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 70),
              method = 'lm', se = FALSE, color = 'purple',linetype = 'solid', size = 1) 

transit_reg <- lm(itm1122 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded)
stargazer(transit_reg, type="text")

#Total of gas fees and parking fees of cars and scooters
ggplot(taipei_bounded_strict, aes(x=oldest_age, y=log(itm1123), color = oldest_age >= 65)) + geom_jitter(size = 0.5, alpha = 0.2) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65),
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65), 
              method = 'lm', se = FALSE, linetype = 'dotted', size = 1, color = 'black') +
  ## Bandwidth 10
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 55),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 75),
              method = 'lm', se = FALSE, linetype = 'solid', size = 1) +
  ## Bandwidth 5 
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age < 65, oldest_age >= 60),
              method = 'lm', se = FALSE, color='purple',linetype = 'solid', size = 1) +
  geom_smooth(data=filter(taipei_bounded_strict, oldest_age >= 65, oldest_age <= 70),
              method = 'lm', se = FALSE, color = 'purple',linetype = 'solid', size = 1) 

transit_reg <- lm(itm1123 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded_strict)
stargazer(transit_reg, type="text")

rdrobust(y = taipei_bounded$itm1110, x = taipei_bounded$oldest_age, c = 65) %>%
  summary()

### Controlling for employment 

#Getting index of oldest member
taipei_bounded <- taipei_bounded %>%
  rowwise()%>%
  mutate(oldest_member_index = which.max(c_across(starts_with("b4_"))))

taipei_bounded <- taipei_bounded %>%
  rowwise() %>%
  mutate(is_oldest_employed = {
    # Construct the variable name for the oldest member's employment status
    b8_var_name <- paste0("b8_", oldest_member_index)
    # Check if the oldest member is employed based on the dynamically constructed variable name
    # Assuming non-zero values indicate employment status
    ifelse(cur_data()[[b8_var_name]] != 0, 1, 0)
  })

