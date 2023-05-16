DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  userId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fullName VARCHAR(256) NOT NULL,
  username VARCHAR(64) UNIQUE NOT NULL,
  password VARCHAR(512) NOT NULL
);

-- La password de todos los usuarios es iissi
INSERT INTO Users (userId, fullName, username, password) VALUES
	(1, 'Carlos Arévalo', 'carlos', 'pbkdf2:sha256:150000$MjN72ikE$897d960e08be9150d943c747ff6194904fd325821945ff7d7f5c1d1d08b40bbd'),
	(2, 'Margarita Cruz', 'margarita', 'pbkdf2:sha256:150000$MjN72ikE$897d960e08be9150d943c747ff6194904fd325821945ff7d7f5c1d1d08b40bbd'),
	(3, 'David Ruiz', 'david', 'pbkdf2:sha256:150000$MjN72ikE$897d960e08be9150d943c747ff6194904fd325821945ff7d7f5c1d1d08b40bbd'),
  (4, 'Inmaculada Hernández', 'inmaculada', 'pbkdf2:sha256:150000$MjN72ikE$897d960e08be9150d943c747ff6194904fd325821945ff7d7f5c1d1d08b40bbd'),
  (5, 'Daniel Ayala', 'daniel', 'pbkdf2:sha256:150000$MjN72ikE$897d960e08be9150d943c747ff6194904fd325821945ff7d7f5c1d1d08b40bbd');
