// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/domain/entities/note_entity.dart';
import 'src/domain/entities/todo_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6862108361595227655),
      name: 'NoteEntity',
      lastPropertyId: const IdUid(7, 1493677288048773510),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2325956317486317666),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4789513195538902755),
            name: 'note',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7849163641810743106),
            name: 'createAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2797032748280607955),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3311567535724719304),
            name: 'isFavorite',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 4777201384192816163),
            name: 'isFixed',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1493677288048773510),
            name: 'image',
            type: 23,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 5827847752321257487),
      name: 'ToDoEntity',
      lastPropertyId: const IdUid(5, 8178412019925625489),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4053452199781951828),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2793030203497530078),
            name: 'text',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7791603939727820395),
            name: 'createAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5467964195078849277),
            name: 'groupId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 7426775246748463389),
            relationTarget: 'GroupToDoEntity'),
        ModelProperty(
            id: const IdUid(5, 8178412019925625489),
            name: 'isCompleted',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 5622547392139153183),
      name: 'GroupToDoEntity',
      lastPropertyId: const IdUid(7, 1189230327323287854),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2226343432019623033),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5725625188420904884),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1111370348728339667),
            name: 'createAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6153604998365301681),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6323731501118469782),
            name: 'isFavorite',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1286774729432161063),
            name: 'isFixed',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1189230327323287854),
            name: 'image',
            type: 23,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'todos', srcEntity: 'ToDoEntity', srcField: '')
      ])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 5622547392139153183),
      lastIndexId: const IdUid(1, 7426775246748463389),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [3247160816363046676],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        3345552812197501285,
        8842311756655630797,
        1624065521052511682,
        7997612560322581523,
        1913333118476635932,
        2220367887358650419
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    NoteEntity: EntityDefinition<NoteEntity>(
        model: _entities[0],
        toOneRelations: (NoteEntity object) => [],
        toManyRelations: (NoteEntity object) => {},
        getId: (NoteEntity object) => object.id,
        setId: (NoteEntity object, int id) {
          object.id = id;
        },
        objectToFB: (NoteEntity object, fb.Builder fbb) {
          final noteOffset = fbb.writeString(object.note);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final imageOffset =
              object.image == null ? null : fbb.writeListInt8(object.image!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, noteOffset);
          fbb.addInt64(2, object.createAt.millisecondsSinceEpoch);
          fbb.addOffset(3, titleOffset);
          fbb.addBool(4, object.isFavorite);
          fbb.addBool(5, object.isFixed);
          fbb.addOffset(6, imageOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final noteParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final createAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0));
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final isFavoriteParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
          final imageParam = const fb.Uint8ListReader(lazy: false)
              .vTableGetNullable(buffer, rootOffset, 16) as Uint8List?;
          final isFixedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 14, false);
          final object = NoteEntity(noteParam,
              id: idParam,
              createAt: createAtParam,
              title: titleParam,
              isFavorite: isFavoriteParam,
              image: imageParam,
              isFixed: isFixedParam);

          return object;
        }),
    ToDoEntity: EntityDefinition<ToDoEntity>(
        model: _entities[1],
        toOneRelations: (ToDoEntity object) => [object.group],
        toManyRelations: (ToDoEntity object) => {},
        getId: (ToDoEntity object) => object.id,
        setId: (ToDoEntity object, int id) {
          object.id = id;
        },
        objectToFB: (ToDoEntity object, fb.Builder fbb) {
          final textOffset = fbb.writeString(object.text);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, textOffset);
          fbb.addInt64(2, object.createAt.millisecondsSinceEpoch);
          fbb.addInt64(3, object.group.targetId);
          fbb.addBool(4, object.isCompleted);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final textParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final createAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0));
          final isCompletedParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 12);
          final object = ToDoEntity(textParam,
              id: idParam,
              createAt: createAtParam,
              isCompleted: isCompletedParam);
          object.group.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.group.attach(store);
          return object;
        }),
    GroupToDoEntity: EntityDefinition<GroupToDoEntity>(
        model: _entities[2],
        toOneRelations: (GroupToDoEntity object) => [],
        toManyRelations: (GroupToDoEntity object) => {
              RelInfo<ToDoEntity>.toOneBacklink(
                      4, object.id, (ToDoEntity srcObject) => srcObject.group):
                  object.todos
            },
        getId: (GroupToDoEntity object) => object.id,
        setId: (GroupToDoEntity object, int id) {
          object.id = id;
        },
        objectToFB: (GroupToDoEntity object, fb.Builder fbb) {
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final imageOffset =
              object.image == null ? null : fbb.writeListInt8(object.image!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, descriptionOffset);
          fbb.addInt64(2, object.createAt.millisecondsSinceEpoch);
          fbb.addOffset(3, titleOffset);
          fbb.addBool(4, object.isFavorite);
          fbb.addBool(5, object.isFixed);
          fbb.addOffset(6, imageOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6);
          final createAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0));
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final isFavoriteParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 12);
          final imageParam = const fb.Uint8ListReader(lazy: false)
              .vTableGetNullable(buffer, rootOffset, 16) as Uint8List?;
          final isFixedParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 14);
          final object = GroupToDoEntity(
              id: idParam,
              description: descriptionParam,
              createAt: createAtParam,
              title: titleParam,
              isFavorite: isFavoriteParam,
              image: imageParam,
              isFixed: isFixedParam);
          InternalToManyAccess.setRelInfo<GroupToDoEntity>(
              object.todos,
              store,
              RelInfo<ToDoEntity>.toOneBacklink(
                  4, object.id, (ToDoEntity srcObject) => srcObject.group));
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [NoteEntity] entity fields to define ObjectBox queries.
class NoteEntity_ {
  /// see [NoteEntity.id]
  static final id =
      QueryIntegerProperty<NoteEntity>(_entities[0].properties[0]);

