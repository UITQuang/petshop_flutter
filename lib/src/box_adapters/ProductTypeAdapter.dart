import 'package:hive/hive.dart';
import 'package:project1/src/models/product_detail.dart';

class ProductTypeAdapter extends TypeAdapter<ProductType> {
  @override
  final typeId = 0;

  get render => null;

  @override
  ProductType read(BinaryReader reader) {
    return ProductType();
  }

  @override
  void write(BinaryWriter writer, ProductType obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemId)
      ..writeByte(2)
      ..write(obj.picture)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  // TODO: implement typeId
  int get hashCode => typeId.hashCode;

  /*@override
  bool operator ==(Object other) =>
     identical(this,other) ||
         other is ProductTypeAdapter &&
             runtimeType == other.runtimeType &&
             typeId = other.typeId;*/
}
