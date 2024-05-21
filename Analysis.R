library(dplyr)
library(stargazer)
library(ggplot2)
#install.packages("rdrobust")
#install.packages("rdensity")
#install.packages("modelsummary")
#install.packages("sandwich")
#install.packages("lmtest")
library(rdrobust) 
library(rddensity) 
library(sandwich)
library(lmtest) 
library(haven)
install.packages("texreg")
library(texreg)
#library(modelsummary)

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
  filter(oldest_age >= min_age & oldest_age <= max_age)  %>%
  mutate(treated = ifelse(oldest_age >= 65, 1, 0))


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

taipei_bounded <- taipei_bounded %>%
  mutate(itm1110_per_person = itm1110 / household_size)

  
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

##Regressions by age

transit_reg <- lm(itm1110 ~ age_40 + age_41 + age_43 + age_44 + age_45 + age_46 + age_47 + age_48 + age_49 + age_50 + age_51 + age_52 + age_53 + age_54 + age_55 + age_56 + age_57 + age_58 + age_59 + age_60 + age_61 + age_62 + age_63 + age_64 + age_65 + age_66 + age_67 + age_68 + age_69 + age_70 + age_71 + age_72 + age_73 + age_74 + age_75 + age_76 + age_77 + age_78 + age_79 + age_80, data=taipei_bounded)
stargazer(transit_reg, type="text")

### Controlling for employment 

#Getting index of oldest member
taipei_bounded <- taipei_bounded %>%
  rowwise()%>%
  mutate(oldest_member_index = which.max(c_across(starts_with("b4_"))))

taipei_bounded <- taipei_bounded %>%
  mutate(is_oldest_employed = {
    b13_var_name <- paste0("b13_", oldest_member_index)
    b13_values <- get(b13_var_name)
    ifelse(b13_values == 1, 1, 0)
  })

### Inference
taipei_bounded$area <- factor(taipei_bounded$b15_1)
taipei_bounded$year <- factor(taipei_bounded$year)
taipei_bounded$b5_1 <- factor(taipei_bounded$b5_1)
taipei_bounded$logitm1110 <- log(taipei_bounded$itm1110)

taipei_bounded_employed <- taipei_bounded %>%
  filter(is_oldest_employed == 1)
taipei_bounded_unemployed <- taipei_bounded %>%
  filter(is_oldest_employed == 0)

##employed population

#Univariate regression, just treated dummy
transit_inf_uni_reg <- lm(itm1110 ~ treated, data=taipei_bounded_employed)
stargazer(transit_inf_uni_reg, type="text")

min_age_band10 <- 55
max_age_band10 <- 75

#Filtering by max and min age
taipei_bounded10 <- taipei_bounded_employed %>%
  filter(oldest_age >= min_age_band10 & oldest_age <= max_age_band10)

min_age_band5 <- 60
max_age_band5 <- 70

taipei_bounded5 <- taipei_bounded_employed %>%
  filter(oldest_age >= min_age_band5 & oldest_age <= max_age_band5)

min_age_band2 <- 63
max_age_band2 <- 67

taipei_bounded2 <- taipei_bounded_employed %>%
  filter(oldest_age >= min_age_band2 & oldest_age <= max_age_band2)

min_age_band1 <- 64
max_age_band1 <- 66

taipei_bounded1 <- taipei_bounded_employed %>%
  filter(oldest_age >= min_age_band1 & oldest_age <= max_age_band1)

transit_inf_control_employed_reg <- lm(log(itm1110) ~ treated + log(itm190) + area + household_size + b5_1 + a19 + year + f34 + f23, data=taipei_bounded2)
stargazer(transit_inf_control_employed_reg, type="text")

employed_cluster_se <- vcovCL(transit_inf_control_reg, cluster = ~ x1)

employed_cluster_test <- coeftest(transit_inf_control_reg, vcov. = employed_cluster_se)

# Print the summary table using stargazer
stargazer(employed_cluster_test, type = "text")


##unemployed population

taipei_bounded10_unemployed <- taipei_bounded_unemployed %>%
  filter(oldest_age >= min_age_band10 & oldest_age <= max_age_band10)

taipei_bounded5_unemployed <- taipei_bounded_unemployed %>%
  filter(oldest_age >= min_age_band5 & oldest_age <= max_age_band5)

