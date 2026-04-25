# Secrets Handling

This public repository must never contain credentials, tokens, private deployment values, customer secrets, or live infrastructure identifiers.

## Public-Safe Practices

- Use placeholders in examples.
- Keep scanner outputs synthetic.
- Avoid real account identifiers, hostnames, URLs, and IP addresses.
- Run repository validation before publishing.
- Enable repository secret scanning and dependency alerts in GitHub.

GitHub recommends repository security practices such as secret scanning and Dependabot. Secret scanning helps detect hardcoded credentials in repository history.
