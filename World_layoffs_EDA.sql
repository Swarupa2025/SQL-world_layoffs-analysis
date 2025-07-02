-- Exploring Data analysis
Select  * 
From layoffs_staging2;

Select MAX(total_laid_off),MAX(percentage_laid_off)
From layoffs_staging2;

Select * 
From layoffs_staging2
where percentage_laid_off=1 
order by funds_raised_millions desc;

Select company,SUM(total_laid_off)
From layoffs_staging2
Group by company
order by 2 desc;

SElect MIN(`date`),MAX(`date`)
From layoffs_staging2;

Select industry,SUM(total_laid_off)
From layoffs_staging2
Group by industry
order by 2 desc;

Select country,SUM(total_laid_off)
From layoffs_staging2
Group by country
order by 2 desc;

Select YEAR(`date`),SUM(total_laid_off)
From layoffs_staging2
Group by YEAR(`date`)
order by 1 desc;

Select stage,SUM(total_laid_off)
From layoffs_staging2
Group by stage
order by 2 desc;

SELECT SUBSTRING(`date`,1,7)as `month`,sum(total_laid_off)
From layoffs_staging2
where SUBSTRING(`date`,1,7) is not null
group by `month`
order by 1 asc;

With Rolling_total As
(
SELECT SUBSTRING(`date`,1,7)as `month`,sum(total_laid_off) as totaloff
From layoffs_staging2
where SUBSTRING(`date`,1,7) is not null
group by `month`
order by 1 asc
)
SELect `month`,totaloff, SUM(totaloff) OVER(order by `month`)as rolling_total
FROM Rolling_total;

Select company,YEAR(`date`), SUM(total_laid_off)
From layoffs_staging2
Group by company,YEAR(`date`)
order by 1 asc;

Select company,YEAR(`date`), SUM(total_laid_off)
From layoffs_staging2
Group by company,YEAR(`date`)
order by 3 desc;

WITH Company_year (company,years,total_laid_off) as
(
Select company,YEAR(`date`), SUM(total_laid_off)
From layoffs_staging2

Group by company,YEAR(`date`)
order by 3 desc
), 
company_year_rank as 
(
Select * , dense_rank() over (partition by years order by total_laid_off desc) as ranking
FROm Company_year
where years is not null

)
SELECT * 
from company_year_rank 
where ranking <= 5
;
