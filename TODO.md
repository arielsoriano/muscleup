# Project TODOs

## UI & UX Improvements

### 1. Fix Floating SnackBar Position Above Bottom Navigation Bar
- [x] **Status**: Done — `_defaultSnackBarMargin` is now `bottom: 16, left: 16, right: 16`, and `showAppSnackBar` accepts an optional `margin` override.
- **Description**: Floating feedback messages (snackbars) displayed when performing actions like deleting a routine or completing workouts currently appear too high up on the screen. The desired behavior is for them to appear at a standard, comfortable low height—positioned just above the bottom tab navigation bar (`Today`, `Routines`, `History`).
- **Root Cause**:
  - In `lib/core/utils/ui_helpers.dart`, the `BuildContextSnackBarExtension.showAppSnackBar` method uses a hardcoded margin with `bottom: 100`:
    ```dart
    static const EdgeInsets _defaultSnackBarMargin = EdgeInsets.only(
      bottom: 100,
      left: 20,
      right: 20,
    );
    ```
  - In Flutter, `Scaffold` automatically calculates and applies the offset needed to keep a floating `SnackBar` (`SnackBarBehavior.floating`) above the `bottomNavigationBar` (and floating action buttons).
  - Adding `bottom: 100` applies an extra 100dp offset on top of the bottom navigation bar height (~80dp), pushing the snackbar into the middle-lower region of the screen instead of right above the bar.
- **Implementation Details**:
  - Modify `_defaultSnackBarMargin` in [ui_helpers.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/core/utils/ui_helpers.dart) to use a normal bottom padding (e.g., `bottom: 16` or `12`, with `left: 16`, `right: 16`).
  - Optionally support custom margin overrides in `showAppSnackBar({EdgeInsets? margin, ...})` if specific screens require custom positioning.
  - Test across different screens:
    - Main Dashboard tabs with `NavigationBar` ([dashboard_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/dashboard_page.dart), [routines_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/routines_page.dart)).
    - Screens without bottom bars (e.g., [active_workout_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/active_workout_page.dart), [workout_details_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/workout_details_page.dart), [settings_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/settings/presentation/pages/settings_page.dart)).
- **Key Files**:
  - `lib/core/utils/ui_helpers.dart`
  - `lib/features/workout/presentation/pages/routines_page.dart`
  - `lib/features/workout/presentation/pages/dashboard_page.dart`

---

## Play Store & Release Assets

### 2. Capture English Screenshots and Prepare Feature Graphic for Google Play Store
- [ ] **Status**: Pending
- **Description**: Capture high-quality English screenshots across all core app screens to serve as default store listing assets for all languages in the Google Play Console, and prepare/validate the Play Store Feature Graphic banner.
- **Google Play Store Asset Specifications**:
  - **Phone Screenshots**:
    - Format: 24-bit PNG or JPEG (no alpha/transparency).
    - Dimensions: Recommended `1080 x 2400 px` or `1080 x 1920 px` (9:19.5 or 9:16 aspect ratio, min 320px, max 3840px).
    - Quantity: 4 to 8 curated screenshots covering full user journey.
    - Language: English (`en-US`) with realistic, clean sample workout data.
  - **Feature Graphic (Promotional Banner)**:
    - Dimensions: `1024 x 500 px` (exact).
    - Format: JPEG or 24-bit PNG (no alpha).
    - Max size: 15 MB.
    - Content: MuscleUp logo, app branding, key value proposition text in English (e.g., *"Simple & Powerful Workout Tracker"*), and phone mockup preview.