taipei_bounded2_unemployed <- taipei_bounded_unemployed %>%
  filter(oldest_age >= min_age_band2 & oldest_age <= max_age_band2)

taipei_bounded1_unemployed <- taipei_bounded_unemployed %>%
  filter(oldest_age >= min_age_band1 & oldest_age <= max_age_band1)

transit_inf_control_unemployed_reg <- lm(log(itm1110) ~ treated + log(itm190) + area + household_size + b5_1 + a19 + year + f34 + f23, data=taipei_bounded2_unemployed)
stargazer(transit_inf_control_unemployed_reg, type="text")

unemployed_cluster_se <- vcovCL(transit_inf_control_unemployed_reg, cluster = ~ x1)

unemployed_cluster_test <- coeftest(transit_inf_control_unemployed_reg, vcov. = employed_cluster_se)
stargazer(unemployed_cluster_test, type = "text")

# Print the summary table using stargazer
stargazer(unemployed_cluster_test, type = "text")

ggplot(aes(x=oldest_age, y= treated), data=taipei_bounded) + geom_line() + 
  ggtitle(" ") +  labs(x = "Oldest Household Member", y = "Probability of Treatment") + 
  theme_classic()

###RD Graphs

#General population

ggplot(taipei_bounded, aes(x = oldest_age, y = log(itm1110_per_person), color = oldest_age >= 65)) + 
  geom_jitter(size = 0.5, alpha = 0.1) +
  geom_smooth(data = filter(taipei_bounded, oldest_age < 65), method = 'lm', 
              se = FALSE, linetype = 'dotted', size = 1, color = 'navy', fill = "navy") +
  geom_smooth(data = filter(taipei_bounded, oldest_age >= 65), method = 'lm', 
              se = FALSE, linetype = 'dotted', size = 1, color = 'navy', fill = "navy") +
  ## Bandwidth 10
  geom_smooth(data = filter(taipei_bounded, oldest_age < 65, oldest_age >= 55), 
              method = 'lm', se = FALSE, color = 'lightblue', linetype = 'solid', size = 1, fill = "lightblue") +
  geom_smooth(data = filter(taipei_bounded, oldest_age >= 65, oldest_age <= 75), 
              method = 'lm', se = FALSE, color = 'lightblue', linetype = 'solid', size = 1, fill = "lightblue") +
  ## Bandwidth 5
  geom_smooth(data = filter(taipei_bounded, oldest_age < 65, oldest_age >= 60), 
              method = 'lm', se = FALSE, color = 'red', linetype = 'solid', size = 1, fill = "purple") +
  geom_smooth(data = filter(taipei_bounded, oldest_age >= 65, oldest_age <= 70), 
              method = 'lm', se = FALSE, color = 'red', linetype = 'solid', size = 1, fill = "purple") +
  ## Bandwidth 2
  geom_smooth(data = filter(taipei_bounded, oldest_age < 65, oldest_age >= 63), 
              method = 'lm', se = FALSE, color = 'black', linetype = 'solid', size = 1, fill = "black") +
  geom_smooth(data = filter(taipei_bounded, oldest_age >= 65, oldest_age <= 67), 
              method = 'lm', se = FALSE, color = 'black', linetype = 'solid', size = 1, fill = "black") +
  labs(x = "Age Of Oldest Member", y = "Log Spending on Transport Per Person") +
  scale_color_manual(name = "Bandwidth Years: 20, 10, 5, 2",
                     values = c("lightblue", "purple", "black", "navy"),
                     labels = c(" ", "Treatment: Age >= 65")) +
  theme_minimal() + theme(legend.position = "top")

#Employed

