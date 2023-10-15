![naveed-ahmed-9Dt4WutvwDs-unsplash (1)](https://github.com/Md-Kaif-Tahir/Indian-Census-SQL/assets/110182266/29c5af94-7745-4d70-ae8f-94757556c78b)

# Indian Census Data Exploration 🌏📊
***Embarking on a Data Odyssey through SQL Queries***

## Author 🚀
- Say hello to [@Mohammad Kaif Tahir](https://github.com/Md-Kaif-Tahir) 👋

## Table of Contents 🗺️
- [Unveiling the Project](#project-overview)
- [Dive into the Dataset](#about-the-dataset)
- [Questions, Insights, and Code](#queries,-reasons,-and-code)

## Project Overview 🚀
Ready for a data rollercoaster? Join me in decoding the **2011 Indian Census dataset**, a treasure trove crafted by the ingenious [@Mohammad Kaif Tahir](https://github.com/Md-Kaif-Tahir). Picture this: two tables, one revealing demographic tales—**districts**, **states**, **sex ratios**, **population growth ballets**, and **literacy rate sonnets**. The other, an atlas, painting **district landscapes**, **state symphonies**, **area brushstrokes**, and **population count crescendos**. 🎨✨

Our data maestro scripted a series of questions, each a compass pointing to a different facet of the data realm—**population trends** and **characteristic constellations**. Let's embark on this voyage to uncover the rhythmic beats of **demographic patterns** and the dance of **regional dynamics**. 💃🕺

## About The Dataset 📚
[**Indian Census 2011 Dataset**](https://www.kaggle.com/datasets/mohammadkaiftahir/indian-census) <br>

**Dataset 1: Demographic Kaleidoscope**
| **Column**      | **Description**                                           |
|-------------|-------------------------------------------------------|
| **District**    | District's name, a narrative within India.               |
| **State**       | Statehood affiliation of the district.             |
| **Growth**      | District's population growth rhythm.         |
| **Sex_Ratio**   | Balancing act: males to females in the population.    |
| **Literacy**    | The script of literacy etched in the district's narrative.      |

**Dataset 2: Geographic Canvas**
| **Column**      | **Description**                                           |
|-------------|-------------------------------------------------------|
| **District**    | The district's prose within India.               |
| **State**       | The state anthem sung by the district.             |
| **Area_km2**    | The canvas painted, district's area in square kilometers.|
| **Population**  | The population saga, the district's count.               |

Feeling the excitement? SQL is our dance partner—let's tango through the questions and let the data tell its story. 💃🔍

## Queries, Reasons, and Code
- **Calculation of total number of rows in both the dataset.** <br>

  - **Reason:** Verifying the number of rows in an SQL dataset is crucial as it offers an essential measure of data volume and completeness. This information helps ensure data integrity, aids in identifying potential data discrepancies, and       provides a fundamental understanding of the dataset's scale and scope. <br>
  
  - **Code:**
    ```sql
    SELECT COUNT(*) FROM dataset1
    SELECT COUNT(*) FROM dataset2
    ```
    
  - **Finding:** Both the dataset has exactly **640 rows** of data.<br>

- **Finding the population of India.** <br>

  - **Reason:** Before we proceed with the in-depth analysis of the Indian Census 2011 data, it's essential to establish the total population figure that our analysis encompasses. The analysis utilized Dataset2 because it contained the necessary information to determine the population of each district. <br>
  
  - **Code:**
    ```sql
    SELECT SUM(population) population FROM dataset2;
    ```
    
  - **Finding:** The sum of the population of every district is, **1210854977**.<br>

- **Average growth percentage of India.** <br>

  - **Reason:** Calculating the average growth percentage of India aids in comprehending the pace of the country's overall population expansion. This information assists in estimating future population sizes after a specific number of years, enabling informed projections and planning. <br>
  
  - **Code:**
    ```sql
    SELECT AVG(growth) AverageGrowth FROM dataset1;
    ```
    
  - **Finding:** The average rate of growth of India’s population is **19.24%.** <br>

- **Average growth percentage state-wise and also display the top 3.** <br>

  - **Reason:** In dataset1, the growth percentage is presented on a district level, offering a detailed perspective of the data. However, for a broader understanding and to formulate more effective strategies, a more comprehensive overview might be more beneficial. Zooming out to view the data on a larger scale could provide a clearer insight into the trends and help in identifying actionable steps. <br>
  
  - **Code:**
    ```sql
    SELECT state, AVG(growth) AS AvgStatesGrowth FROM dataset1 
    GROUP BY state
    ORDER BY AvgStatesGrowth DESC;
    
    SELECT state, AVG(growth) AS AvgStatesGrowth FROM dataset1 
    GROUP BY state
    ORDER BY AvgStatesGrowth DESC
    LIMIT 3;
    ```
    
  - **Finding:** Highest growth% state is **Nagaland**, followed by **Dadra**, and **Daman** with **82.28%, 55.88%,** and **42.74%** respectively.<br>

- **Average sex ratio of different states and find the worst 3 performers.** <br>

  - **Reason:** Determining the average gender distribution across various states can aid in tailoring product offerings to suit specific regional demographics. This approach ensures that products are aligned with the preferences of different states' populations, enhancing the potential for successful market penetration. <br>
  
  - **Code:**
    ```sql
    SELECT state, ROUND(AVG(sex_ratio)) AS sex_ratio FROM dataset1 
    GROUP BY state
    ORDER BY sex_ratio DESC;
    
    SELECT state, ROUND(AVG(sex_ratio)) AS sex_ratio FROM dataset1 
    GROUP BY state
    ORDER BY sex_ratio ASC
    LIMIT 3;
    ```
    
  - **Finding:** The highest ratio is of **Kerala****’s** with **1080 Females per 1000 Males**. The worst performers are **Dadra**, **Daman** and **Chandigarh**.<br>

- **Literacy rate of different states and also states with greater than 90%.** <br>

  - **Reason:** The literacy rate serves as a significant parameter for determining the most effective marketing approach. This factor ensures that marketing materials resonate better with the audience by considering their level of understanding and engagement. <br>
  
  - **Code:**
    ```sql
    SELECT state, ROUND(AVG(literacy)) AS literacy_rate FROM dataset1 
    GROUP BY state
    ORDER BY literacy_rate DESC;
    
    SELECT state, ROUND(AVG(literacy)) AS literacy_rate 
    FROM dataset1 
    GROUP BY state
    HAVING ROUND(AVG(literacy)) > 90
    ORDER BY literacy_rate DESC
    ```
    
  - **Finding:** **Kerala** again comes on the top with the highest literacy rate in India, with **94%**, followed by **Lakshadweep** with **92%**.<br>

- **Top and bottom 3 states in literacy rates.** <br>

  - **Reason:** Finding the extreme edges helps us in understanding the spread of the data that we are dealing with. <br>
  
  - **Code:**
    ```sql
    /* Method 1 */
    (SELECT state, ROUND(AVG(literacy)) AS literacy_rate 
    FROM dataset1 
    GROUP BY state
    ORDER BY literacy_rate ASC
    LIMIT 3)
    UNION
    (SELECT state, ROUND(AVG(literacy)) AS literacy_rate 
    FROM dataset1 
    GROUP BY state
    ORDER BY literacy_rate DESC
    LIMIT 3)
    ORDER BY literacy_rate DESC
    ```
    ```sql
    /*Method 2*/
    WITH literacy_cte AS (
        SELECT state, ROUND(AVG(literacy)) AS literacy_rate
        FROM dataset1
        GROUP BY state
    )
    SELECT state, literacy_rate
    FROM (
        SELECT state, literacy_rate
        FROM literacy_cte
        ORDER BY literacy_rate ASC
        LIMIT 3
        ) AS lower_literacy
    UNION ALL
    SELECT state, literacy_rate
    FROM (
        SELECT state, literacy_rate
        FROM literacy_cte
        ORDER BY literacy_rate DESC
        LIMIT 3
        ) AS higher_literacy
    ORDER BY literacy_rate DESC;
    ```
    
  - **Finding:** The ***top 3*** are, **Kerala, Lakshadweep** and **Mizoram** with **94%, 92%, 89%,** respectively, and the **bottom 3** are **Rajasthan, Arunachal Pradesh**, and **Bihar** with **65%, 64%** and **62%** respectively.<br>

- **States starting with a letter ‘A’ or ‘B’.** <br>

  - **Reason:** This question helps to display the power of **LIKE function**. <br>
  
  - **Code:**
    ```sql
    SELECT DISTINCT state FROM dataset1 
    WHERE LOWER(state) LIKE 'a%' OR LOWER(state) LIKE 'b%'
    ```
    
  - **Finding:** States that starts with the letter _‘A’_ are, **Andaman and Nicobar Islands, Andhra Pradesh, Arunachal Pradesh, Assam**. For letter _‘B’_ is only **Bihar**.<br>

- **Calculate the number of males and females.** <br>

  - **Reason:** In our earlier analysis, we focused solely on calculating the average sex ratio, which provided a percentage-based perspective. However, this approach didn't offer a detailed understanding of the actual male and female populations in different states. To address this limitation, I've now incorporated the real male and female population figures for each state, allowing for a more comprehensive and accurate assessment. <br>
  
  - **Code:**
    ```sql
    /* Males = population/(sex_ratio+1)
       Females = population*(sex_ratio)/(sex_ratio+1) */
    SELECT c.state, SUM(ROUND(c.population/(c.sex_ratio+1))) AS male, SUM(ROUND(c.population*(c.sex_ratio)/(c.sex_ratio+1))) AS female
    FROM
    (SELECT d1.district, d1.state, d1.sex_ratio/1000 as sex_ratio,  d2.population
    FROM dataset1 AS d1
    INNER JOIN dataset2 AS d2
    ON d1.district=d2.district) AS c
    GROUP BY state
    ```
    
  - **Finding:** ***State Wise Gender Distribution***
  ![banner](Assets/StateWiseGenderDistribution.png)

- **Actual population in previous census and in current census.** <br>

  - **Reason:** The difference in values will help us understand at which pace the population is growing at. To calculate the previous census, I have subtracted the growth percentage from the current census data. <br>
  
  - **Code:**
    ```sql
    SELECT	i.state, ROUND(((i.current_population))/(1+(i.states_growth/100))) AS previous_population, i.current_population
    FROM
    	(SELECT d1.state,
           (SUM(d1.growth)) / (COUNT(d1.growth)) AS states_growth,
            SUM(d2.population) AS current_population
    		FROM dataset1 AS d1
    		INNER JOIN dataset2 AS d2 ON d1.state = d2.state
    		GROUP BY d1.state 
    		ORDER BY d1.state) AS i
    ORDER BY i.state ASC;
    ```
    
  - **Finding:** ***State Wise Population Change***
  ![banner](Assets/StateWiseGenderDistribution.png)

- **How the change in population influenced the area km2 of the population.** <br>

  - **Reason:** As the country's population grows, the available land area per person is likely to decrease. This could lead to a more condensed living space, potentially resulting in the construction of skyscrapers and tall buildings to accommodate the increasing population within limited land resources. <br>
  
  - **Code:**
    ```sql
    SELECT 
        (g.total_area / g.previous_census_population) AS previous_census_population_vs_area, 
        (g.total_area / g.current_census_population) AS current_census_population_vs_area 
    FROM (
        SELECT q.*, r.total_area 
        FROM (
            SELECT '1' AS keyy, n.* 
            FROM (
                SELECT 
                    SUM(m.previous_census_population) AS previous_census_population, 
                    SUM(m.current_census_population) AS current_census_population 
                FROM (
                    SELECT e.state,
                        SUM(e.previous_census_population) AS previous_census_population,
                        SUM(e.current_census_population) AS current_census_population 
                    FROM (
                        SELECT d.district, d.state, ROUND(d.population / (1 + d.growth)) AS previous_census_population, d.population AS current_census_population 
                        FROM (
                            SELECT a.district, a.state, a.growth, b.population 
                            FROM dataset1 a 
                            INNER JOIN dataset2 b ON a.district = b.district
                        ) d
                    ) e
                    GROUP BY e.state
                ) m
            ) n
        ) q 
        INNER JOIN (
            SELECT '1' AS keyy, z.* 
            FROM (
                SELECT SUM(area_km2) AS total_area 
                FROM dataset2
            ) z
        ) r ON q.keyy = r.keyy
    ) g;
    ```
    
  - **Finding:**
    |**Area km2 (Previous Census)**|	**Area km2 (Current Census)**|
    |-----------------------------|--------------------------|
    |  0.04806182205366204       |	  0.0026745920896968024  |

- **Calculate the top 3 districts with highest literacy rates from each district.** <br>

  - **Reason:** The primary objective of this calculation is to showcase the effectiveness of window functions in SQL. These functions simplify complex coding tasks by allowing us to achieve significant results through straightforward steps. <br>
  
  - **Code:**
    ```sql
    SELECT a.* FROM
    	(SELECT district, state, literacy, RANK() OVER(PARTITION BY state 
    	 ORDER BY literacy DESC) AS rnk FROM dataset1) AS a
    WHERE a.rnk in (1,2,3) ORDER BY state
    ```

    - **Finding:** ***Top 3 Districts with Highest Literacy Rates***
  ![banner](Assets/Top3DistrictsLiteracy.png)

## The Saga Unfolds 📖

As we journey through the SQL queries, the data paints a vivid narrative of India's diverse landscapes, revealing stories of growth, gender dynamics, literacy, and more. 🌐✨

- **Rows in the Dataset:** With exactly 640 rows in both datasets, our canvas is detailed and expansive. Every row holds a piece of the intricate mosaic that is the Indian Census data. 🧩

- **India's Population Dance:** The heartbeat of our analysis—India's population stands at a staggering 1,210,854,977. Each number is a life, a story, and a chapter in the evolving tale of the nation. 🇮🇳💖

- **Average Growth Tempo:** India's pulse beats at an average growth rate of 19.24%. A rhythm that shapes the future, influencing plans and strategies for the years to come. 📈🌱

- **State Spotlight:** Nagaland takes the lead in growth, while Kerala shines with a sex ratio of 1080 females for every 1000 males. Diverse, vibrant, and full of contrasts. 🌏💃

- **Literacy Symphony:** Kerala once again emerges as the literary maestro, orchestrating a 94% literacy rate. Lakshadweep follows closely, a testament to the power of education in shaping minds. 📚🎓

- **Extreme Literacy Edges:** Rajasthan, Arunachal Pradesh, and Bihar grapple with lower literacy rates, reminding us of the challenges that echo in the diversity of India's educational landscape. 📉🎭

- **States in the Limelight:** From the Andaman and Nicobar Islands to Bihar, states starting with 'A' and 'B' paint a vibrant palette, each contributing a unique hue to India's identity. 🌈🎨

- **Gender Ballet:** The dance of population reflects in the gender distribution. States like Dadra, Daman, and Chandigarh face challenges, emphasizing the need for balance and equality. 👫⚖️

- **Census Time Travel:** Comparing past and present, we witness the evolving tapestry of population and area. A story of change, growth, and the intricate relationship between land and people. 🔄📊

- **Literacy Heights:** The top 3 districts in literacy rates from each state emerge as beacons of education. A testament to the collective effort to illuminate minds across the nation. 🏫✨

## Closing the Chapter 🌅

Our exploration through the Indian Census data is a testament to the power of data storytelling. Each query unveils a layer, each insight adds a stroke, and together they form a masterpiece—a reflection of a nation's past, present, and potential future. As we close this chapter, the data remains an open book, inviting curious minds to delve deeper, ask more questions, and continue the saga of exploration. 📖🚀
