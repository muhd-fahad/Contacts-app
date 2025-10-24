import 'package:contacts/model/contact_model.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateContactScreen extends StatelessWidget {
  final Contact contact;

  const UpdateContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final contactProvider = context.read<ContactProvider>();
    final initialData = contact;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController(text: initialData.name);
    final TextEditingController phoneController = TextEditingController(text: initialData.phone);
    final TextEditingController emailController = TextEditingController(
        text: initialData.email);

    void submit() async {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        final newContact = Contact(id: initialData.id,
            name: nameController.text,
            phone: phoneController.text,
            email: emailController.text);
        await contactProvider.updateContact(newContact);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Contact')),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: CircleAvatar(radius: 40,
                      child: Icon(Icons.account_circle_outlined, size: 48),)),
                    const Text('Name'),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),),
                        hintText: 'Enter name',
                      ),
                      textInputAction: TextInputAction.next,
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
                          borderRadius: BorderRadius.circular(12),),
                        hintText: 'Enter phone number',
                      ),
                      textInputAction: TextInputAction.next,
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
                    const Text('Email'),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),),
                        hintText: 'Enter Email',
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submit(),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone email is required';
                        }
                        // else if (value.length != 10) {
                        //   return 'Enter valid phone number ';
                        // }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // const Spacer(),
                Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
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
                    Flexible(
                      fit: FlexFit.tight,
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
                SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
