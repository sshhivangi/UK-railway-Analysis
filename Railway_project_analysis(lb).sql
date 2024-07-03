---------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ANALYSING RAILWAY DATASET-------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
---CREATING A NEW DATABASE TO ANALYSE RAILWAY PROJECT---
create database SQL_project;
USE SQL_project;

---STEP-1 CREATING A TABLE CALLED RAILWAY WITH ALL THE COLUMNS WITH DATATYPE VARCHAR(MAX)---
create table Railway (
Transaction_ID varchar(max),
Date_of_Purchase varchar(max),
Time_of_Purchase varchar(max),
Purchase_Type varchar(max),
Payment_Method varchar(max),
Railcard varchar(max),
Ticket_Class varchar(max),
Ticket_Type varchar(max),
Price varchar(max),
Departure_Station varchar(max),
Arrival_Destination varchar(max),
Date_of_Journey varchar(max),
Departure_Time varchar(max),
Arrival_Time varchar(max),
Actual_Arrival_Time varchar(max),
Journey_Status VARCHAR(MAX),
Reason_for_Delay varchar(max),
Refund_Request varchar(max)
);

Select * from Railway;
--THE TABLE IS EMPTY NOW---
---------------------------------------------------------------------------------------------------------------------------------------------------------

--STEP-3 NOW IMPORT RAILWAY CSV FILE USING BULK STATEMENT---
Bulk insert Railway
from 'C:\Users\Shivangi Chaurasia\Documents\railway.csv'
with (fieldterminator = ',',
	  rowterminator = '\n',
	  firstrow = 2);
SELECT * FROM RAILWAY;
--WE CAN SEE THE TABLE IS FILLED WITH THE DATA--
-------------------------------------------------------------------------------------

--STEP-4 MAKE A COPY OF THE ORIGINAL DATASET SO THAT WE DON'T LOSS IT--
select * into Railway_copy from Railway;
select * from Railway_copy;

--LET'S FIND OUT ALL THE COLUMNS AND THEIR DATATYPE--
select Column_name, Data_type
from Information_schema.columns
where table_name in ('Railway');

---------------------------------------------------------------------------------------
--STEP-5 CHECKING FOR NULL VALUES AND INVALID FORMAT IN THE ROWS OF ALL THE COLUMNS--


------------TRANSACTION ID COLUMN------------
SELECT TRANSACTION_ID FROM Railway
WHERE TRANSACTION_ID IS NULL;
---THERE IS NO NULL VALUE IN TRANSACTION ID---


------------DATE_OF PURCHASE-----------------
SELECT DATE_OF_PURCHASE FROM Railway
WHERE ISDATE(Date_of_Purchase)=0;
---THERE IS 17866 ROWS HAVING dd-mm--yyyy FORMAT IN DATE_OF_PURCHASE WE SHOULD CONVERT IN INTO  yyyy-mm-dd FORMAT ---

---CHECKING FOR THE INVALIND DATE ---
SELECT DATE_OF_PURCHASE FROM Railway
WHERE DATE_OF_PURCHASE NOT LIKE '__-__-____';

---THERE IS ONE INVALID DATA IN A ROW LET'S FIX IT FIRST---
UPDATE RAILWAY SET DATE_OF_PURCHASE= '31-12-2023'
WHERE DATE_OF_PURCHASE='31-12%2023';

---RECHECK FOR INVALID DATE---
SELECT DATE_OF_PURCHASE FROM Railway
WHERE DATE_OF_PURCHASE NOT LIKE '__-__-____';
---RESULT SHOWS THERE IS NO INVALID VALUES LEFT---

---NOW LET'S CHANGE THE FORMAT OF DATE_OF_PURCHASE AND UPDATE RAILWAY TABLE---
UPDATE Railway SET DATE_OF_PURCHASE = TRY_CONVERT(DATE, DATE_OF_PURCHASE, 105);

---RECHECK FOR INCORRECT FORMAT OF DATE---
SELECT DATE_OF_PURCHASE FROM Railway
WHERE ISDATE(DATE_OF_PURCHASE)=0;
-- 0 ROWS--

