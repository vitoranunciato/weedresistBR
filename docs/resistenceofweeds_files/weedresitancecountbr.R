library(RCurl)
library(ggplot2)
library(gganimate)

weedresitancecount = getURL("https://raw.githubusercontent.com/vitoranunciato/weedresistBR/main/docs/weedresitancecount_br.csv")

wrc = read.csv(text = weedresitancecount)

p <- ggplot(
  wrc,
  aes(Year, Count, group = Herb, color = factor(Herb))
) +
  geom_line(size=2) +
  scale_x_continuous(breaks = round(seq(min(wrc$Year), max(wrc$Year), by = 2))) +
  scale_y_continuous(breaks = round(seq(min(wrc$Count), max(wrc$Count), by = 5)))+
  labs(x = "Year", y = "Herbicide‐resistant weeds by county", title = "History of reports of herbicide-resistant weeds in Brazil.", color = "Herbicide", caption = "Adapted of Heap, 2020.") +
  theme(legend.position = "top")+
  geom_vline(xintercept = 2005, colour="black", linetype = "longdash")+
  theme_classic()

p.a = p + annotate("text", x = 2000, y = 50, label = "Pre RR traits")
p.b = p.a + annotate("text", x = 2010, y = 50, label = "Post RR traits")
p.c = p.b + geom_point() +  transition_reveal(Year)


anim_save("weedresitancecount.gif", p.c)

