select * from project1.dbo.data1;

select * from project1.dbo.data2;

--no of rows in our tables
select count(*) from project1.dbo.data1;
select count(*) from project1.dbo.data2;

--dataset for jharkhand and bihar
select * from project1..data1
where state in('jharkhand','bihar');

--population of India
select sum(Population) as Total_population
from project1..data2;

--what is the avrage groth of India
select avg(growth)*100 avg_growth
from project1.dbo.data1;

--avg growth of every state
select state,avg(growth)*100 avg_growth 
from project1.dbo.data1 
group by state;

--avg sex ratio of India
select avg(sex_ratio) avg_sex_ratio 
from project1.dbo.data1;

--avg sex_ratio of every state
select state,round(avg(sex_ratio),0) avg_sex_ratio 
from project1.dbo.data1 
group by state
order by avg_sex_ratio desc;

--avg literacy rate
select state,round(avg(literacy),2) avg_literacy
from project1.dbo.data1 
group by state 
having(round(avg(literacy),2))>90
order by avg_literacy desc;

--top 3 state showing highest growth ratio
select top 3 state,avg(growth)*100 avg_growth 
from project1.dbo.data1 
group by state
order by avg_growth desc;

--bottom 3 states showing lowest sex ratio
select top 3 state,avg(sex_ratio) avg_sex_ratio
from project1.dbo.data1
group by state 
order by avg_sex_ratio asc;

--top and bottom 3 states in literacy state
drop table if exists #topstates
create table #topstates
(
   state nvarchar(255),
   topstates float
)
insert into #topstates
select state,avg(Literacy) avg_literacy_ratio
from project1.dbo.data1
group by state 
order by avg_literacy_ratio desc;

select top 3 * 
from #topstates 
order by #topstates.topstates desc;


drop table if exists #bottomstates
create table #bottomstates
(
   state nvarchar(255),
   bottomstates float
)
insert into #bottomstates
select state,avg(Literacy) avg_literacy_ratio
from project1.dbo.data1
group by state 
order by avg_literacy_ratio desc;

select top 3 * 
from #bottomstates 
order by #bottomstates.bottomstates asc;

--using union operater to combine thes two
select * from(
select top 3 * 
from #topstates 
order by #topstates.topstates desc) a

union

select * from(
select top 3 * 
from #bottomstates 
order by #bottomstates.bottomstates asc) b;

--states starting with letter A and B
select distinct state from project1..data1 where lower(state) like 'a%' or lower(state) like 'b%';

--states start with A or ending with D
select distinct state from project1..data1 where lower(state) like 'a%' or lower(state) like '%d';