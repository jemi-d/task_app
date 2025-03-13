import 'dart:math';

import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _commencementDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _assignedToController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _urn = TextEditingController();
  final String _assignedBy = 'Current User';
  DateTime? _commencementDate;
  DateTime? _dueDate;

  String _generateRandomURN() {
    return 'URN-${Random().nextInt(100000)}';
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, bool isCommencement) async {
    DateTime initialDate = isCommencement ? DateTime.now() : _commencementDate ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isCommencement ? DateTime.now() : _commencementDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
        if (isCommencement) {
          _commencementDate = picked;
          _dueDateController.clear();
          _dueDate = null;
        } else {
          _dueDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    _urn.text = _generateRandomURN();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task',style: TextStyle(color: Colors.white),),foregroundColor: Colors.white,
      backgroundColor: Colors.green.shade900,),
      body: Center(
        child: SizedBox(width: 700,
          child: Card(color: Colors.green.shade100,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(flex: 9,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField(_taskNameController, 'Task Name', true),
                            _buildDisabledField(_urn.text, 'Unique Reference Number'),
                            _buildTextField(_descriptionController, 'Detailed Description', true),
                            _buildDatePickerField(_commencementDateController, 'Date of Commencement',true),
                            _buildDatePickerField(_dueDateController, 'Due Date',false),
                            _buildTextField(_assignedToController, 'Assigned To', true),
                            _buildDisabledField(_assignedBy, 'Assigned By'),
                            _buildTextField(_clientNameController, 'Client Name', true),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 0,
                      child: SizedBox(width: 180,height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.green.shade900)),),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save Task', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintStyle: TextStyle(color: Colors.green.shade900),
          labelText: label,labelStyle: TextStyle(color: Colors.green.shade900),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,width: 2),borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,width: 2),borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.green.shade900)),
        ),
        validator: isRequired ? (value) => value!.isEmpty ? 'Please enter $label' : null : null,
      ),
    );
  }

  Widget _buildDisabledField(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(hintStyle: TextStyle(color: Colors.green.shade900),
          labelText: label,labelStyle: TextStyle(color: Colors.green.shade900),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,width: 2),borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,width: 2),borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.green.shade900)),
        ),
        initialValue: value,
        enabled: false,
      ),
    );
  }

  Widget _buildDatePickerField(TextEditingController controller, String label, bool isCommencement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(hintStyle: TextStyle(color: Colors.green.shade900),
          labelText: label,labelStyle: TextStyle(color: Colors.green.shade900),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,width: 2),borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,width: 2),borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.green.shade900)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context, controller, isCommencement),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please select $label';
          }
          if (!isCommencement && _dueDate != null && _commencementDate != null && _dueDate!.isBefore(_commencementDate!)) {
            return 'Due date must be after commencement date';
          }
          return null;
        },
      ),
    );
  }
}

