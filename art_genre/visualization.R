library(dplyr)
library(tidyr)
library(ggplot2)
library(data.table)
library(ggthemes)

#--------------------------------Adding new labels-------------------
result <-
  fread(
    "/Users/dejiatang/Desktop/Spring2017/vision/vision_project/art_genre/results/result_s_2.csv"
  )

train <- result %>%
  gather(type, value, epoch_loss:epoch_acc) %>%
  filter(type == 'epoch_acc', phase == 'test') %>%
  select(model, epoch, value)
# %>%
#  mutate(model = ifelse(model=='feature_extract', 'feature_extract_18', model)) %>%
#  mutate(model = ifelse(model=='finetune', 'finetune_18', model))

plot <- train %>%
  ggplot(aes(x = epoch, y = value)) +
  geom_line(aes(col=model), alpha = 0.5) +
  geom_smooth(aes(col = model)) +
  ylim(0.65,0.85)+
  theme_hc() + 
  labs(x = "Epoch", y = 'Testing Accuracy') +
  ggtitle("Style Classification:\nEpoch vs. Testing Accuracy") +
  scale_colour_wsj("colors6", "")
plot
