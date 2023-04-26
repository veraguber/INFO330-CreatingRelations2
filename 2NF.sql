--Table to store the relationships residing in the abilities column--
CREATE TABLE Pokemon_Ability (pokemon_ref_id INTEGER, ability_id INTEGER, FOREIGN KEY (pokemon_ref_id) REFERENCES imported_pokemon_data (pokedex_number), FOREIGN KEY (ability_id) REFERENCES Ability (id));

--Table with type is created which has an autoincrementing id and the type name which will be unique type names extracted from type1 and type2--
CREATE TABLE Type (pokemon_id INTEGER, type_name VARCHAR(20) NOT NULL, FOREIGN KEY (pokemon_id) REFERENCES imported_pokemon_data (pokedex_number));

--Inserting data into the type table--
INSERT INTO TYPE(pokemon_id) SELECT pokedex_number FROM imported_pokemon_data;
INSERT INTO Type(type_name) SELECT DISTINCT type1 FROM imported_pokemon_data UNION SELECT DISTINCT type2 FROM imported_pokemon_data WHERE pokemon_id == pokedex_number;
--There is now an id associated with every type seen in the csv file, some may not have an id since not every type has an associated value--

--Need a table to represent the many-to-many relationship in the types which is represented below:--
CREATE TABLE Pokemon_Type (pokemon_dex_id INTEGER, type_id INTEGER, PRIMARY KEY (pokemon_dex_id, type_id), FOREIGN KEY (pokemon_dex_id) REFERENCES imported_pokemon_data(pokedex_number), FOREIGN KEY (type_id) REFERENCES Type(pokemon_id));

--Inserting data into the pokemon type table--
INSERT INTO OR IGNORE Pokemon_Type (pokemon_dex_id, type_id) SELECT p.pokedex_number, t.pokemon_id FROM imported_pokemon_data AS p JOIN Type AS t ON p.type1 = t.type_name OR p.type2 = t.type_name;

ALTER TABLE imported_pokemon_data DROP COLUMN type1;
ALTER TABLE imported_pokemon_data DROP COLUMN type2;
