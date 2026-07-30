# Project kickstart

Use this sequence when starting a new application so the repository, agent guidance, specifications, verification, CI and deployment contracts exist before feature development expands.

## Standard sequence

1. Create the project in the normal local workspace.
2. Initialize and publish the Git repository immediately.
3. Install Foundation from the project root.
4. Open the coding agent in the project directory.
5. Give the agent one initial project prompt containing the stack, infrastructure, product baseline, specification rules, CI requirements and deployment model.
6. Review the generated architecture, specifications, scripts and workflows before starting application features.
7. Run `./scripts/verify.sh` locally and confirm GitHub Actions passes.

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

### 4. Open the coding agent

Open Claude Code, Codex or another coding agent from the project root so repository instructions and project files are available automatically.

### 5. Initial project prompt

```text
Create a new SaaS product with the following stack: Laravel, shadcn/ui, Redis and Mailpit.

Production will run on a VPS using scripts/install.sh and scripts/update.sh. The Git repository is already initialized.

Read and follow AGENTS.md and the installed Foundation guidance. Create and maintain the .specs directory as the source of truth for the existing application specification and internal documentation. Update the relevant specifications whenever features, behavior, architecture, operations or deployment change. Record architectural decisions as ADRs rather than rewriting decision history.

Set up GitHub Actions CI for pull requests and pushes. CI must install the required PHP and frontend dependencies, prepare an isolated test environment, make required services such as Redis available, build frontend assets, and run scripts/verify.sh. Extend scripts/verify.sh with the application-specific Laravel tests, linting, static analysis and build checks. Keep CI separate from production deployment workflows and do not store secrets in the repository.

Base features:
- Users can register and log in with email.
- Users can authenticate through Google and Facebook.
- Provide SaaS public pages such as Features and Pricing.
- Support multiple languages from the beginning.
- Users can manage connected accounts in the dashboard.
- Subscription and payment integrations are deferred; every account uses the free plan for now.

Application features:
- Add the project-specific feature list here.

Before implementing the application features, document the proposed architecture, authentication model, localization approach, local service setup, CI workflow and VPS deployment process in .specs. Then implement the smallest coherent baseline and run the full verification suite.
```

## CI baseline

Every new project must have an application workflow in addition to the Foundation structure check. The workflow should run for pull requests and branch pushes and should include the checks that can prevent a broken release:

- backend dependency installation and validation;
- frontend dependency installation and production build;
- automated tests;
- linting, formatting checks and static analysis where configured;
- required service containers or test substitutes;
- `./scripts/verify.sh` as the stable project verification entry point.

Mailpit is normally a local development service. CI only needs it when automated tests exercise SMTP delivery through the running service; otherwise use the framework's test mail transport or fakes.

## Kickstart completion checklist

A project is ready for feature development when:

- the remote repository exists and `main` is pushed;
- Foundation is installed and reviewed;
- `AGENTS.md` routes agents to `.specs`;
- architecture, feature and operations documents describe the current baseline;
- `scripts/install.sh`, `scripts/update.sh` and `scripts/verify.sh` contain project-specific behavior;
- application CI exists and passes on GitHub;
- local setup requirements for Redis, Mailpit, database and frontend tooling are documented;
- no payment behavior is implied when the product is currently free-only.