  /// see [NoteEntity.note]
  static final note =
      QueryStringProperty<NoteEntity>(_entities[0].properties[1]);

  /// see [NoteEntity.createAt]
  static final createAt =
      QueryIntegerProperty<NoteEntity>(_entities[0].properties[2]);

  /// see [NoteEntity.title]
  static final title =
      QueryStringProperty<NoteEntity>(_entities[0].properties[3]);

  /// see [NoteEntity.isFavorite]
  static final isFavorite =
      QueryBooleanProperty<NoteEntity>(_entities[0].properties[4]);

  /// see [NoteEntity.isFixed]
  static final isFixed =
      QueryBooleanProperty<NoteEntity>(_entities[0].properties[5]);

  /// see [NoteEntity.image]
  static final image =
      QueryByteVectorProperty<NoteEntity>(_entities[0].properties[6]);
}

/// [ToDoEntity] entity fields to define ObjectBox queries.
class ToDoEntity_ {
  /// see [ToDoEntity.id]
  static final id =
      QueryIntegerProperty<ToDoEntity>(_entities[1].properties[0]);

  /// see [ToDoEntity.text]
  static final text =
      QueryStringProperty<ToDoEntity>(_entities[1].properties[1]);

  /// see [ToDoEntity.createAt]
  static final createAt =
      QueryIntegerProperty<ToDoEntity>(_entities[1].properties[2]);

  /// see [ToDoEntity.group]
  static final group = QueryRelationToOne<ToDoEntity, GroupToDoEntity>(
      _entities[1].properties[3]);

  /// see [ToDoEntity.isCompleted]
  static final isCompleted =
      QueryBooleanProperty<ToDoEntity>(_entities[1].properties[4]);
}

/// [GroupToDoEntity] entity fields to define ObjectBox queries.
class GroupToDoEntity_ {
  /// see [GroupToDoEntity.id]
  static final id =
      QueryIntegerProperty<GroupToDoEntity>(_entities[2].properties[0]);

  /// see [GroupToDoEntity.description]
  static final description =
      QueryStringProperty<GroupToDoEntity>(_entities[2].properties[1]);

  /// see [GroupToDoEntity.createAt]
  static final createAt =
      QueryIntegerProperty<GroupToDoEntity>(_entities[2].properties[2]);

  /// see [GroupToDoEntity.title]
  static final title =
      QueryStringProperty<GroupToDoEntity>(_entities[2].properties[3]);

  /// see [GroupToDoEntity.isFavorite]
  static final isFavorite =
      QueryBooleanProperty<GroupToDoEntity>(_entities[2].properties[4]);

  /// see [GroupToDoEntity.isFixed]
  static final isFixed =
      QueryBooleanProperty<GroupToDoEntity>(_entities[2].properties[5]);

  /// see [GroupToDoEntity.image]
  static final image =
      QueryByteVectorProperty<GroupToDoEntity>(_entities[2].properties[6]);
}
