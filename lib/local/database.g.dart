// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with drift.TableInfo<$TasksTable, TaskDB> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta = const drift.VerificationMeta(
    'id',
  );
  @override
  late final drift.GeneratedColumn<int> id = drift.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const drift.VerificationMeta _nameMeta = const drift.VerificationMeta(
    'name',
  );
  @override
  late final drift.GeneratedColumn<String> name = drift.GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const drift.VerificationMeta _urnMeta = const drift.VerificationMeta(
    'urn',
  );
  @override
  late final drift.GeneratedColumn<String> urn = drift.GeneratedColumn<String>(
    'urn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: drift.Constant(''),
  );
  static const drift.VerificationMeta _descriptionMeta =
      const drift.VerificationMeta('description');
  @override
  late final drift.GeneratedColumn<String> description =
      drift.GeneratedColumn<String>(
        'description',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _commencementDateMeta =
      const drift.VerificationMeta('commencementDate');
  @override
  late final drift.GeneratedColumn<String> commencementDate =
      drift.GeneratedColumn<String>(
        'commencement_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _dueDateMeta =
      const drift.VerificationMeta('dueDate');
  @override
  late final drift.GeneratedColumn<String> dueDate =
      drift.GeneratedColumn<String>(
        'due_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _assignedToMeta =
      const drift.VerificationMeta('assignedTo');
  @override
  late final drift.GeneratedColumn<String> assignedTo =
      drift.GeneratedColumn<String>(
        'assigned_to',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _assignedByMeta =
      const drift.VerificationMeta('assignedBy');
  @override
  late final drift.GeneratedColumn<String> assignedBy =
      drift.GeneratedColumn<String>(
        'assigned_by',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _clientNameMeta =
      const drift.VerificationMeta('clientName');
  @override
  late final drift.GeneratedColumn<String> clientName =
      drift.GeneratedColumn<String>(
        'client_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const drift.VerificationMeta _statusMeta =
      const drift.VerificationMeta('status');
  @override
  late final drift.GeneratedColumn<String> status =
      drift.GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: drift.Constant('Scheduled'),
      );
  @override
  List<drift.GeneratedColumn> get $columns => [
    id,
    name,
    urn,
    description,
    commencementDate,
    dueDate,
    assignedTo,
    assignedBy,
    clientName,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  drift.VerificationContext validateIntegrity(
    drift.Insertable<TaskDB> instance, {
    bool isInserting = false,
  }) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('urn')) {
      context.handle(
        _urnMeta,
        urn.isAcceptableOrUnknown(data['urn']!, _urnMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('commencement_date')) {
      context.handle(
        _commencementDateMeta,
        commencementDate.isAcceptableOrUnknown(
          data['commencement_date']!,
          _commencementDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_commencementDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedToMeta);
    }
    if (data.containsKey('assigned_by')) {
      context.handle(
        _assignedByMeta,
        assignedBy.isAcceptableOrUnknown(data['assigned_by']!, _assignedByMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedByMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  TaskDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskDB(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      urn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}urn'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      commencementDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}commencement_date'],
          )!,
      dueDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}due_date'],
          )!,
      assignedTo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}assigned_to'],
          )!,
      assignedBy:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}assigned_by'],
          )!,
      clientName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}client_name'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TaskDB extends drift.DataClass implements drift.Insertable<TaskDB> {
  final int id;
  final String name;
  final String urn;
  final String description;
  final String commencementDate;
  final String dueDate;
  final String assignedTo;
  final String assignedBy;
  final String clientName;
  final String status;
  const TaskDB({
    required this.id,
    required this.name,
    required this.urn,
    required this.description,
    required this.commencementDate,
    required this.dueDate,
    required this.assignedTo,
    required this.assignedBy,
    required this.clientName,
    required this.status,
  });
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<int>(id);
    map['name'] = drift.Variable<String>(name);
    map['urn'] = drift.Variable<String>(urn);
    map['description'] = drift.Variable<String>(description);
    map['commencement_date'] = drift.Variable<String>(commencementDate);
    map['due_date'] = drift.Variable<String>(dueDate);
    map['assigned_to'] = drift.Variable<String>(assignedTo);
    map['assigned_by'] = drift.Variable<String>(assignedBy);
    map['client_name'] = drift.Variable<String>(clientName);
    map['status'] = drift.Variable<String>(status);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      urn: drift.Value(urn),
      description: drift.Value(description),
      commencementDate: drift.Value(commencementDate),
      dueDate: drift.Value(dueDate),
      assignedTo: drift.Value(assignedTo),
      assignedBy: drift.Value(assignedBy),
      clientName: drift.Value(clientName),
      status: drift.Value(status),
    );
  }

  factory TaskDB.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return TaskDB(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      urn: serializer.fromJson<String>(json['urn']),
      description: serializer.fromJson<String>(json['description']),
      commencementDate: serializer.fromJson<String>(json['commencementDate']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      assignedTo: serializer.fromJson<String>(json['assignedTo']),
      assignedBy: serializer.fromJson<String>(json['assignedBy']),
      clientName: serializer.fromJson<String>(json['clientName']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'urn': serializer.toJson<String>(urn),
      'description': serializer.toJson<String>(description),
      'commencementDate': serializer.toJson<String>(commencementDate),
      'dueDate': serializer.toJson<String>(dueDate),
      'assignedTo': serializer.toJson<String>(assignedTo),
      'assignedBy': serializer.toJson<String>(assignedBy),
      'clientName': serializer.toJson<String>(clientName),
      'status': serializer.toJson<String>(status),
    };
  }

  TaskDB copyWith({
    int? id,
    String? name,
    String? urn,
    String? description,
    String? commencementDate,
    String? dueDate,
    String? assignedTo,
    String? assignedBy,
    String? clientName,
    String? status,
  }) => TaskDB(
    id: id ?? this.id,
    name: name ?? this.name,
    urn: urn ?? this.urn,
    description: description ?? this.description,
    commencementDate: commencementDate ?? this.commencementDate,
    dueDate: dueDate ?? this.dueDate,
    assignedTo: assignedTo ?? this.assignedTo,
    assignedBy: assignedBy ?? this.assignedBy,
    clientName: clientName ?? this.clientName,
    status: status ?? this.status,
  );
  TaskDB copyWithCompanion(TasksCompanion data) {
    return TaskDB(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      urn: data.urn.present ? data.urn.value : this.urn,
      description:
          data.description.present ? data.description.value : this.description,
      commencementDate:
          data.commencementDate.present
              ? data.commencementDate.value
              : this.commencementDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      assignedTo:
          data.assignedTo.present ? data.assignedTo.value : this.assignedTo,
      assignedBy:
          data.assignedBy.present ? data.assignedBy.value : this.assignedBy,
      clientName:
          data.clientName.present ? data.clientName.value : this.clientName,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('urn: $urn, ')
          ..write('description: $description, ')
          ..write('commencementDate: $commencementDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('assignedBy: $assignedBy, ')
          ..write('clientName: $clientName, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    urn,
    description,
    commencementDate,
    dueDate,
    assignedTo,
    assignedBy,
    clientName,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.urn == this.urn &&
          other.description == this.description &&
          other.commencementDate == this.commencementDate &&
          other.dueDate == this.dueDate &&
          other.assignedTo == this.assignedTo &&
          other.assignedBy == this.assignedBy &&
          other.clientName == this.clientName &&
          other.status == this.status);
}

class TasksCompanion extends drift.UpdateCompanion<TaskDB> {
  final drift.Value<int> id;
  final drift.Value<String> name;
  final drift.Value<String> urn;
  final drift.Value<String> description;
  final drift.Value<String> commencementDate;
  final drift.Value<String> dueDate;
  final drift.Value<String> assignedTo;
  final drift.Value<String> assignedBy;
  final drift.Value<String> clientName;
  final drift.Value<String> status;
  const TasksCompanion({
    this.id = const drift.Value.absent(),
    this.name = const drift.Value.absent(),
    this.urn = const drift.Value.absent(),
    this.description = const drift.Value.absent(),
    this.commencementDate = const drift.Value.absent(),
    this.dueDate = const drift.Value.absent(),
    this.assignedTo = const drift.Value.absent(),
    this.assignedBy = const drift.Value.absent(),
    this.clientName = const drift.Value.absent(),
    this.status = const drift.Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const drift.Value.absent(),
    required String name,
    this.urn = const drift.Value.absent(),
    required String description,
    required String commencementDate,
    required String dueDate,
    required String assignedTo,
    required String assignedBy,
    required String clientName,
    this.status = const drift.Value.absent(),
  }) : name = drift.Value(name),
       description = drift.Value(description),
       commencementDate = drift.Value(commencementDate),
       dueDate = drift.Value(dueDate),
       assignedTo = drift.Value(assignedTo),
       assignedBy = drift.Value(assignedBy),
       clientName = drift.Value(clientName);
  static drift.Insertable<TaskDB> custom({
    drift.Expression<int>? id,
    drift.Expression<String>? name,
    drift.Expression<String>? urn,
    drift.Expression<String>? description,
    drift.Expression<String>? commencementDate,
    drift.Expression<String>? dueDate,
    drift.Expression<String>? assignedTo,
    drift.Expression<String>? assignedBy,
    drift.Expression<String>? clientName,
    drift.Expression<String>? status,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (urn != null) 'urn': urn,
      if (description != null) 'description': description,
      if (commencementDate != null) 'commencement_date': commencementDate,
      if (dueDate != null) 'due_date': dueDate,
      if (assignedTo != null) 'assigned_to': assignedTo,
      if (assignedBy != null) 'assigned_by': assignedBy,
      if (clientName != null) 'client_name': clientName,
      if (status != null) 'status': status,
    });
  }

  TasksCompanion copyWith({
    drift.Value<int>? id,
    drift.Value<String>? name,
    drift.Value<String>? urn,
    drift.Value<String>? description,
    drift.Value<String>? commencementDate,
    drift.Value<String>? dueDate,
    drift.Value<String>? assignedTo,
    drift.Value<String>? assignedBy,
    drift.Value<String>? clientName,
    drift.Value<String>? status,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      urn: urn ?? this.urn,
      description: description ?? this.description,
      commencementDate: commencementDate ?? this.commencementDate,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      clientName: clientName ?? this.clientName,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = drift.Variable<String>(name.value);
    }
    if (urn.present) {
      map['urn'] = drift.Variable<String>(urn.value);
    }
    if (description.present) {
      map['description'] = drift.Variable<String>(description.value);
    }
    if (commencementDate.present) {
      map['commencement_date'] = drift.Variable<String>(commencementDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = drift.Variable<String>(dueDate.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = drift.Variable<String>(assignedTo.value);
    }
    if (assignedBy.present) {
      map['assigned_by'] = drift.Variable<String>(assignedBy.value);
    }
    if (clientName.present) {
      map['client_name'] = drift.Variable<String>(clientName.value);
    }
    if (status.present) {
      map['status'] = drift.Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('urn: $urn, ')
          ..write('description: $description, ')
          ..write('commencementDate: $commencementDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('assignedBy: $assignedBy, ')
          ..write('clientName: $clientName, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends drift.GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  @override
  Iterable<drift.TableInfo<drift.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<drift.TableInfo<drift.Table, Object?>>();
  @override
  List<drift.DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      drift.Value<int> id,
      required String name,
      drift.Value<String> urn,
      required String description,
      required String commencementDate,
      required String dueDate,
      required String assignedTo,
      required String assignedBy,
      required String clientName,
      drift.Value<String> status,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      drift.Value<int> id,
      drift.Value<String> name,
      drift.Value<String> urn,
      drift.Value<String> description,
      drift.Value<String> commencementDate,
      drift.Value<String> dueDate,
      drift.Value<String> assignedTo,
      drift.Value<String> assignedBy,
      drift.Value<String> clientName,
      drift.Value<String> status,
    });

class $$TasksTableFilterComposer
    extends drift.Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get urn => $composableBuilder(
    column: $table.urn,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get commencementDate => $composableBuilder(
    column: $table.commencementDate,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get assignedBy => $composableBuilder(
    column: $table.assignedBy,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => drift.ColumnFilters(column),
  );

  drift.ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => drift.ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends drift.Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get urn => $composableBuilder(
    column: $table.urn,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get commencementDate => $composableBuilder(
    column: $table.commencementDate,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get assignedBy => $composableBuilder(
    column: $table.assignedBy,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => drift.ColumnOrderings(column),
  );

  drift.ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => drift.ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends drift.Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  drift.GeneratedColumn<String> get urn =>
      $composableBuilder(column: $table.urn, builder: (column) => column);

  drift.GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get commencementDate => $composableBuilder(
    column: $table.commencementDate,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  drift.GeneratedColumn<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get assignedBy => $composableBuilder(
    column: $table.assignedBy,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  drift.GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        drift.RootTableManager<
          _$AppDatabase,
          $TasksTable,
          TaskDB,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (TaskDB, drift.BaseReferences<_$AppDatabase, $TasksTable, TaskDB>),
          TaskDB,
          drift.PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                drift.Value<int> id = const drift.Value.absent(),
                drift.Value<String> name = const drift.Value.absent(),
                drift.Value<String> urn = const drift.Value.absent(),
                drift.Value<String> description = const drift.Value.absent(),
                drift.Value<String> commencementDate =
                    const drift.Value.absent(),
                drift.Value<String> dueDate = const drift.Value.absent(),
                drift.Value<String> assignedTo = const drift.Value.absent(),
                drift.Value<String> assignedBy = const drift.Value.absent(),
                drift.Value<String> clientName = const drift.Value.absent(),
                drift.Value<String> status = const drift.Value.absent(),
              }) => TasksCompanion(
                id: id,
                name: name,
                urn: urn,
                description: description,
                commencementDate: commencementDate,
                dueDate: dueDate,
                assignedTo: assignedTo,
                assignedBy: assignedBy,
                clientName: clientName,
                status: status,
              ),
          createCompanionCallback:
              ({
                drift.Value<int> id = const drift.Value.absent(),
                required String name,
                drift.Value<String> urn = const drift.Value.absent(),
                required String description,
                required String commencementDate,
                required String dueDate,
                required String assignedTo,
                required String assignedBy,
                required String clientName,
                drift.Value<String> status = const drift.Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                name: name,
                urn: urn,
                description: description,
                commencementDate: commencementDate,
                dueDate: dueDate,
                assignedTo: assignedTo,
                assignedBy: assignedBy,
                clientName: clientName,
                status: status,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          drift.BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    drift.ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      TaskDB,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (TaskDB, drift.BaseReferences<_$AppDatabase, $TasksTable, TaskDB>),
      TaskDB,
      drift.PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
}
