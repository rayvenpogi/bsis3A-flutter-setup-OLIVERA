import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: MiniForm(), debugShowCheckedModeBanner: false),
  );
}

class MiniForm extends StatefulWidget {
  const MiniForm({super.key});

  @override
  State<MiniForm> createState() => _MiniFormState();
}

class _MiniFormState extends State<MiniForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final messageController = TextEditingController();

  String displayName = "";
  String displayMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Form"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: messageController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: "Message"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          displayName = nameController.text;
                          displayMessage = messageController.text;
                        });
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),

            const Divider(height: 40),

            if (displayName.isNotEmpty)
              Card(
                child: ListTile(
                  title: Text("Name: $displayName"),
                  subtitle: Text("Message: $displayMessage"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
