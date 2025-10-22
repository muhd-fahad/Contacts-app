import 'package:contacts/model/contact_model.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:contacts/screens/update_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedScreen extends StatelessWidget {
  final int index;
  final Contact contact;

  const DetailedScreen({super.key, required this.contact,required this.index});

  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<ContactProvider>(context) ;
    final data = context.watch<ContactProvider>() ;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 40),
              Text(contact.name, style: TextStyle(fontSize: 28)),
              Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.call),
                  Text(contact.phone, style: TextStyle(fontSize: 20)),
                ],
              ),
              // SizedBox(height: 24),
              Spacer(),
              Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.error,
                          ),
                        ),
                        icon: Icon(Icons.delete_outline_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                          data.deleteContact(index);

                        },
                        label: Text('Delete'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateContactScreen(index: index),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Edit'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
