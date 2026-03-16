class Investment {
  final int? id;
  final String category;
  final String instrumentName;
  final int amount;

  Investment({
    this.id,
    required this.category,
    required this.instrumentName,
    required this.amount,
  });

  factory Investment.fromMap(Map<String, dynamic> map) {
    return Investment(
      id: map['id'] as int?,
      category: map['category'] ?? '',
      instrumentName: map['name'] ?? '',
      amount: (map['nominal'] is int) 
          ? map['nominal'] 
          : int.tryParse(map['nominal']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'category': category,
      'name': instrumentName,
      'nominal': amount,
    };
  }
}