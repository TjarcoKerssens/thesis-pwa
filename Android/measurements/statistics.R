CONFIDENCE = 0.01

# Average Power consumption in W over 30 minutes
android_pwa_values =    c(1.288841645, 1.266350414, 1.28849271, 1.271608907, 1.345585186,
                          1.269091124, 1.268481414, 1.260936963,1.279534828, 1.21310274,
                          1.304914805, 1.253012247, 1.252946022,1.243076405, 1.260249671,
                          1.244565597, 1.222892705, 1.338224892,1.252564332, 1.288180725)
android_native_values = c(1.289021469, 1.289927775, 1.28914259, 1.283675544, 1.307657773,
                          1.279396033, 1.280403287, 1.278392237,1.292660133, 1.288462521,
                          1.268618393, 1.299971279, 1.290751192,1.332345104, 1.31086153,
                          1.259260893, 1.338396388, 1.330978521,1.302116651, 1.261261935)

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
  print("t-test: The average energy consumption of PWAs and Native apps does not differ, p-value: %f", ttest$p.value)
}else{
  print(sprintf("t-test: The average energy consumption of PWAs and Native apps does differ, p-value: %f", ttest$p.value))
}

if (wtest$p.value > CONFIDENCE){
  print("Wilcox: The average energy consumption of PWAs and Native apps does not differ")
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
