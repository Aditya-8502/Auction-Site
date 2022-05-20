drop database BiddingSite;
create database BiddingSite;
USE BiddingSite;
CREATE TABLE Account(username varchar(25) NOT NULL, password varchar(30) NOT NULL, type varchar(20), PRIMARY KEY(username));

CREATE TABLE Seller(seller_username varchar(25), primary key(seller_username),foreign key(seller_username) references Account(username));

CREATE TABLE Item(model varchar(20) NOT NULL,make varchar(20) NOT NULL,car_type varchar(20) NOT NULL, color varchar(15) NOT NULL,car_year int NOT NULL, 
vin varchar(10) NOT NULL, primary key(vin));

CREATE TABLE Bids(buyer_username varchar(25) NOT NULL,vin varchar(10) NOT NULL, bidding_price int NOT NULL, bidding_time datetime DEFAULT NOW() NOT NULL, foreign key (buyer_username) references Account(username), 
foreign key (vin) references Item(vin), primary key(buyer_username,vin,bidding_price), CHECK(bidding_price>=0)); 

CREATE TABLE Auto_Bids(buyer_username varchar(25) NOT NULL,vin varchar(10) NOT NULL, bidding_price int NOT NULL, increment int NOT NULL, 
upper_limit int NOT NULL, foreign key (buyer_username) references Account(username), primary key(buyer_username,vin), CHECK(bidding_price>=0), CHECK(increment>=1));  

CREATE TABLE Auction(seller_name varchar(25) NOT NULL, vin varchar(10) NOT NULL, initial_bidding_price int NOT NULL, lbound_increment int NOT NULL, secret_min int NOT NULL, 
close_date datetime NOT NULL, open_date datetime DEFAULT NOW() NOT NULL, closed varchar(5), primary key(vin), foreign key(seller_name) references Seller(seller_username), foreign key (vin) references Item(vin),
CHECK(initial_bidding_price>=0), CHECK(lbound_increment>=1), CHECK(secret_min>=0), CHECK(close_date > open_date));

CREATE TABLE Sells(seller_username varchar(25), vin varchar(10),primary key (vin), foreign key (seller_username) references Seller(seller_username), 
foreign key (vin) references Item(vin));

CREATE TABLE Question(qid int NOT NULL AUTO_INCREMENT, question varchar(150) NOT NULL, qUsername varchar(25) NOT NULL, vin varchar(10) NOT NULL, 
foreign key(qUsername) references Account(username), foreign key (vin) references Item(vin), PRIMARY KEY(qid));

CREATE TABLE Answer(qid int NOT NULL, answer varchar(150) NOT NULL, aUsername varchar(25) NOT NULL, 
foreign key(aUsername) references Account(username), foreign key(qid) references Question(qid),PRIMARY KEY(qid, answer));

CREATE TABLE Alert(alert_username varchar(25) NOT NULL, model varchar(20)NOT NULL,make varchar(20) NOT NULL,car_type varchar(20) NOT NULL, color varchar(15) NOT NULL, PRIMARY KEY(alert_username,model,make,car_type,color),
 FOREIGN KEY(alert_username) REFERENCES Account(username));

INSERT INTO Account(username, password) 
VALUES ("buyer1","buyer1"),
("buyer2","buyer2"),
("buyer3","buyer3"),
("seller1","seller1"),
("seller2","seller2"),
("seller3","seller3");

INSERT INTO Account(username, password, type) 
VALUES ("admin","admin","Admin"),
("cr1","cr1","CustomerRep"),
("cr2","cr2","CustomerRep"),
("cr3","cr3","CustomerRep");

INSERT INTO Seller(seller_username)
VALUES ("seller1"),
("seller2"),
("seller3");

INSERT INTO Item(make, model, car_type, color, car_year, vin) 
VALUES ("Honda","CRV","suv","blue",2000,"0"),
("Honda","CRV","suv","green",2001,"1"),
("Honda","CRV","suv","red",2002,"2"),
("Tesla","Model S","sedan","green",2020,"3"),
("Tesla","Model X","suv","black",2018,"4"),
("Tesla","Model X","suv","white",2021,"5"),
("Toyota","Camry","sedan","green",2016,"6"),
("Hyundai","Elantra","sedan","grey",2021,"7"),
("Honda","CRV","suv","blue",2000,"8"),
("Chevrolet","Camaro","sedan","red",2019,"9"),
("BMW","M3","sedan","green",2021,"10"),
("BMW","328i","sedan","grey",2018,"11"),
("Mercedes","A35 AMG","hatchback","silver",2022,"12"),
("Toyota","Prius","sedan","white",2021,"13"),
("Honda","Accord","sedan","black",2018,"14"),
("Honda","Accord","sedan","silver",2020,"15"),
("Tesla","Model Y","suv","red",2019,"16"),
("Ford","GT","sedan","silver",2012,"17");