- **Key Screens to Capture**:
  1. **Today / Dashboard**: Active workout card in progress, quick start routines list ([dashboard_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/dashboard_page.dart)).
  2. **Routines Management**: Routines list (e.g., *Push Day*, *Pull Day*, *Legs*) with drag-to-reorder and exercise count badges ([routines_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/routines_page.dart)).
  3. **Active Workout Logging**: Live tracking view showing set logging (weight, reps, checkmarks, rest timer) ([active_workout_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/active_workout_page.dart)).
  4. **Routine Details & Exercise Config**: Routine composition, exercise sets, targets, and reordering ([workout_details_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/workout_details_page.dart)).
  5. **Exercise Library & Progress**: Exercise database with muscle groups and exercise history/progression ([exercise_library_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/settings/presentation/pages/exercise_library_page.dart), [exercise_progress_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/exercise_progress_page.dart)).
  6. **Workout History**: Completed sessions calendar list with timestamps and summary badges ([dashboard_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/workout/presentation/pages/dashboard_page.dart#L642)).
  7. **Settings & Themes**: Theme skin selector (Volt, Crimson, Cobalt, etc.), language switcher, and offline sync ([settings_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/settings/presentation/pages/settings_page.dart)).
- **Output Storage Locations**:
  - Screenshots: `assets/store/screenshots/` or `docs/playstore/screenshots/`
  - Feature Graphic: `assets/playstore_feature_graphic.png` (verify 1024x500 dimensions and update if needed)

---

## Monetization & Developer Support

### 3. Research & Implement "Buy Me a Coffee" / Tip Jar (Store Policy Compliant)
- [ ] **Status**: Pending
- **Description**: Add a way for users to financially support the app development ("Buy Me a Coffee" / Tip Jar) in a manner that strictly complies with Google Play Store and Apple App Store payment policies.
- **Store Policy Analysis & Risks**:
  - **Google Play Payments Policy**: Google Play **strictly prohibits** direct external donation/tipping links (e.g., direct URLs opening `buymeacoffee.com`, Ko-fi, PayPal, or Stripe) within apps distributed via Google Play. Using an external payment link for creator donations leads to immediate app rejection or policy violation strikes (exemptions only apply to registered 501(c)(3) / non-profit charities).
  - **Apple App Store Policy (Guideline 3.1.1 & 3.2.1)**: Apple similarly requires that voluntary tips / developer donations use Apple In-App Purchase (IAP) consumable items.
- **Feasible Approaches**:
  - **Approach A (Recommended - 100% Policy Compliant In-App "Tip Jar")**:
    - Implement native In-App Purchases using the official Flutter package `in_app_purchase: ^3.2.0` (or `purchases_flutter` / RevenueCat).
    - Setup consumable products in Google Play Console (and App Store Connect if releasing on iOS):
      - ☕ *Buy Me a Coffee* (e.g., $1.99 / €1.99)
      - ⚡ *Energy Drink* (e.g., $4.99 / €4.99)
      - 🥤 *Protein Tub* (e.g., $9.99 / €9.99)
    - Add a dedicated "Support Development" tile in [settings_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/settings/presentation/pages/settings_page.dart) opening a clean tip jar modal with theme support and thank-you animations.
    - Note: Google/Apple takes a 15% platform fee, but users get instant, trusted 1-tap checkout.
  - **Approach B (Indirect External Link via GitHub / Project Website)**:
    - Instead of putting a direct payment link, add an "Open Source / GitHub Repository" or "About Developer" link in [settings_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/settings/presentation/pages/settings_page.dart) using `url_launcher`.
    - Place the Buy Me a Coffee / Ko-fi / GitHub Sponsors badge on the external GitHub repo README or developer landing page.
    - *Constraint*: The button text in the app must not say "Donate" or "Tip" pointing to an external site.
  - **Approach C (Hybrid / Build Flavors)**:
    - If releasing on both Google Play and alternative channels (e.g., direct APK on GitHub / F-Droid), use a build flavor/flag:
      - `playStore` flavor: In-App Billing (IAP) tip jar.
      - `github` / `fdroid` flavor: Direct Buy Me a Coffee / Ko-fi web link.
- **Required Steps for Approach A (Native IAP)**:
  1. Add `in_app_purchase` dependency to [pubspec.yaml](file:///Users/arielsoriano/Documents/GitHub/muscleup/pubspec.yaml).
  2. Create monetization domain/cubit layer (e.g., `lib/features/monetization/presentation/cubit/tip_jar_cubit.dart`).
  3. Register consumable product IDs in Google Play Console.
  4. Create UI in [settings_page.dart](file:///Users/arielsoriano/Documents/GitHub/muscleup/lib/features/settings/presentation/pages/settings_page.dart) and add localized strings across all `.arb` files.
