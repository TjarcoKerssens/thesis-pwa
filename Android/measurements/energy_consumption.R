CONFIDENCE = 0.01

# Average Energy consumption in W over 30 minutes
android_pwa_values =    c(2.319851807, 2.279418082, 2.319226319, 2.288856612, 2.421973946,
                          2.284325951, 2.283200584, 2.269647444, 2.30313582, 2.183581293,
                          2.348840124, 2.255361899, 2.255236434, 2.237443054, 2.268430503,
                          2.240205628, 2.201098032, 2.408728526, 2.25451434, 2.318600351)
android_native_values = c(2.320201262, 2.321784859, 2.320455372, 2.310485045, 2.353657148,
                          2.302882154, 2.304687505, 2.295726552, 2.326671899, 2.319141056,
                          2.283467437, 2.339915803, 2.323282445, 2.396920819, 2.358243825,
                          2.266657014, 2.409018473, 2.395758676, 2.343729241, 2.270154185)

# For p > 0.05 accept H0 that means are equal
ttest = t.test(android_native_values, android_pwa_values);

# For p > 0.05 accept H0 that data is from the same class
wtest = wilcox.test(android_native_values, android_pwa_values);

# for p > 0.05 accept H0 that data is from the same continious distribution
kstest = ks.test(android_native_values, android_pwa_values);

boxplot(android_native_values, android_pwa_values,
        names=c("Native", "PWA"), 
        main="Energy consumption on Android in kilojoule, \nmeasured 20 times over 30 minutes",
        xlab="Application type", ylab="Energy consumption in kJ")


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
