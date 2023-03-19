CREATE DATABASE filmBase

CREATE TABLE RatingMPAA (
  id_rating serial2 PRIMARY KEY,
  name varchar(10) NOT NULL
);

CREATE TABLE Country (
  id_country serial PRIMARY KEY,
  name varchar(100) NOT NULL
);

CREATE TABLE Reward (
  id_reward serial2 PRIMARY KEY,
  name varchar(50) NOT NULL
);

CREATE TABLE ImageQuality (
  id_quality serial2 PRIMARY KEY,
  name varchar(15) NOT NULL
);

CREATE TABLE AgeLimit (
  id_limit serial2 PRIMARY KEY,
  name varchar(5) NOT NULL
);

CREATE TABLE Film (
  id_film serial PRIMARY KEY,
  name_film varchar(120) NOT NULL,
  year int NOT NULL CHECK (year >= 1895),
  anotation text,
  slogan text,
  budget int8 NOT NULL CHECK (budget > 0),
  marketing int8,
  fees_at_home int8,
  fees_in_world int8,
  dvd_release date,
  duration int NOT NULL CHECK (duration > 0),
  id_rating int2,
  id_limit int2,
  id_quality int2,
  CONSTRAINT FK_Film_quality
    FOREIGN KEY (id_quality)
      REFERENCES ImageQuality(id_quality),
  CONSTRAINT FK_Film_rating
    FOREIGN KEY (id_rating)
      REFERENCES RatingMPAA(id_rating),
  CONSTRAINT FK_Film_limit
    FOREIGN KEY (id_limit)
      REFERENCES AgeLimit(id_limit)
);

CREATE TABLE Genre (
  id_genre serial PRIMARY KEY,
  name varchar(60) NOT NULL
);

CREATE TABLE FilmGenre (
  id_filmGenre serial PRIMARY KEY,
  id_film int,
  id_genre int,
  CONSTRAINT FK_FilmGenre_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film),
  CONSTRAINT FK_FilmGenre_genre
    FOREIGN KEY (id_genre)
      REFERENCES Genre(id_genre)
);

CREATE TABLE FIO (
  id_fio serial PRIMARY KEY,
  surname varchar(80) NOT NULL,
  name varchar(150) NOT NULL,
  patronymic varchar(100)
);

CREATE TABLE Actor (
  id_actor serial PRIMARY KEY,
  id_fio int,
  CONSTRAINT FK_Actor_fio
    FOREIGN KEY (id_fio)
      REFERENCES FIO(id_fio)
);

CREATE TABLE Language (
  id_language serial2 PRIMARY KEY,
  name varchar(100) NOT NULL
);

CREATE TABLE Person (
  id_person serial PRIMARY KEY,
  id_fio int,
  CONSTRAINT FK_Person_fio
    FOREIGN KEY (id_fio)
      REFERENCES FIO(id_fio)
);

CREATE TABLE Post (
  id_post serial2 PRIMARY KEY,
  name varchar(120) NOT NULL
);

CREATE TABLE FilmPerson (
  id_film_person serial PRIMARY KEY,
  id_film int,
  id_person int,
  id_post int2,
  CONSTRAINT FK_FilmPerson_person
    FOREIGN KEY (id_person)
      REFERENCES Person(id_person),
  CONSTRAINT FK_FilmPerson_post
    FOREIGN KEY (id_post)
      REFERENCES Post(id_post),
  CONSTRAINT FK_FilmPerson_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE Nominations (
  id_nominations serial2 PRIMARY KEY,
  name varchar(100) NOT NULL,
  id_reward int2, 
  CONSTRAINT FK_Nominations_reward
    FOREIGN KEY (id_reward)
      REFERENCES Reward(id_reward)
);

CREATE TABLE Viewer (
  id_viewer serial PRIMARY KEY,
  count_viewers int8 NOT NULL CHECK (count >= 0),
  id_film int,
  id_country int,
  CONSTRAINT FK_Viewer_country
    FOREIGN KEY (id_country)
      REFERENCES Country(id_country),
  CONSTRAINT FK_Viewer_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE FilmReward (
  id_filmReward serial PRIMARY KEY,
  id_film int,
  id_reward int2,
  CONSTRAINT FK_FilmReward_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film),
  CONSTRAINT FK_FilmReward_reward
    FOREIGN KEY (id_reward)
      REFERENCES Reward(id_reward)
);

CREATE TABLE AudioTrack (
  id_audio serial2 PRIMARY KEY,
  id_film int,
  id_language int2,
  CONSTRAINT FK_AudioTrack_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film),
  CONSTRAINT FK_AudioTrack_language
    FOREIGN KEY (id_language)
      REFERENCES Language(id_language)
);

CREATE TABLE Subtitles (
  id_subtitles serial PRIMARY KEY,
  id_film int,
  id_language int2,
  CONSTRAINT FK_Subtitles_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film),
  CONSTRAINT FK_Subtitles_language
    FOREIGN KEY (id_language)
      REFERENCES Language(id_language)
);

CREATE TABLE Doubler (
  id_doubler serial PRIMARY KEY,
  id_fio int,
  CONSTRAINT FK_Doubler_fio
    FOREIGN KEY (id_fio)
      REFERENCES FIO(id_fio)
);

CREATE TABLE ActorDoubler (
  id_actor_doubler serial PRIMARY KEY,
  id_film int,
  id_actor int,
  id_doubler int,
  CONSTRAINT FK_ActorDoubler_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film),
  CONSTRAINT FK_ActorDoubler_actor
    FOREIGN KEY (id_actor)
      REFERENCES Actor(id_actor),
  CONSTRAINT FK_ActorDoubler_doubler
    FOREIGN KEY (id_doubler)
      REFERENCES Doubler(id_doubler)
);

CREATE TABLE FilmCountry (
  id_film_country serial PRIMARY KEY,
  id_film int,
  id_country int,
  CONSTRAINT FK_FilmCountry_country
    FOREIGN KEY (id_country)
      REFERENCES Country(id_country),
  CONSTRAINT FK_FilmCountry_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