---ALTER THE TABLE WITH THE DATE FORMAT
ALTER TABLE Railway
ALTER COLUMN DATE_OF_PURCHASE date;


----------------------TIME_OF_PURCHASE-------------------
SELECT TIME_OF_PURCHASE FROM Railway
WHERE TIME_OF_PURCHASE IS NULL;
---THERE IS NO NULL VALUE IN TIME_OF_PURCHASE---

--- WE WILL CHECK IF THE TIME OF PURCHASE HAS IN THE CORRECT FORMATAS H:MM:SS---
SELECT TIME_OF_PURCHASE FROM Railway
WHERE TIME_OF_PURCHASE not like '__:__:__';
--RESULTS SHOW 0 ROW IT MEANS EVERY DATA IS IN THE CORRECT FORMAT--

---UPDATING DTA TYPE TO THE TIME---
UPDATE Railway
SET TIME_OF_PURCHASE = TRY_CONVERT(TIME, TIME_OF_PURCHASE, 108);

--ALTER THE TABLE--
ALTER TABLE Railway
ALTER COLUMN TIME_OF_PURCHASE TIME;

--NOW CHECK THE DATA TYPE--
SELECT Column_name, Data_type
FROM Information_schema.columns
WHERE table_name in ('Railway');

---------NOW WE CAN SEE THE DATA TYPE OF TIME_OF_PURCHASE CHANGES TO TIME-------



----------------------PURCHASE_TYPE---------------------
SELECT PURCHASE_TYPE FROM Railway
WHERE PURCHASE_TYPE IS NULL;
SELECT DISTINCT PURCHASE_TYPE FROM RAILWAY;
---THERE IS NO NULL VALUE IN PURCHASE_TYPE---
---THERE ARE 2 DISTINCT VALUE IS PRESENT--
--1.ONLINE 
--2.STATION---



----------------------PAYMENT_METHOD---------------------
SELECT PAYMENT_METHOD FROM Railway
WHERE PAYMENT_METHOD IS NULL;
SELECT DISTINCT PAYMENT_METHOD FROM RAILWAY;
---THERE IS NO NULL VALUE IN PAYMENT_METHOD---
---THERE ARE 3 DISTINCT VALUES ARE PRESENT--
--1.DEBIT CARD||
--2.CREDIT CARD||
--3.CONTACTLESS---



----------------------RAILCARD---------------------
SELECT RAILCARD FROM Railway
WHERE RAILCARD IS NULL;
SELECT DISTINCT RAILCARD FROM RAILWAY;
---THERE IS NO NULL VALUE IN RAILCARD---
---THERE ARE 4 DISTINCT VALUES ARE PRESENT 
--1.NONE||
--2.DISABLED||
--3.SENIOR||
--4.ADULT---



----------------------TICKET_CLASS---------------------
SELECT TICKET_CLASS FROM Railway
WHERE TICKET_CLASS IS NULL;
SELECT DISTINCT TICKET_CLASS FROM RAILWAY;
---THERE IS NO NULL VALUE IN TICKET_CLASS---
---THERE ARE 2 DISTINCT VALUES ARE PRESENT 
--1.FIRST CLASS 
--2.STANDARD---



----------------------TICKET_TYPE---------------------
SELECT TICKET_TYPE FROM Railway
WHERE TICKET_TYPE IS NULL;
SELECT DISTINCT TICKET_TYPE FROM RAILWAY;
---THERE IS NO NULL VALUE IN TICKET_TYPE---
---THERE ARE 3 DISTINCT VALUES
--1.ANYTIME||
--2.ADVANCE||
--3.OFF-PEAK---



----------------------PRICE---------------------
 ---CHECKING FOR MISSING VALUES IN NUMERIC COLUMN PRICE---
SELECT  Price FROM Railway
WHERE ISNUMERIC(Price) = 0;

--WE CAN SEE THERE ARE 5 INVALID VALUES TO HANDLE IT--
update Railway
set Price = '31' where Price  = '31&^';
update Railway
set Price = '3' where Price  = '3--';
update Railway
set Price = '4' where Price  = '4ú';
update Railway
set Price = '3' where Price  = '3$';
update Railway
set Price = '16' where Price  = '16A';

