import 'package:shared_preferences/shared_preferences.dart';

Future saveCreds(String creds) async {
  final preferences = await SharedPreferences.getInstance();

  preferences.setString("login", "creds");
}

final cafes = [
  {
    "hotelId": 1,
    "address": "Hotel Alankar, Karad",
    "addressURL": "https:/maps.app.goo.gl/7gT23bifXxzda7ES9",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 2,
    "address": "Hotel Sarovar, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/MrzQ9nRm7cb2ZyhX8",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 2,
    "texture": 2,
    "ambience": 4
  },
  {
    "hotelId": 3,
    "address": "Hotel Samudra, Pune",
    "addressURL": "https:/maps.app.goo.gl/yLxdaULfW2hbL5iZ8",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 4,
    "address": "Ramee International, Surat",
    "addressURL": "https:/maps.app.goo.gl/VYRkpj1ECNNnPCzc7",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 5,
    "address": "Hotel sangam, Karad",
    "addressURL": "https:/maps.app.goo.gl/CfiLBukD2ecESEPWA",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 3,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 6,
    "address": "Hotel Dehati, Pune",
    "addressURL": "https:/maps.app.goo.gl/4Yz9JB5pKxzyLCMG6",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 5,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 7,
    "address": "Hotel surve's, Pune",
    "addressURL": "https:/maps.app.goo.gl/iSAtVcJZktZpo4rg6",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 5,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 8,
    "address": "The Fern, Karad",
    "addressURL": "https:/maps.app.goo.gl/5LdmBtqRBv3KREEe7",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 2,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 9,
    "address": "Hotel Pankaj, Karad",
    "addressURL": "https:/maps.app.goo.gl/GAxdPmNNCDWE4BHG8",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 4,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 10,
    "address": "Hotel Radiant, Kolhapur",
    "addressURL": "https:/maps.app.goo.gl/dVBQ7VT8Law82Rc1A",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 2,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 11,
    "address": "Nisarg Sea Food, Pune",
    "addressURL": "https:/maps.app.goo.gl/LxYqhUnk1mMDEjTR9",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 4,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 12,
    "address": "Hotel Abhishek Veg, Pune",
    "addressURL": "https:/maps.app.goo.gl/Cez1gAFjkLfsNhMi7",
    "qualtity": 4,
    "quantity": 5,
    "authenticity": 4,
    "spicy": 3,
    "texture": 3,
    "ambience": 4
  },
  {
    "hotelId": 13,
    "address": "Pune Adda, Pune",
    "addressURL": "https:/maps.app.goo.gl/Ekbd9LKvneCcoe4j6",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 5,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 14,
    "address": "Hotel Shreyas, Pune",
    "addressURL": "https:/maps.app.goo.gl/8GDtAmitpfKv5sQMA",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 4,
    "spicy": 2,
    "texture": 4,
    "ambience": 3
  },
  {
    "hotelId": 15,
    "address": "Harvest Club, Pune",
    "addressURL": "https:/maps.app.goo.gl/WCT6qaiDVSJ7Z8qj7",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 5,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 16,
    "address": "JW Marriott Hotel, Pune",
    "addressURL": "https:/maps.app.goo.gl/dtT8nyutj9b5T9178",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 17,
    "address": "Saffron Vegetarian Restaurant, Pune",
    "addressURL": "https:/maps.app.goo.gl/bh43DuJmsDaFUutY6",
    "qualtity": 4,
    "quantity": 2,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 18,
    "address": "Hotel Opal, Kolhapur",
    "addressURL": "https:/maps.app.goo.gl/AJ3b8v6mLkViNV7Q7",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 4,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 19,
    "address": "Wadeshwar, Pune",
    "addressURL": "https:/maps.app.goo.gl/aweLVaTyhY1oYkTk9",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 20,
    "address": "Goodluck Cafe, Pune",
    "addressURL": "https:/maps.app.goo.gl/AVPHnkGroemfLDA39",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 4,
    "texture": 5,
    "ambience": 3
  },
  {
    "hotelId": 21,
    "address": "Sheetal Hotel, Pune",
    "addressURL": "https:/maps.app.goo.gl/oNkFqBTGoedkx7R57",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 22,
    "address": "Oblique Kitchen, Pune",
    "addressURL": "https:/maps.app.goo.gl/6LRSTsDaHKLCXtju8",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 23,
    "address": "Surtea, Surat",
    "addressURL": "https:/maps.app.goo.gl/Mr8shjvTNGX3oMXLA",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 4,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 24,
    "address": "The village rangoli restaurant, surat",
    "addressURL": "https:/maps.app.goo.gl/mUqGJXxrEJb3vrvD7",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 25,
    "address": "Kabbab culture, Surat",
    "addressURL": "https:/maps.app.goo.gl/BSnB1wtKpQ6KaMbw8",
    "qualtity": 4,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 5,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 26,
    "address": "Royal dine in, Surat",
    "addressURL": "https:/maps.app.goo.gl/hq9A5og6MgTbKrS68",
    "qualtity": 4,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 5,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 27,
    "address": "World of desserts, Surat",
    "addressURL": "https:/maps.google.com/?cid=4938202151609274881&entry=gps",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 5,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 28,
    "address": "Sri Raghavendra Davanagere Benne Dose, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/JeJi972MyXJdHqyA9",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 5,
    "texture": 5,
    "ambience": 3
  },
  {
    "hotelId": 29,
    "address": "Dal Roti Restaurant, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/mCotTeK5tUZJ8Hzf9",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 3
  },
  {
    "hotelId": 30,
    "address": "Sri Krishna Bhavan, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/Wk9YH1Dbh56BAq93A",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 2,
    "spicy": 4,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 31,
    "address": "Rasoi Restaurant, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/6dpahfBFXk7eLhRk7",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 5,
    "texture": 5,
    "ambience": 3
  },
  {
    "hotelId": 32,
    "address": "Chulha Chauki Da Dhaba, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/YbmZuXLfxcwTWZkj9",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 5,
    "texture": 5,
    "ambience": 4
  },
  {
    "hotelId": 33,
    "address": "Sri Upahar, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/2AL11FAE6Lc4LZGA7",
    "qualtity": 2,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 2,
    "ambience": 1
  },
  {
    "hotelId": 34,
    "address": "Paakashala, Bengaluru",
    "addressURL": "https:/maps.app.goo.gl/5gAhMd5RvJQPZjRe8",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 3
  },
  {
    "hotelId": 35,
    "address": "Burger mine, pune",
    "addressURL": "https:/maps.app.goo.gl/DxTvx44yBZkF8C2n7?g_st=ic",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 3
  },
  {
    "hotelId": 36,
    "address": "Khau galli, Ruia college mumbai",
    "addressURL": "https:/maps.app.goo.gl/dp1eG9D7t2CPD29v8",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 37,
    "address": "Khau galli, Juhu beach, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/Q1bEDc1AjrYT6jDp9",
    "qualtity": 4,
    "quantity": 5,
    "authenticity": 3,
    "spicy": 4,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 38,
    "address": "Mani's Cafe, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/jcyKjjXkpjUZLvU96",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 2,
    "texture": 4,
    "ambience": 3
  },
  {
    "hotelId": 39,
    "address": "Tawakkal Restaurant, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/MLgRNUiqbgGnQSzW6",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 2
  },
  {
    "hotelId": 40,
    "address": "Hotel Mauli, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/4BUyJJzYHhnLYhSA8",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 41,
    "address": "DP's Fast Food Center Matunga, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/Q5a2perKfsFa7RYR7",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 42,
    "address": "Bademiya, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/c73fSMPAf5Kqhiue6",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 43,
    "address": "Hariom, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/tAe6PUJYLAMVUvFGA",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 5,
    "spicy": 3,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 44,
    "address": "Bansuri, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/eRS9Kv29WKjeS6677",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 45,
    "address": "Leopold Cafe, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/SfiTKpba94nnLZLU8",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 2,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 46,
    "address": "Mumbai Bites (Girgaon), Mumbai",
    "addressURL": "https:/maps.app.goo.gl/CTpJL2MzoHv8MCFJ7",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 1,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 47,
    "address": "Greens Restaurant Malad, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/DwqB5kVM7HktG6En7",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 49,
    "address": "Copper Chimney, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/abcdefgh12345678",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 50,
    "address": "Shiv Sagar, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop98765432",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 2,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 51,
    "address": "Trishna, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/qrstuvwx56781234",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 52,
    "address": "Gajalee, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/yzabcd98762345123",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 53,
    "address": "Theobroma",
    "addressURL": "https:/maps.app.goo.gl/pqrstuvw23456789",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 2,
    "texture": 5,
    "ambience": 3
  },
  {
    "hotelId": 54,
    "address": "New Restaurant 1",
    "addressURL": "https:/maps.app.goo.gl/abcd1234efgh5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 4,
    "texture": 3,
    "ambience": 5
  },
  {
    "hotelId": 55,
    "address": "XYZ Eatery",
    "addressURL": "https:/maps.app.goo.gl/efgh5678abcd1234",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 2,
    "spicy": 3,
    "texture": 2,
    "ambience": 5
  },
  {
    "hotelId": 56,
    "address": "Seafood Delight",
    "addressURL": "https:/maps.app.goo.gl/5678abcd1234efgh",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 4,
    "spicy": 4,
    "texture": 5,
    "ambience": 3
  },
  {
    "hotelId": 57,
    "address": "spicy Bites",
    "addressURL": "https:/maps.app.goo.gl/1234efgh5678abcd",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 3,
    "texture": 4,
    "ambience": 2
  },
  {
    "hotelId": 58,
    "address": "Fusion Flavors",
    "addressURL": "https:/maps.app.goo.gl/gh5678abcd1234ef",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 2,
    "spicy": 4,
    "texture": 3,
    "ambience": 5
  },
  {
    "hotelId": 59,
    "address": "Mumbai Spice",
    "addressURL": "https:/maps.app.goo.gl/234efgh5678abcd1",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 60,
    "address": "Urban Kitchen",
    "addressURL": "https:/maps.app.goo.gl/78abcd1234efgh56",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 5
  },
  {
    "hotelId": 61,
    "address": "City Treats",
    "addressURL": "https:/maps.app.goo.gl/8abcd1234efgh567",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 62,
    "address": "Spice Lounge",
    "addressURL": "https:/maps.app.goo.gl/4efgh5678abcd123",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 3,
    "texture": 5,
    "ambience": 4
  },
  {
    "hotelId": 63,
    "address": "Exotic Eats",
    "addressURL": "https:/maps.app.goo.gl/5678abcd1234efgh",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 2,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 64,
    "address": "Coastal Cuisine",
    "addressURL": "https:/maps.app.goo.gl/gh5678abcd1234ef",
    "qualtity": 5,
    "quantity": 5,
    "authenticity": 4,
    "spicy": 4,
    "texture": 5,
    "ambience": 4
  },
  {
    "hotelId": 65,
    "address": "Mumbai Munch",
    "addressURL": "https:/maps.app.goo.gl/234efgh5678abcd1",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 2,
    "spicy": 3,
    "texture": 3,
    "ambience": 5
  },
  {
    "hotelId": 66,
    "address": "Spice Haven",
    "addressURL": "https:/maps.app.goo.gl/78abcd1234efgh56",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 67,
    "address": "Modern Bites",
    "addressURL": "https:/maps.app.goo.gl/8abcd1234efgh567",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 68,
    "address": "Pan Asian Delight",
    "addressURL": "https:/maps.app.goo.gl/4efgh5678abcd123",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 4,
    "texture": 5,
    "ambience": 4
  },
  {
    "hotelId": 69,
    "address": "Sizzling Spices",
    "addressURL": "https:/maps.app.goo.gl/5678abcd1234efgh",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 3,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 70,
    "address": "Savory Treats",
    "addressURL": "https:/maps.app.goo.gl/gh5678abcd1234ef",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 71,
    "address": "Urban Flavors",
    "addressURL": "https:/maps.app.goo.gl/234efgh5678abcd1",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 72,
    "address": "Urban Spice Delight, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 73,
    "address": "Sizzling Street, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 74,
    "address": "Tasty Treats, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 75,
    "address": "Flavorful Fusion, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 76,
    "address": "Spice Kingdom, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 77,
    "address": "City Sizzlers, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 78,
    "address": "Mumbai Grill House, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 79,
    "address": "Savoury Spices, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 80,
    "address": "Flavour Junction, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 81,
    "address": "Delicious Dine, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 82,
    "address": "spicy Delights, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 83,
    "address": "Taste of Mumbai, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 84,
    "address": "Mumbai Spice Hub, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 85,
    "address": "Urban Grill Express, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 86,
    "address": "Flavoursome Fare, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 87,
    "address": "Savoury Street, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 88,
    "address": "spicy Fusion Bistro, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 89,
    "address": "City Spice House, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 90,
    "address": "Mumbai Delicacies, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 91,
    "address": "Exquisite Eats, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 92,
    "address": "Fusion Fantasy, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 93,
    "address": "Spice Sensation, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 94,
    "address": "City Bites, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 95,
    "address": "Culinary Crafts, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 96,
    "address": "Mumbai Delight, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 97,
    "address": "Zesty Zest, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 98,
    "address": "Delicious Delights, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 99,
    "address": "Spice Symphony, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 100,
    "address": "City Spice Junction, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 101,
    "address": "Fusion Finesse, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 102,
    "address": "Mumbai Flavors, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 103,
    "address": "Spice Splendor, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 104,
    "address": "Culinary Connections, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 105,
    "address": "Mumbai Spice Trail, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 106,
    "address": "City Spice Haven, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 107,
    "address": "Fusion Feast, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 108,
    "address": "Mumbai Mingle, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 109,
    "address": "Spice Supreme, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 110,
    "address": "Delightful Dining, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 111,
    "address": "Mumbai Melange, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 112,
    "address": "Spice Elegance, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5,
    "ambience": 5
  },
  {
    "hotelId": 113,
    "address": "City Spice Whirl, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/3456789abcdefghij",
    "qualtity": 3,
    "quantity": 3,
    "authenticity": 3,
    "spicy": 2,
    "texture": 3,
    "ambience": 2
  },
  {
    "hotelId": 114,
    "address": "Mumbai Munchies, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/ijklmnop56781234",
    "qualtity": 4,
    "quantity": 4,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 115,
    "address": "Zestful Zing, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/56781234ijklmnop",
    "qualtity": 5,
    "quantity": 3,
    "authenticity": 5,
    "spicy": 4,
    "texture": 4,
    "ambience": 5
  },
  {
    "hotelId": 116,
    "address": "Delicious Diversity, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/mnop5678123456789",
    "qualtity": 3,
    "quantity": 4,
    "authenticity": 3,
    "spicy": 3,
    "texture": 3,
    "ambience": 3
  },
  {
    "hotelId": 117,
    "address": "Mumbai Munch, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/123456789mnop5678",
    "qualtity": 4,
    "quantity": 3,
    "authenticity": 4,
    "spicy": 4,
    "texture": 4,
    "ambience": 4
  },
  {
    "hotelId": 118,
    "address": "Spice Showcase, Mumbai",
    "addressURL": "https:/maps.app.goo.gl/uvwxyz56781234567",
    "qualtity": 5,
    "quantity": 4,
    "authenticity": 5,
    "spicy": 3,
    "texture": 5
  }
];
