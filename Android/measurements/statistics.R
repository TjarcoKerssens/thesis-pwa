android_pwa_values = c(3.6657, 4.1509);
android_native_values = c(3.8894, 3.8262);

# For p > 0.05 accept H0 that means are equal
t.test(android_native_values, android_pwa_values)
