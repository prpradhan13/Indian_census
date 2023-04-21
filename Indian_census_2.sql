select * from project1..data1;

select * from project1..data2;

--calculate males and females by District level

--females/males=sex_ratio .....(eq1) , females+males=population ....(eq2) , females=(population-males) ....(eq3)
--(population-males) = (sex_ratio)*males .....(from eq 3 & eq 1)....(eq4)
--from eq 4,  population = males(sex_ratio+1)
--population of males,  males = population/(sex_ratio+1)
--population of females, females = population-population/(sex_ratio+1)
-- =>population(1-1/(sex_ratio+1))
-- =>(population*(sex_ratio))/(sex_ratio+1)

select c.district,c.state,round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0)females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from project1..data1 a inner join project1..data2 b on a.district=b.district)c;

--calculating males and females by State level

select d.state,sum(d.males) total_males,sum(d.females)total_females from
(select c.district,c.state,round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0)females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from project1..data1 a inner join project1..data2 b on a.district=b.district) c) d
group by d.State;

--total literacy rate
--total literacy pepole/population=literacy_ratio
--total literacy people = literacy_ratio*population
--total literacy people = (1-literacy_ratio)*population

select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people, round((1-d.literacy_ratio)*d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from project1..data1 a inner join project1..data2 b on a.district=b.district) d

--total literacy rate by state level
select c.state,sum(literate_people) total_literate,sum(illiterate_people) total_illiterate from
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people, round((1-d.literacy_ratio)*d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from project1..data1 a inner join project1..data2 b on a.district=b.district) d) c
group by c.state;
