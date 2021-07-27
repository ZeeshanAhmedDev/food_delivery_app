import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/recent_orders.dart';
import 'package:food_delivery_app/screens/restaurant_screen.dart';
import 'package:food_delivery_app/widgets/rating_stars.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  buildRestaurants() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantScreen(restaurant: restaurant),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                width: 1.0,
                color: Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: restaurant.imageUrl,
                    child: Image(
                      height: 150.0,
                      width: 150.0,
                      image: AssetImage(restaurant.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        RatingStars(restaurant.rating),
                        SizedBox(height: 4.0),
                        Text(
                          restaurant.address,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '0.2 miles away',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Zeeshan Rehman'),
              accountEmail: Text('shanisukk@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/burger.jpg'),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.home_filled,
                  size: 30.0,
                ),
                title: Text('Home')),
            ListTile(
                leading: Icon(
                  Icons.history,
                  size: 30.0,
                ),
                title: Text('Order History')),
            ListTile(
                leading: Icon(Icons.favorite_border, size: 30.0),
                title: Text('Favourite Orders')),
            ListTile(
                leading: Icon(Icons.event_note_outlined, size: 30.0),
                title: Text('My Addresses')),
            ListTile(
                leading: Icon(Icons.credit_card, size: 30.0),
                title: Text('Foodies Credit')),
            ListTile(
                leading: Icon(Icons.doorbell_outlined, size: 30.0),
                title: Text('Notifications')),
            ListTile(
                leading: Icon(Icons.question_answer_outlined, size: 30.0),
                title: Text('FAQs')),
            ListTile(
                leading: Icon(Icons.star_border_outlined, size: 30.0),
                title: Text('Rate Us')),
            ListTile(
                leading: Icon(Icons.feedback_outlined, size: 30.0),
                title: Text('Send Feedback')),
          ],
        ),
      ),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.account_circle),
        //   iconSize: 30.0,
        //   onPressed: () {},
        // ),
        title: Text('Foodies'),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              'Cart (${currentUser.cart.length})',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.grey.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Search Food or Restaurants',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Nearby Restaurants',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              buildRestaurants(),
            ],
          ),
        ],
      ),
    );
  }
}
