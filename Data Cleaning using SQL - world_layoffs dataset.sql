-- Data Cleaning 

-- 1. import data set
-- create new database and import data using import wizard- right click on create db Tables. Table data import wizard

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data  - if there is a issues with spellins or somthing
-- 3. NULL values or Blank values
-- 4. Remove Any Columns

-- going to start
-- need to create another table to take a copy of layoffs table 
-- if we make a mistake we need row data. 

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;   -- newly created for practice

INSERT layoffs_staging 
SELECT * 
FROM layoffs;

-- there is not unique value column. need to add a column to remove duplicate 
-- use WINDOW FUNCTION with ROW_NUMBER()
-- use backtick for date - it is keyword as a column name

SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- partition by all the columns because we need to find most duplicate values
-- check wether the row_num > 1 - they are duplicates
-- use SUBQUERY OR CTE

WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- check these are correct? 
SELECT *
FROM layoffs_staging
WHERE company = 'Hibob';   -- yes duplicates

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';  -- yes duplicate 2 rows

-- To only remove,  duplicate rows
-- can identify duplicates using CTE but can't delete

WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE                       -- get an error
FROM duplicate_cte
WHERE row_num > 1;  

-- create another staging table. because ROW_NUMBER only for find the duplicates
-- to remove

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- check is it properly created
SELECT *
FROM layoffs_staging2; 

-- now got empty table. need to add numbered table, which is layoffs_staging.
INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- 1. DELETE Duplicate Values
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Check is it correct
SELECT *
FROM layoffs_staging2
WHERE row_num > 1; 

SELECT * 
FROM layoffs_staging2;

-- 2. Standardizing Data - remove mistakes from the data set. like white spaces, spelling mistakes...

-- check first column - company 
-- TRIM - remove white spaces
SELECT company, TRIM(company) 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- check second column - industry 
-- ORDER BY 1 means sorts the result by the first selected column, which is industry
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1; 

-- there are blanck cells, null cells  
-- Crypto , Crypto Currency, CryptoCurrency - like that names. same name different type

 SELECT *
 FROM layoffs_staging2 
 WHERE industry LIKE 'Crypto%';
 
 UPDATE layoffs_staging2
 SET industry = 'Crypto'       -- all the other name for Cripto turn to Crypto
 WHERE industry LIKE 'Crypto%';
 
 
-- check third column - location
SELECT DISTINCT location
FROM  layoffs_staging2
ORDER BY 1;               -- ok with here 
 
-- check 4th column - country 
SELECT DISTINCT country
FROM  layoffs_staging2
ORDER BY 1;  
-- United States and United States. -  A dot issue at the end  
SELECT *
FROM  layoffs_staging2
WHERE country LIKE 'United States%'; 

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- check 5th column - date
-- date column data type is text - use STR_TO_DATE() function

SELECT `date`, 
STR_TO_DATE(`date`, '%m/%d/%Y/')   -- check this works first
FROM layoffs_staging2;

-- STR_TO_DATE(string, format)
-- string → The text you want to convert.
-- format → The pattern that tells MySQL how to interpret the text.

-- update actual column
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y/');

-- check is it works
SELECT *
FROM layoffs_staging2;  

-- but still date column data type doesn't changed
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- 3. Remove Null values and Blanks
SELECT *
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL;  -- check total_laid_off column null values

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;  -- total_laid_off & percentage_laid_off null rows are useless


SELECT DISTINCT industry     -- industry column also have missing values and null values
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL OR industry = '';   -- check null and missing values - industry

SELECT * 
FROM layoffs_staging2
WHERE company = 'Airbnb';      -- check value in industry missing value part
-- this Airbnb is travel industry. we can update missing value in industry column

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- join same table together and going to put same industry name each industry missing values
SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;                   -- this is not work


-- need to these blanks cells convert to null values
UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

-- before we can't update blank to null. now no any blanks, all are null values. 
-- now update work properly
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL )
AND t2.industry IS NOT NULL; 

-- check is it works
SELECT * 
FROM layoffs_staging2
WHERE company = 'Airbnb';  -- yes works

-- again check null or missing values
SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL OR industry = ''; 

-- this industry have one row and it can't fill with another info from this industry
-- we don't know what is the industry
SELECT * 
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

-- 4. Remove Columns and Rows 

-- if these row are not usable. we can delete these rows
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

-- now we do not want row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
