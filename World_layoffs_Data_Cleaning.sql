#Data Cleaning

/*
best practices for data cleaning would be 
1  Remove Duplicates
2. Standardize the data
3. Null values
4. Remove unwante dcolumns if any
*/

-- Checking the table contains

Select *
From layoffs;

-- Creating a similar table with same col names so that the original dtata base table will not undergo any changes

Create table layoffs_staging
Like layoffs;

-- To check if headers are created properly

Select *
From layoffs_staging;

-- copying the whole data from the original table

Insert layoffs_staging 
select *
From layoffs;

/* -- we can observe there is nothing that represents a uniques value in this table that
 would help us in removing duplicates. So we are trying to create row number partitioned by every column 
 so we can get any duplicates if row number changes from 1 to 2 as
 partition should give us a unique value(Window Function)
 */
 
 Select *,
 Row_number() Over(partition by company ,location,industry,total_laid_off , 
 percentage_laid_off, `date`,stage,country, funds_raised_millions) As Row_num
 From layoffs_staging;
 
  /* off all the above query results we are interested in rows with row nunbers>1 
 which shows the duplicates. so we are can use subqueries or cte for this*/
 
 WITH duplicate_cte As 
 (
 Select *,
 Row_number() Over(partition by company ,location,industry,total_laid_off , 
 percentage_laid_off, `date`,stage,country, funds_raised_millions) As Row_num
 From layoffs_staging
 )
 Select *
 From duplicate_cte
 where Row_num >1;

 Select  * 
 From layoffs_staging
 where company = "Casper";
 
 /* so when we try to delete the table rows 
 that had 2 as row num cannot be poosible as we cannot update a real table from cte
 so we are going to create a table with the cte query and delte the rows not needed
 */
 
 CREATE TABLE `layoffs_staging2` (
  `company` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` decimal(5,2) DEFAULT NULL,
  `date`  varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `funds_raised_millions` decimal(10,2) DEFAULT NULL,
  `Row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Checking to see if all headers are created 
Select  * 
 From layoffs_staging2;
 
-- Insreting the data along with the row number as an extra column
 
INSERT into layoffs_staging2
Select *,
 Row_number() Over(partition by company ,location,industry,total_laid_off , 
 percentage_laid_off, `date`,stage,country, funds_raised_millions) As Row_num
 From layoffs_staging;
 
 
 -- selecting the rows  with Row_num>1 representing the duplicate rows
 
 Select  * 
 From layoffs_staging2
 where Row_num >1;
 
 
 -- Deletong the duplicate rows
 
DELETE 
 From layoffs_staging2
 where Row_num >1;
 
 -- double checking if the duplicates are deleted

 Select  * 
 From layoffs_staging2;
 
 -- Standardizing data
 
 
 -- 1.Removing the extra spaces before and after the data 
 
 Select distinct(company)
 From layoffs_staging2;

 UPDATE layoffs_staging2
 SET company= TRIm(company);
 
-- Making changes to the industry domain that are same but named differently
Select *
 From layoffs_staging2
 where industry like 'crypto%';

-- Updating the table

 UPDATE layoffs_staging2
 SET industry= 'Crypto'
 Where industry like "Crypto%";

-- Checking if the country names are misspelled 
Select distinct country 
 From layoffs_staging2
 order by 1;
 
 -- Updating accordingly
 UPDATE layoffs_staging2
 SET country= 'United States'
 Where country like "United States%";
 
 -- Chnaging the date format in the table before changing the data type
 Select `date`,str_to_date(`date`,'%m/%d/%Y')
 From layoffs_staging2;

-- checking if everthing changed in format 

select `date`
From layoffs_staging2;

-- changing the date from string to date format

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Altering the table with date data type

ALTER Table layoffs_staging2
modify column `date` date;

-- Double checking

select *
From layoffs_staging2;

-- Removing null values

select *
From layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- converting the blank spaces into null values

update layoffs_staging2
set industry =null
where industry ='';

-- Checking the null values

select *
From layoffs_staging2
where industry is null
or industry like '';


select *
From layoffs_staging2
where company like 'Bally%';

-- Self joining the table so that valid null values will be replaced by the actual values from the same company

select t1. industry,t2.industry 
from layoffs_staging2 t1
join layoffs_staging2 t2 
	on t1.company= t2.company
where (t1.industry is null )
and t2.industry is not null;

-- Updating table
update layoffs_staging2 t1
join layoffs_staging2 t2 
	on t1.company= t2.company
set t1.industry =t2.industry 
where (t1.industry is null )
and t2.industry is not null;

-- selecting the null values that are not useful
select *
From layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
From layoffs_staging2
where total_laid_off =0
and percentage_laid_off =0;

-- Deleting them

DELETE 
From layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

DELETE 
From layoffs_staging2
where total_laid_off =0
and percentage_laid_off =0;

-- Altering table by deleting extra column we created

alter table layoffs_staging2
drop column Row_num;