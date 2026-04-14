
DROP TABLE IF EXISTS bikes;
CREATE TABLE bikes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    image VARCHAR(255),
    description TEXT,
    engine VARCHAR(100),
    mileage VARCHAR(100),
    price VARCHAR(50)
);

DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    service_id INT,
    name VARCHAR(255),
    contact VARCHAR(50),
    address TEXT,
    date DATE
);

DROP TABLE IF EXISTS contact;
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    message TEXT
);

DROP TABLE IF EXISTS emi;
CREATE TABLE emi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bike_id INT,
    months INT,
    amount VARCHAR(50)
);

DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    message TEXT
);

DROP TABLE IF EXISTS services;
CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    image VARCHAR(255),
    price VARCHAR(50)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    contact VARCHAR(50)
);
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (4,'Hunter 350','hunter350.png','
The Royal Enfield Hunter 350 is powered by the proven J-series 349cc BS6 engine which develops 20.2 BHP power and 27 Nm torque. Built for unpredictable urban environments, the anti-lock braking system with 300mm front and 270mm rear discs bring you safely to a stop at even the shortest of distances, keeping you firmly in control. This Hunter 350 motorcycle has a fuel tank capacity of 13 litres.','350cc','36.2 kmpl','137640');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (5,'Goan Classic 350','goanclassic350.png','Goan Classic 350 is a Classic-based bobber-style motorcycle with features like whitewall tyres, raised mid-ape handlebars, tubeless spoke wheels, wider rear-tyre etc. 
The new Royal Enfield Goan Classic comes with new features like -
1. Ape style handle bars
2. New lowered seats/bobbered inspired rider seat.
3. Whitewall tubeless tyres.
4. Tubeless aluminium spoke wheels (1st time on 350 CC RE motorcycle)
5. All LED lighting','349cc J-platform','36.2 km/l','223634');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (6,'Classic 350','classic350.png','Classic 350 is known for its timeless retro design and iconic thump.
It offers a comfortable riding posture and smooth handling.
Perfect for long rides as well as daily commuting.
The bike represents heritage and modern reliability together.
A favorite among riders who love classic styling.','349cc single-cylinder','~35–40 km/l','221393');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (7,'Bullet 350','bullet350.png','Bullet 350 is one of the oldest motorcycles in production.
It is known for its rugged build and iconic sound.
The bike is simple, reliable, and easy to maintain.
Perfect for traditional riders who prefer raw riding feel.
A true symbol of Royal Enfield legacy.','349cc','~35–40 km/l','166650');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (8,'Meteor 350','meteor350.png','Meteor 350 is designed for relaxed cruising and long journeys.
It offers a comfortable seat and upright riding posture.
Equipped with modern features like Tripper navigation.
Ideal for highway touring and smooth rides.
A perfect cruiser for beginners and experienced riders.','349cc','~35 km/l','219660');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (9,'Scram 440','scram440.png','Scram 440 is a versatile scrambler designed for urban and rough roads.
It offers a lightweight and agile riding experience.
Perfect for riders who want adventure with daily usability.
Stylish design with rugged performance.
A mix of practicality and adventure.','443cc','~ 30-35 km/l','230641');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (10,'Guerrilla 450','guerrilla450.png','Guerrilla 450 is a modern roadster with aggressive styling.
It focuses on performance and urban riding dynamics.
Offers a sporty feel with advanced features.
Designed for younger riders seeking performance bikes.
A bold step into next-gen motorcycles.','452cc','30km/l','249194');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (11,'Himalayan 450','himalayan450.png','Himalayan 450 is an adventure bike built for extreme terrains.
It offers excellent suspension and off-road capability.
Designed for long-distance touring and mountain rides.
Comfortable for both on-road and off-road journeys.
A true adventure companion.','452cc liquid-cooled','30km/l','319682');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (12,'Bear 650','bear650.png','Bear 650 represents a powerful and bold motorcycle concept.
It focuses on rugged performance and muscular design.
Built for strong road presence and stability.
Combines power with modern styling.
A bike for those who want uniqueness.','648cc twin-cylinder','25km/l','375393');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (13,'Shotgun 650','shotgun650.png','Shotgun 650 is a custom-inspired bobber-style motorcycle.
It offers a unique design and strong road presence.
Perfect for riders who love standout styling.
Comfortable yet powerful for city and highway.
A blend of style and performance.','648cc','~22-25km/l','413042');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (14,'Classic 650','classic650.png','Classic 650 combines retro styling with modern power.
It offers a premium riding experience.
Designed for comfort and long rides.
Maintains classic Royal Enfield DNA.
A powerful version of the iconic Classic.','648cc','25km/l','379252');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (15,'Bullet 650','bullet650.png','Bullet 650 is expected to carry forward Bullet legacy with more power.
It offers a raw and powerful riding experience.
Maintains classic styling with modern upgrades.
Perfect for traditional and power-loving riders.
A modern classic machine.','648cc','25km/l','416793');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (16,'Super Meteor 650','supermeteor650.png','Super Meteor 650 is a premium cruiser motorcycle.
Designed for long-distance highway touring.
Offers comfortable seating and stable handling.
Perfect for relaxed cruising experience.
A flagship cruiser from Royal Enfield.','648cc','23km/l','419824');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (17,'Interceptor 650','interceptor650.png','Interceptor 650 is a modern roadster with classic styling.
It offers a perfect balance of power and comfort.
Great for both city rides and highway touring.
Easy to handle and rider-friendly.
One of the most popular 650cc bikes.','648cc','25km/l','355322');
INSERT INTO bikes ( id , name , image , description , engine , mileage , price ) VALUES (18,'Continental GT 650','continental650.png','Continental GT 650 is a café racer style motorcycle.
Designed for sporty and aggressive riding.
Offers excellent handling and performance.
Low seating position gives racing feel.
Perfect for enthusiasts who love speed and style.','648cc','25km/l','375245');
INSERT INTO bookings ( id , user_id , service_id , name , contact , address , date ) VALUES (1,1,1,'Koushiki Verma','09111173151','Ward No 10, Village Dulhar, Post Saiyyadpur, House No 155, City Khandwa','2026-04-12');
INSERT INTO contact ( id , name , email , message ) VALUES (1,'Koushiki Verma','koushikiverma19@gmail.com','I want to customize my bike can you give me more details about this');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (1,4,3,'48174');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (2,4,6,'24087');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (3,4,12,'12043');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (4,5,3,'78271');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (5,5,6,'39135');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (6,5,12,'19567');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (7,6,3,'77487');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (8,6,6,'38743');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (9,6,12,'19371');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (10,7,3,'58327');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (11,7,6,'29163');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (12,7,12,'14581');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (13,8,3,'76881');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (14,8,6,'38440');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (15,8,12,'19220');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (16,9,3,'80724');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (17,9,6,'40362');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (18,9,12,'20181');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (19,10,3,'87217');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (20,10,6,'43608');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (21,10,12,'21804');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (22,11,3,'111888');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (23,11,6,'55944');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (24,11,12,'27972');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (25,12,3,'131387');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (26,12,6,'65693');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (27,12,12,'32846');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (28,13,3,'144564');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (29,13,6,'72282');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (30,13,12,'36141');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (32,14,3,'132738');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (33,14,6,'66369');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (35,14,12,'33184');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (36,15,3,'145877');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (37,15,6,'72938');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (38,15,12,'36469');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (39,16,3,'146938');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (40,16,6,'73469');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (41,16,12,'36734');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (42,17,3,'124362');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (43,17,6,'62181');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (44,17,12,'31090');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (45,18,3,'131335');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (46,18,6,'65667');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (47,18,12,'32833');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (48,19,3,'124362');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (49,19,6,'62181');
INSERT INTO emi ( id , bike_id , months , amount ) VALUES (50,19,12,'31090');
INSERT INTO feedback ( id , name , email , message ) VALUES (1,'Koushiki Verma','koushikiverma19@gmail.com','I have used your website it''s very good ');
INSERT INTO services ( id , name , description , image , price ) VALUES (1,'General Service','Complete bike inspection including engine check, oil level, brakes, and overall performance tuning. Ensures smooth and safe riding experience.','generalservice.png','INR 1500');
INSERT INTO services ( id , name , description , image , price ) VALUES (2,'Engine Repair','Detailed engine diagnostics and repair including piston, valves, and internal components. Improves bike performance and lifespan.','enginerepair.png','INR 4000');
INSERT INTO services ( id , name , description , image , price ) VALUES (3,'Oil Change','Replacement of engine oil with high-quality lubricant to ensure smooth engine operation and reduce wear and tear.','oilchange.png','INR 800');
INSERT INTO services ( id , name , description , image , price ) VALUES (5,'Brake & Clutch Repair','Inspection and repair of braking system and clutch plates to ensure safety and proper control during riding.','brakeclutchrepair.png','INR 1200');
INSERT INTO services ( id , name , description , image , price ) VALUES (6,'Bike Customization','Modify your bike with accessories, paint jobs, and styling upgrades to enhance appearance and uniqueness.','bikecustomization.png','INR 5000');
INSERT INTO services ( id , name , description , image , price ) VALUES (7,'Battery Check & Replacement','Battery inspection, charging, and replacement services to ensure reliable ignition and electrical performance.','batteryservice.png','INR 1500');
INSERT INTO services ( id , name , description , image , price ) VALUES (8,'Tyre Replacement','Replacement of worn-out tyres with high-quality new tyres for better grip, safety, and riding comfort.','tyrereplacement.png','INR 3000');
INSERT INTO services ( id , name , description , image , price ) VALUES (9,'Water Wash & Cleaning','Complete bike cleaning including foam wash, polishing, and detailing for a fresh and shiny look.','waterwash.png','INR 500');
INSERT INTO services ( id , name , description , image , price ) VALUES (10,'Water Wash & Cleaning','Complete bike cleaning including foam wash, polishing, and detailing for a fresh and shiny look.','waterwash.png','INR 500');
INSERT INTO users ( id , first_name , last_name , email , password , contact ) VALUES (1,'Koushiki','Verma','koushikiverma19@gmail.com','1904','9111173151');
INSERT INTO users ( id , first_name , last_name , email , password , contact ) VALUES (2,'First','Last','firstlast123@gmail.com','12345','9999911111');
INSERT INTO users ( id , first_name , last_name , email , password , contact ) VALUES (3,'riya','verma','riya123@gmail.com','12345','1111122222');


ALTER TABLE bikes AUTO_INCREMENT = 19;
ALTER TABLE users AUTO_INCREMENT = 4;
ALTER TABLE services AUTO_INCREMENT = 11;