-- sélectionner tous les albums
SELECT * FROM albums ; 
-- sélectionner les titres avec "Great" dans la colonne title de la table albums 
SELECT Title FROM albums 
WHERE Title LIKE '%Great%';
-- donner le nombre total d'albums contenus dans la base 
SELECT COUNT(*) FROM albums ; 
-- supprimer les noms d'albums contenant 'music' 
-- d'abord on supprime la sécurité sur les clés étrangères 
PRAGMA foreign_keys = OFF;
DELETE FROM albums WHERE Title LIKE '%music%' ;
PRAGMA foreign_keys = ON ;
-- Récupérer tous les albums écrits par AC/DC
-- implique ici de lier les tables albums et artistes, par INNER JOIN 
-- on lie l'autre tableau ON l'ancien et on précise quelle est la clé étrangère commune 
SELECT * FROM albums 
INNER JOIN artists ON albums.ArtistId = artists.ArtistId 
WHERE artists.Name LIKE '%AC/DC%';
-- Récupérer tous les titres des albums de AC/DC
-- ici aussi implique de lier les tables albums et artistes, par INNER JOIN 
-- on lie l'autre tableau ON l'ancien et on précise quelle est la clé étrangère commune 
SELECT Title FROM albums 
INNER JOIN artists ON albums.ArtistId = artists.ArtistId 
WHERE artists.Name LIKE '%AC/DC%';
-- Récupérer la liste des titres de l'album "Let There Be Rock"
SELECT * FROM tracks 
INNER JOIN albums ON tracks.AlbumId = albums.AlbumId 
WHERE albums.Title LIKE 'Let There Be Rock' ;
-- Afficher le prix de cet album ainsi que sa durée totale
-- il faut ici lancer deux requêtes en une 
-- cela implique de créer un tableau avec des noms de colonnes provisoires 
-- heureusement ici tout provient de la même jointure de tableau 
-- donc la suite peut être écrite une seule fois 
SELECT 
    SUM(UnitPrice) as TotalPrice, 
    SUM(Milliseconds) as TotalDuration
FROM tracks  
INNER JOIN albums ON tracks.AlbumId = albums.AlbumId
WHERE albums.Title LIKE 'Let There Be Rock';
-- Afficher le coût de l'intégralité de la discographie de "Deep Purple"
SELECT SUM(UnitPrice) FROM tracks INNER JOIN albums ON tracks.AlbumId = albums.AlbumId INNER JOIN artists ON albums.ArtistId = artists.ArtistId WHERE artists.Name = 'Deep Purple'; 
-- Créer l'album de ton artiste favori en base, en renseignant correctement les trois tables albums, artists et tracks
INSERT INTO artists (Name) Values ('Blood Command');
INSERT INTO albums (Title, ArtistId) Values ('Funeral Beach', (SELECT ArtistId FROM artists WHERE Name = 'Blood Command'));  
INSERT INTO tracks (Name, AlbumId) VALUES ('Pissed off and slightly offended', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('March of the Swan Elite', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Cult of the New Beat', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Death to all bus Us!', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Wolves at the Door', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('High Five for Life', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Here Next to Murderous', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')),('True North', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Corpse Reviver', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Oceans Inside Neptune', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')), ('Funeral Beach', (SELECT AlbumId FROM albums WHERE Title = 'Funeral Beach')); 
-- 









