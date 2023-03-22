import 'package:dio_api/view/user_list.dart';
import 'package:flutter/material.dart';

class MyIndex extends StatelessWidget {
  const MyIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [

      const Item(
          title: '#1',
          description: 'Making GET requests with Dio',
          url: '',
          widget : UserList()
      ),

    ];

    return
      ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return
          Card( //                           <-- Card widget
            child: ListTile(
              //leading: Icon(icons[index]),
              title: Text(items[index].title),
              subtitle: Text(items[index].description),
              onTap: () async {
                navigateToPage(context,items[index].widget);
              },
            ),
          );
      },
    );
  }
}

class Item {
  final String title;
  final String description;
  final String url;
  final Widget widget;

  const Item({
    required this.title,
    required this.description,
    required this.url,
    required this.widget,
  });
}

void navigateToPage(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => destination),
  );
}