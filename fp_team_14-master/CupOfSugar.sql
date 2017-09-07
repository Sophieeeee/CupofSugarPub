/*Only dropping so that we can re-run this code*/ 
DROP DATABASE IF EXISTS cupOfSugar; #Dangerous line of code
CREATE DATABASE cupOfSugar;

USE cupOfSugar;

/*All users will be stored on one table. Can be pulled by typeOfUser*/
CREATE TABLE Users(
	uuid INT(11) PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    accountBalance FLOAT(24) NOT NULL,
    address VARCHAR(100) NOT NULL,
    typeOfUser VARCHAR(10) NOT NULL,
    /*if the shopper is taken or not*/
    shopperStatus VARCHAR(10)
);

/*Table of stores*/
CREATE TABLE Stores(
	uuid INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    image VARCHAR(200)
);

/*Links categories with appropriate stores*/
CREATE TABLE Categories(
	category VARCHAR(15) NOT NULL,
    store INT(11),
    FOREIGN KEY fk1(store) REFERENCES Stores(uuid)
);

/*Each row will indicate 1 shopper's availability - store and time*/
CREATE TABLE AvailableIntervals(
	uuid INT(11) PRIMARY KEY auto_increment,
	shopper INT(11),
    store INT(11),
    timeInterval INT(3), /*time will be an integer from 0 to 24*/
    intervalStatus VARCHAR(10) NOT NULL,
    FOREIGN KEY fk1(shopper) REFERENCES Users(uuid),
    FOREIGN KEY fk2(store) REFERENCES Stores(uuid)
);

/*Each row represents one item available at a store*/
CREATE TABLE Items(
	uuid INT(11) PRIMARY KEY AUTO_INCREMENT,
    itemName VARCHAR(100),
    category VARCHAR(50),
    image VARCHAR(200)
);

CREATE TABLE StoreToItems(
	uuid INT(11) PRIMARY KEY AUTO_INCREMENT,
    storeID INT(11),
    itemID INT(11),
    price FLOAT(24)
);

/*A cart is just a customer-item relationship
 *Delete the rows where customer==uuid to delete that customer's cart*/
CREATE TABLE Cart(
	customer INT(11),
    intervalTime INT(11),
    item INT(11),
    quantity INT(11),
    FOREIGN KEY fk1(customer) REFERENCES Users(uuid),
    FOREIGN KEY fk3(item) REFERENCES StoreToItems(uuid)
);

CREATE TABLE ConfirmedOrders(
	customer INT(11) NOT NULL,
    shopper INT(11) NOT NULL,
    store INT(11) NOT NULL,
    chosenInterval INT(11) NOT NULL,
    orderStatus VARCHAR(15),
    customerOrderFeedback VARCHAR(250),
    shopperOrderFeedback VARCHAR(250),
    orderRating INT(10),
    FOREIGN KEY fk1(customer) REFERENCES Users(uuid),
    FOREIGN KEY fk2(shopper) REFERENCES Users(uuid),
    FOREIGN KEY fk3(chosenInterval) REFERENCES AvailableIntervals(uuid),
    FOREIGN KEY fk4(store) REFERENCES Stores(uuid)
);

/**Prepopulate some values**/
INSERT INTO Users(email, password, fname, lname, accountBalance, address, typeOfUser, shopperStatus) 
	VALUES	('guest@guest.com','1234','Guest','McGuesterson', 0, '840 Childs Way, Los Angeles, CA 90089','customer','customer'),
			('customer1@aol.com','1234','Peaches','ScarletBuns', 20, '3335 S Figueroa St, Los Angeles, CA 90007','customer','customer'),
			('customer2@aol.com','1234','Eddo','Hintoso', 20, '920 W 37th Place, Los Angeles, CA 90089','customer','customer'),
            ('shopper1@aol.com','1234','Hildibrand','Fallohide', 10, '325 W Adams Blvd, Los Angeles, CA 90007','shopper','available'),
			('shopper2@aol.com','1234','Gwen','Lovejoy', 10, '1292 W 29th Street, Los Angeles, CA 90007','shopper','available'),
            ('shopper3@aol.com','1234','Tommy','Trojan', 10, '3551 Trousdale Pkwy, Los Angeles, CA 90089','shopper','available'),
            ('nnamasiv@usc.edu','1234','Nandhini','Sivam', 10, '3335 S Figueroa St, Los Angeles, CA 90007','shopper','available'),
            ('shopper5@aol.com', '1234', 'Sophie', 'Wang', 10, 'USC USC USC USC USC', 'shopper', 'available');

