# Set the working directory.
setwd("C:/Users/juano/Desktop/Belgium/Third Year/BIN381")

# Read the file.
pupae <- read.csv("Datasets-20250909/pupae.csv")

head(pupae)

# Get the structure (str) of popae.
str(pupae)

pupae$T_treatment

# Transform the T_treatment type to factor.
pupae$T_treatment <- as.factor(pupae$T_treatment)

str(pupae)

allom <- read.csv("Datasets-20250909/allometry.csv")

str(allom)

allom$species <- factor(allom$species)

allom$treesize <- factor(ifelse(allom$diameter < 10, "Small", ifelse(allom$diameter < 20, "Medium", "Large")))

table(allom$treesize)

nums <- c(1:15)
nums > 5

nums[nums > 5]

myvector <- c(11,13,5,6,NA,9)

mean(myvector)
# No mean because of the NA.

# Remove all NA values.
mean(myvector, na.rm = TRUE)

datavec <- c(2, -9999, 100, 3, -9999, 5)

datavec[datavec == -9999] <- NA

summary(pupae)

#Remove Gender NA's.
pupae_subset <- subset(pupae, !is.na(Gender) & !is.na(Frass))
summary(pupae_subset)

substr(c("good","good riddance", "good","good on ya"),1,4)
  