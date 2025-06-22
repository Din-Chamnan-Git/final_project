import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Smit",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text("Let’s stream your favorite movie"),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 1,
                    bottom: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),

                      Expanded(
                        child: TextField(
                          style: TextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Find Here ",
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 18,
                        color: AppBarTheme.of(context).backgroundColor,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.clear_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