SELECT  Price FROM Railway
WHERE ISNUMERIC(Price) = 0;
--NOW THERE IS NO INVALID VALUES---
--ALTER THE TABLE BY ALTER VALUE OF THE COLUMN PRICE UPTO 2 DECIMAL PLACES--
ALTER TABLE Railway
ALTER COLUMN Price DECIMAL(10,2);

SELECT PRICE FROM Railway;
---NOW ALL THE PRICE VALUES ARE UPTO 2 DECIMAL VALUES---




----------------------DEPARTURE_STATION---------------------
SELECT DEPARTURE_STATION FROM Railway
WHERE DEPARTURE_STATION IS NULL;
SELECT DISTINCT DEPARTURE_STATION FROM RAILWAY;
---THERE IS NO NULL VALUE IN DEPARTURE_STATION---
---THERE ARE 12 DISTINT VALUES OD DEPARTURE_STATION ARE 
--1.READING||
--2.Manchester Piccadilly||
--3.London Paddington||
--4.Oxford||
--5.Edinburgh Waverley||
--6.York||
--7.Liverpool Lime Street||
--8.London Kings Cross||
--9.Birmingham New Street||
--10.Bristol Temple Meads||
--11.London St Pancras||
--12.London Euston---




----------------------ARRIVAL_DESTINATION---------------------
SELECT ARRIVAL_DESTINATION FROM Railway
WHERE ARRIVAL_DESTINATION IS NULL;
SELECT DISTINCT ARRIVAL_DESTINATION FROM RAILWAY;
---THERE IS NO NULL VALUE IN ARRIVAL_DESTINATION---
---THERE ARE 32 DISTINCT ARRIVAL DESTINATIONS 
--Reading
--Manchester Piccadilly
--Wolverhampton
--Peterborough
--Swindon
--Doncaster
--London Paddington
--Oxford
--Edinburgh Waverley
--Stafford
--Leeds
--Didcot
--Leicester
--York
--Liverpool Lime Street
--Wakefield
--Durham
--Warrington
--Nuneaton
--Edinburgh
--London Kings Cross
--Birmingham New Street
--Bristol Temple Meads
--Tamworth
--Coventry
--Sheffield
--Cardiff Central
--Crewe
--Nottingham
--London Waterloo
--London St Pancras
--London Euston---



----------------------DATE_OF_JOURNEY---------------------
SELECT DATE_OF_JOURNEY FROM RAILWAY
WHERE ISDATE(DATE_OF_JOURNEY)=0; 
---RESULTS SHOWS THERE IS 19,689 ROWS ARE HAVING DD-MM-YYYY DATE FORMAT---

---CHECKING FOR THE INVALIND DATE ---
SELECT DATE_OF_JOURNEY FROM Railway
WHERE DATE_OF_JOURNEY NOT LIKE '__-__-____';

-- 2 ROWS HAVE INVALID DATE LET'S FIX THIS FIRST--

UPDATE RAILWAY SET DATE_OF_JOURNEY= 'O4-02-2024'
WHERE DATE_OF_JOURNEY='04*02-2024';
UPDATE RAILWAY SET DATE_OF_JOURNEY= '06-02-2024'
WHERE DATE_OF_JOURNEY='06--02-2024';

--RECHECK FOR INVALID DATE--
SELECT DATE_OF_JOURNEY FROM Railway
WHERE DATE_OF_JOURNEY NOT LIKE '__-__-____';
--RESULT: 0 ROWS-- 

--LET'S UPDATE THE TABLE 
UPDATE Railway SET DATE_OF_JOURNEY = TRY_CONVERT(DATE, DATE_OF_JOURNEY, 105);

--ALTER COLUMN DATA TYPE--
ALTER TABLE Railway
ALTER COLUMN DATE_OF_JOURNEY date;

SELECT Column_name, Data_type
FROM Information_schema.columns
WHERE table_name in ('Railway')
------------NOW WE CAN SEE THE DATA TYPE OF DATE_OF_JOURNEY CHANGES TO DATE-------