INSERT INTO Stores(name, address, image)
	VALUES	('Ralphs', '2600 S Vermont Ave, Los Angeles, CA 90007','https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Ralphs.svg/2000px-Ralphs.svg.png'),
			('Vons','3461 W 3rd St, Los Angeles, CA 90020','https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Vons_logo.svg/1200px-Vons_logo.svg.png'),
            ('Food4Less','1748 W Jefferson Blvd, Los Angeles, CA 90018','https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Food4Less_logo.svg/2000px-Food4Less_logo.svg.png'),
            ('Trader Joes', '263 S La Brea Ave, Los Angeles, CA 90036','http://www.movinshoesmadison.com/fullmoonrun/wp-content/uploads/2015/04/traderjoes.png'),
            ('Whole Foods', '3607 S Vermont Ave, Los Angeles, CA 90007','https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Whole_Foods_Market_logo.svg/543px-Whole_Foods_Market_logo.svg.png'),
            ('Target', 'FIGat7th, 735 S Figueroa St, Los Angeles, CA 90017','http://static.wixstatic.com/media/4a07ef_dd6b5375b3ab4811865ac03536efd67a~mv2.png'),
            ('Macys', 'FIGat7th, 735 S Figueroa St #303, Los Angeles, CA 90017','http://static.wixstatic.com/media/4a07ef_dd6b5375b3ab4811865ac03536efd67a~mv2.png'),
            ('Forever 21', 'Beverly Center, 8500 Beverly Blvd #835, Los Angeles, CA 90048','http://static.wixstatic.com/media/4a07ef_dd6b5375b3ab4811865ac03536efd67a~mv2.png'),
            ('CVS', '3335 S Figueroa St q, Los Angeles, CA 90007','https://www.cvshealth.com/newsroom/media-gallery-and-corporate-logos/cvs-health-logos?download_file=/sites/default/files/cvs-pharmacy-logo.png'),
            ('Walgreens', '617 W 7th St, Los Angeles, CA 90017','https://upload.wikimedia.org/wikipedia/en/thumb/6/65/Walgreens_Logo.svg/1280px-Walgreens_Logo.svg.png');

INSERT INTO Categories(category, store)
	VALUES	('grocery',1),
			('grocery',2),
            ('grocery',3),
            ('grocery',4),
            ('grocery',5),
            ('grocery',6),
            ('clothing',6),
            ('clothing',7),
            ('clothing',8),
            ('convenience',9),
            ('convenience',10),
            ('health',9),
            ('health',10);

INSERT INTO AvailableIntervals(shopper,store,timeInterval,intervalStatus)
	VALUES	(7, 9, 8, 'available'),
			(4, 9, 15, 'available'),
            (5, 9, 17, 'available');

