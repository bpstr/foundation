# Foundation

A small, reusable engineering foundation for projects built and maintained with coding agents.

Foundation gives every project the same basic operating model without forcing every project to use the same language, framework, or deployment platform. Each project keeps its own architecture and feature truth locally, while this repository supplies the conventions, templates, checks, and reusable automation.

## Install into any project

Run this from the project root. It works for both a new directory and an existing repository:

```bash
curl -fsSL https://raw.githubusercontent.com/bpstr/foundation/main/install.sh | bash
```

The installer is intentionally conservative:

- initializes Git when the directory is not already a repository;
- does not replace existing project files or deployment scripts;
- adds a small managed block to an existing `AGENTS.md` instead of replacing it;
- installs shared agent guidance under `.foundation/`;
- creates the `.specs/` structure and templates when missing;
- adds standard operational script contracts when missing;
- can be run again to refresh Foundation-managed files.

Review the resulting changes before committing them:

```bash
git status
git diff
```

## What is installed

```text
AGENTS.md                         Agent entry point
foundation.yml                   Project-level Foundation configuration
.foundation/                     Foundation-managed rules and version metadata
.specs/                          Project architecture, decisions, features and operations
scripts/install.sh               First-time application installation contract
scripts/update.sh                Application update/deployment contract
scripts/verify.sh                Local and CI verification entry point
scripts/healthcheck.sh           Runtime health verification contract
scripts/rollback.sh              Release rollback contract
.github/workflows/foundation.yml Shared structure validation
```

Foundation standardizes **how a project explains itself and how automation invokes it**. It does not own the application's actual architectural decisions, feature specifications, or deployment implementation.

## Core rules

1. `AGENTS.md` is short and routes agents to durable project knowledge.
2. `.specs/architecture/` describes how the system currently works.
3. `.specs/features/` describes current and planned product behavior.
4. `.specs/decisions/` contains append-only Architecture Decision Records.
5. `.specs/operations/` documents deployment, recovery and runtime concerns.
6. Project scripts expose stable commands even when their internal implementation differs.
7. Behavioral changes update the relevant feature specification.
8. Architectural changes create or supersede an ADR rather than rewriting history.

## Typical agent workflow

Before changing the project, an agent should:

1. read `AGENTS.md` and `.foundation/AGENTS.md`;
2. read `.specs/README.md` and the relevant feature and architecture documents;
3. implement the smallest coherent change;
4. update specifications when behavior or architecture changes;
5. run `./scripts/verify.sh`;
6. report implementation, documentation and operational impact together.

## Project-owned versus Foundation-managed

Foundation-managed files live under `.foundation/` and may be refreshed by rerunning the installer. Project-owned documents and scripts are created only when missing and are never silently replaced.

| Area | Owner |
|---|---|
| `.foundation/*` | Foundation |
| Root `AGENTS.md` managed block | Foundation |
| Root `AGENTS.md` project rules | Project |
| `.specs/architecture/*` | Project |
| `.specs/features/*` | Project |
| `.specs/decisions/*` | Project |
| `.specs/operations/*` | Project |
| `scripts/*` | Project |
| `foundation.yml` | Project |

## Repository layout

```text
foundation/
├── install.sh
├── standards/
├── project-template/
│   ├── .foundation/
│   ├── .specs/
│   ├── .github/workflows/
│   ├── scripts/
│   └── foundation.yml
├── tools/
└── .github/workflows/
```

- `standards/` explains the conventions for humans.
- `project-template/` contains files installed into projects.
- `tools/` contains checks used locally and by CI.
- `.github/workflows/` contains reusable GitHub workflows.

## Updating projects

Run the same installer again from a project root:

```bash
curl -fsSL https://raw.githubusercontent.com/bpstr/foundation/main/install.sh | bash
```

Foundation-managed files are refreshed. Project-owned files are preserved. After reviewing the diff, commit the update like any other project change.

## Deployment philosophy

Central automation should orchestrate deployments, but each project should own the application-specific implementation behind a stable script interface:

```bash
./scripts/install.sh
./scripts/update.sh
./scripts/verify.sh
./scripts/healthcheck.sh
./scripts/rollback.sh
```

This allows Laravel, Node.js, Astro, workers, games, and future stacks to share one delivery model without pretending they deploy identically.

## Status

Foundation is intentionally small and practical. Add conventions only after they prove useful across multiple projects; avoid turning the repository into a framework that every project must fight.
