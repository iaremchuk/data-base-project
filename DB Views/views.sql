--horizontal  
create view compositions_rock_hv
as
select * 
from "public.Compositions"
where "GenreID" = 4;

select * from compositions_rock_hv


--vertical
create view compositions_name_date_vv
as
select "Title" 
, "Year" 
from "public.Compositions"

select * from compositions_name_date_vv


--mixed
create view compositions_name_rock_jazz_mixed
as
select "Title" 
, "GenreID"  
from "public.Compositions"
where "GenreID" in (4, 3)

select * from compositions_name_rock_jazz_mixed


--with joining
create view compositions_name_with_genres_joining(composition_name, composition_genre)
as 
select pc."Title" 
, pg."GenreName" 
from "public.Compositions" pc, "public.Genres" pg 

select * from compositions_name_with_genres_joining


--with subquery
create view user_compositions_count_subquery
as
select  pu."FirstName" || ' ' ||  pu."LastName" as user 
, (
select count(pca."CompositionID")
from "public.CompositionAuthors" pca  
where pu."UserID" = pca."UserID" 
) as number_of_compositions
from "public.Users" pu 

select * from user_compositions_count_subquery


--with the union
create view genres_savefileformats_union
as
select pg."GenreID" as id
, pg."GenreName" as name
from "public.Genres" pg 
union
select psff."SaveFileFormatID" 
, psff."SaveFileFormatName" 
from "public.SaveFileFormats" psff 
order by 1

select * from genres_savefileformats_union



--view on the select from another one view
create view compositions_genres
as
select pc."Title"
, pg."GenreName" 
from "public.Compositions" pc inner join "public.Genres" pg 
on pc."GenreID" = pg."GenreID"
order by 1

select * from compositions_genres

create view compositions_blues
as
select "Title"
, "GenreName"
from compositions_genres
where "GenreName" like 'Bl%'

select * from compositions_blues



--view with check option
create view compositions_2022
as
select pc."Title" as compositions
, extract (year from pc."Year") as year
from "public.Compositions" pc 
where pc."Year" > '2021-12-31' and pc."Year" < '2023-01-01'
with check option

select * from compositions_2022