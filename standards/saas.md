# SaaS application standard

Use this profile for hosted software products that manage customer accounts, persistent product data and recurring application access, even when billing is deferred or the first release is free-only.

The standard defines the baseline concerns that must be deliberately addressed before product-specific features expand. It does not require premature enterprise functionality, but it does require explicit decisions, secure defaults and an upgrade path.

## 1. Product and account model

Document the product boundary and ownership model before creating domain features:

- distinguish users, customer accounts or workspaces, and connected external accounts;
- decide whether the first release is single-user, workspace-based or organization-based;
- associate customer-owned records with the correct account boundary;
- enforce ownership through policies or equivalent authorization checks rather than controller assumptions;
- document invitations, roles and team access as implemented, deferred or intentionally unsupported;
- prevent cross-account reads, writes, exports, jobs and notifications.

A simple product may start with one personal account per user. It must still document that choice and avoid data models that make later account separation unsafe.

## 2. Authentication and identity

The authentication baseline should include:

- email registration and login;
- email verification where the product stores customer data or sends operational notifications;
- password reset and secure session handling;
- rate limiting for authentication and recovery endpoints;
- social authentication only for configured providers;
- safe linking and unlinking of social identities without creating duplicate users or locking users out;
- account profile, password and active-session management;
- account deletion and data-retention behavior;
- optional two-factor authentication documented as implemented, planned or out of scope.

Authentication proves identity. Authorization must separately prove access to every account-owned resource and action.

## 3. Plans, entitlements and usage

Billing may be postponed, but product access should not be hard-coded as if every capability will always be unlimited.

- define the current plans, including a free-only launch state;
- represent feature access and usage limits through explicit entitlements or plan rules;
- keep billing provider logic separate from product authorization;
- do not show fake checkout, subscription or cancellation behavior before it exists;
- document usage counters, reset periods and enforcement where limits exist;
- design subscription states so a payment provider can later map into them without rewriting product data ownership.

For a free-only release, all accounts may receive the same free plan and entitlements.

## 4. Public, legal and support surfaces

A production SaaS should deliberately provide or defer:

- landing, features and pricing pages;
- sign-in, registration and password recovery pages;
- privacy policy and terms of service;
- cookie or tracking consent when required by the actual integrations in use;
- contact or support path;
- clear product identity, company identity and transactional email sender details;
- status or incident communication appropriate to the product's maturity.

Pricing pages must describe the real current offer. A free-only launch must not imply working paid subscriptions.

## 5. Localization and regional behavior

When multiple languages are supported:

- keep interface strings out of templates and application logic;
- define locale detection, user selection and persistence;
- localize validation, authentication, transactional email and public pages;
- format dates, times, numbers and currencies deliberately;
- store timestamps in a consistent server format and display them in the relevant timezone;
- define fallback behavior for missing translations;
- test at least the default locale and one secondary locale.

## 6. Dashboard and account management

The baseline dashboard should expose only real, supported operations and normally includes:

- profile and security settings;
- locale and notification preferences where supported;
- connected social identities and external integrations;
- plan and usage information, even when the only plan is free;
- account deletion or a documented support-assisted deletion process;
- workspace, member and role settings only when the account model supports them.

Connected accounts must have clear provider identity, connection state, permissions and disconnect behavior.

## 7. Data, privacy and security

Every SaaS project must document and test its customer-data boundary.

- validate and authorize all input and account-scoped access;
- protect state-changing browser requests against CSRF;
- escape untrusted output and sanitize rich content where applicable;
- keep secrets in environment or secret-management systems;
- avoid sensitive personal data, credentials and tokens in logs;
- encrypt provider tokens and other sensitive stored values where appropriate;
- define export, deletion, retention and backup behavior;
- apply rate limits to abuse-sensitive endpoints;
- audit security-relevant actions when product risk justifies it;
- document GDPR or other regulatory obligations relevant to the actual product and market.

## 8. Email, queues, cache and scheduled work

Infrastructure must have explicit development, test and production behavior.

- use Mailpit or an equivalent local email sink during development;
- use framework mail fakes or a controlled SMTP service in automated tests;
- queue transactional email and long-running work where appropriate;
- define Redis responsibilities such as queue, cache, session, locks or rate limiting;
- make jobs idempotent when retries could duplicate side effects;
- configure retry, timeout, backoff and failure handling;
- document queue workers and scheduled commands as production processes;
- provide a way to inspect and retry failed jobs safely.

## 9. Observability and operations

The production baseline should include:

- structured application and web-server logs;
- error reporting with sensitive-data filtering;
- health checks for the application and critical dependencies;
- queue and scheduler visibility;
- database and customer-upload backup policy;
- restore and rollback instructions;
- safe database migration behavior;
- environment configuration documentation;
- install, update, verify, healthcheck and rollback scripts with project-specific implementation.

Operational processes required by the application must be managed on the VPS, not left as undocumented shell sessions.

## 10. CI and deployment

Every SaaS application needs project-specific GitHub Actions CI in addition to Foundation structure validation.

CI should run on pull requests and relevant pushes and should:

- install backend and frontend dependencies from lock files;
- prepare an isolated test environment;
- start required service containers or test substitutes;
- validate configuration without using production secrets;
- run automated tests, including authorization and account-isolation tests;
- run formatting, linting and static analysis where configured;
- build production frontend assets;
- invoke `./scripts/verify.sh` as the stable verification entry point.

Deployment workflows must remain separate from CI and must call the project-owned deployment scripts. Production deployment should use protected GitHub environments or an equivalent approval and secret boundary when the project reaches that maturity.

## 11. Required specifications

A SaaS project should maintain at least:

- `.specs/architecture/overview.md` for components and runtime boundaries;
- an account and authorization model;
- a data ownership or tenancy model;
- an authentication and connected-identity specification;
- a plan, entitlement and usage model;
- a localization specification when multilingual;
- feature specifications for implemented customer behavior;
- `.specs/operations/deployment.md` for CI, deployment and runtime processes;
- backup, recovery and data-deletion behavior;
- ADRs for significant architectural choices.

Document deferred functionality explicitly so agents do not invent incomplete billing, teams, permissions or compliance features.

## SaaS baseline completion checklist

A project has a coherent SaaS baseline when:

- the user and customer-account boundary is explicit;
- authorization protects every customer-owned resource;
- authentication, recovery and connected identities have safe lifecycle behavior;
- the real plan and entitlement state is represented without fake billing;
- localization behavior is documented and tested when required;
- email, queues, Redis, scheduler and workers have defined environments;
- privacy, deletion, retention and secret-handling behavior is documented;
- CI tests the application rather than only repository structure;
- VPS deployment, health checks, backups and rollback are operationally defined;
- `.specs` and the implementation describe the same current product.