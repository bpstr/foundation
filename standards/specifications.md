# Project specification standard

Every project keeps durable technical and product knowledge in `.specs/` so humans and agents can understand the system without reconstructing it from source code.

## Document classes

### Architecture

`.specs/architecture/` describes the system as it currently exists. Update these documents in place when components, boundaries, data flows or infrastructure change.

### Features

`.specs/features/` describes user-visible and system-visible behavior, constraints, failure cases and acceptance criteria. Update the relevant feature specification in the same change that modifies behavior.

### Decisions

`.specs/decisions/` contains Architecture Decision Records. ADRs preserve why an important choice was made. Accepted ADRs are historical: supersede them with a new ADR rather than silently rewriting the old decision.

### Operations

`.specs/operations/` describes deployment, configuration, observability, backup, recovery and rollback behavior.

## Writing rules

- Describe current truth, not code line by line.
- Link specifications to relevant code paths and ADRs.
- Record explicit non-goals and constraints.
- Include failure behavior and operational impact.
- Prefer one focused document over one enormous project specification.
- Keep `.specs/README.md` as the navigation index.

## Change rules

A change is complete when implementation, tests, specifications and operational notes agree. Cosmetic refactors do not require artificial specification edits, but behavioral or architectural changes do.
