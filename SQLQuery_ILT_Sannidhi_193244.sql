--1. Display passenger name who has a 'e' as second letter in their name

select passname from Passenger where passname like '_e%';

--2. Display the name of the youngest passenger.

select passname from passenger where passdob=
  (select max(passdob) max from passenger);

--3. Display the name of the passenger, date of birth and age.


select passname, passdob, datediff (hour,passdob,getdate())/8766 as age from passenger;


--4. Display the number of flights leaving Kolkata.

Select Count(*) No_of_Flights from Flight where flightsource='kol';


--5. Display the name of city where the number of flights leaving and reaching is the same.

Select flightsource from 
 (select flightsource,count(*) f from Flight group by  flightsource)A inner join 
 (select flightdest,count(*) d from Flight group by  flightdest)B ON A.f=B.d and
 A.flightsource=B.flightdest;


--6. Display the name of the city which has flight source but no destination.

  (Select flightsource FROM FLIGHT where flightdest = null);
 
--7. Display the dates on which flight 1 and 4 is flying.

Select flightdate from flight where flightid=1 or flightid=4;


--8. Display the number of passenger in each flight. Use column alias “PassCount”.

Select flightid,Count(BD.passid) PassengerCount from Booking_details BD inner join Booking B ON B.bookingid=BD.bookingid group by flightid;

--9. Display the name and date of birth of passengers who are senior citizen (age>=60).

select passname, passdob from Passenger where passdob >= dateadd(yy, -60, getdate());

--10. Display the booking id having the highest number of passengers.

Select bookingid from Booking_details GROUP BY bookingid HAVING COUNT(passid)=
 (
 Select MAX(C) FROM 
 (
 Select bookingid,COUNT(passid) C FROM Booking_details GROUP BY bookingid
 ) a);

--11. Display the booking id (ticket) and the total cost for the booking. Use column alias “Total Fare”.

Select B.bookingid,F.ticketcost TOTAL_FARE FROM Booking B INNER JOIN Flight F ON B.flightid=F.flightid;


--13. Display the city receiving the maximum number of flights.

 select flightdest from flight group by flightdest having count(*)=(select max(c)  from (select count(*) c  from flight  group by flightdest)a );
              
--14. Display the passenger’s name having more than 1 booking.

Select passname from Passenger where passid IN  ( Select passid from Booking_details GROUP BY passid HAVING COUNT(bookingid)>1);

--15. Display flightid with no of booking.

 select flightid,count(*) NO_OF_BOOKINGS from booking group by flightid;

--16. Display the passenger (name only) who booked ticket on the day of flight for flight no 1.

 select p.passname from passenger p,booking b,flight f,booking_details d
 where b.flightid='1' and f.flightdate=b.bookdate and d.passid=p.passid and b.bookingid=d.bookingid;

--17. Display flights having the same source and destination.

select flightid from flight where flightdest=flightsource;


--20. Display passenger name , date of birth sorted by the month of birth .(Jan ? Dec).

select passname,passdob from passenger order by passdob;

