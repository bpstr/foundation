# SaaS profile

Apply these rules when `foundation.yml` sets `project.profile: saas`.

Before implementing product features, make the SaaS account boundary, authorization model, plan state, localization behavior and operational processes explicit in `.specs`.

## Required baseline decisions

1. Define the difference between a user, customer account or workspace, and connected external accounts.
2. Scope every customer-owned record, query, job, export and notification to the correct account.
3. Enforce access with policies or equivalent authorization checks and test cross-account denial.
4. Document registration, email verification, password recovery, sessions, social identity linking and account deletion.
5. Represent the current plan and feature entitlements explicitly, including a free-only launch; do not add fake billing behavior.
6. Define locale selection, persistence, fallback, translated email and regional formatting when multilingual.
7. Document Redis usage, queues, scheduled work, job retries and production worker processes.
8. Keep secrets and provider tokens out of source control and sensitive values out of logs.
9. Define data export, deletion, retention, backup, restore, health checking and rollback behavior.
10. Add application-specific GitHub Actions CI that runs tests, account-isolation checks, linting or static analysis, frontend builds and `./scripts/verify.sh`.

## Expected SaaS specifications

Maintain the current truth for:

- architecture and runtime components;
- account, ownership and authorization model;
- authentication and connected identities;
- plans, entitlements and usage limits;
- localization and timezone behavior;
- implemented customer-facing features;
- email, queue, cache and scheduler behavior;
- CI, deployment, health checks, backups, recovery and deletion;
- significant decisions as append-only ADRs.

Deferred functionality must be labelled as deferred. Agents must not invent incomplete subscriptions, teams, roles, compliance claims or integrations merely because they are common in SaaS products.

The complete human-readable standard is maintained in the Foundation repository at `standards/saas.md`.