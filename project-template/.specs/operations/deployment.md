---
title: Deployment
status: draft
last_reviewed: null
---

# Deployment

## Environments

Document local, preview, staging and production environments that exist.

## Required configuration

List required environment variables and external services without storing secret values.

## Continuous integration

Document the GitHub Actions workflows used for pull requests and pushes. Include dependency installation, test environment setup, required service containers, automated tests, linting, static analysis, application builds and the invocation of `scripts/verify.sh`.

Keep CI validation separate from production deployment. Document which branch protections or required checks must pass before merging.

## First installation

Describe what `scripts/install.sh` performs and its prerequisites.

## Release update

Describe what `scripts/update.sh` performs, including migrations, caches, assets and workers.

## Health verification

Describe health endpoints, process checks and dependencies used by `scripts/healthcheck.sh`.

## Rollback

Describe release rollback, data migration limitations and recovery procedures.

## Observability

Document logs, metrics, alerts and where operators should investigate failures.
