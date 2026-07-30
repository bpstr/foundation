# Changelog

All notable changes to Foundation are documented here.

## 0.2.1 — 2026-07-30

- Add a first-class `saas` project profile with installed agent guidance.
- Add a comprehensive SaaS application standard covering account boundaries, authorization, identity, entitlements, localization, privacy, queues, CI and VPS operations.
- Make the CatalogPatch kickstart explicitly select and apply the SaaS profile.
- Require authorization and cross-account isolation testing in the SaaS CI baseline.
- Update the installer to refresh managed SaaS profile guidance.
- Align the project template metadata with Foundation 0.2.1.

## 0.2.0 — 2026-07-30

- Add a standard project kickstart workflow with a concrete CatalogPatch Laravel example.
- Require project-specific GitHub Actions CI in addition to the Foundation structure workflow.
- Add CI planning to the deployment standard and installed deployment specification template.
- Clarify that `scripts/verify.sh` is the stable application verification entry point.

## 0.1.0 — 2026-07-29

- Add the non-destructive project installer.
- Add shared agent instructions and project specification conventions.
- Add architecture, feature, ADR and deployment templates.
- Add project-owned operational script contracts.
- Add reusable and repository-level Foundation checks.