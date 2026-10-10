# Medemy student app

Flutter app for BSc Nursing students. It talks to the Medemy backend in `../medemy-backend`; the API contract is
`../medemy-backend/docs/STUDENT_API.md` and the design brief is `docs/MOBILE_APP_UI_UX_PRODUCT_DESIGN_BRIEF.md` there.

## First-time setup

1. Use Flutter 3.47 or later (`fvm use 3.47.2` if you use fvm).
2. Generate the Firebase configuration. This replaces the placeholder `lib/firebase_options.dart`:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure --project=medmy-edu
   ```

   Register the Android and iOS apps with the ID `com.medemyedu.beonlabs`. Until this is done the app opens on a
   "Firebase is not configured" screen.
3. In the Firebase console, enable the Email/Password sign-in provider.

## Run against a local backend

Start the backend (`npm run dev` in `medemy-backend`), then:

```bash
flutter run                                                   # iOS simulator: http://localhost:3000
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000   # Android emulator
```

A student sees a topic only when its subject, unit and the topic itself are published and available in the admin,
and the topic has a published version.

## Develop

```bash
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs   # after changing a model
```

Tests use fake repositories, so they need neither Firebase nor a running backend.

## Layout

- `lib/core`: configuration, API client with token refresh, sign-in and session state, routing, theme, shared widgets.
- `lib/features`: one folder per feature (`auth`, `profile`, `academic`, `topic`, `shell`).

Built so far: sign-in with email and password, email verification, profile and semester setup, curriculum browsing,
and topic content in Learn, Revise and Exam High-Yield. Practice and Progress are placeholders.
