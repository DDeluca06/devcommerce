# devcommerce
ECommerce MySQL database and test application.

# Prerequisites
- Node.JS v20.18.0 or later
- NPM 10.8.2 or later
- Reading Capability (this one's very important)

# Modules Used
All listed modules also include their dependencies.
- Sequelize
- Nodemon
- Dotenv (.env not included, duh)
- MySQL2

# File System
```
├── node_modules          # Node modules. 
├── app.mjs               # The app, as lazily built as lazy comes.
├── incentive.sql         # SQL statements to create the DB and tables, with example data.
├── versions.png          # If you missed the README prerequisites (a big one at that), here's a PNG version.
├── package-lock.json     # Packages, but locked.
├── package.json          # Packages.
├── LICENSE               # This is where I would put the license, if I had one.
└── README.md             # You're reading it. Like right now.
```
# Reflection Questions
1. How do primary and foreign keys help maintain data integrity?
  a. By designating primary and foreign keys inside of your tables, you are able to uniquely identify data and maintain structure within your database, thus enabling you to keep data integrity.
2. What insights can be gained by joining multiple tables?
  a. There's plenty of insight to be gained from joining tables, predominately organizing customer data and retrieving values such as total revenue on a per customer basis.
3. How can aggregate functions summarize data?
  a. Aggregation functions create room for collumns to be created within MySQL without the need for back-end or server-sided assistance, getting the averages of values and sum of simple mathematical equations.
4. What types of analyses are enabled by date functions?
  a. Date functions allow us to analyse times, dates, and essential filtering to allow for effective scraping of data. Rather than scouring an entire timeline, focus on a specific point in time.
5. How might you extend this database for additional e-commerce features?
  a. I would personally like to extend the database to include discounts and a cart system, giving the potential to build it out into a full fledged and proper ecommerce platform.
