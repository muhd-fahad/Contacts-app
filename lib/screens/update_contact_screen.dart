import 'package:contacts/model/contact_model.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateContactScreen extends StatelessWidget {
  final int index;

  const UpdateContactScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final contactProvider = context.read<ContactProvider>();
    // Get the current contact data to pre-populate fields
    final initialData = contactProvider.contact[index];

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Initialize controllers with existing contact data
    final TextEditingController nameController = TextEditingController(
      text: initialData.name,
    );
    final TextEditingController phoneController = TextEditingController(
      text: initialData.phone,
    );

    void submit() {
      final isValid = formKey.currentState!.validate();

      if (isValid) {
        // --- Use the new updateContact method ---
        contactProvider.updateContact(
          index,
          Contact(name: nameController.text, phone: phoneController.text),
        );
        // ----------------------------------------

        // Pop twice: once for the Update screen, once for the Detailed screen
        // to show the updated list on the Home screen.
        // Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pop(context);
        // No need to clear controllers if popping the screen
      }
    }

    return Scaffold(
      // Updated title
      appBar: AppBar(title: const Text('Edit Contact')),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: CircleAvatar(radius: 48)),
              const Text('Name'),
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
              const Text('Phone number'),
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
              const Spacer(),
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
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: submit,
                        child: const Text('Save Changes'),
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
