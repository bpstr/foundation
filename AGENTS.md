# Foundation repository agent instructions

This repository defines shared conventions installed into other projects.

## Required workflow

1. Read `README.md` and the relevant document under `standards/` before changing a convention.
2. Keep the public installer safe for both new and existing repositories.
3. Never make the installer overwrite project-owned specifications, configuration or deployment scripts.
4. Keep Foundation-managed guidance under `project-template/.foundation/` generic and stack-neutral.
5. Update `README.md`, `CHANGELOG.md` and `VERSION` when changing the public contract.
6. Run `./tools/check.sh project-template` before considering work complete.
7. Check shell syntax with `bash -n install.sh tools/check.sh project-template/scripts/*.sh`.

## Design principle

Foundation standardizes project knowledge, agent behavior and automation entry points. It must not become a framework that owns application-specific implementation.
