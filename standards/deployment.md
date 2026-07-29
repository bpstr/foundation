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

Central GitHub workflows may orchestrate checkout, locking, credentials, artifacts and reporting. The project scripts remain responsible for knowing how the application is installed, updated and checked.
