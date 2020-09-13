
library(dplyr)
library(ggplot2)
library(reshape2)

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
        legend.background = element_rect(fill = "lightgray")) +
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
  theme(legend.position = (c(0.5, 0.65)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_x_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10))



# colnames(data) <- c("mrna",
#                     "-6", "-5.5",
#                     "-5", "-4.5",
#                     "-4", "-3.5",
#                     "-3" , "-2.5",
#                     "-2", "-1.5",
#                     "-1", "-0.5", "0")
colnames(data) <- c("mrna",
                    "-7", "-6.5",
                    "-6", "-5.5",
                    "-5", "-4.5",
                    "-4" , "-3.5")

# d <- read.delim(textConnection(data), sep="")
data <- melt(data, id.vars="mrna")

# Everything on the same plot
ggplot(data, aes(mrna,value, col=variable)) +
  geom_line() +
  theme_light()
stat_smooth()

# Separate plots
ggplot(data, aes(mrna, value)) + 
  geom_line() + 
  # stat_smooth() +
  facet_wrap(~variable)


data %>%
  ggplot(aes(x = mrna,
             y = prob_mrna)) +
  geom_line(size = 1, colour = "red") +
  labs(x = "mrna",
       y = "prob_mrna",
       color = "Legend") +
  theme_light() + 
  # scale_y_continuous(limits = c(0, 0.05), breaks=seq(0, 0.05, 0.01)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))






### FIGURE 4

# Figure 4. a)
# define paths
input_path <- "/Users/sirikonanoor/Documents/pioneer/csvfiles/"
full_path_0 <- paste0(input_path, "lac0.csv")
full_path_1 <- paste0(input_path, "lac1.csv")
full_path_2 <- paste0(input_path, "lac2.csv")
full_path_3 <- paste0(input_path, "lac3.csv")
full_path_4 <- paste0(input_path, "lac4.csv")
full_path_5 <- paste0(input_path, "lac5.csv")
full_path_6 <- paste0(input_path, "lac6.csv")

# read data with effectiveness 0.0
data0 <- read.table(file = full_path_0,
                    sep = ",") %>%
  mutate(lac = "0")
# read data with effectiveness 0.5 and rbind
data1 <- read.table(file = full_path_1,
                    sep = ",") %>%
  mutate(lac = "1") %>%
  rbind(data0, .)
# read data with effectiveness 0.5 and rbind
data2 <- read.table(file = full_path_2,
                    sep = ",") %>%
  mutate(lac = "2") %>%
  rbind(data1, .)
# read data with effectiveness 0.6 and rbind
data3 <- read.table(file = full_path_3,
                    sep = ",") %>%
  mutate(lac = "3") %>%
  rbind(data2, .)
# read data with effectiveness 0.7 and rbind
data4 <- read.table(file = full_path_4,
                    sep = ",") %>%
  mutate(lac = "4") %>%
  rbind(data3, .)
# read data with effectiveness 0.8 and rbind
data5 <- read.table(file = full_path_5,
                    sep = ",") %>%
  mutate(lac = "5") %>%
  rbind(data4, .)
# read data with effectiveness 1.0 and rbind
full_data <- read.table(file = full_path_6,
                        sep = ",") %>%
  mutate(lac = "6") %>%
  rbind(data5, .)

# full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_compliance",
                         "percent_infected",
                         "protection",
                         "reff",
                         "lac")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_compliance,
             y = percent_infected,
             group = lac)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 1,
               width = 5,
               geom = "point",
               aes(color = lac)) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.4,
               width = 5,
               geom = "line",
               aes(color = lac)) +
  labs(x = "Vaccine Compliance (%)",
       y = "Percent Infected",
       color = "lac (%)") + 
  theme_light() + 
  scale_color_discrete(breaks=c("0","40","50", "60",
                                "70","80","90","100")) + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 20),
                     breaks = seq(0, 20, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))