ggplot(taipei_bounded_employed, aes(x = oldest_age, y = log(itm1110_per_person), color = oldest_age >= 65)) + 
  geom_jitter(size = 0.5, alpha = 0.1) +
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age < 65), method = 'lm', 
              se = FALSE, linetype = 'dotted', size = 1, color = 'navy', fill = "navy") +
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age >= 65), method = 'lm', 
              se = FALSE, linetype = 'dotted', size = 1, color = 'navy', fill = "navy") +
  ## Bandwidth 10
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age < 65, oldest_age >= 55), 
              method = 'lm', se = FALSE, color = 'lightblue', linetype = 'solid', size = 1, fill = "lightblue") +
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age >= 65, oldest_age <= 75), 
              method = 'lm', se = FALSE, color = 'lightblue', linetype = 'solid', size = 1, fill = "lightblue") +
  ## Bandwidth 5
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age < 65, oldest_age >= 60), 
              method = 'lm', se = FALSE, color = 'red', linetype = 'solid', size = 1, fill = "purple") +
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age >= 65, oldest_age <= 70), 
              method = 'lm', se = FALSE, color = 'red', linetype = 'solid', size = 1, fill = "purple") +
  ## Bandwidth 2
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age < 65, oldest_age >= 63), 
              method = 'lm', se = FALSE, color = 'black', linetype = 'solid', size = 1, fill = "black") +
  geom_smooth(data = filter(taipei_bounded_employed, oldest_age >= 65, oldest_age <= 67), 
              method = 'lm', se = FALSE, color = 'black', linetype = 'solid', size = 1, fill = "black") +
  labs(x = "Age Of Oldest Member", y = "Log Spending on Transport Per Person") +
  scale_color_manual(name = "Bandwidth Years: 20, 10, 5, 2",
                     values = c("lightblue", "purple", "black", "navy"),
                     labels = c(" ", "Treatment: Age >= 65")) +
  theme_minimal() + theme(legend.position = "top")


##Unemployed

ggplot(taipei_bounded_unemployed, aes(x = oldest_age, y = log(itm1110_per_person), color = oldest_age >= 65)) + 
  geom_jitter(size = 0.5, alpha = 0.1) +
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age < 65), method = 'lm', 
              se = FALSE, linetype = 'dotted', size = 1, color = 'navy', fill = "navy") +
  geom_smooth(data = filter(taipei_bounded, oldest_age >= 65), method = 'lm', 
              se = FALSE, linetype = 'dotted', size = 1, color = 'navy', fill = "navy") +
  ## Bandwidth 10
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age < 65, oldest_age >= 55), 
              method = 'lm', se = FALSE, color = 'lightblue', linetype = 'solid', size = 1, fill = "lightblue") +
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age >= 65, oldest_age <= 75), 
              method = 'lm', se = FALSE, color = 'lightblue', linetype = 'solid', size = 1, fill = "lightblue") +
  ## Bandwidth 5
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age < 65, oldest_age >= 60), 
              method = 'lm', se = FALSE, color = 'red', linetype = 'solid', size = 1, fill = "purple") +
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age >= 65, oldest_age <= 70), 
              method = 'lm', se = FALSE, color = 'red', linetype = 'solid', size = 1, fill = "purple") +
  ## Bandwidth 2
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age < 65, oldest_age >= 63), 
              method = 'lm', se = FALSE, color = 'black', linetype = 'solid', size = 1, fill = "black") +
  geom_smooth(data = filter(taipei_bounded_unemployed, oldest_age >= 65, oldest_age <= 67), 
              method = 'lm', se = FALSE, color = 'black', linetype = 'solid', size = 1, fill = "black") +
  labs(x = "Age Of Oldest Member", y = "Log Spending on Transport Per Person") +
  scale_color_manual(name = "Bandwidth Years: 20, 10, 5, 2",
                     values = c("lightblue", "purple", "black", "navy"),
                     labels = c(" ", "Treatment: Age >= 65")) +
  theme_minimal() + theme(legend.position = "top")

##rdrobust robustness checks

taipei_bounded$logitm1110 <- log(taipei_bounded$itm1110)
taipei_bounded$logitm1110_per_person <- log(taipei_bounded$itm1110_per_person)
taipei_bounded_employed$logitm1110 <- log(taipei_bounded_employed$itm1110)
taipei_bounded_unemployed$logitm1110 <- log(taipei_bounded_unemployed$itm1110)
taipei_bounded_employed$logitm1110_per_person <- log(taipei_bounded_employed$itm1110_per_person)
taipei_bounded_unemployed$logitm1110_per_person <- log(taipei_bounded_unemployed$itm1110_per_person)

#employed
employed_robust <- rdrobust(y = taipei_bounded_employed$logitm1110_per_person, x = taipei_bounded_employed$oldest_age, c = 65)


rdrobust(y = taipei_bounded_unemployed$logitm1110_per_person, x = taipei_bounded_unemployed$oldest_age, c = 65) %>%
  summary()

#general pop
rdrobust(y = taipei_bounded$logitm1110_per_person, x = taipei_bounded$oldest_age, c = 65) %>%
  summary()

