--Creating a table to hold the abilities from the csv file--
CREATE TABLE Ability (id INTEGER PRIMARY KEY, ability_name TEXT);

--Table to store the relationships residing in the abilities column--
CREATE TABLE Pokemon_Ability (pokemon_ref_id INTEGER, ability_id INTEGER, FOREIGN KEY (pokemon_ref_id) REFERENCES imported_pokemon_data (pokedex_number), FOREIGN KEY (ability_id) REFERENCES Ability (id));

--Inserting values into ability table so that they can be split and trimmed--
INSERT INTO Ability (id, ability_name) SELECT pokedex_number, abilities FROM imported_pokemon_data;

--Inserting unique abilities into the table utilizing the provided code in section--
WITH split(id, ability_name, nextability) AS (SELECT id, '' AS ability_name, ability_name||',' AS nextability FROM Ability UNION ALL SELECT id, substr(nextability, 0, instr(nextability, ',')) AS ability_name, substr(nextability, instr(nextability, ',')+1) AS nextability FROM split WHERE nextability !='') SELECT id, ability_name FROM split WHERE ability_name !='' ORDER BY id;



