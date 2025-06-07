# Required Libraries
library(ggplot2)       # for plotting
library(dplyr)         # for data manipulation
library(glmtoolbox)    # for Hosmer-Lemeshow test

# Load prediction result
df <- read.csv("data/predictions.csv")

# Hosmer–Lemeshow test
# We make a simple logistic model using the predicted probabilities
model <- glm(actual ~ predicted_proba, data = df, family = binomial())

# Perform the HL test using the model, grouped into 10 bins
hl_result <- hltest(model = model, g = 10)

# Show the test result in console
print(hl_result)