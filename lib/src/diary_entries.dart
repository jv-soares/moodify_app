import 'models/diary_entry.dart';
import 'models/episode_severity.dart';
import 'models/life_event.dart';
import 'models/medication.dart';

final diaryEntries = [
  DiaryEntry(
    id: '1',
    createdAt: DateTime(2022, 1, 1),
    episode: Mania(Level.mild),
    moodRating: 50,
    symptoms: [],
    medications: const [
      Medication(
        id: '1',
        name: 'Omeprazol',
        tabletsTaken: 3,
        dose: Dose(300, UnitOfMeasurement.mg),
      ),
      Medication(
        id: '2',
        name: 'Tramadol',
        tabletsTaken: 2,
        dose: Dose(200, UnitOfMeasurement.mg),
      ),
    ],
    lifeEvent: const LifeEvent(
      impactRating: 3,
      description:
          'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
    ),
    observations: 'Foi um dia difícil',
  ),
  DiaryEntry(
    id: '2',
    createdAt: DateTime(2022, 1, 2),
    episode: Mania(Level.mild),
    moodRating: 23,
    symptoms: [],
    medications: const [
      Medication(
        id: '1',
        name: 'Omeprazol',
        tabletsTaken: 2,
        dose: Dose(300, UnitOfMeasurement.mg),
      ),
      Medication(
        id: '2',
        name: 'Tramadol',
        tabletsTaken: 1,
        dose: Dose(200, UnitOfMeasurement.mg),
      ),
    ],
    observations: 'Foi um dia daorao',
  ),
  DiaryEntry(
    id: '3',
    createdAt: DateTime(2022, 1, 3),
    episode: Mania(Level.mild),
    moodRating: 50,
    symptoms: [],
    medications: const [
      Medication(
        id: '1',
        name: 'Omeprazol',
        tabletsTaken: 3,
        dose: Dose(300, UnitOfMeasurement.mg),
      ),
      Medication(
        id: '2',
        name: 'Tramadol',
        tabletsTaken: 2,
        dose: Dose(200, UnitOfMeasurement.mg),
      ),
    ],
    lifeEvent: const LifeEvent(
      impactRating: 3,
      description:
          'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
    ),
    observations: 'Foi um dia difícil',
  ),
  DiaryEntry(
    id: '4',
    createdAt: DateTime(2022, 1, 4),
    episode: Mania(Level.mild),
    moodRating: 50,
    symptoms: [],
    medications: const [
      Medication(
        id: '1',
        name: 'Omeprazol',
        tabletsTaken: 3,
        dose: Dose(300, UnitOfMeasurement.mg),
      ),
      Medication(
        id: '2',
        name: 'Tramadol',
        tabletsTaken: 2,
        dose: Dose(200, UnitOfMeasurement.mg),
      ),
    ],
    lifeEvent: const LifeEvent(
      impactRating: 3,
      description:
          'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
    ),
    observations: 'Foi um dia difícil',
  ),
  DiaryEntry(
    id: '5',
    createdAt: DateTime(2022, 1, 5),
    episode: Mania(Level.mild),
    moodRating: 50,
    symptoms: [],
    medications: const [
      Medication(
        id: '1',
        name: 'Omeprazol',
        tabletsTaken: 3,
        dose: Dose(300, UnitOfMeasurement.mg),
      ),
      Medication(
        id: '2',
        name: 'Tramadol',
        tabletsTaken: 2,
        dose: Dose(200, UnitOfMeasurement.mg),
      ),
    ],
    lifeEvent: const LifeEvent(
      impactRating: 3,
      description:
          'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
    ),
    observations: 'Foi um dia difícil',
  ),
  DiaryEntry(
    id: '6',
    createdAt: DateTime(2022, 1, 6),
    episode: Mania(Level.mild),
    moodRating: 50,
    symptoms: [],
    medications: const [
      Medication(
        id: '1',
        name: 'Omeprazol',
        tabletsTaken: 3,
        dose: Dose(300, UnitOfMeasurement.mg),
      ),
      Medication(
        id: '2',
        name: 'Tramadol',
        tabletsTaken: 2,
        dose: Dose(200, UnitOfMeasurement.mg),
      ),
    ],
    lifeEvent: const LifeEvent(
      impactRating: 3,
      description:
          'Hoje acordei com o pe esquerdo e fui pro trabalho na base da chibatada',
    ),
    observations: 'Foi um dia difícil',
  ),
];
