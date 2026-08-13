import '../../../../core/constants/exercise_library.dart';

/// Builds the text the user copies out of the app and pastes into an assistant
/// along with their own training notes.
///
/// It is written in English on purpose, and not translated like the rest of the
/// app: it is read by a model, not by the user, and instruction-following is
/// most reliable in English across the assistants people actually have at hand.
///
/// It asks for one language-sensitive thing only: catalog exercises spelled the
/// way the catalog spells them, which is what lets the app store them as a link
/// to the catalog rather than as frozen text, so the routine still reads
/// correctly after the user switches the app to another language.
///
/// Everything else must come back untranslated. An earlier version asked for
/// the whole reply "in $languageName", and assistants took that literally:
/// "LUNES — Torso" came back as "Monday — Upper body" and "Bicho muerto" as
/// "Dead Bug". Those are the user's own words about their own training, and the
/// notes they paste are often not in the language the app is set to — so the
/// instruction has to be the opposite of a translation request.
class RoutineImportPrompt {
  const RoutineImportPrompt._();

  /// Where the user's own notes go. Kept as the last line so pasting the
  /// prompt and then the notes into a chat window produces a coherent message.
  static const String notesHeader = 'NOTES TO CONVERT';

  static String build({
    required String languageCode,
    required String languageName,
  }) {
    final catalog = ExerciseLibrary.exercises
        .map((exercise) => exercise.getLocalizedName(languageCode))
        .where((name) => name.isNotEmpty)
        .join(', ');

    return '''
You are converting someone's workout notes into JSON for the Muscleup workout app.

TASK
Read the training notes at the end of this message and reply with a single JSON object that Muscleup can import. Reply with the JSON only — no explanation before or after it.

LANGUAGE — TRANSLATE NOTHING
The notes may be written in any language. The words in them are the user's own and must survive unchanged:
- Routine names: copy the day label exactly as it appears in the notes.
- Exercise names that are not in the catalog listed below: copy them exactly as written.
- The "notes" field: write it in the language of the notes, in the user's own wording.
Only one thing is spelled for you: an exercise that IS in the catalog takes the catalog spelling, which is given below in $languageName ($languageCode).

FORMAT
{
  "routines": [
    {
      "name": "Monday — Upper body",
      "exercises": [
        {
          "name": "Incline Bench Press",
          "sets": 4,
          "reps": 10,
          "weight": 22.5,
          "weightUnit": "kg",
          "restSeconds": 90,
          "notes": "Slow on the way down"
        }
      ]
    }
  ]
}

FIELDS
- routines (required): one entry per training day or session.
- name (required, on a routine): the day label exactly as it appears in the notes, e.g. "LUNES — Torso". Never translated, never reworded.
- exercises (required): in the order they are performed.
- name (required, on an exercise): the exercise name, nothing else.
- sets: how many sets. Either a number, when every set has the same targets, or a list when they differ: "sets": [{"weight": 20, "reps": 12}, {"weight": 25, "reps": 10}].
- reps: repetitions per set, a single number. For a range such as 8-12, use the lower number.
- weight: load per set, a number. Leave it out when the notes do not give one — it is better left empty than guessed.
- weightUnit: "kg" or "lb". Defaults to "kg".
- seconds: use instead of reps for held or timed exercises, e.g. {"name": "Plank", "sets": 3, "seconds": 45}.
- minutes, km or meters: use instead of reps for cardio, e.g. {"name": "Running", "sets": 1, "minutes": 30}.
- restSeconds: rest between sets. Leave it out when the notes do not give one.
- notes: everything about the exercise that is not a number — "per leg", "seated with back support", "wide grip", tempo, machine settings.

RULES
1. One routine per training day. A day marked as rest, off or left empty is not a routine: leave it out entirely.
2. Never invent weights, repetitions or rest times. Leaving a field out is correct: the app leaves an unstated load empty for the user to fill in, and falls back to their usual repetitions and rest.
3. Keep qualifiers out of the exercise name. Whatever is in brackets is a note: "Step-up with dumbbells (12 per leg)" becomes name "Step-up with dumbbells", reps 12, notes "12 per leg".
4. When an exercise is one of the catalog exercises listed below, use that exact spelling: that is what links it to the app's catalog. When it is not in the catalog, copy the user's own name letter for letter — do not translate it, do not tidy it up, and do not swap it for a catalog exercise that is merely similar.
5. Output valid JSON: double quotes, no trailing commas, no comments, numbers unquoted.

CATALOG EXERCISES, SPELLED IN $languageName
$catalog

EXAMPLE
These notes:
MONDAY — Upper
1. Incline dumbbell press 4x10 with 22.5 kg
2. Lat pulldown, wide grip 3x12
TUESDAY — Rest

become this JSON:
{"routines":[{"name":"MONDAY — Upper","exercises":[{"name":"Incline Bench Press","sets":4,"reps":10,"weight":22.5,"weightUnit":"kg","notes":"With dumbbells"},{"name":"Lat Pulldown","sets":3,"reps":12,"notes":"Wide grip"}]}]}

Note that the day label came through as written, down to the capitals, and that Tuesday produced nothing at all.

Notes in another language behave the same way. From "LUNES — Torso" containing "6. Bicho muerto (12 por lado)", the routine name stays "LUNES — Torso" and the exercise stays {"name":"Bicho muerto","reps":12,"notes":"12 por lado"} — the day label and an exercise the catalog does not have are copied across, never translated.

$notesHeader
''';
  }
}
