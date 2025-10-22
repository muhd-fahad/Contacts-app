import 'package:contacts/model/contact_model.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final contact = context.read<ContactProvider>();

    void submit() {
      final isValid = formKey.currentState!.validate();

      if (isValid) {
        contact.addContact(
          Contact(name: nameController.text, phone: phoneController.text),
        );
        Navigator.pop(context);

        nameController.clear();
        phoneController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Add new contact')),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: CircleAvatar(radius: 48)),
              Text('Name'),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter name',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              Text('Phone number'),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  } else if (value.length != 10) {
                    return 'Enter valid phone number ';
                  }
                  return null;
                },
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
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: () {
                          submit();
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
