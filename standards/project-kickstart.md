# SaaS project kickstart

Use this sequence when starting a new SaaS application so the repository, account model, agent guidance, specifications, verification, CI and deployment contracts exist before product feature development expands.

This workflow uses the Foundation `saas` profile and the requirements in [`saas.md`](saas.md). Foundation itself remains usable for other project types, but this kickstart is specifically for hosted SaaS products.

## Standard sequence

1. Create the project in the normal local workspace.
2. Initialize and publish the Git repository immediately.
3. Install Foundation from the project root.
4. Set `project.profile: saas` in `foundation.yml` and record the framework, runtime and deployment model.
5. Open the coding agent in the project directory.
6. Give the agent one initial project prompt containing the stack, SaaS baseline, infrastructure, product scope, specification rules, CI requirements and deployment model.
7. Review the generated account model, authorization rules, architecture, specifications, scripts and workflows before starting application features.
8. Run `./scripts/verify.sh` locally and confirm GitHub Actions passes.

## CatalogPatch example

### 1. Create the Laravel project

```bash
cd ~/Websites
laravel new catalogpatch.com
cd catalogpatch.com
```

### 2. Initialize and publish the Git repository

```bash
echo "# catalogpatch" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:bpstr/catalogpatch.git
git push -u origin main
```

### 3. Install Foundation

```bash
curl -fsSL https://raw.githubusercontent.com/bpstr/foundation/main/install.sh | bash
```

Review the installed files before continuing:

```bash
git status
git diff
```

### 4. Select the SaaS profile

Update the project section of `foundation.yml`:

```yaml
project:
  profile: saas
  framework: laravel
  frontend: shadcn-ui
  runtime: php
  deployment: vps
```

The installed `.foundation/profiles/saas.md` becomes mandatory agent guidance for this project.

### 5. Open the coding agent

Open Claude Code, Codex or another coding agent from the project root so repository instructions, the selected SaaS profile and project files are available automatically.

### 6. Initial project prompt

```text
Create a new SaaS product with the following stack: Laravel, shadcn/ui, Redis and Mailpit.

Production will run on a VPS using scripts/install.sh and scripts/update.sh. The Git repository is already initialized and Foundation is installed. The project uses the saas profile in foundation.yml.

Read and follow AGENTS.md, .foundation/AGENTS.md and .foundation/profiles/saas.md. Create and maintain the .specs directory as the source of truth for the existing application specification and internal documentation. Update the relevant specifications whenever features, behavior, data ownership, authorization, architecture, operations or deployment change. Record architectural decisions as ADRs rather than rewriting decision history.

Before implementing product features, define and document the SaaS baseline:
- the relationship between users, customer accounts or workspaces, and connected external accounts;
- ownership and authorization rules for every customer-owned resource;
- authentication, email verification, password recovery, sessions and social identity linking;
- the current free plan, feature entitlements and any usage limits without implementing fake billing behavior;
- localization, locale persistence, translated email and regional formatting;
- Redis responsibilities, queues, scheduled tasks and production worker processes;
- privacy, account deletion, data retention, backups and recovery;
- public, legal and support pages that are implemented now or explicitly deferred.

Set up GitHub Actions CI for pull requests and pushes. CI must install the required PHP and frontend dependencies, prepare an isolated test environment, make required services such as Redis available, build frontend assets, and run scripts/verify.sh. Extend scripts/verify.sh with the application-specific Laravel tests, authorization and account-isolation tests, linting, static analysis and build checks. Keep CI separate from production deployment workflows and do not store secrets in the repository.

Base features:
- Users can register and log in with email.
- Users can verify their email and recover their password.
- Users can authenticate through Google and Facebook.
- Social identities can be linked and unlinked safely without duplicate users or account lockout.
- Provide real SaaS public pages such as Features and Pricing.
- Provide Privacy Policy and Terms pages before public production use.
- Support multiple languages from the beginning.
- Users can manage their profile, security settings and connected accounts in the dashboard.
- Subscription and payment integrations are deferred; every customer account uses the explicit free plan and its entitlements for now.
- Account deletion and customer-data handling must be documented and implemented at a level appropriate for the release.

Application features:
- Add the project-specific feature list here.

Before implementing the application features, document the proposed architecture, account and authorization model, authentication lifecycle, plan and entitlement model, localization approach, local service setup, CI workflow and VPS deployment process in .specs. Then implement the smallest coherent SaaS baseline and run the full verification suite.
```

## SaaS CI baseline

Every new SaaS project must have an application workflow in addition to the Foundation structure check. The workflow should run for pull requests and relevant branch pushes and should include the checks that can prevent a broken or insecure release:

- backend dependency installation and validation;
- frontend dependency installation and production build;
- automated unit and feature tests;
- authorization and cross-account isolation tests;
- authentication and account lifecycle tests;
- linting, formatting checks and static analysis where configured;
- required service containers or test substitutes;
- `./scripts/verify.sh` as the stable project verification entry point.

Mailpit is normally a local development service. CI only needs it when automated tests exercise SMTP delivery through the running service; otherwise use the framework's test mail transport or fakes.

## SaaS kickstart completion checklist

A project is ready for application feature development when:

- the remote repository exists and `main` is pushed;
- Foundation is installed and reviewed;
- `foundation.yml` selects the `saas` profile;
- `AGENTS.md` routes agents to `.specs` and the installed SaaS guidance;
- the user, customer-account and connected-account boundaries are explicit;
- authorization and customer-data isolation rules are documented and tested;
- authentication and identity lifecycle behavior is defined;
- the real free plan and entitlement state is represented without fake payment behavior;
- architecture, feature and operations documents describe the current baseline;
- `scripts/install.sh`, `scripts/update.sh` and `scripts/verify.sh` contain project-specific behavior;
- application CI exists and passes on GitHub;
- local and production requirements for Redis, Mailpit, database, queues, scheduler and frontend tooling are documented;
- deployment, health checks, backups, account deletion and rollback behavior are documented;
- public pricing and legal pages do not imply functionality that does not exist.