# ClearPath

ClearPath is an iOS-first Flutter money coach. It combines connected accounts, recurring bills, a spending plan, and explainable purchase guidance in one calm dashboard.

This repository is a working product prototype with sample data. The UI, navigation, bill entry, demo statement scan, and purchase affordability flow are functional. Real financial data and generative AI are intentionally not called directly from the mobile client; those integrations require a secure backend.

## Run it

```bash
flutter pub get
flutter run
```

Quality checks:

```bash
flutter analyze
flutter test
```

## What is included

- Today dashboard with a safe-to-spend number, account balances, upcoming bills, and personalized insight
- Purchase checker with comfortable, caution, and over-budget outcomes
- Monthly plan with category progress and proactive guidance
- Bills list with manual entry and a simulated scan/review flow
- Connected-account education and consent screen
- Profile, goals, notifications, and privacy settings shell
- Two Codemagic workflows: a simulator artifact and a signed TestFlight release

## Recommended production architecture

The mobile app should talk only to your API. The API should own all provider secrets and perform the financial calculations.

```text
Flutter app
   │ authenticated HTTPS
   ▼
API (Supabase Edge Functions, Cloud Run, or similar)
   ├── bank-link provider (Plaid, MX, or Finicity)
   ├── PostgreSQL with row-level security
   ├── private object storage for statements and bills
   ├── OCR / document extraction
   └── AI insight service using precomputed, minimal financial facts
```

Suggested core tables: `users`, `institutions`, `accounts`, `transactions`, `recurring_bills`, `budgets`, `goals`, `documents`, and `insights`. Store provider access tokens encrypted on the server. Never send bank credentials or provider secrets to the app, logs, analytics, or an AI model.

The safe-to-spend value should be deterministic and auditable:

```text
available cash
- bills due before next income
- planned essential spending
- minimum debt payments
- user-selected safety cushion
= safe to spend
```

Use AI to explain the result, categorize ambiguous transactions, summarize trends, and suggest options. Do not let a model invent balances or perform the authoritative calculation. Every recommendation should show the inputs used and include an educational-not-advice disclosure.

## Bill and report uploads

In production, use the iOS document picker and camera scanner. Upload directly to private storage with a short-lived signed URL, scan for malware, extract merchant/amount/due date with OCR, and require user confirmation before saving. Delete the original file according to a visible retention setting.

## Codemagic setup

1. Push this folder to a Git provider and add the repository in Codemagic.
2. Create the iOS App ID `com.karrionfuler.clearpathMoney` in Apple Developer, or replace that identifier in Xcode and `codemagic.yaml`.
3. Add an App Store Connect API-key integration named `ClearPath App Store Connect`.
4. Add an environment-variable group named `clearpath_production` for API base URLs and public client identifiers. Do not place private provider or AI keys in this group if they would be compiled into the app.
5. Run `ClearPath iOS Simulator` first, then `ClearPath iOS` to sign and upload to TestFlight.

The release workflow expects Codemagic automatic signing. Increment the version in `pubspec.yaml` before App Store submissions.

## Before handling real money data

- Add authentication, consent records, data export/deletion, encryption, audit logs, and device-secure token storage.
- Complete a privacy policy, threat model, incident-response plan, and provider compliance review.
- Add accessibility, localization, offline/error states, notification permissions, and end-to-end tests.
- Have legal/compliance counsel review financial-guidance copy and applicable privacy, open-banking, and consumer-protection obligations.
