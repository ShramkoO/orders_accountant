abstract class SupabaseTable {
  const SupabaseTable();
  String get tableName;
}

class UserTable implements SupabaseTable {
  const UserTable();

  @override
  String get tableName => 'profile';

  String get id => 'id';
  String get firstName => 'first_name';
  String get lastName => 'last_name';
}

class PostTable implements SupabaseTable {
  const PostTable();

  @override
  String get tableName => 'post';

  String get id => 'id';
  String get title => 'title';
  String get content => 'content';
}
