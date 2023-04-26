--Base stats table that will be associated with the primary key for 3rd NF--
CREATE TABLE Base_Stats (id INTEGER PRIMARY KEY AUTOINCREMENT, pokedex_number INTEGER, attack INTEGER, defense INTEGER, sp_attack INTEGER, sp_defense INTEGER, speed INTEGER, hp INTEGER, FOREIGN KEY (pokedex_number) REFERENCES imported_pokemon_data (pokedex_number));

--Insert values into the table--
INSERT INTO Base_Stats (pokedex_number, attack, defense, sp_attack, sp_defense, speed, hp) SELECT pokedex_number, attack, defense, sp_attack, sp_defense, speed, hp FROM imported_pokemon_data;

--Pokemon Base Stats Table for other stats associated with a primary key--
CREATE TABLE Pokemon_Base_Stats (id INTEGER PRIMARY KEY AUTOINCREMENT, pokedex_number INTEGER, base_total INTEGER, base_egg_steps INTEGER, base_happiness INTEGER, experience_growth INTEGER, FOREIGN KEY (pokedex_number) REFERENCES imported_pokemon_data(pokedex_number));

--Insert values into the table--
INSERT INTO Pokemon_Base_Stats (pokedex_number, base_total, base_egg_steps, base_happiness, experience_growth) SELECT pokedex_number, base_total, base_egg_steps, base_happiness, experience_growth FROM imported_pokemon_data;

--Getting rid of the appropriate columns--
ALTER TABLE imported_pokemon_data DROP COLUMN attack, DROP COLUMN defense, DROP COLUMN sp_attack, DROP COLUMN sp_defense, DROP COLUMN speed, DROP COLUMN hp;

ALTER TABLE imported_pokemon_data DROP COLUMN base_total, DROP COLUMN base_egg_steps, DROP COLUMN base_happiness, DROP COLUMN experience_growth;