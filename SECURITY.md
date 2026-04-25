# Security Policy

## Public Repository Scope

This repository contains public-safe product documentation, architecture summaries, diagrams, and synthetic examples. It does not contain proprietary application source code, deployment secrets, customer records, internal infrastructure values, or exploit-enabling implementation details.

## Reporting Security Questions

For security questions about this public repository, open a security-question issue using the provided template.

Do not post secrets, vulnerability exploit details, customer data, private URLs, internal tickets, or live infrastructure identifiers in public issues.

## Validation

Before publishing changes, run:

```bash
./scripts/validate-public-repo.sh
```

The validation scripts check for private-path indicators and use available secret scanning tools when installed.
