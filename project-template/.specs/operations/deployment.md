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
