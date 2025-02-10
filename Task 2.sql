create database titanic;
USE titanic;

# Check for Missing Values

SELECT 
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Missing_Age,
    SUM(CASE WHEN Cabin IS NULL THEN 1 ELSE 0 END) AS Missing_Cabin,
    SUM(CASE WHEN Embarked IS NULL THEN 1 ELSE 0 END) AS Missing_Embarked
FROM titanic;

# Create a Column for Family Size

ALTER TABLE titanic ADD COLUMN FamilySize INT;

UPDATE titanic  
SET FamilySize = SibSp + Parch + 1;

# Survival Count and Percentage

SELECT Survived, COUNT(*) AS Count, 
       ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM titanic), 2) AS Percentage
FROM titanic
GROUP BY Survived;

# Survival Rate by Gender

SELECT Sex, Survived, COUNT(*) AS Count 
FROM titanic 
GROUP BY Sex, Survived 
ORDER BY Sex, Survived;

# Survival Rate by Passenger Class

SELECT P_class, Survived, COUNT(*) AS Count 
FROM titanic 
GROUP BY P_class, Survived 
ORDER BY P_class, Survived;

# Average Fare by Survival Status

SELECT Survived, AVG(Fare) AS Avg_Fare 
FROM titanic 
GROUP BY Survived;

# Survival Rate by Family Size

SELECT FamilySize, Survived, COUNT(*) AS Count 
FROM titanic 
GROUP BY FamilySize, Survived 
ORDER BY FamilySize, Survived;

# Correlation Between Fare and Survival

SELECT 
    CASE 
        WHEN Fare < 10 THEN 'Low'
        WHEN Fare BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'High' 
    END AS FareCategory,
    Survived, COUNT(*) 
FROM titanic
GROUP BY FareCategory, Survived;