----------------------DEPARTURE TIME---------------------
SELECT DEPARTURE_TIME FROM Railway
WHERE DEPARTURE_TIME IS NULL;
---THERE IS NO NULL VALUE IN DEPARTURE_TIME---

--- WE WILL CHECK IF THE DEPARTURE_TIME HAS IN THE CORRECT FORMATAS HH:MM:SS---
SELECT DEPARTURE_TIME FROM Railway
WHERE DEPARTURE_TIME not like '__:__:__';
--RESULTS SHOW 1 ROW WITH INNCORRECT FORMAT--

--LET'S FIX THE TIME FORMAT---
UPDATE RAILWAY SET DEPARTURE_TIME= '18:45:00'
WHERE DEPARTURE_TIME='18:45::00';

--RECHECK FOR INNCORRECT FORMAT--
SELECT DEPARTURE_TIME FROM Railway
WHERE DEPARTURE_TIME not like '__:__:__';
--RESULT SHOWS 0 ROW--

---UPDATING DTA TYPE TO THE TIME---
UPDATE Railway
SET DEPARTURE_TIME = TRY_CONVERT(TIME, DEPARTURE_TIME, 108);

--ALTER THE TABLE--
ALTER TABLE Railway
ALTER COLUMN DEPARTURE_TIME TIME;

--NOW CHECK THE DATA TYPE--
SELECT Column_name, Data_type
FROM Information_schema.columns
WHERE table_name in ('Railway');




----------------------ARRIVAL TIME---------------------
SELECT ARRIVAL_TIME FROM Railway
WHERE ARRIVAL_TIME IS NULL;
---THERE IS NO NULL VALUE IN ARRIVAL_TIME---

--- WE WILL CHECK IF THE ARRIVAL_TIME HAS IN THE CORRECT FORMATAS HH:MM:SS---
SELECT ARRIVAL_TIME FROM Railway
WHERE ARRIVAL_TIME not like '__:__:__';
--RESULTS SHOW 0 ROW WITH INNCORRECT FORMAT--

---UPDATING DTA TYPE TO THE TIME---
UPDATE Railway
SET ARRIVAL_TIME = TRY_CONVERT(TIME, ARRIVAL_TIME, 108);

--ALTER THE TABLE--
ALTER TABLE Railway
ALTER COLUMN ARRIVAL_TIME TIME;

--NOW CHECK THE DATA TYPE--
SELECT Column_name, Data_type
FROM Information_schema.columns
WHERE table_name in ('Railway');




----------------------ACTUAL ARRIVAL TIME---------------------
SELECT ACTUAL_ARRIVAL_TIME FROM Railway
WHERE ACTUAL_ARRIVAL_TIME IS NULL;
---THERE IS 1880 ROWS WITH NULL VALUE IN ACTUAL_ARRIVAL_TIME---

UPDATE Railway 
SET ACTUAL_ARRIVAL_TIME =''
WHERE ACTUAL_ARRIVAL_TIME IS NULL;
SELECT ACTUAL_ARRIVAL_TIME FROM Railway;

--- WE WILL CHECK IF THE ACTUAL_ARRIVAL_TIME HAS IN THE CORRECT FORMATAS HH:MM:SS---
SELECT ACTUAL_ARRIVAL_TIME FROM Railway
WHERE ACTUAL_ARRIVAL_TIME not like '__:__:__';
--RESULTS SHOW 2 ROW WITH INNCORRECT FORMAT--

--LET'S UPDATE ACTUAL_ARRIVAL_TIME WITH CORRECT FORMAT--
UPDATE RAILWAY SET ACTUAL_ARRIVAL_TIME= '21:15:00'
WHERE ACTUAL_ARRIVAL_TIME='21:15::00';
UPDATE RAILWAY SET ACTUAL_ARRIVAL_TIME= '19:15:00'
WHERE ACTUAL_ARRIVAL_TIME='19:15::00';

SELECT ACTUAL_ARRIVAL_TIME FROM Railway
WHERE ACTUAL_ARRIVAL_TIME not like '__:__:__';
--RESULTS SHOWS 0 ROW WITH INNCORECT FORMAT--

---UPDATING DTA TYPE TO THE TIME---
UPDATE Railway
SET ACTUAL_ARRIVAL_TIME = TRY_CONVERT(TIME, ACTUAL_ARRIVAL_TIME, 108);

