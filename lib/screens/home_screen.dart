import 'package:contacts/provider/contact_provider.dart';
import 'package:contacts/screens/add_contact_screen.dart';
import 'package:contacts/screens/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton.filledTonal(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
              icon: Icon(Icons.dark_mode),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Consumer<ContactProvider>(
          builder: (context, contactData, _) {
            final totalCount = contactData.contact.length;
            if (contactData.contact.isEmpty) {
              return Center(child: Text('No Contacts found!'));
            } else {
              return Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$totalCount contact${totalCount > 1 ? 's' : ''}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: totalCount,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedScreen(
                                    index: index,
                                    contact: contactData.contact[index],
                                  ),
                                ),
                              );
                            },
                            title: Text(contactData.contact[index].name),
                            subtitle: Text(contactData.contact[index].phone),
                            leading: CircleAvatar(
                              child: Icon(Icons.account_circle_outlined),
                            ),
                            trailing: Icon(Icons.chevron_right_rounded),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
