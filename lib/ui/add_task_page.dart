import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import '../common/common_ui.dart';
import '../datamodel/Task.dart';
import '../local/database.dart';
import '../viewModel/task_view_model.dart';

class AddTaskPage extends StatefulWidget {
  final TaskDB? taskDB;
  final UserDetail userDetail;
  const AddTaskPage({super.key, this.taskDB, required this.userDetail});

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
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _assignedByController = TextEditingController();
  static final storage = FlutterSecureStorage();
  DateTime? _commencementDate;
  DateTime? _dueDate;
  bool _isEditMode = false;

  String _generateRandomURN() {
    return 'URN-${Random().nextInt(100000)}';
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, bool isCommencement) async {
    DateTime? existingDate = controller.text.isNotEmpty ? DateTime.tryParse(controller.text) : null;
    DateTime initialDate = existingDate ??
        (isCommencement ? DateTime.now() : _commencementDate ?? DateTime.now());

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

  Future<void> _saveTask() async {
    String? storedEmail = await storage.read(key: 'email');
    String? storedUser = await storage.read(key: 'username');
    if(_formKey.currentState!.validate()){
      // if(!mounted) return;
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      final task = TasksCompanion(
        name: Value(_taskNameController.text),
        urn: Value(_urn.text),
        description: Value(_descriptionController.text),
        commencementDate: Value(_commencementDate!.toString()),
        dueDate: Value(_dueDate!.toString()),
        assignedTo: Value(_assignedToController.text),
        assignedBy: Value(storedUser!),
        clientName: Value(_clientNameController.text),
        status: Value('1'),
        clientDesignation: Value(_designationController.text),
        clientEmail: Value(_emailController.text),
        currentUser: Value(storedUser),
        currentUserEmail: Value(storedEmail!),
      );

      if (_isEditMode && widget.taskDB != null) {
        await taskProvider.editTask(
          TaskDB(
            id: widget.taskDB!.id,
            name: _taskNameController.text,
            urn: _urn.text,
            description: _descriptionController.text,
            commencementDate: _commencementDate!.toString(),
            dueDate: _dueDate!.toString(),
            assignedTo: _assignedToController.text,
            assignedBy: storedUser,
            clientName: _clientNameController.text,
            status: widget.taskDB!.status,
            clientDesignation: _designationController.text,
            clientEmail: _emailController.text,
            currentUserEmail: storedEmail,
            currentUser: storedUser
          ),
        );
      } else {
        await taskProvider.addTask(task);
      }
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) Navigator.pop(context);
      });
    }else{
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid data')));
    }
  }

  @override
  void initState() {
    if (widget.taskDB != null) {
      _isEditMode = true;
      _prefillFields(widget.taskDB!);
    } else {
      _assignedByController.text = widget.userDetail.name;
      _urn.text = _generateRandomURN();
    }
    super.initState();
  }

  void _prefillFields(TaskDB task) {
    _taskNameController.text = task.name;
    _urn.text = task.urn;
    _descriptionController.text = task.description;
    _commencementDate = DateTime.parse(task.commencementDate);
    _dueDate = DateTime.parse(task.dueDate);
    _commencementDateController.text = task.commencementDate.substring(0,10);
    _dueDateController.text = task.dueDate.substring(0,10);
    _assignedToController.text = task.assignedTo;
    _assignedByController.text = widget.userDetail.name;
    _clientNameController.text = task.clientName;
    _designationController.text = task.clientDesignation;
    _emailController.text = task.clientEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarUI(isSidebarOpen: false,onValueChanged: (value){},isAddTask: true,heading: 'Add Task',),
          Expanded(
            child: Center(
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
                                  _buildDisabledField(_assignedByController.text, 'Assigned By'),
                                  _buildTextField(_clientNameController, 'Client Name', true),
                                  _buildTextField(_designationController, 'Client Designation', true),
                                  _buildTextField(_emailController, 'Client email', true),
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
                                onPressed: _saveTask,
                                child: const Text('Save', style: TextStyle(color: Colors.white),),
                              ),
                            ),),
                        ],),
                    ),),),
              ),),
          ),],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: 20,
        maxLines: 1,
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
        textInputAction: TextInputAction.none,
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
        onTap: () => _selectDate(context, controller, isCommencement),
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