--ALTER THE TABLE--
ALTER TABLE Railway
ALTER COLUMN ACTUAL_ARRIVAL_TIME TIME;

--NOW CHECK THE DATA TYPE--
SELECT Column_name, Data_type
FROM Information_schema.columns
WHERE table_name in ('Railway');





----------------------JOURNEY_STATUS---------------------
SELECT JOURNEY_STATUS FROM Railway
WHERE JOURNEY_STATUS IS NULL;
SELECT DISTINCT JOURNEY_STATUS FROM RAILWAY; 
---THERE IS NO NULL VALUE IN JOURNEY_STATUS---
---THERE ARE 3 DISTINCT VALUE INTHE JOURNEY_STATUS COLUMN
--On Time
--Delayed
--Cancelled---



----------------------REASON_FOR_DELAY---------------------
SELECT REASON_FOR_DELAY FROM Railway
WHERE REASON_FOR_DELAY IS NULL;
---OUT OF 31653 ROWS THERE IS 27481 NULL VALUES PRESENT IN THIS COLUMN---

---TO HANDLE WITH MISSING VALUES UPDATE REASON_FOR_DELAY COLUMNS WITH A DEFAULT VALUE---
UPDATE Railway 
SET REASON_FOR_DELAY ='NO REASON PROVIDED'
WHERE REASON_FOR_DELAY IS NULL;
SELECT REASON_FOR_DELAY FROM Railway;
---THE MISSING VALUE IN COLUMN IS NOW UPDATED WITH "NO REASON PROVIDED"---

SELECT REASON_FOR_DELAY FROM Railway
WHERE REASON_FOR_DELAY IS NULL;
---NOW THERE IS NO NULL VALUE IN REASON_FOR_DELAY---

SELECT DISTINCT REASON_FOR_DELAY FROM RAILWAY; 
---NOW THERE IS NO NULL VALUE IN REFUND_RE
---THERE ARE 8 DISTINCT VALUES IN REASON FOR DELAY--
--Staffing
--NULL
--Weather
--Staff Shortage
--Weather Conditions
--Signal Failure
--Traffic
--Technical Issue---




----------------------REFUND_REQUEST---------------------
SELECT REFUND_REQUEST FROM Railway
WHERE REFUND_REQUEST IS NULL;
SELECT DISTINCT REFUND_REQUEST FROM RAILWAY; 
---NOW THERE IS NO NULL VALUE IN REFUND_REQUEST---
---THERE ARE 2 DISTINCT VALUE FOR REFUND--
--YES
--NO---


 
---------------------------------------------------------------------------------------------------------------------------------------------------------
/*
  1.Identify Peak Purchase Times and Their Impact on Delays: 
  This query determines the peak times for ticket purchases and analyzes if there is any correlation with journey delays.
*/

-- Create a temporary table to store the data from the purchase time
WITH Purchase_time AS (
    SELECT DATEPART(HOUR, CAST([Time_of_Purchase] AS TIME)) AS Purchase_time
    FROM Railway
)

SELECT Purchase_time,
    COUNT(*) AS PurchaseCount
FROM Purchase_time
GROUP BY Purchase_time
ORDER BY Purchase_time;
---HERE WE CAN SEE A TEMPRARY TABLE WITH PURCHASE COUNT OF EVERY HOUR FROM 0 TO 23.---
---LET'S SEE THE TOP 5 PURCHASE COUNT TO DETERMINE THE PEAK PURCHASES BY TIME---

WITH Purchase_time AS (
    SELECT DATEPART(HOUR, CAST([Time_of_Purchase] AS TIME)) AS Purchase_time
    FROM Railway
)

SELECT TOP 5 Purchase_time,
    COUNT(*) AS PurchaseCount
FROM Purchase_time
GROUP BY Purchase_time
ORDER BY PurchaseCount DESC;

----THE RESULT SHOWS TOP 5 PEAK PURCHASE TIME BY PURCHASE COUNT ARE_
/*
17
20 
9 
7 
8 
*/
--- THE PEAK PURCHASE TIME ARE 5pm, 8pm, 9am, 7am, 8am---

