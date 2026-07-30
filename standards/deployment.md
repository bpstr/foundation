# Deployment contract

Foundation standardizes deployment entry points, not application-specific commands.

Every deployable project should provide:

- `scripts/install.sh` for first-time installation;
- `scripts/update.sh` for deploying a new release;
- `scripts/verify.sh` for local and CI verification;
- `scripts/healthcheck.sh` for runtime verification;
- `scripts/rollback.sh` for returning to a previous release.

## Requirements

Scripts must:

- use `set -Eeuo pipefail` or an equivalent strict mode;
- fail clearly rather than reporting false success;
- be safe to invoke from automation;
- avoid embedding secrets;
- document required environment variables;
- expose application-specific behavior behind the stable filename;
- distinguish reversible release rollback from irreversible data migrations.

## Continuous integration

Every application must provide project-specific GitHub Actions CI in addition to the Foundation structure workflow. CI should run for pull requests and pushes and must call `scripts/verify.sh` after preparing the application's dependencies and test environment.

The application workflow should cover, where applicable:

- backend and frontend dependency installation;
- linting, formatting checks and static analysis;
- automated tests;
- frontend or application builds;
- required service containers such as a database or Redis;
- caching that improves speed without hiding missing dependency declarations.

CI and production deployment are separate concerns. Pull request validation must not deploy the application. Production credentials must remain in GitHub environment or repository secrets and must never be committed.

Central GitHub workflows may orchestrate checkout, locking, credentials, artifacts and reporting. The project scripts remain responsible for knowing how the application is installed, updated and checked.