INSERT INTO Items(itemName, category, image) 
	VALUES	('Ardell Pro Brow Building Fiber Gel', 'beauty', 'http://www.cvs.com/bizcontent/merchandising/productimages/large/74764656513.jpg'),
			('Maybelline Line Stiletto', 'beauty', 'https://www.maybelline.com/~/media/mny/global/eye-makeup/eyeliner/line-stiletto-ultimate-precision-liquid-eyeliner/maybelline-eyeliner-line-stiletto-blackest-black-041554209440-o.jpg'),
            ('Nars Radiant Concealer', 'beauty', 'http://ghk.h-cdn.co/assets/15/19/nars-radiant-creamy-concealer.jpg'),		('Neutrogena Makeup Remover Cleansing Wipes', 'beauty', 'http://theeverygirl.com/sites/default/files/articles/inlineimages/neutrogena.jpg'),
			('Neutrogena Daily Scrub', 'beauty', 'https://www.cvs.com/bizcontent/merchandising/productimages/large/70501022047.jpg'),
            ('Aveeno Lotion', 'beauty', 'https://i5.walmartimages.com/asr/2b15cc21-8d6e-4887-818a-19f13ebbd5f5_1.28e8f5c5dcb374fbdd8b8ccd978aac33.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF'),
            ('Vaseline Lotion', 'beauty', 'https://i5.walmartimages.com/asr/a62365c3-e408-4cc8-b789-5a60f4796129_1.576e7b35aace57514fbef5af566a4a0f.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF'),
            ('St. Ives Oatmeal Scrub', 'beauty', 'https://media2.s-nbcnews.com/j/newscms/2016_36/1157135/st-_ives-facewash-today-015_30fee7d72a645ab7a71819a434d3f4ed.today-inline-large.jpg'),
            ('Dove Men+Care', 'beauty', 'http://bpc.h-cdn.co/assets/16/08/1456181665-dove-men-extra-fresh-deodorant.jpg'),
            ('Irish Spring Body Wash', 'beauty', 'https://i5.walmartimages.com/asr/09f3a191-f350-4aff-ba29-b7fbd5bee503_1.35ef933f0425f37753f5adf188b3af62.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF'),
            ('DayQuil Severe', 'health', 'https://images-na.ssl-images-amazon.com/images/I/911PRkoXqnL._SY355_.jpg'),
            ('Delsym Cough Syrup', 'health', 'https://images-na.ssl-images-amazon.com/images/I/51jxvSn5MYL.jpg'),
            ('Claratin Allergy Tablets', 'health', 'https://images-na.ssl-images-amazon.com/images/I/513tD-javIL.jpg'),
            ('Advil', 'health', 'http://target.scene7.com/is/image/Target/14959066?wid=520&hei=520&fmt=pjpeg'),
            ('ACE Bandage', 'health', 'https://i5.walmartimages.com/asr/36461e7b-d4b7-4fa3-84c0-828a9c7d172e_1.6ee58da48e9a75ce7759def92e3325f2.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF'),
            ('Bandaid Tough Strips', 'health', 'https://s-media-cache-ak0.pinimg.com/736x/35/bb/ae/35bbae24762d602a9a827b44d858f808.jpg'),
            ('Nature Maid Vitamin C 1000mg', 'health', 'http://richmedia.channeladvisor.com/ImageDelivery/imageService?profileId=52000717&imageID=105362176&recipeId=243'),
            ('One-A-Day For Men', 'health', 'https://i5.walmartimages.com/asr/9409aed7-a121-42d7-a107-4257f549f586_1.5f89478ef51a33096019498c8fd64a5f.jpeg'),
            ('Neosporin', 'health', 'https://www.neosporin.com/sites/neosporin_us/files/product-images/pain-relief-ointment.png'),
            ('Emergen-C 1000mg', 'health', 'https://images-na.ssl-images-amazon.com/images/I/5175m%2BnTIfL._SX355_.jpg'),
			('Bounty 2 Ply 48 Sheets', 'Household', 'https://resources.cleanitsupply.com/LARGE/USSCO/259910.JPG'),
			('Brawny Paper Towel Roll Regular 6CT', 'Household', 'http://www.cvs.com/bizcontent/merchandising/productimages/large/4200043908.jpg'),
			('CVS Forks', 'Household', 'http://www.cvs.com/bizcontent/merchandising/productimages/large/5042845780.jpg'),
			('Dixie 3ox Bathroom Cups', 'Household', 'https://pics.drugstore.com/prodimg/84209/450.jpg'),
			('Kleenex Everyday Facial Tissues 85CT', 'Household', 'http://ecx.images-amazon.com/images/I/51Pq92XFYIL.jpg'),
            ('Puffs Plus Lotion 124CT', 'Household', 'https://images-na.ssl-images-amazon.com/images/G/01/aplus/detail-page/B004FH8PLA_puffs_201311267_4627_lg.jpg'),
            ('CVS Flushable Ultra Soft Cleansing Wipes', 'Household', 'http://www.cvs.com/bizcontent/merchandising/productimages/large/5042846675.jpg'),
            ('Alvarado Street Bakery Bread Organic Sprouted 100% Whole Wheat','Bakery','https://shop.safeway.com/productimages/100x100/960191449_100x100.jpg'),
			('Baguette French Demi La Brea', 'Bakery','https://shop.safeway.com/productimages/100x100/960217783_100x100.jpg'),
			('Bakery Bread Filone Artisan Plain', 'Bakery', 'https://shop.safeway.com/productimages/100x100/194010326_100x100.jpg'),
			('Colombo Extra Sour French 24 Oz', 'Bakery', 'https://shop.safeway.com/productimages/100x100/960112545_100x100.jpg'),
			('Colombo Garlic Bread 10 Oz', 'Bakery', 'https://shop.safeway.com/productimages/100x100/960133008_100x100.jpg'),
            ('Daves Killer Bread Organic Honey Oats', 'Bakery','https://shop.safeway.com/productimages/100x100/960165877_100x100.jpg'),
			('Daves Killer Bread Organic Powerseed', 'Bakery', 'https://shop.safeway.com/productimages/100x100/960165878_100x100.jpg'),
			('Eureka Bread Organic Grainiac', 'Bakery', 'https://shop.safeway.com/productimages/100x100/960139383_100x100.jpg'),
            ('Ball Park Hot Dog Buns', 'Bakery', 'https://shop.safeway.com/productimages/100x100/196050123_100x100.jpg'),
            ('Orowheat Bread Dill Rye', 'Bakery', 'https://shop.safeway.com/productimages/100x100/196050786_100x100.jpg'),
			('Apples Cripps Pink', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184020011_100x100.jpg'),
			('Apples Fuji Large', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184020066_100x100.jpg'),
			('Apples Gala Organic', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184700038_100x100.jpg'),
			('Bananas', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184060007_100x100.jpg'),
			('Blackberries Prepacked 18 Oz', 'Fruit', 'https://shop.safeway.com/productimages/100x100/960041218_100x100.jpg'),
			('Blueberries Prepacked 6 Oz', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184070083_100x100.jpg'),
			('Strawberries Prepacked 1 Lb', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184070124_100x100.jpg'),
			('Grapes Green Seedless 2 Lbs', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184100014_100x100.jpg'),
            ('Artichokes Jumbo Organic', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184710364_100x100.jpg'),
			('Asparagus Green', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184260003_100x100.jpg'),
			('Peas Sugar Snap', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184470015_100x100.jpg'),
			('Broccoli', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184290003_100x100.jpg'),
			('Brussel Sprouts', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184300031_100x100.jpg'),
			('Carrots', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184320053_100x100.jpg'),
			('Garlic', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184390060_100x100.jpg'),
			('Bell Peppers Orange', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184480013_100x100.jpg'),
			('A2 Milk 2% 1 Half Gallon', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960158210_100x100.jpg'),
			('Clover Organic Milk Fat Free Gallon', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960127253_100x100.jpg'),
			('Clover Organic Milk Lowfat 1% Quart', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960127256_100x100.jpg'),
			('Lucerne Milk Fat Free Gallon', 'Dairy', 'https://shop.safeway.com/productimages/100x100/136010127_100x100.jpg'),
			('Lucerne Milk Lowfat 1% Half Gallon', 'Dairy', 'https://shop.safeway.com/productimages/100x100/136010145_100x100.jpg'),
			('Baileys Coffee Creamer French Vanilla', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960140713_100x100.jpg'),
			('Coffee-mate Coffee Creamer Liquid Hazelnut', 'Dairy', 'https://shop.safeway.com/productimages/100x100/136450057_100x100.jpg'),
			('Challenge Butter', 'Dairy', 'https://shop.safeway.com/productimages/100x100/138250107_100x100.jpg'),
            ('Swiffer Sweeper X-tra Large', 'Household', 'http://www.homedepot.com/catalog/productImages/1000/8c/8c7632e7-f5bb-47be-abb4-273cece335ad_1000.jpg'),
            ('Febreze Extra Strength', 'Household', 'http://doesitreallywork.org/wp-content/uploads/2012/12/Does-Febreze-work.jpg'),
            ('Tide Pods 3-in-1', 'Household', 'https://images-na.ssl-images-amazon.com/images/I/81%2BmsSFxl1L._SY355_.jpg'),
            ('Bounty 8-Pack', 'Household', 'http://whatsyourdeal.com/grocery-coupons/wp-content/uploads/2014/03/bounty.jpg'),
            ('Kleenex Tissues', 'Household', 'http://www.careersatkc.com/media/62989/61250305_the-original-46mm-uk-shared-carton_3d_lr.jpg'),
            ('Avocado Hass Large', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184040158_100x100.jpg'),
            ('Organic Grapefruit', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184700244_100x100.jpg'),
            ('Limes', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184080409_100x100.jpg'),
            ('Watermelon', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184110224_100x100.jpg'),
            ('Bosc Pears', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184120608_100x100.jpg'),
            ('Red Seedless Grapes', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184100012_100x100.jpg'),
            ('Green Seedless Grapes', 'Fruit', 'https://shop.safeway.com/productimages/100x100/184100014_100x100.jpg'),
            ('Large Brown Eggs', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960225901_100x100.jpg'),
            ('Eggbeaters', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960120604_100x100.jpg'),
            ('Challenge Butter 16oz', 'Dairy', 'https://shop.safeway.com/productimages/100x100/138250107_100x100.jpg'),
            ('Daisy Light Sour Cream', 'Dairy', 'https://shop.safeway.com/productimages/100x100/136200038_100x100.jpg'),
            ('Kerrygold Irish Butter', 'Dairy', 'https://shop.safeway.com/productimages/100x100/138250237_100x100.jpg'),
            ('Earth Balance Organic Whipped Buttery Spread', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960086143_100x100.jpg'),
            ('Signature Breadsticks', 'Dairy', 'https://shop.safeway.com/productimages/100x100/960045025_100x100.jpg'),
            ('Mediterranean Pita Pockets', 'Bakery', 'https://shop.safeway.com/productimages/100x100/196100846_100x100.jpg'),
            ('Orowheat Hot Dog Buns', 'Bakery', 'https://shop.safeway.com/productimages/100x100/196050070_100x100.jpg'),
            ('Organic Sprouted Sonoma Sun Bread', 'Bakery', 'https://shop.safeway.com/productimages/100x100/960188323_100x100.jpg'),
            ('Filone Artisan', 'Bakery', 'https://shop.safeway.com/productimages/100x100/960014102_100x100.jpg'),
            ('Carrots', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184320053_100x100.jpg'),
            ('Cabbage', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184310009_100x100.jpg'),
            ('Green Bell Peppers', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/184480005_100x100.jpg'),
            ('Organic Golden Brown Potatoes', 'Vegetables', 'https://shop.safeway.com/productimages/100x100/960049154_100x100.jpg'),
            ('Okra', 'Vegetables', 'http://pinoyrecipe-27b1.kxcdn.com/wp-content/uploads/2014/07/okra-health-benefits.jpg'),
            ('Spinach', 'Vegetables', 'http://cdn3-www.wholesomebabyfood.momtastic.com/assets/uploads/2015/04/baby-spinach.jpg'),
            ('Eggplant', 'Vegetables', 'https://media.mercola.com/assets/images/foodfacts/eggplant-fb.jpg'),
            ('Lotus Root', 'Vegetables', 'http://www.knorr.pk/Images/2796/2796-873442-Lotus%20Root%20copy.jpg');




/*Inserting Items into CVS*/
INSERT INTO StoreToItems(storeID, itemID, price)
	VALUES	(9, 1, 4.21),
			(9, 2, 6.35),
            (9, 3, 8.90),
            (9, 4, 6.65),
            (9, 5, 5.25),
            (9, 6, 3.75),
            (9, 7, 3.50),
            (9, 8, 5.39),
            (9, 9, 4.29),
			(9, 10, 7.39),
            (9, 11, 2.99),
            (9, 12, 4.69),
            (9, 13, 3.29),
            (9, 14, 6.79),
            (9, 15, 5.59),
            (9, 16, 4.39),
            (9, 17, 2.39),
            (9, 18, 5.69),
            (9, 19, 1.29),
            (9, 20, 1.79),
            (9, 21, 3.69),
            (9, 22, 1.29),
            (9, 23, 1.59),
            (9, 24, 2.59),
            (9, 25, 3.39),
            (9, 26, 4.59),
            (9, 27, 3.99),
            (1, 28, 5.59),
            (1, 29, 1.99),
            (1, 30, 2.29),
            (1, 31, 5.99),
            (1, 32, 3.99),
            (1, 33, 2.29),
            (1, 34, 6.79),
            (1, 35, 4.99),
            (1, 36, 5.39),
            (1, 37, 5.59),
            (1, 38, 1.00),
            (1, 39, 0.99),
            (1, 40, 2.99),
            (1, 41, 0.99),
            (1, 42, 4.49),
            (1, 43, 4.99),
            (1, 44, 6.39),
            (1, 45, 11.59),
            (1, 46, 6.59),
            (1, 47, 5.69),
            (1, 48, 3.99),
            (1, 49, 4.49),
            (1, 50, 3.39),
            (1, 51, 4.99),
            (1, 52, 6.39),
            (1, 53, 1.79),
			(1, 54, 4.59),
            (1, 55, 5.69),
            (1, 56, 4.99),
            (1, 57, 4.49),
            (1, 58, 3.39),
            (1, 59, 4.99),
            (1, 60, 6.39),
            (1, 61, 3.79),
            (9, 62, 13.99),
            (9, 63, 2.78),
            (9, 64, 5.69),
            (9, 65, 8.99),
            (9, 66, 1.50),
            (1, 67, 2.79),
            (1, 68, 2.69),
            (1, 69, 0.60),
            (1, 70, 11.19),
            (1, 71, 1.40),
            (1, 72, 8.98),
            (1, 73, 11.18),
            (1, 74, 4.99),
            (1, 75, 4.49),
            (1, 76, 4.49),
            (1, 77, 4.19),
            (1, 78, 4.49),
            (1, 79, 5.09),
            (1, 80, 4.49),
            (1, 81, 3.99),
            (1, 82, 3.99),
            (1, 83, 5.59),
            (1, 84, 1.69),
            (1, 85, 0.17),
            (1, 86, 1.39),
            (1, 87, 1.40),
            (1, 89, 4.49),
            (1, 90, 1.20),
            (1, 91, 0.60),
            (1, 92, 0.34),
            (1, 93, 1.60);



