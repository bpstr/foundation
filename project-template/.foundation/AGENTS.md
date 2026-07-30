# Shared agent operating rules

These rules are managed by Foundation. Project-specific instructions belong in the root `AGENTS.md` or a more local `AGENTS.md`.

## Before changing code

1. Read the root `AGENTS.md`.
2. Read `foundation.yml` and, when `project.profile` names an installed profile, read the matching `.foundation/profiles/<profile>.md` guidance.
3. Read `.specs/README.md` and the relevant architecture, feature, decision and operations documents.
4. Inspect the existing implementation and tests before proposing a replacement.
5. Identify behavioral, data, security, deployment and compatibility impact.

## While changing code

1. Make the smallest coherent change that satisfies the task.
2. Follow existing project patterns unless an explicit architectural decision changes them.
3. Do not add hidden fallbacks, credentials, production data or undocumented operational dependencies.
4. Add or update tests for changed behavior where the project supports testing.
5. Update feature specifications when behavior, constraints, APIs or acceptance criteria change.
6. Create a new ADR for significant architectural choices; supersede rather than rewrite accepted ADRs.
7. Update operations documentation when configuration, deployment, migrations, queues, storage, monitoring or recovery changes.
8. Apply the selected project profile without inventing deferred functionality.

## Before completion

1. Run `./scripts/verify.sh`.
2. Confirm implementation and specifications describe the same behavior.
3. Report migrations, compatibility concerns, deployment steps and unresolved risks.
4. Do not claim checks passed when they were not executed or could not run.