CREATE TABLE Cinema (
	CinemaID INT PRIMARY KEY,
	Nome VARCHAR (100) NOT NULL,
	Indirizzo VARCHAR (255) NOT NULL,
	Phone VARCHAR (20)
);
 
CREATE TABLE Theater (
	TheaterID INT PRIMARY KEY,
	CinemaID INT,
	Nome VARCHAR(50) NOT NULL,
	Capacity INT NOT NULL,
	ScreenType VARCHAR(50),
	FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
); 

CREATE TABLE Movie (
	MovieID INT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Director VARCHAR(100),
	ReleaseDate DATE,
	DurationMinutes INT,
	Rating VARCHAR(5)
); 

CREATE TABLE Showtime (
	ShowtimeID INT PRIMARY KEY,
	MovieID INT,
	TheaterID INT,
	ShowDateTime DATETIME NOT NULL,
	Price DECIMAL(5,2) NOT NULL,
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
	FOREIGN KEY (TheaterID) REFERENCES Theater(TheaterID)
);

CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL, 	LastName VARCHAR(50) NOT NULL,
	Email VARCHAR(100),
	PhoneNumber VARCHAR(20)
); 
DROP TABLE IF EXISTS Ticket;

CREATE TABLE Ticket (
	TicketID INT PRIMARY KEY IDENTITY (1,1),
	ShowtimeID INT,
	SeatNumber VARCHAR(10) NOT NULL,
	PurchasedDateTime DATETIME NOT NULL,
	CustomerID INT,
	FOREIGN KEY (ShowtimeID) REFERENCES Showtime(ShowtimeID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Review (
	ReviewID INT PRIMARY KEY,
	MovieID INT,
	CustomerID INT,
	ReviewText TEXT,
	Rating INT CHECK (Rating >= 1 AND Rating <= 5),
	ReviewDate DATETIME NOT NULL,
	FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
	CinemaID INT,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Position VARCHAR(50),
	HireDate DATE,
	FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);



INSERT INTO Cinema (CinemaID, Nome, Indirizzo, Phone) 
VALUES 
    (1, 'Jurassic Park', 'Via Joyce', '543255-3'),
    (2, 'Cineplex Odeon', 'Via Fermi', '333-666'),
    (3, 'AMC Theaters', 'Via A', '33-4324234');

INSERT INTO Theater (TheaterID, CinemaID, Nome, Capacity, ScreenType) 
VALUES 
    (1, 1, 'Stardust Village', 100, 'Standard'),
    (2, 1, 'Uci Cinema', 120, '3D'),
    (3, 2, 'Madison', 130, 'IMAX');

	

	
INSERT INTO Movie (MovieID, Title, Director, ReleaseDate, DurationMinutes, Rating) 
VALUES 
    (1, 'Guinea Pig ', 'Frank Darabont', '1994-09-23', 142, '9.3'),
    (2, 'Harry Potter', 'Rowling', '1972-03-24', 175, '9.2'),
	(3, 'Live-Leak', 'Christopher Nolan', '2008-07-18', 152, '9.0');




INSERT INTO Showtime (ShowtimeID, MovieID, TheaterID, ShowDateTime, Price) 
VALUES 
    (1, 1, 1, '2024-03-02 18:00:00', 5.25),
    (2, 2, 3, '2024-03-02 20:00:00', 2.30),
    (3, 3, 2, '2024-03-02 17:30:00', 11.20);

INSERT INTO Showtime (ShowtimeID, MovieID, TheaterID, ShowDateTime, Price) 
VALUES 
	(4, 1, 2, '2024-03-02 17:20:00', 12.20);

	

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber) 
VALUES 
    (1, 'Ramil', 'Doe', 'ramil.doe@.com', '555-1234'),
    (2, 'Giulia', 'Paglia', 'giulia.smith@.com', '555-5678'),
    (3, 'Alice', 'Guglielmi', 'alice@com', '333-1112');




INSERT INTO Ticket ( ShowtimeID, SeatNumber, PurchasedDateTime, CustomerID) 
VALUES 
    ( 1, 'A22', '2024-03-12 15:30:00', 1),
    ( 2, 'B8', '2024-03-12 16:45:00', 2),
    ( 3, 'C16', '2024-03-12 17:00:00', 3);
	INSERT INTO Ticket ( ShowtimeID, SeatNumber, PurchasedDateTime, CustomerID) 
VALUES 
    ( 4, 'C16', '2024-03-12 17:00:00', 3);

	SELECT * FROM Ticket


INSERT INTO Review (ReviewID, MovieID, CustomerID, ReviewText, Rating, ReviewDate) 
VALUES 
    (1, 1, 1, 'Gran bel film.', 5, '2024-03-11 21:00:00'),
    (2, 2, 2, 'Classic masterpiece.', 5, '2024-03-11 21:30:00'),
    (3, 3, 3, 'Amazing performance by Heath Ledger.', 5, '2024-03-11 22:00:00');


	

	INSERT INTO Employee (EmployeeID, CinemaID, FirstName, LastName, Position, HireDate) 
VALUES 
    (1, 1, 'Alice', 'Bianchi', 'Biglietteria', '2022-01-15'),
    (2, 1, 'Jane', 'Fante', 'Comessa', '2022-02-20'),
    (3, 2, 'Sara', 'Johnson', 'Pulizie', '2022-03-10');

	SELECT * FROM EMPLOYEE;
	--Punto 1
	
	

CREATE VIEW FilmsInProgrammation AS

	 SELECT 
		Title,
		Director,
		DurationMinutes,
		ReleaseDate,
		Rating
	FROM Movie

	JOIN Showtime ON Movie.MovieID= ShowTime.MovieID;

SELECT * FROM FilmsInProgrammation;

  --Punto 2

 -- SELECT Capacity FROM Theater;
 


  CREATE VIEW AvailableSeatsForShow AS
		SELECT 
		
		Title,

		Theater.Capacity AS TotalSeats,
		Theater.Capacity - (SELECT COUNT(*) FROM Ticket WHERE Showtime.ShowtimeID = Ticket.ShowtimeID) AS Difference 


      FROM Showtime
	  JOIN  Theater ON  Showtime.TheaterID = Theater.TheaterID
	  JOIN Movie ON Showtime.MovieID = Movie.MovieID

	SELECT * FROM AvailableSeatsForShow; 

	

	--3

	 CREATE VIEW TotalEarningsPerMovie AS
	     
		 SELECT Title,  Price * (SELECT COUNT(*) FROM Ticket WHERE Showtime.ShowtimeID = Ticket.ShowtimeID) AS Incasso
 
		 FROM Movie

		 JOIN Showtime
			ON Showtime.MovieID = Movie.MovieID

	SELECT * FROM TotalEarningsPerMovie; 

	--4
	
	CREATE VIEW RecentReviews AS

	SELECT Title, ReviewText AS 'RECENSIONI', ReviewDate , Review.Rating

	FROM Review

	JOIN Movie 
	ON Movie.MovieID= Review.MovieID


	SELECT * FROM RecentReviews
	ORDER BY ReviewDate DESC
	;
	  
--DROP PROCEDURE PurchaseTicket



	CREATE PROCEDURE PurchaseTicket	
		@ShowtimeID INT ,
		@SeatNumber VARCHAR(10) ,
		@CustomerID INT 
	 AS

	BEGIN 

	BEGIN TRY
		
		SELECT * FROM Ticket
			JOIN Showtime ON Ticket.ShowtimeID = Showtime.ShowtimeID
	WHERE @SeatNumber = Ticket.SeatNumber AND Showtime.ShowtimeID = @ShowtimeID

		IF @@rowcount = 0

		INSERT INTO Ticket(ShowtimeID, SeatNumber, CustomerID, PurchasedDateTime ) VALUES
		(@ShowtimeID, @SeatNumber, @CustomerID, CURRENT_TIMESTAMP )

	END TRY 

	BEGIN CATCH
	PRINT 'Errore: ' + ERROR_MESSAGE()
	END CATCH

	END;

	EXEC  PurchaseTicket @ShowtimeID = 3, @SeatNumber = '846', @CustomerID = 2

    SELECT * 
	FROM Ticket
	JOIN  Showtime ON Ticket.ShowtimeID = Showtime.ShowtimeID
	JOIN  Movie ON Showtime.MovieID= Movie.MovieID


	SELECT * FROM Ticket



	--DROP PROCEDURE UpdateMovieSchedule

	CREATE PROCEDURE UpdateMovieSchedule
		
		@MovieID INT,
		@ShowDateTime DATETIME 
		AS
	BEGIN 
	UPDATE Showtime SET ShowDateTime = @ShowDateTime  WHERE MovieID = @MovieID

	END;

	EXEC UpdateMovieSchedule @ShowDateTime= '2024-06-02 19:30:00', @MovieID= 2

	 SELECT * FROM Showtime

