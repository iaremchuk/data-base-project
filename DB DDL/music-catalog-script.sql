
CREATE TABLE "public.Compositions" (
	"CompositionID" serial NOT NULL,
	"Title" varchar(100) NOT NULL,
	"GenreID" integer NOT NULL,
	"Year" smallint NOT NULL,
	"SaveFileFormatID" integer NOT NULL,
	"Text" varchar(1000),
	"Music" varchar(300) NOT NULL,
	"AvailableTo" varchar(30) NOT NULL,
	CONSTRAINT "Compositions_pk" PRIMARY KEY ("CompositionID")
) WITH (
  OIDS=FALSE
)

CREATE TABLE "public.Users" (
	"UserID" serial NOT NULL,
	"LastName" varchar(100) NOT NULL,
	"FirstName" varchar(100) NOT NULL,
	"Email" varchar(100) NOT NULL,
	"Phone" char(20) NOT NULL,
	"Password" varchar(255) NOT NULL,
	CONSTRAINT "Users_pk" PRIMARY KEY ("UserID")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.Comments" (
	"CommentID" serial NOT NULL,
	"UserID" integer NOT NULL,
	"CompositionID" integer NOT NULL,
	"Text" varchar(5000) NOT NULL,
	"Date" DATE NOT NULL,
	"ParentCommentID" integer NOT NULL,
	CONSTRAINT "Comments_pk" PRIMARY KEY ("CommentID")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.CompositionAuthors" (
	"CompositionID" integer NOT NULL,
	"UserID" integer NOT NULL,
	CONSTRAINT "CompositionAuthors_pk" PRIMARY KEY ("CompositionID","UserID")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.Genres" (
	"GenreID" serial NOT NULL,
	"GenreName" varchar(50) NOT NULL,
	CONSTRAINT "Genres_pk" PRIMARY KEY ("GenreID")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.SaveFileFormats" (
	"SaveFileFormatID" serial NOT NULL,
	"SaveFileFormatName" varchar(50) NOT NULL,
	CONSTRAINT "SaveFileFormats_pk" PRIMARY KEY ("SaveFileFormatID")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.Tags" (
	"TagID" serial NOT NULL,
	"TagName" varchar(50) NOT NULL,
	CONSTRAINT "Tags_pk" PRIMARY KEY ("TagID")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.CompositionTags" (
	"CompositionID" integer NOT NULL,
	"TagID" integer NOT NULL,
	CONSTRAINT "CompositionTags_pk" PRIMARY KEY ("CompositionID","TagID")
) WITH (
  OIDS=FALSE
);


ALTER TABLE "Compositions" ADD CONSTRAINT "Compositions_fk0" FOREIGN KEY ("GenreID") REFERENCES "Genres"("GenreID");
ALTER TABLE "Compositions" ADD CONSTRAINT "Compositions_fk1" FOREIGN KEY ("SaveFileFormatID") REFERENCES "SaveFileFormats"("SaveFileFormatID");

ALTER TABLE "Comments" ADD CONSTRAINT "Comments_fk0" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_fk1" FOREIGN KEY ("CompositionID") REFERENCES "Compositions"("CompositionID");
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_fk2" FOREIGN KEY ("ParentCommentID") REFERENCES "Comments"("CommentID");

ALTER TABLE "CompositionAuthors" ADD CONSTRAINT "CompositionAuthors_fk0" FOREIGN KEY ("CompositionID") REFERENCES "Compositions"("CompositionID");
ALTER TABLE "CompositionAuthors" ADD CONSTRAINT "CompositionAuthors_fk1" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");

ALTER TABLE "CompositionTags" ADD CONSTRAINT "CompositionTags_fk0" FOREIGN KEY ("CompositionID") REFERENCES "Compositions"("CompositionID");
ALTER TABLE "CompositionTags" ADD CONSTRAINT "CompositionTags_fk1" FOREIGN KEY ("TagID") REFERENCES "Tags"("TagID");
