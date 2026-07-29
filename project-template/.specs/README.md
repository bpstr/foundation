# Project specifications

This directory is the durable source of truth for project behavior, architecture, decisions and operations.

## Start here

1. Read `architecture/overview.md` for the system map.
2. Read the relevant document under `features/` before changing behavior.
3. Read linked ADRs under `decisions/` before changing established architecture.
4. Read `operations/deployment.md` before changing runtime or delivery behavior.

## Directory map

- `architecture/` — current system structure and boundaries;
- `features/` — feature behavior, constraints and acceptance criteria;
- `decisions/` — append-only Architecture Decision Records;
- `operations/` — deployment, configuration, observability and recovery;
- `templates/` — starting points for new specification documents;
- `glossary.md` — project terminology.

## Maintenance rules

- Update architecture documents in place when current system structure changes.
- Update feature documents in the same change as behavioral changes.
- Create a new ADR for important decisions and mark older decisions as superseded.
- Keep this README as the index of active documents.

## Active features

Add links to feature specifications here as the project grows.
