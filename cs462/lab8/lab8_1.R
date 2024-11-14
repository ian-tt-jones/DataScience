connection_string = 'mongodb+srv://student:UMBC@umbc-cmsc462.xxst0lk.mongodb.net/'
grocery = mongo(collection='grocery', db='Lab_8', url=connection_string)
grocery$count()
install.packages('ggplot2')
library(ggplot2)
lab8 <- grocery$find('{}')
ggplot(lab8, aes(Item_Visibility, Item_MRP)) + geom_point() + 
  scale_x_continuous("Item Visibility", breaks = seq(0,0.35,0.05))+ 
  scale_y_continuous("Item MRP", breaks = seq(0,270,by = 30))+ theme_bw()

ggplot(lab8, aes(Item_Visibility, Item_MRP)) + geom_point(aes(color = Item_Type)) + 
  scale_x_continuous("Item Visibility", breaks = seq(0,0.35,0.05))+
  scale_y_continuous("Item MRP", breaks = seq(0,270,by = 30))+ 
  theme_bw() + labs(title="Scatterplot") + facet_wrap( ~ Item_Type)

ggplot(lab8, aes(Item_MRP)) + geom_histogram(binwidth = 2)+
  scale_x_continuous("Item MRP", breaks = seq(0,270,by = 30))+
  scale_y_continuous("Count", breaks = seq(0,200,by = 20))+
  labs(title = "Histogram")

ggplot(lab8, aes(x = Outlet_Identifier, y = Item_Outlet_Sales)) +
  geom_boxplot(outlier.colour = "black") +
  scale_y_continuous("Item sales", breaks = seq(0, max(lab8$Item_Outlet_Sales), by = 500)) +
  theme_bw() +
  labs(title="Box plot",
       x="Outlet",
       y="Item sales") +
  theme(axis.text.x = element_text(angle = 90))

ggplot(lab8, aes(Item_Outlet_Sales)) + geom_area(stat = "bin", bins = 30, fill = "steelblue") + scale_x_continuous(breaks = seq(0,11000,1000))+ labs(title = "Area Chart", x = "Item Outlet Sales", y = "Count")
