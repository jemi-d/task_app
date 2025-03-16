class Task {
  String urn;
  String taskName;
  String assignedBy;
  String assignedTo;
  String commencementDate;
  String dueDate;
  String clientName;
  String status;
  int taskType;


  Task({
    required this.urn,
    required this.taskName,
    required this.assignedBy,
    required this.assignedTo,
    required this.commencementDate,
    required this.dueDate,
    required this.clientName,
    required this.status,
    required this.taskType
  });
}

class UserDetail {
  String name;
  String email;

  UserDetail({
    required this.name,
    required this.email,
  });

  factory UserDetail.fromMap(Map<String, String> map) {
    return UserDetail(
      email: map['email'] ?? '',
      name: map['username'] ?? '',
    );
  }
}
