
	CREATE TABLE IF NOT EXISTS provincias (
		id INTEGER PRIMARY KEY,
		nombre TEXT NOT NULL
	);
	CREATE UNIQUE INDEX IF NOT EXISTS idx_provincias_nombre
		ON provincias(nombre);

	CREATE TABLE IF NOT EXISTS cantones (
		id INTEGER PRIMARY KEY,
		provincia_id INTEGER NOT NULL REFERENCES provincias(id),
		nombre TEXT NOT NULL
	);
	CREATE INDEX IF NOT EXISTS idx_cantones_nombre
		ON cantones(nombre);

	CREATE TABLE IF NOT EXISTS distritos (
		id INTEGER PRIMARY KEY,
		canton_id INTEGER NOT NULL REFERENCES cantones(id),
		nombre TEXT NOT NULL
	);
	CREATE INDEX IF NOT EXISTS idx_distritos_nombre
		ON distritos(nombre);

	CREATE TABLE IF NOT EXISTS centros (
		id INTEGER PRIMARY KEY,
		distrito_id INTEGER NOT NULL REFERENCES distritos(id),
		nombre TEXT NOT NULL,
		direccion TEXT NOT NULL,
		url TEXT NOT NULL,
		UNIQUE(distrito_id, nombre, direccion)
	);

	CREATE TABLE IF NOT EXISTS juntas (
		id INTEGER PRIMARY KEY,
		centro_id INTEGER NOT NULL REFERENCES centros(id)
	);

	CREATE TABLE IF NOT EXISTS personas (
		id INTEGER PRIMARY KEY,
		cedula TEXT NOT NULL,
		expiracion INTEGER NOT NULL,
		nombre TEXT NOT NULL,
		apellido_1 TEXT NOT NULL,
		apellido_2 TEXT NOT NULL,
		genero INTEGER NOT NULL,
		distrito_id INTEGER NOT NULL REFERENCES distritos(id)
	);
	CREATE UNIQUE INDEX IF NOT EXISTS idx_personas_cedula
		ON personas(cedula);

	CREATE TABLE IF NOT EXISTS padron (
		persona_id INTEGER NOT NULL REFERENCES personas(id),
		junta_id INTEGER NOT NULL REFERENCES juntas(id),
		UNIQUE(persona_id, junta_id)
	);
	CREATE UNIQUE INDEX idx_padron_persona_id
		ON padron(persona_id);
	CREATE INDEX idx_padron_junta_id
		ON padron(junta_id);

