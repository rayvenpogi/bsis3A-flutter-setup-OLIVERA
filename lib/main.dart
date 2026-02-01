import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MiniForm(),
    debugShowCheckedModeBanner: false,
  ));
}

// 1. THE CLASS (The "Mini-Component" for your screen)
class MiniForm extends StatefulWidget {
  const MiniForm({super.key});

  @override
  State<MiniForm> createState() => _MiniFormState();
}

class _MiniFormState extends State<MiniForm> {
  // 2. THE TOOLS (Variables and Controllers)
  // The "Security Guard" for the form
  final _formKey = GlobalKey<FormState>();

  // The "Remote Controls" for the input boxes
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  // Variables to hold the data for the "Preview" section
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
            // 3. THE FORM (The wrapper for inputs)
            Form(
              key: _formKey, // Connecting the security guard
              child: Column(
                children: [
                  // Full Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    // Simple logic: if empty, return error text
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Message Field
                  TextFormField(
                    controller: messageController,
                    maxLines: 3, // Multi-line requirement
                    decoration: const InputDecoration(labelText: "Message"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // 4. THE SUBMIT BUTTON
                  ElevatedButton(
                    onPressed: () {
                      // Triggering the validation (The 'Security Guard' checks the boxes)
                      if (_formKey.currentState!.validate()) {
                        // THE VOID ACTION: Update the state to show the preview
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

            // 5. THE PREVIEW AREA (Shows up after submit)
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