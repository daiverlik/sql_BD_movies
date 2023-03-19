CREATE DATABASE filmBase

CREATE TABLE RatingMPAA (
  id_rating serial2 PRIMARY KEY,
  name varchar(10) NOT NULL
);

CREATE TABLE AgeLimit (
  id_limit serial2 PRIMARY KEY,
  name varchar(5) NOT NULL
);

CREATE TABLE ImageQuality (
  id_quality serial2 PRIMARY KEY,
  name varchar(15) NOT NULL
);

CREATE TABLE FIO (
  id_fio serial PRIMARY KEY,
  surname varchar(80) NOT NULL,
  name varchar(150) NOT NULL,
  patronymic varchar(100)
);

CREATE TABLE Post (
  id_post serial2 PRIMARY KEY,
  name varchar(120) NOT NULL
);

CREATE TABLE Person (
  id_person serial PRIMARY KEY,
  id_fio int,
  id_post int2,
  CONSTRAINT FK_Person_fio
    FOREIGN KEY (id_fio)
      REFERENCES FIO(id_fio),
  CONSTRAINT FK_Person_post
    FOREIGN KEY (id_post)
      REFERENCES Post(id_post)
);

CREATE TABLE Film (
  id_film serial PRIMARY KEY,
  name_film varchar(120) NOT NULL,
  year int NOT NULL CHECK (year >= 1895),
  annotation text,
  slogan text,
  regisseur int,
  scriptwriter int,
  producer int,
  operator int,
  composer int,
  designer int,
  montage int,
  budget int8 NOT NULL CHECK (budget > 0),
  marketing int8,
  fees_at_home int8,
  fees_in_world int8,
  dvd_release date,
  duration int NOT NULL CHECK (duration > 0),
  id_rating int2,
  id_limit int2,
  id_quality int2,
  CONSTRAINT FK_Film_limit
    FOREIGN KEY (id_limit)
      REFERENCES AgeLimit(id_limit),
  CONSTRAINT FK_Film_quality
    FOREIGN KEY (id_quality)
      REFERENCES ImageQuality(id_quality),
  CONSTRAINT FK_Film_rating
    FOREIGN KEY (id_rating)
      REFERENCES RatingMPAA(id_rating),
  CONSTRAINT FK_Film_regisseur
    FOREIGN KEY (regisseur)
      REFERENCES Person(id_person),
  CONSTRAINT FK_Film_scriptwriter
    FOREIGN KEY (scriptwriter)
      REFERENCES Person(id_person),
  CONSTRAINT FK_Film_producer
    FOREIGN KEY (producer)
      REFERENCES Person(id_person),
  CONSTRAINT FK_Film_operator
    FOREIGN KEY (operator)
      REFERENCES Person(id_person),
  CONSTRAINT FK_Film_composer
    FOREIGN KEY (composer)
      REFERENCES Person(id_person),
  CONSTRAINT FK_Film_designer
    FOREIGN KEY (designer)
      REFERENCES Person(id_person),
  CONSTRAINT FK_Film_montage
    FOREIGN KEY (montage)
      REFERENCES Person(id_person)
);

CREATE TABLE Country (
  id_country serial PRIMARY KEY,
  name_country varchar(100) NOT NULL,
  id_film int,
  CONSTRAINT FK_Country_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE Reward (
  id_reward serial2 PRIMARY KEY,
  name varchar(50) NOT NULL,
  id_film int,
  CONSTRAINT FK_Reward_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE Actor (
  id_actor serial PRIMARY KEY,
  id_fio int,
  CONSTRAINT FK_Actor_fio
    FOREIGN KEY (id_fio)
      REFERENCES FIO(id_fio)
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
  CONSTRAINT FK_ActorDoubler_actor
    FOREIGN KEY (id_actor)
      REFERENCES Actor(id_actor),
  CONSTRAINT FK_ActorDoubler_doubler
    FOREIGN KEY (id_doubler)
      REFERENCES Doubler(id_doubler),
  CONSTRAINT FK_ActorDoubler_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE Viewer (
  id_viewer serial PRIMARY KEY,
  name_country varchar(100),
  count int8 NOT NULL,
  id_film int,
  CONSTRAINT FK_Viewer_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE Genre (
  id_genre serial PRIMARY KEY,
  name varchar(60) NOT NULL,
  id_film int,
  CONSTRAINT FK_Genre_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE AudioTrack (
  id_audio serial2 PRIMARY KEY,
  language varchar(100) NOT NULL,
  id_film int,
  CONSTRAINT FK_AudioTrack_film
    FOREIGN KEY (id_film)
      REFERENCES Film(id_film)
);

CREATE TABLE Subtitles (
  id_subtitles serial PRIMARY KEY,
  language varchar(100) NOT NULL,
  id_film int,
  CONSTRAINT FK_Subtitles_film
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

