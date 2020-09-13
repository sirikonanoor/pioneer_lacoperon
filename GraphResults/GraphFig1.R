# Figure 1 has the "controls" to show that the code works

library(dplyr)
library(ggplot2)
library(reshape2)
require(MASS)
require(scales) 

### FIGURE 1:


# Figure 1. a)
data <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1a.csv",
                   sep = ",")
colnames(data) <- c("mrna", "probability")

data %>%
  ggplot(aes(x = mrna,
             y = probability)) +
  geom_line(size = 1, color = "#00C19C") +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)") +
  theme_light() +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_x_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10))


# Figure 1. b)
data1 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1a.csv",
                    sep = ",")
colnames(data1) <- c("mrna", "prob1")
data2 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1brep.csv",
                    sep = ",")
colnames(data2) <- c("mrna", "prob2")

data3 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1brnap.csv",
                    sep = ",")
colnames(data3) <- c("mrna", "prob3")

data <- left_join(data1, data2, by='mrna')
data <- left_join(data, data3, by = 'mrna')

data %>%
  ggplot(aes(x = mrna)) +
  # first line
  geom_line(aes(y = prob1,
                color = "Baseline"),
            size = 1) +
  # second line
  geom_line(aes(y = prob2,
                color = "Increased repressors"),
            size = 1) +
  # third line
  geom_line(aes(y = prob3,
                color = "Increased RNAPs"),
            size = 1) +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)",
       color = "Legend") +
  theme_light()  + 
  theme(legend.position = (c(0.8, 0.7)),
        legend.background = element_rect(fill = "lightgray"))  +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_continuous(limits = c(0, 100),
                   breaks = seq(0, 100, 10))



# Figure 1. c)
data1 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1a.csv",
                    sep = ",")
colnames(data1) <- c("mrna", "prob1")
data2 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1ctrans.csv",
                    sep = ",")
colnames(data2) <- c("mrna", "prob2")

data3 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1cdeg.csv",
                    sep = ",")
colnames(data3) <- c("mrna", "prob3")

data <- left_join(data1, data2, by='mrna')
data <- left_join(data, data3, by = 'mrna')

data %>%
  ggplot(aes(x = mrna)) +
  # first line
  geom_line(aes(y = prob1,
                color = "Baseline"),
            size = 1) +
  # second line
  geom_line(aes(y = prob2,
                color = "Increased Transcription"),
            size = 1) +
  # third line
  geom_line(aes(y = prob3,
                color = "Increased Degradation"),
            size = 1) +
  labs(x = "# of mRNA",
       y = "p(mRNA | allolactose)",
       color = "Legend") +
  theme_light()  + 
  theme(legend.position = (c(0.8, 0.85)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) + 
  scale_x_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10))

