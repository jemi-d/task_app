
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCommencementPage extends StatefulWidget {
  const TaskCommencementPage({super.key});

  @override
  _TaskCommencementPageState createState() => _TaskCommencementPageState();
}

class _TaskCommencementPageState extends State<TaskCommencementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _areaNameController = TextEditingController();
  final TextEditingController _schoolCountController = TextEditingController();
  final TextEditingController _establishedDateController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Task Commencement',style: TextStyle(color: Colors.white),),foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.green.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('General Data'),
            onTap: () => setState(() => selectedTab = 'General Data'),
          ),
          ...schoolNames.map((name) => ListTile(
            title: Text(name),
            onTap: () => setState(() => selectedTab = name),
          )),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (selectedTab == 'General Data') {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_areaNameController, 'Name of the Area', true),
            _buildTextField(_schoolCountController, 'Total No. of Schools (Max 5)', true,
                onChanged: (value) => generateSchoolButtons()),
          ],
        ),
      );
    } else {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview - $selectedTab', style: Theme.of(context).textTheme.titleLarge),
            _buildDropdown('Type of School', ['Public', 'Private', 'Govt Aided', 'Special'], (value) {
              setState(() {
                schoolType = value;
              });
            }),
            _buildMultiSelect('Curriculum', ['CBSE', 'ICSE', 'IB', 'State Board'], selectedCurriculum),
            _buildTextField(_establishedDateController, 'Established On', true),
            _buildMultiSelect('Grades Present', ['Primary', 'Secondary', 'Higher Secondary'], selectedGrades),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDropdown(String label, List<String> options, Function(String?) onChanged) {
    return Padding(
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

  Widget _buildTextField(TextEditingController controller, String label, bool isRequired, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
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