---CREATE A TEMPORARY TABLE TO STORE THE DATA AND DELAY STATUS---
WITH PurchaseDelay AS (
    SELECT 
        DATEPART(HOUR, CAST([TIME_OF_PURCHASE] AS TIME)) AS PURCHASE_TIME,
        CASE WHEN [JOURNEY_STATUS] = 'Delayed' THEN 1 ELSE 0 END AS IsDelayed
    FROM Railway
)

---CALCULATE THE PERCENTAGE OF DELAYED JOURNEY FOR EACH PURCHASE TIME---
SELECT TOP 5 PURCHASE_TIME, 
       100.0 * SUM(IsDelayed) / COUNT(*) AS DelayPercentage
FROM PurchaseDelay
GROUP BY PURCHASE_TIME
ORDER BY DelayPercentage DESC ;
----THE RESULT SHOWS TOP 5 PURCHASE TIME BY DELAY PERCENTAGE ARE_
/*
9
6
16
10
2
*/
--- THE PEAK PURCHASE TIME ARE 5pm, 8pm, 9am, 7am, 8am---
--- THE PEAK PURCHASE TIME BY DELAY ARE 9am, 6am, 4pm, 10am, 2am---
------------------CONCLUSION: BY THE ABOVE ANALYSIS WE CAN CONCLUDE THAT THERE IS NO CO-RELATION BETWEEN PURCHASE TIME AND DELAY------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
  2.Analyze Journey Patterns of Frequent Travelers: 
  This query identifies frequent travelers (those who made more than three purchases) and analyzes their most common journey patterns.
*/
---There is no detail about individual customer (like Name, Email...) so the frequent travellers are identified as the journey patterns of train---

-- Step 1: Identify frequent journeys
WITH JourneyFrequency AS (
    SELECT 
        [Departure_Station],
        [Arrival_Destination],
        COUNT(*) AS JourneyCount
    FROM 
        railway
    GROUP BY 
        [Departure_Station],
        [Arrival_Destination]
    HAVING 
        COUNT(*) > 3
)

-- Step 2: Analyze journey patterns
SELECT 
    jf.[Departure_Station],
    jf.[Arrival_Destination],
    jf.JourneyCount
FROM 
    JourneyFrequency jf
ORDER BY 
    jf.JourneyCount DESC;

--Result:
/*
Departure_Station       Arrival_Station         Journey_count
Manchester Piccadilly	Liverpool Lime Street	4628
London Euston	        Birmingham New Street	4209
London Kings Cross	    York	                3922
London Paddington	    Reading	                3873
London St Pancras	    Birmingham New Street	3471
Liverpool Lime Street	Manchester Piccadilly	3002
Liverpool Lime Street	London Euston	        1097
London Euston	        Manchester Piccadilly	712
Birmingham New Street	London St Pancras	    702
London Paddington	    Oxford	                485
Manchester Piccadilly	London Euston	        345
London St Pancras	    Leicester	            337
York	                Durham	                258
York	                Peterborough	        242
Reading	                Swindon	                228
Birmingham New Street	Tamworth	            227
Birmingham New Street	Manchester Piccadilly	224
Birmingham New Street	Nuneaton	            219
York	                Doncaster	            211
Liverpool Lime Street	Crewe	                193
Birmingham New Street	Stafford	            190
Birmingham New Street	Liverpool Lime Street	175
Manchester Piccadilly	Sheffield	            171
London Kings Cross	    Edinburgh Waverley	    163
Manchester Piccadilly	Nottingham	            158
Reading	                London Paddington	    148
Manchester Piccadilly	London Paddington	    144
Oxford	                Bristol Temple Meads	144
London Kings Cross	    Liverpool Lime Street	144
Manchester Piccadilly	Leeds	                142
York	                Edinburgh	            138
Birmingham New Street	London Euston	        125
Reading	                Oxford	                122
Liverpool Lime Street	Sheffield	            101
Liverpool Lime Street	Leeds	                96
London St Pancras	    Wolverhampton	        83
London Paddington	    London Waterloo	        68
Birmingham New Street	York	                65
Birmingham New Street	Coventry	            65
Edinburgh Waverley	    London Kings Cross	    51
Reading	                Didcot	                48
Birmingham New Street	Reading             	47
London Paddington	    Liverpool Lime Street	44
Birmingham New Street	London Paddington	    32
Reading	Birmingham New  Street	                32
Birmingham New Street	Wolverhampton	        32
Liverpool Lime Street	London St Pancras	    31
London Paddington	    Manchester Piccadilly	30
Liverpool Lime Street	London Paddington	    27
Birmingham New Street	London Kings Cross	    17
York	                Leeds	                17
London Euston	        York	                17
Manchester Piccadilly	London St Pancras	    16
London Euston	        Oxford	                16
Reading	                Liverpool Lime Street	16
Manchester Piccadilly	London Kings Cross	    16
York	                Birmingham New Street	16
Bristol Temple Meads	Cardiff Central	        16
Birmingham New Street	Edinburgh	            16
York	                Edinburgh Waverley	    15
York	                Liverpool Lime Street	15
Manchester Piccadilly	York	                15
York	                Wakefield	            15
Manchester Piccadilly	Warrington	            15
Liverpool Lime Street	Birmingham New Street	14
*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
  3.Revenue Loss Due to Delays with Refund Requests: 
  This query calculates the total revenue loss due to delayed journeys for which a refund request was made.
*/

