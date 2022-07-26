--one to one (1 person has 1 NI number)
--one to many (1 diet can have many animals)
--many to many (1 animal could have many keepers)


--inner join implies at least a one to one relationship or one to many 

SELECT
A.name,
A.species,
A.age,
D.diet_type 
FROM animals AS A 
INNER JOIN diets AS D ON A.diet_id = D.id
WHERE A.age > 4;

-- count the animals in the zoo that are herbivores

SELECT 
count(A.id), 
A.species, 
D.diet_type 
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id = D.id 
WHERE D.diet_type = 'herbivore'
GROUP BY A.species, D.diet_type

-- left join brings all records from left table and all matching records on the right

SELECT 
A.name, A.age,
A.species, 
D.diet_type 
FROM animals AS A
LEFT JOIN diets AS D ON A.diet_id = D.id;

-- right join is the inverse of the left join 

SELECT 
A.name, A.age,
A.species, 
D.diet_type 
FROM animals AS A
RIGHT JOIN diets AS D ON A.diet_id = D.id;

-- return how animals follwo each diet type, including diets which no animals follow 

SELECT 
count(A.id),  
D.diet_type 
FROM animals AS A
RIGHT JOIN diets AS D ON A.diet_id = D.id
GROUP BY D.diet_type ;

-- return how many animals have a matching diet. including those with no diet 

SELECT 
count(A.id),  
D.diet_type 
FROM animals AS A
LEFT JOIN diets AS D ON A.diet_id = D.id
GROUP BY D.diet_type ;

-- full join brings back records in both tables 

SELECT 
A.name,
A.species,
A.age,
D.diet_type 
FROM animals AS A
FULL JOIN diets AS D ON A.diet_id = D.id;

-- rota for the keeperes and the animals they look AFTER
-- order by animal name and day 

SELECT A.name AS animal_name,
A.species,
CS.DAY,
K.name AS keeper_name
FROM animals AS A
INNER JOIN care_schedule AS CS ON A.id = CS. animal_id
INNER JOIN keepers AS K ON K.id = CS.keeper_id 
ORDER BY CS.DAY, A.name ;

-- show keepers for ernest the snake 

SELECT A.name AS animal_name,
A.species,
K.name AS keeper_name
FROM animals AS A
INNER JOIN care_schedule AS CS ON A.id = CS. animal_id
INNER JOIN keepers AS K ON K.id = CS.keeper_id 
WHERE A.species = 'Snake' 
AND A.name = 'Ernest'
ORDER BY CS.DAY, A.name ;

-- slack task

SELECT
A.name, 
A.species,
T."name",
start_date,
end_date
FROM animals AS A
INNER JOIN animals_tours AS ANT ON A.id = ANT.animal_id 
INNER JOIN tours AS T ON ANT.tour_id = T.id 
ORDER BY T."name", A."name";

-- extended slack test limitng animals to ones only operating on tours ATM

SELECT
A.name, 
A.species,
T."name",
start_date,
end_date
FROM animals AS A
INNER JOIN animals_tours AS ANT ON A.id = ANT.animal_id 
INNER JOIN tours AS T ON ANT.tour_id = T.id 
WHERE ANT.start_date <= NOW()
AND (ANT.end_date >= NOW()
OR ANT.end_date IS NULL )
ORDER BY T."name", A."name";

SELECT 
keepers.name AS keeper_name,
managers.name AS manager_name 
FROM keepers 
INNER JOIN keepers AS managers ON keepers.manager_id = managers.id ;




































