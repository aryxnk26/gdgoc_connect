enum EventCategory { technical, workshop, hackathon, social }

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String venue;
  final String speaker;
  final EventCategory category;
  final int capacity;
  int registeredCount;
  bool isUserRegistered;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.venue,
    required this.speaker,
    required this.category,
    required this.capacity,
    required this.registeredCount,
    this.isUserRegistered = false,
  });

  Event copyWith({
    bool? isUserRegistered,
    int? registeredCount,
  }) {
    return Event(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      venue: venue,
      speaker: speaker,
      category: category,
      capacity: capacity,
      registeredCount: registeredCount ?? this.registeredCount,
      isUserRegistered: isUserRegistered ?? this.isUserRegistered,
    );
  }
}