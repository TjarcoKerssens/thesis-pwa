CONFIDENCE = 0.01

# Average Power consumption in W over 30 minutes
android_pwa_values =    c(1.33156211, 1.28315847, 1.298490981, 1.299951315, 1.275810032,
                          1.340627514,1.266964028,1.289616013, 1.276585535, 1.26689953)
android_native_values = c(1.334181695, 1.307999773, 1.310260285, 1.317541942, 1.318618294,
                          1.351429703, 1.298724997, 1.262741647, 1.309469143, 1.274373724)

# For p > 0.05 accept H0 that means are equal
ttest = t.test(android_native_values, android_pwa_values);

# For p > 0.05 accept H0 that data is from the same class
wtest = wilcox.test(android_native_values, android_pwa_values);

# for p > 0.05 accept H0 that data is from the same continious distribution
kstest = ks.test(android_native_values, android_pwa_values);

boxplot(android_native_values, android_pwa_values,
        names=c("Native", "PWA"), 
        main="Android energy consumption in Watt, \nmeasured 20 times over 30 minutes",
        xlab="Application type", ylab="Power consumption in Watt")


test.normality <- function(){
  pwa_normality = shapiro.test(android_pwa_values)
  native_normality = shapiro.test(android_native_values)
  
  if(pwa_normality$p.value > CONFIDENCE &&
     native_normality$p.value > CONFIDENCE){
    print(sprintf("Shapiro: The 30 minute datasets are normally distributed, p-value pwa: %f, p-value native: %f", 
                  pwa_normality$p.value, native_normality$p.value))
  }else{
    print(sprintf("Shapiro: The 30 minute datasets are not normally distributed, p-value pwa: %f, p-value native: %f", 
                  pwa_normality$p.value, native_normality$p.value))
  }
}

# Print to the screen whether all data is normally distributed
test.normality()

if (ttest$p.value > CONFIDENCE){
  print(sprintf("t-test: The average energy consumption of PWAs and Native apps does not differ, p-value: %f", ttest$p.value))
}else{
  print(sprintf("t-test: The average energy consumption of PWAs and Native apps does differ, p-value: %f", ttest$p.value))
}

if (wtest$p.value > CONFIDENCE){
  print(sprintf("Wilcox: The average energy consumption of PWAs and Native apps does not differ, p-value: %f", wtest$p.value))
}else{
  print(sprintf("Wilcox: The average energy consumption of PWAs and Native apps does differ, p-value: %f", wtest$p.value))
}

if (kstest$p.value > CONFIDENCE){
  print(sprintf("Kolmogorov: The average energy consumption of PWAs and Native apps does not differ, p-value: %f", kstest$p.value))
}else{
  print(sprintf("Kolmogorov: The average energy consumption of PWAs and Native apps does differ, p-value: %f", kstest$p.value))
}

qqnorm(android_native_values, main="Q-Q Plot Energy Consumption \nNative Android Implementation")
qqline(android_native_values, col='red')

qqnorm(android_pwa_values, main="Q-Q Plot Energy Consumption \nPWA Android Implementation")
qqline(android_pwa_values, col='red')


# Perform aditional tests, since p-values are not conclusive
ttestGreater = t.test(android_native_values, android_pwa_values, alternative = "greater");
ttestLess = t.test(android_native_values, android_pwa_values, alternative = "less");

if (ttestGreater$p.value > CONFIDENCE){
  print(sprintf("ttest greater: the energy consumption of native is smaller, p-value: %f", ttestGreater$p.value))
}else{
  print(sprintf("ttest greater: the energy consumption of native is greater , p-value: %f", ttestGreater$p.value))
}

if (ttestLess$p.value > CONFIDENCE){
  print(sprintf("ttest less: the energy consumption of native is greater, p-value: %f", ttestLess$p.value))
}else{
  print(sprintf("ttest less: the energy consumption of native is smaller , p-value: %f", ttestLess$p.value))
}
