--Creating a temporary table to hold the abilities from the csv file--
CREATE TABLE Ability (id INTEGER PRIMARY KEY, ability_name TEXT);

--Inserting values into ability table so that they can be split and trimmed--
INSERT INTO Ability (id, ability_name) SELECT pokedex_number, abilities FROM imported_pokemon_data;

--Inserting unique abilities into the Abilities table utilizing the provided code in section--
CREATE TABLE Abilities AS WITH
--Uses a recursive split function to split the ability_name column into individual rows--
split(id, ability_name, nextability) AS (SELECT id, '' AS ability_name, ability_name||',' AS nextability FROM Ability
--Nextability is each ability_name string with a concatenated ,--
--The union combines the first part with a recursive query that takes the ability_name from nextability--
UNION ALL SELECT id, substr(nextability, 0, instr(nextability, ',')) AS ability_name, substr(nextability, instr(nextability, ',')+1) AS nextability FROM split WHERE nextability !='') SELECT id, ability_name FROM split WHERE ability_name !='' ORDER BY id;
--Last part filters out empty ability rows, sorts by id and the output is a table with unique values in each row associated with an id.

--Dropping the placeholder table that was used to create the final Abilities table--
DROP TABLE Ability;

--Getting rid of the [] from the beginning and end of the strings--
UPDATE Abilities SET ability_name = REPLACE(REPLACE(ability_name, '[', ''), ']', '');
--Getting rid of any leading or trailing whitespace--
UPDATE Abilities SET ability_name = TRIM(ability_name);

--Getting rid of the abilities column--
ALTER TABLE imported_pokemon_data DROP COLUMN abilites;