INSERT INTO Auction(seller_name, vin, initial_bidding_price, lbound_increment, secret_min, close_date, open_date, closed) 
VALUES ("seller1","0",5100,200,7500,"2022-06-29T20:00:00.0","2022-05-29T20:00:00.0", NULL),
("seller2","1",5200,250,8500,"2022-06-05T20:00:00.0","2022-05-10T21:00:00.0", NULL),
("seller2","2",5300,300,9500,"2022-06-10T20:00:00.0","2022-05-01T22:00:00.0", NULL),
("seller3","3",5300,300,0,"2022-06-29T20:00:00.0","2022-05-15T22:00:00.0", NULL),
("seller1","4",7500,300,10000,"2022-05-29T20:00:00.0","2022-05-01T22:00:00.0", "YES"),
("seller1","5",5000,300,6000,"2022-05-20T20:00:00.0","2022-05-15T22:00:00.0", "YES"),
("seller2","6",500,300,1000,"2022-07-29T20:00:00.0","2022-05-29T22:00:00.0", NULL),
("seller2","7",2300,300,5000,"2022-06-09T20:00:00.0","2022-05-29T22:00:00.0", NULL),
("seller3","8",8000,300,10000,"2022-03-15T20:00:00.0","2022-02-15T22:00:00.0", "YES"),
("seller1","9",2300,300,2400,"2022-01-30T20:00:00.0","2021-12-15T22:00:00.0", "YES"),
("seller3","10",10000,300,15000,"2023-05-29T20:00:00.0","2022-05-29T22:00:00.0", NULL);

INSERT INTO Bids(buyer_username,vin, bidding_price, bidding_time)
VALUES ("buyer1","8","9000","2022-03-15T19:59:58.0"),
("buyer2","8","9001","2022-03-15T19:59:59.10"),
("buyer3","1","5300","2022-06-01T13:00:00.0"),
("buyer1","1","5500","2022-06-02T21:30:00.0"),
("buyer2","1","6000","2022-06-02T15:15:00.0"),
("buyer3","1","8500","2022-06-03T23:50:00.0"),
("buyer1","2","5300","2022-05-15T12:23:52.0"),
("buyer2","2","10000","2022-06-05T13:00:00.0"),
("buyer1","2","10005","2022-06-06T14:15:00.0"),
("buyer3","3","5300","2022-05-16T23:22:00.0"),
("buyer1","4","10000","2022-05-16T13:29:00.0"),
("buyer2","4","12000","2022-05-16T13:35:00.0"),
("buyer1","5","5100","2022-05-20T13:00:00.0"),
("buyer1","8","8000","2022-02-16T15:23:00.0"),
("buyer2","8","8200","2022-02-17T08:35:00.0"),
("buyer3","8","10200","2022-02-17T22:15:00.0"),
("buyer2","8","10400","2022-03-12T13:45:00.0"),
("buyer1","8","10450","2022-03-13T07:12:00.0"),
("buyer3","8","10460","2022-03-15T23:00:00.0"),
("buyer1","9","2300","2021-12-16T12:30:00.0"),
("buyer2","9","2350","2021-12-29T23:00:00.0"),
("buyer1","9","2400","2022-01-15T15:29:00.0"),
("buyer1","10","10460","2022-12-25T23:00:00.0");

INSERT INTO Question(qid, vin, question, qUsername) 
VALUES (1, "0","What is the color?","buyer1"),
(2, "0","What is the color again?","buyer2"),
(3, "1","How many wheels?","buyer2"),
(4, "2","Is this car?","buyer3");

INSERT INTO Answer(qid, answer, aUsername) 
VALUES (1,"blue","cr1"),
(1,"nah red","cr2"),
(3,"4","cr2"),
(3,"5 actually","cr2"),
(4,"na u tell me","cr3");

INSERT INTO Alert(alert_username, make, model, car_type, color)
VALUES ('buyer1',"Honda","CRV","car","blue"),
('buyer1',"Tesla","Model S","car","red"),
('buyer2',"Honda","CRV","car","red"),
('buyer2',"Tesla","Model S","car","blue");



