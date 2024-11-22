// Importing Sequelize and dotenv
import { Sequelize, DataTypes } from 'sequelize';
import dotenv from 'dotenv';

// Load env variables
dotenv.config();

// Create our Sequelize instance!
const sequelize = new Sequelize(
    process.env.DB_NAME, // Database name
    process.env.DB_USER, // Username
    process.env.DB_PASSWORD, // Password (totally didn't have to try 40 times to get this one right)
    {
        host: process.env.DB_HOST, // Host
        port: process.env.DB_PORT, // Port
        dialect: process.env.DB_DIALECT, // Dialect (e.g., 'mysql')
        logging: false // You do NOT need all of this output, just give me my print statements and leave me alone
                            // Future Demitri here (11 PM): ^ This guy doesn't know what he's talking about, you probably should toggle this as you need it.
    }
);

// Defining/'Creating' the Customer model
const Customer = sequelize.define('Customer', {
    customerid: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
        unique: true,
    },
    regdate: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    first_name: {
        type: DataTypes.STRING(20),
        allowNull: false,
    },
    last_name: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    email: {
        type: DataTypes.STRING(50),
        unique: true,
        allowNull: false,
    },
    phone: {
        type: DataTypes.STRING(15),
        unique: true,
        allowNull: false,
    },
    address: {
        type: DataTypes.STRING(90),
        unique: true,
        allowNull: false,
    },
    city: {
        type: DataTypes.STRING(58),
        allowNull: false,
    },
    state: {
        type: DataTypes.STRING(2),
        allowNull: false,
    },
    zip: {
        type: DataTypes.STRING(9),
        allowNull: false,
    },
}, {
    tableName: 'customers',
    timestamps: false, // Disables timestamps (I.E: createdAt, updatedAt)
});

// Test the connection
const testConnection = async () => {
    try {
        await sequelize.authenticate();
        console.log(`We're in, Captain!`);
    } catch (error) {
        console.error('You did SOMETHING wrong. Good luck:', error); // I LOVE SARCASM!!!!!
    }
};

// Syncronizing the model
const syncModel = async () => {
    try {
        await sequelize.sync();
        console.log(`Syncronized!`);
    } catch (error) {
        console.error('Something went wrong! Take a cryptic, unhelpful message:', error); // I LOVE SARCASM!!!!!
    }
};

// Calling functions
testConnection();
syncModel();
