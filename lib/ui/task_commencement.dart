import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tf1/common/common_ui.dart';
import 'package:tf1/local/database.dart';
import 'package:tf1/viewModel/task_view_model.dart';

class TaskCommencementPage extends StatefulWidget {
  final TaskDB taskDB;
  const TaskCommencementPage({super.key, required this.taskDB});

  @override
   TaskCommencementPageState createState() => TaskCommencementPageState();
}

class TaskCommencementPageState extends State<TaskCommencementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _areaNameController = TextEditingController();
  final TextEditingController _schoolCountController = TextEditingController();
  final TextEditingController _establishedDateController = TextEditingController();
  bool isSidebarOpen = true;
  String? schoolType;
  List<String> selectedCurriculum = [];
  List<String> selectedGrades = [];
  List<String> schoolNames = [];
  String selectedTab = 'General Data';

  void generateSchoolButtons() {
    setState(() {
      int count = int.tryParse(_schoolCountController.text) ?? 0;
      count = count.clamp(0, 5); // Limit max 5 schools
      schoolNames = List.generate(count, (index) => 'School-${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context,listen: false);
    return Scaffold(
      body: Column(
        children: [
          TopBarUI(isSidebarOpen: isSidebarOpen,onValueChanged: (value){
            setState(() {
              isSidebarOpen = value;
            });
          },isAddTask: false,heading: 'Task Commencement',),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 0,child: _buildSidebar()),
                Expanded(flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildContent(provider),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSidebarOpen ? 200 : 0,
      color: Colors.green.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(isSidebarOpen)...[
            ListTile(
              title: const Text('General Data'),
              onTap: () => setState(() => selectedTab = 'General Data'),
            ),
            ...schoolNames.map((name) => ListTile(
              title: Text(name),
              onTap: () => setState(() => selectedTab = name),
            )),
          ]
        ],
      ),
    );
  }

  Widget _buildContent(TaskProvider provider) {
    if (selectedTab == 'General Data') {
      return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_areaNameController,false, 'Name of the Area', true),
            _buildTextField(_schoolCountController, true,'Total No. of Schools (Max 5)', true,
                onChanged: (value) => generateSchoolButtons()),
          ],
        ),
      );
    } else {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Overview - $selectedTab', style: Theme.of(context).textTheme.titleLarge),
              _buildDropdown('Type of School', ['Public', 'Private', 'Govt Aided', 'Special'], (value) {
                setState(() {
                  schoolType = value;
                });
              }),
              _buildMultiSelect('Curriculum', ['CBSE', 'ICSE', 'IB', 'State Board'], selectedCurriculum),
              _buildTextField(_establishedDateController, false,'Established On', true),
              _buildMultiSelect('Grades Present', ['Primary', 'Secondary', 'Higher Secondary'], selectedGrades),
              const SizedBox(height: 20),
              SizedBox(width: 180,height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.green.shade900)),),
                  onPressed: () async {
                    await provider.updateStatus(widget.taskDB.id,'2');
                    Navigator.pop(context);
                  },
                  child: const Text('Finish', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildDropdown(String label, List<String> options, Function(String?) onChanged) {
    return Container(width: 250,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildMultiSelect(String label, List<String> options, List<String> selectedList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            children: options.map((option) {
              return FilterChip(
                label: Text(option),
                selected: selectedList.contains(option),
                onSelected: (bool selected) {
                  setState(() {
                    selected ? selectedList.add(option) : selectedList.remove(option);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,bool isNum, String label, bool isRequired, {Function(String)? onChanged}) {
    return Container(width: 250,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: isRequired ? (value) => value!.isEmpty ? 'Please enter $label' : null : null,
        onChanged: onChanged,
      ),
    );
  }
}
