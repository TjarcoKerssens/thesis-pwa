CONFIDENCE = 0.01

pwa_first_paint <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Android_first_paint_pwa.csv")
web_first_paint <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Android_first_paint_web.csv")
native_first_paint <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Android_first_paint_native.csv")
pwa_first_paint_large <-read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Android_first_paint_pwa_large.csv")

pwa_first_paint_samsung <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Samsung_first_paint_pwa.csv")
native_first_paint_samsung <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Samsung_first_paint_native.csv")
web_first_paint_samsung <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Samsung_first_paint_web.csv")


pwa_first_paint_nexus <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Nexus_first_paint_pwa.csv")
native_first_paint_nexus <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Nexus_first_paint_native.csv")
web_first_paint_nexus <- read.csv("/Users/tjarco/Development/thesis-pwa/Android/measurements/data/Nexus_first_paint_web.csv")

pwa <- pwa_first_paint$First.paint
pwa_3g <- pwa_first_paint$First.paint.3G
web <- web_first_paint$First.paint
web_3g <- web_first_paint$First.paint.3G
native <- native_first_paint$First.paint
pwa_large <- pwa_first_paint_large$First.paint

pwa_samsung = pwa_first_paint_samsung$First.paint
native_samsung = native_first_paint_samsung$First.paint
web_samsung = web_first_paint_samsung$First.paint

pwa_nexus = pwa_first_paint_nexus$First.paint
native_nexus = native_first_paint_nexus$First.paint
web_nexus = web_first_paint_nexus$First.paint

test.normality <- function(data, name){
  normality = shapiro.test(data)
  
  if(normality$p.value > CONFIDENCE){
    print(sprintf("%s data is normally distributed, p-value = %f", name, normality$p.value))
  }else{
    print(sprintf("%s data is not normally distributed, p-value = %f", name, normality$p.value))
  }
}

test.differ <- function(first, seccond, names){
  wtest = wilcox.test(first, seccond);
  if (wtest$p.value > CONFIDENCE){
    print(sprintf("Wilcox: The first paint time of %s does not differ, p-value: %f", names, wtest$p.value))
  }else{
    print(sprintf("Wilcox: The first paint time of %s does differ, p-value: %f", names, wtest$p.value))
  }
}

test.normality(data=pwa, name="PWA normal network")
test.normality(data=pwa_3g, name="PWA slow network")
test.normality(data=web, name="Web normal network")
test.normality(data=web_3g, name="Web Slow network")
test.normality(data=native, name="Native")

test.differ(first=pwa, seccond=native, names="PWA and Native")
test.differ(first=pwa, seccond=web, names="PWA and Web normal")
test.differ(first=pwa_3g, seccond=web_3g, names="PWA and Web slow")

test.normality(data = pwa_samsung, name="PWA on Samsung")
test.normality(data = native_samsung, name = "Native on Samsung")
test.normality(data = web_samsung, name= "Web on Samsung")
test.differ(first = pwa_samsung, seccond = native_samsung, names="Samsung PWA and Native")
test.differ(first = pwa_samsung, seccond = web_samsung, names="Samsung PWA and Web")

test.normality(data = pwa_nexus, name="PWA on Nexus")
test.normality(data = native_nexus, name = "Native on Nexus")
test.normality(data = web_nexus, name = "Web on Nexus")
test.differ(first = pwa_nexus, seccond = native_nexus, names="Nexus PWA and Native")
test.differ(first = pwa_nexus, seccond = web_nexus, names = "Nexus PWA and Web")

qqnorm(native, main="Q-Q Plot paint time \nNative Implementation")
qqline(native, col='red')

qqnorm(pwa, main="Q-Q Plot paint time \nPWA Implementation")
qqline(pwa, col='red')

qqnorm(pwa_3g, main="Q-Q Plot paint time \n3G PWA Implementation")
qqline(pwa_3g, col='red')

qqnorm(web, main="Q-Q Plot paint time \nWeb Implementation")
qqline(web, col='red')

qqnorm(web_3g, main="Q-Q Plot paint time \n3G Web Implementation")
qqline(web_3g, col='red')

boxplot(native, pwa,
        names=c("Native", "PWA"), 
        main="First Paint times in ms",
        xlab="Application type", ylab="Paint time")

boxplot(web, pwa,
        names=c("Web", "PWA"), 
        main="First Paint times in ms",
        xlab="Application type", ylab="Paint time")

boxplot(web_3g, pwa_3g,
        names=c("Web", "PWA"), 
        main="First Paint times 3G in ms",
        xlab="Application type", ylab="Paint time")

boxplot(native, pwa_large,
        names=c("Native", "Large PWA"), 
        main="First Paint times in ms",
        xlab="Application type", ylab="Paint time")

boxplot(native_samsung, pwa_samsung,   
        names=c("Native", "PWA"), 
        main="First Paint times in ms on the\nSamsung Galaxy J",
        xlab="Application type", ylab="Paint time")

boxplot(web_samsung, pwa_samsung,   
        names=c("Web", "PWA"), 
        main="First Paint times in ms on the\nSamsung Galaxy J",
        xlab="Application type", ylab="Paint time")

boxplot(native_nexus, pwa_nexus,   
        names=c("Native", "PWA"), 
        main="First Paint times in ms on the\nNexus 5X",
        xlab="Application type", ylab="Paint time")

boxplot(web_nexus, pwa_nexus,   
        names=c("Web", "PWA"), 
        main="First Paint times in ms on the\nNexus 5X",
        xlab="Application type", ylab="Paint time")
