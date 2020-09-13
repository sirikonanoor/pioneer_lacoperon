
library(dplyr)
library(ggplot2)
library(reshape2)
require(MASS)
require(scales) 

# Figure 2. a)
data <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.2a.csv",
                   sep = ",")
colnames(data) <- c("mrna",
                    "10^ -6", "10^ -5.5",
                    "10^ -5", "10^ -4.5",
                    "10^ -4", "10^ -3.5",
                    "10^ -3" , "10^ -2.5",
                    "10^ -2", "10^ -1.5",
                    "10^ -1", "10^ -0.5", "10^ 0")

data <- melt(data, id.vars="mrna")

# Everything on the same plot
ggplot(data, aes(mrna, value, col=variable)) +
  geom_line() +
  theme_light() +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)",
       color = "Allolactose (M)") +
  theme(legend.background = element_rect(fill = "lightgray"))  +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_continuous(limits = c(0, 40),
                     breaks = seq(0, 40, 5))


  

# Figure 2. b)
data <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.2a.csv",
                   sep = ",")
colnames(data) <- c("mrna",
                    "10^ -6", "10^ -5.5",
                    "10^ -5", "10^ -4.5",
                    "10^ -4", "10^ -3.5",
                    "10^ -3" , "10^ -2.5",
                    "10^ -2", "10^ -1.5",
                    "10^ -1", "10^ -0.5", "10^ 0")

data <- melt(data, id.vars="mrna")

# Separate plots
ggplot(data, aes(mrna, value)) + 
  geom_line() + 
  facet_wrap(~variable) +
  theme_light() +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)",
       color = "Allolactose (M)") +
  theme(legend.background = element_rect(fill = "lightgray"))  +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_continuous(limits = c(0, 40),
                     breaks = seq(0, 40, 10))



# Figure 2. c)
data <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.2c.csv",
                   sep = ",")
colnames(data) <- c("mrna",
                    "10^ -9", "10^ -8.5",
                    "10^ -8", "10^ -7.5",
                    "10^ -7", "10^ -6.5",
                    "10^ -6" , "10^ -5.5",
                    "10^ -5", "10^ -4.5",
                    "10^ -4", "10^ -3.5", "10^ -3")

data <- melt(data, id.vars="mrna")

# Everything on the same plot
ggplot(data, aes(mrna, value, col=variable)) +
  geom_line() +
  theme_light() +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)",
       color = "Allolactose (M)") +
  theme(legend.background = element_rect(fill = "lightgray")) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_continuous(limits = c(0, 40),
                     breaks = seq(0, 40, 5))


# Figure 2. d)
data <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.2c.csv",
                   sep = ",")
colnames(data) <- c("mrna",
                    "10^ -9", "10^ -8.5",
                    "10^ -8", "10^ -7.5",
                    "10^ -7", "10^ -6.5",
                    "10^ -6" , "10^ -5.5",
                    "10^ -5", "10^ -4.5",
                    "10^ -4", "10^ -3.5", "10^ -3")

data <- melt(data, id.vars="mrna")

# Separate plots
ggplot(data, aes(mrna, value)) + 
  geom_line() + 
  facet_wrap(~variable) +
  theme_light() +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)",
       color = "Allolactose (M)") +
  theme(legend.background = element_rect(fill = "lightgray"))  +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_continuous(limits = c(0, 40),
                     breaks = seq(0, 40, 10))

