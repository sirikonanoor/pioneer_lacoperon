
library(dplyr)
library(ggplot2)
library(reshape2)
require(MASS)
require(scales) 

# Figure 3. a)
data <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.2e.csv",
                   sep = ",")
colnames(data) <- c("allolac",
                    "mrna")
data %>%
  ggplot(aes(x = allolac,
             y = mrna)) +
  geom_line(size = 1, color = "#00C19C") +
  geom_point(size = 2, color = "#00C19C") +
  labs(x = "Allolactose Concentration (M)",
       y = "Predicted # of mRNA",
       color = "Legend") +
  theme_light() +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_continuous(limits = c(0, 5),
                     breaks = seq(0, 5, 0.5))


# Figure 3. b)
data1 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3a.csv",
                    sep = ",")
colnames(data1) <- c("mrna", "xhatY1")
data2 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3atrans.csv",
                    sep = ",")
colnames(data2) <- c("mrna", "xhatY2")

data3 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3adeg.csv",
                    sep = ",")
colnames(data3) <- c("mrna", "xhatY3")

data <- left_join(data1, data2, by='mrna')
data <- left_join(data, data3, by = 'mrna')

data %>%
  ggplot(data, map = aes(x = mrna)) +
  # first line
  geom_line(aes(y = xhatY1, color = "Baseline"),
            size = 1) +
  geom_point(aes(y = xhatY1, color = "Baseline"),
             size = 2) + 
  # second line
  geom_line(aes(y = xhatY2, color = "Increased Transcription"),
            size = 1) +
  geom_point(aes(y = xhatY2, color = "Increased Transcription"),
             size = 2) + 
  # third line
  geom_line(aes(y = xhatY3,
                color = "Increased Degradation"),
            size = 1) +
  geom_point(aes(y = xhatY3, color = "Increased Degradation"),
             size = 2) + 
  labs(x = "# of mRNA",
       y = "Predicted Allolactose Concentration (M)",
       color = "Legend") +
  theme_light()  + 
  theme(legend.position = (c(0.8, 0.2)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) 




# Figure 3. c)
data1 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3b.csv",
                    sep = ",")
colnames(data1) <- c("lac", "bias1")
data2 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3btrans.csv",
                    sep = ",")
colnames(data2) <- c("lac", "bias2")

data3 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3bdeg.csv",
                    sep = ",")
colnames(data3) <- c("lac", "bias3")

data <- left_join(data1, data2, by='lac')
data <- left_join(data, data3, by = 'lac')

data %>%
  ggplot(data, map = aes(x = lac)) +
  # first line
  geom_line(aes(y = bias1, color = "Baseline"),
            size = 1) +
  geom_point(aes(y = bias1, color = "Baseline"),
             size = 2) + 
  # second line
  geom_line(aes(y = bias2, color = "Increased Transcription"),
            size = 1) +
  geom_point(aes(y = bias2, color = "Increased Transcription"),
             size = 2) + 
  # third line
  geom_line(aes(y = bias3,
                color = "Increased Degradation"),
            size = 1) +
  geom_point(aes(y = bias3, color = "Increased Degradation"),
             size = 2) + 
  labs(x = "Allolactose Concentration (M)",
       y = "Bias (M)",
       color = "Legend") +
  theme_light()  + 
  theme(legend.position = (c(0.65, 0.4)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) 



# Figure 3. d)
data1 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3c.csv",
                    sep = ",")
colnames(data1) <- c("lac", "var1")
data2 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3ctrans.csv",
                    sep = ",")
colnames(data2) <- c("lac", "var2")

data3 <- read.table("/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3cdeg.csv",
                    sep = ",")
colnames(data3) <- c("lac", "var3")

data <- left_join(data1, data2, by='lac')
data <- left_join(data, data3, by = 'lac')

data %>%
  ggplot(data, map = aes(x = lac)) +
  # first line
  geom_line(aes(y = var1, color = "Baseline"),
            size = 1) +
  geom_point(aes(y = var1, color = "Baseline"),
             size = 2) + 
  # second line
  geom_line(aes(y = var2, color = "Increased Transcription"),
            size = 1) +
  geom_point(aes(y = var2, color = "Increased Transcription"),
             size = 2) + 
  # third line
  geom_line(aes(y = var3,
                color = "Increased Degradation"),
            size = 1) +
  geom_point(aes(y = var3, color = "Increased Degradation"),
             size = 2) + 
  labs(x = "Allolactose Concentration (M)",
       y = "Variance (M)",
       color = "Legend") +
  theme_light()  + 
  theme(legend.position = (c(0.75, 0.4)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) 
