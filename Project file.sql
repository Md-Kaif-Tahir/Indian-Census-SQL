--Importing the CSV to the SQL server	
	SELECT * FROM Projects.dbo.Data_1;
	SELECT * FROM Projects.dbo.Data_2;

-- Total numbers of rows in First DATASET
	SELECT COUNT(*) AS Total_rows 
	FROM Projects.dbo.Data_1 ;

-- Total numbers of rows in Second DATASET
	SELECT COUNT(*) AS Total_rows 
	FROM Projects.dbo.Data_2 ;

-- Dataset from Jharkhand and Bihar ( Filtering )
   SELECT * FROM Projects.dbo.Data_1
   WHERE state in ('Jharkhand' , 'Bihar');

-- Total population of the India
	SELECT SUM(population) AS Population 
	FROM projects.dbo.Data_2;

-- Average growth of the India
	SELECT AVG(growth)*100 AS avg_growth
	FROM projects.dbo.Data_1;

-- Average growth of the India, State wise
	SELECT state, ROUND(AVG(growth),3) * 100 AS avg_growth
    FROM projects.dbo.Data_1
    GROUP BY state
	ORDER BY avg_growth ASC;

-- Average Sex_Ratio of the India
	SELECT AVG(Sex_Ratio) AS Sex_Ratio
	FROM projects.dbo.Data_1;

-- Average Sex_Ratio of the India, State wise
	SELECT state, ROUND(AVG(Sex_Ratio),0) AS Sex_Ratio
    FROM projects.dbo.Data_1
    GROUP BY state
	ORDER BY Sex_Ratio ASC;

-- Bottom 3 states showing lowest sex ratio
	SELECT TOP 3 state, ROUND(AVG(sex_ratio),0) AS avg_sex_ratio
	FROM projects.dbo.Data_1 
	GROUP BY state 
	ORDER BY avg_sex_ratio ASC

-- Average literacy_rate of the India
	SELECT AVG(literacy) AS literacy_rate
	FROM projects.dbo.Data_1;

-- Average literacy_rate of the India, Top 10 State greater than 80% 
	SELECT TOP 10 state, ROUND(AVG(literacy),0) AS literacy
    FROM projects.dbo.Data_1
    GROUP BY state
	HAVING ROUND(AVG(literacy),0) > 80
	ORDER BY literacy ASC;

-- Top and Bottom 3 states in literacy states
    
	-- TOP 3 STATES
    DROP TABLE IF exists #Topstates
	CREATE TABLE #Topstates
	( State nvarchar(225),
	  Top_states float)

	INSERT INTO #Topstates
	SELECT state, ROUND(AVG(literacy),0) AS Avg_literacy_ratio
	FROM Projects.dbo.Data_1
	GROUP BY state 
	ORDER BY Avg_literacy_ratio DESC;

	SELECT TOP 3 * FROM #Topstates 
	ORDER BY top_states DESC;

    -- BOTTOM 3 STATES
    DROP TABLE IF exists #Bottomstates
	CREATE TABLE #Bottomstates
	( State nvarchar(225),
	  Bottom_states float)

	INSERT INTO #Bottomstates
	SELECT state, ROUND(AVG(literacy),0) AS Avg_literacy_ratio
	FROM Projects.dbo.Data_1
	GROUP BY state 
	ORDER BY Avg_literacy_ratio DESC;

	SELECT TOP 3 * FROM #Bottomstates 
	ORDER BY Bottom_states ASC;

	-- Joining both the table

	SELECT * FROM (
		SELECT TOP 3 * FROM #Topstates 
		ORDER BY Top_states DESC
	) AS TopStates
	UNION 
	SELECT * FROM (
		SELECT TOP 3 * FROM #Bottomstates 
		ORDER BY Bottom_states ASC
	) AS BottomStates;

-- States starting with letter 'a'
	SELECT DISTINCT(state) 
	FROM projects.dbo.Data_1
	WHERE LOWER(state) like 'a%';

-- States starting with letter 'a' or ending with letter 'd'
	SELECT DISTINCT(state) 
	FROM projects.dbo.Data_1
	WHERE LOWER(state) like 'a%' OR LOWER(state) LIKE '%d';

-- calculating the total number of males and females in each state

	SELECT D.state, SUM(D.males) AS Total_Males, SUM(D.females) AS Total_females 
	FROM

	(SELECT C.district,C.state, ROUND(C.population/(sex_ratio+1),0) AS Males, 
	ROUND((population*sex_ratio)/(sex_ratio + 1),0) AS Females

	FROM
	(SELECT A.district,A.state, A.sex_ratio/1000 AS sex_ratio, B.population 
	FROM projects.dbo.Data_1 AS A
	INNER JOIN projects.dbo.Data_2 AS B
	ON A.district = B.district) C ) D
	GROUP BY D.state

