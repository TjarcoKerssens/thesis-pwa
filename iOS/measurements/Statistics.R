CONFIDENCE = 0.05;

# values are given by a score between 0 and 20 and measured for 30 minutes
ios_native_values = c(5,4,5,5,3,3,4,4,4,3,
                      4,4,4,3,3,4,3,5,4,5);
ios_pwa_values =    c(5,3,3,2,6,2,5,4,2,2,
                      2,2,2,4,2,2,2,5,2,3);

# For p > 0.05 accept H0 that means are equal
ttest = t.test(ios_native_values, ios_pwa_values);
wtest = wilcox.test(ios_native_values, ios_pwa_values, exact = FALSE);

normality_native = shapiro.test(ios_native_values);
normality_pwa = shapiro.test(ios_pwa_values);

boxplot(ios_native_values, ios_pwa_values,
        names=c("Native", "PWA"), 
        main="Average energy consumption on iOS, \nmeasured 20 times over 30 minutes",
        xlab="Application type", ylab="Energy consumption score", ylim=c(0,8))

if(normality_native$p.value > CONFIDENCE && normality_pwa$p.value > CONFIDENCE){
  print("The data is normally distributed")
}else{
  print(sprintf("The data is not normally distributed: native p=%f, pwa p=%f", normality_native$p.value, normality_pwa$p.value))
}

if(ttest$p.value > CONFIDENCE){
  print("t-test: Energy consumption for PWA and Native is similar")
}else{
  print(sprintf("t-test: Energy consumption for PWA and Native differs, p=%f", ttest$p.value))
}

if(wtest$p.value > CONFIDENCE){
  print("Wilcox: Energy consumption for PWA and Native is similar")
}else{
  print(sprintf("Wilcox: Energy consumption for PWA and Native differs, p=%f", wtest$p.value))
}

# qqnorm(ios_native_values, main="Q-Q Plot Energy Consumption \nNative iOS Implementation")
# qqline(ios_native_values, col='red')

# qqnorm(ios_pwa_values, main="Q-Q Plot Energy Consumption \nPWA iOS Implementation")
# qqline(ios_pwa_values, col='red')
