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

# Credit_score function
score_card <- function(prob) {
  min_score <- 300
  max_score <- 850
  score <- max_score - prob * (max_score - min_score)
  return(score)
}

# Use the function
df$credit_score <- score_card(df$predicted_proba)

# Bins for calibration analysis
df$bin <- ntile(df$predicted_proba, 10)

# For each bin, calculate the average predicted and actual default rate
df_summary <- df %>%
  group_by(bin) %>%
  summarise(
    avg_pred = mean(predicted_proba),
    avg_actual = mean(actual)
  )

# Plot calibration curves
plot <- ggplot(df_summary, aes(x = avg_pred, y = avg_actual)) +
  geom_point(size = 2) +                     # dots for each bin
  geom_line() +                              # connect the dots
  geom_abline(slope = 1, intercept = 0,      # ideal calibration line
              linetype = "dashed", color = "gray") +
  labs(
    title = "Calibration Curve",
    x = "Predicted Default Probability",
    y = "Observed Default Rate"
  )

# Save the Plot
ggsave("calibration_curve.png", plot = plot, width = 6, height = 4, dpi = 300)