-- Total literacy rate

SELECT D.state, SUM(literate_people) AS Total_literate_population, SUM(illiterate_people) AS Total_illiterate_population
FROM
    (
	SELECT C.district, C.state, ROUND(C.literacy_ratio*C.population, 0) AS literate_people, ROUND((1-C.literacy_ratio)* C.population,0) AS illiterate_people 
    FROM (
	    SELECT A.district, A.state, A.literacy/100 AS literacy_ratio, B.population 
        FROM Projects.dbo.Data_1 AS A
        INNER JOIN Projects.dbo.Data_2 AS B ON A.district = B.district
	) AS C
) AS D
GROUP BY D.state

-- Population in previous censes VS current cencus ( on basis of state)

SELECT D.state, SUM(D.Previous_census_population) AS Total_Previous_Population, SUM(D.current_census_population) AS Total_Current_Population
FROM (
    SELECT C.district, C.state, ROUND(C.population / (1 + C.growth), 0) AS Previous_census_population, ROUND(C.population, 0) AS current_census_population
    FROM (
        SELECT A.district, A.state, A.growth, B.population 
        FROM Projects.dbo.Data_1 AS A 
        INNER JOIN Projects.dbo.Data_2 AS B ON A.district = B.district
    ) C
) D
GROUP BY D.state;

-- Total population in previous cences vs current cencus

SELECT SUM(E.Total_Previous_Population) AS Total_Previous_Population, SUM(E.Total_Current_Population) AS Total_Current_Population
FROM (
    SELECT D.state, 
           SUM(D.Previous_census_population) AS Total_Previous_Population, 
           SUM(D.current_census_population) AS Total_Current_Population
    FROM (
        SELECT C.district, 
               C.state, 
               SUM(ROUND(C.population / (1 + C.growth), 0)) AS Previous_census_population, 
               SUM(ROUND(C.population, 0)) AS current_census_population
        FROM (
            SELECT A.district, 
                   A.state, 
                   A.growth, 
                   B.population 
            FROM Projects.dbo.Data_1 AS A 
            INNER JOIN Projects.dbo.Data_2 AS B ON A.district = B.district
        ) C
        GROUP BY C.district, C.state
    ) D
    GROUP BY D.state
) E;

-- Population vs Area ( ERROR )

SELECT G.total_area / G.previous_census_population AS Previous_Census_Density,
       G.total_area / G.current_census_population AS Current_Census_Density
FROM (
    SELECT q.*, r.total_area
    FROM (
        SELECT '1' AS keyy, N.*
        FROM (
            SELECT SUM(E.Total_Previous_Population) AS Total_Previous_Population,
                   SUM(E.Total_Current_Population) AS Total_Current_Population
            FROM (
                SELECT D.state,
                       SUM(D.Previous_census_population) AS Total_Previous_Population,
                       SUM(D.current_census_population) AS Total_Current_Population
                FROM (
                    SELECT C.district,
                           C.state,
                           SUM(ROUND(C.population / (1 + C.growth), 0)) AS Previous_census_population,
                           SUM(ROUND(C.population, 0)) AS current_census_population
                    FROM (
                        SELECT A.district,
                               A.state,
                               A.growth,
                               B.population
                        FROM Projects.dbo.Data_1 AS A
                        INNER JOIN Projects.dbo.Data_2 AS B ON A.district = B.district
                    ) C
                    GROUP BY C.district, C.state
                ) D
                GROUP BY D.state
            ) E
        ) N
    ) q
    INNER JOIN (
        SELECT '1' AS keyy, z.*
        FROM (
            SELECT SUM(area_km2) total_area
            FROM Projects.dbo.Data_2
        ) z
    ) r ON q.keyy = r.keyy
) G;

-- Top 3 districts from each state which has the higest literacy ratio

SELECT a.* FROM
(SELECT district,state,literacy,rank() OVER(PARTITION by state order by literacy DESC) rnk 
FROM Projects.dbo.Data_1) a
WHERE a.rnk IN (1,2,3) ORDER BY state



select (g.total_area/g.previous_census_population)  as previous_census_population_vs_area, (g.total_area/g.current_census_population) as 
current_census_population_vs_area from
(select q.*,r.total_area from (

select '1' as keyy,n.* from
(select sum(m.previous_census_population) previous_census_population,sum(m.current_census_population) current_census_population from(
select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from Projects.dbo.Data_1 a inner join Projects.dbo.Data_2 b on a.district=b.district) d) e
group by e.state)m) n) q inner join (

select '1' as keyy,z.* from (
select sum(area_km2) total_area from Projects.dbo.Data_2)z) r on q.keyy=r.keyy)g

Projects.dbo.Data_1