SELECT SUM(PRICE) AS 'TOTAL REVENUE LOSS DUE TO DELAYED JOURNEY'
FROM RAILWAY
WHERE REFUND_REQUEST ='YES' AND JOURNEY_STATUS ='DELAYED';

---------RESULT SHOWS THAT TOTAL REVENUE LOSS DUE TO DELAYED JOURNEY IS_ 26165.00---------------------------

/*
  4.Impact of Railcards on Ticket Prices and Journey Delays: 
  This query analyzes the average ticket price and delay rate for journeys purchased with and without railcards.
*/
--Calculate average ticket price and delay rate for journeys with railcards--
SELECT 
    CASE 
        WHEN Railcard IS NOT NULL AND Railcard != 'None' THEN 'With Railcard' 
        ELSE 'Without Railcard' 
    END AS RailcardStatus,
    AVG(CAST(Price AS DECIMAL(10, 2))) AS AverageTicketPrice,
    SUM(CASE WHEN Journey_Status = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DelayRate
FROM railway
GROUP BY 
    CASE 
        WHEN Railcard IS NOT NULL AND Railcard != 'None' THEN 'With Railcard' 
        ELSE 'Without Railcard' 
    END;

-- RESULT:

/*
    RAILCARD_FLAG 	   AVG_TICKET_PRICE   DELAY_RATE
	With Railcard	    15.670610	     8.216115510013
    Without Railcard	27.425996	     6.740606176498
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------
/*
  5.Journey Performance by Departure and Arrival Stations: 
  This query evaluates the performance of journeys by calculating the average delay time for each pair of departure and arrival stations.
*/
WITH JourneyPerformance AS (
    SELECT 
        DEPARTURE_STATION,
        ARRIVAL_DESTINATION,
        AVG(DATEDIFF(MINUTE, ARRIVAL_TIME, ACTUAL_ARRIVAL_TIME)) AS AVG_DELAYED_TIME
    FROM 
        Railway
    WHERE 
        JOURNEY_STATUS = 'Delayed' AND
        ACTUAL_ARRIVAL_TIME IS NOT NULL
    GROUP BY 
        DEPARTURE_STATION, ARRIVAL_DESTINATION
)
SELECT 
    DEPARTURE_STATION,
    ARRIVAL_DESTINATION,
    ISNULL(AVG_DELAYED_TIME, 0) AS AVG_DELAYED_TIME 
FROM 
    JourneyPerformance
ORDER BY AVG_DELAYED_TIME	DESC;
--RESULT:
/*
Manchester Piccadilly	Leeds	143
York	Doncaster	68
Manchester Piccadilly	Liverpool Lime Street	67
London Euston	Birmingham New Street	54
Manchester Piccadilly	Nottingham	53
Liverpool Lime Street	London Paddington	38
London Euston	York	36
Liverpool Lime Street	London Euston	36
London Paddington	Reading	35
Birmingham New Street	London Euston	31
York	Durham	30
Birmingham New Street	Manchester Piccadilly	26
Manchester Piccadilly	London Euston	24
Liverpool Lime Street	Manchester Piccadilly	21
Oxford	Bristol Temple Meads	19
London Kings Cross	York	16
Edinburgh Waverley	London Kings Cross	15
York	Wakefield	12
*/
----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
  6.Revenue and Delay Analysis by Railcard and Station
  This query combines revenue analysis with delay statistics, providing insights into journeys' performance and 
  revenue impact involving different railcards and stations.
*/
SELECT 
    Railcard, [Departure_Station], [Arrival_Destination],
    COUNT(*) AS TotalJourneys,
    SUM(CAST(Price AS DECIMAL(10, 2))) AS TotalRevenue,
    AVG(CAST(Price AS DECIMAL(10, 2))) AS AverageTicketPrice,
    SUM(CASE WHEN [Journey_Status] = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DelayRate
FROM 
    railway
GROUP BY 
    Railcard, [Departure_Station], [Arrival_Destination]
ORDER BY
    Railcard, [Departure_Station], [Arrival_Destination] ;

--RESULT:
--- the performance and revenue impact of journeys involving different railcards and stations.
---It will include the total number of journeys, total revenue, average ticket price, and delay rate for each combination 
---of railcard type and station.
/*
Railcard Departure_Station      Arrival_Station         TotalJourney   TotalRevenue  AvgTicketPrice  DelayRate
Adult	 Birmingham New Street	York	                 65	           1347.00	     20.723076	     0.000000000000
Adult	 Birmingham New Street	Manchester Piccadilly    224           2507.00       11.191964	     42.857142857142
Adult	 Birmingham New Street	London St Pancras	     34	           630.00	     18.529411	     0.000000000000
Adult	 Birmingham New Street	London Euston	         14	           300.00	     21.428571	     0.000000000000
Adult	 Birmingham New Street	Liverpool Lime Street	 48	           484.00	     10.083333	     0.000000000000
Adult	 Liverpool Lime Street	Sheffield	             67	           540.00	     8.059701	     0.000000000000
Adult	 Liverpool Lime Street	Manchester Piccadilly	 503           1527.00	     3.035785	     20.675944333996
Adult	 Liverpool Lime Street	London Paddington	     13	           871.00	     67.000000	     100.000000000000
Adult	 Liverpool Lime Street	London Euston	         191           13819.00	     72.350785	     63.350785340314
Adult	 Liverpool Lime Street	Leeds	                 63	           685.00	     10.873015	     0.000000000000
*/


-----------------------------------------------------------------------------------------------------------------------------------------------------

/*
   7.Journey Delay Impact Analysis by Hour of Day
   This query analyzes how delays vary across different hours of the day, calculating the average delay
   in minutes for each hour and identifying the peak hours for delays.
*/

-- Step 1: Calculate the delay in minutes for each journey
WITH JourneyDelays AS (
    SELECT Transaction_ID,
        DATEPART(HOUR, Arrival_Time) AS Arrival_Hour,
        DATEDIFF(MINUTE, Arrival_Time, Actual_Arrival_Time) AS Delay_In_Minutes
    FROM Railway
    WHERE Journey_Status = 'Delayed'
)

-- Step 2: Analyze delays by hour of the day
SELECT Arrival_Hour,
    AVG(Delay_In_Minutes) AS Average_Delay_In_Minutes,
    COUNT(*) AS Number_Of_Delays
FROM JourneyDelays
GROUP BY Arrival_Hour
ORDER BY COUNT(*) DESC;
--Result: 
/*
Arrival_hour  Avg_delay_in_min  Num_of_delay
10        	  42	             626
19	          15	             282
11	          53	             255
9	          70	             254
17	          49	             252
18	          52	             150
12	          29	             114
5	          23	             108
8	          23	             47
16	          33	             46
7	          48	             42
6	          28	             37
4	          21	             33
1	          36	             17
15	          19	             15
2	          34	             14
*/
