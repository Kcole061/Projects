Select *
From [Portfolio Project 1]..CovidDeaths
order by 3,4

--Select *
--From [Portfolio Project 1]..CovidVaccinations
--order by 3,4


Select location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project 1]..CovidDeaths

-- Total Cases vs. Total Deaths
-- Shows the percentage of potential death fron contracting Covid
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From [Portfolio Project 1]..CovidDeaths

--United States Death Percentage
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From [Portfolio Project 1]..CovidDeaths
Where location = 'United States'

--Total Cases vs. Population
--Shows percent of people who have had covid
Select location, date, total_cases, population, (total_cases/population)*100 as Had_Covid_Percentage
From [Portfolio Project 1]..CovidDeaths
Where location = 'United States' 

-- Countries with the highest rate of infection
Select location, population, max(total_cases) as Highest_Infection_Count, max((total_cases/population))*100 as Infected_Population_Percentage
From [Portfolio Project 1]..CovidDeaths
where continent is not null
group by location, population
order by Infected_Population_Percentage desc

-- Countries with the Highest Death count per Population
Select location, max(cast(total_deaths as int)) as Total_Death_Count
From [Portfolio Project 1]..CovidDeaths
where continent is not null
group by location
order by Total_Death_Count desc

-- By Continent
-- Countries with the Highest Death count per Population
Select continent, max(cast(total_deaths as int)) as Total_Death_Count
From [Portfolio Project 1]..CovidDeaths
where continent is not null
group by continent
order by Total_Death_Count desc

--Select location, max(cast(total_deaths as int)) as Total_Death_Count
--From [Portfolio Project 1]..CovidDeaths
--where continent is null
--group by location
--order by Total_Death_Count desc

--Global Numbers

--Daily New Cases
Select date, sum(new_cases) as Daily_New_Cases
from [Portfolio Project 1]..CovidDeaths
where continent is not null 
group by date
order by 1

--Daily New Deaths
Select date, sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths, (sum(cast(new_deaths as int))/sum(new_cases)) * 100 as Death_Percentage
from [Portfolio Project 1]..CovidDeaths
where continent is not null 
group by date
order by 1

-- GLobal Percentage
Select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths, (sum(cast(new_deaths as int))/sum(new_cases)) * 100 as Death_Percentage
from [Portfolio Project 1]..CovidDeaths
where continent is not null 
order by 1


-- Total Population vs. Vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccinated
From [Portfolio Project 1]..CovidDeaths Dea
join [Portfolio Project 1]..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null
order by 2,3



-- CTE

With PopulationvsVaccination (continent, location, date, population, new_vaccinations, Rolling_Vaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccinated
From [Portfolio Project 1]..CovidDeaths Dea
join [Portfolio Project 1]..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null

)
select *, (Rolling_Vaccinated/population)*100
from PopulationvsVaccination

-- Temp Table
drop table if exists #Percent_Population_Vaccinated

create table #Percent_Population_Vaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling_vaccinated numeric
)


Insert into #Percent_Population_Vaccinated

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccinated
From [Portfolio Project 1]..CovidDeaths Dea
join [Portfolio Project 1]..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null


select *, (Rolling_Vaccinated/population)*100
from #Percent_Population_Vaccinated


-- Creating view for visualizations
create view Percent_Population_Vaccinated as

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccinated
From [Portfolio Project 1]..CovidDeaths Dea
join [Portfolio Project 1]..CovidVaccinations Vac
on Dea.location = Vac.location
and Dea.date = Vac.date
where dea.continent is not null

select *
from Percent_Population_Vaccinated