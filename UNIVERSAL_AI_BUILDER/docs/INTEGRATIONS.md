# MCP integration catalog

This distribution ships disabled configuration examples. Installing an MCP server and enabling its tools are separate actions. Review upstream code, pin a tested version for production, and store credentials in Goose secret storage.

## GitHub

- Upstream: https://github.com/github/github-mcp-server
- Local command example: github-mcp-server
- Secret key name: GITHUB_PERSONAL_ACCESS_TOKEN
- Use a dedicated token with only the repositories and permissions required.
- Begin read-only. Enable write tools only for tasks that explicitly require them.

## Brave Search

- Upstream: https://github.com/brave/brave-search-mcp-server
- Package: @brave/brave-search-mcp-server
- Command: npx -y @brave/brave-search-mcp-server --transport stdio
- Secret key name: BRAVE_API_KEY
- Upstream README lists Node.js 22.x or newer for its development/build workflow.
- Upstream README describes web, news, image, video, local/place search and related tools.
- Brave API account, key, plan, and usage limits are external requirements.

## Playwright browser automation

- Upstream: https://github.com/microsoft/playwright-mcp
- Package: @playwright/mcp
- Command: npx -y @playwright/mcp@latest
- Upstream README lists Node.js 18 or newer.
- Browser installation and OS libraries may be additional requirements.
- Use only with authorized websites and test accounts. Do not enable unrestricted access to private browser sessions or stored credentials.

## Workspace filesystem

- Package: @modelcontextprotocol/server-filesystem
- Command example: npx -y @modelcontextprotocol/server-filesystem /absolute/path/to/workspace
- Restrict the final argument to one dedicated project directory. Never grant the whole home directory or Android shared storage by default.

## Adding an integration

1. Verify the official upstream repository and license.
2. Check supported runtime versions and installation instructions.
3. Pin a specific package version after testing; avoid unreviewed latest tags in production.
4. Add the MCP entry with enabled: false.
5. Store secrets with Goose secret storage.
6. Inspect the exposed tool list and remove unnecessary capabilities.
7. Test successful calls, invalid input, network failure, timeout, and graceful shutdown.
8. Enable only after verification.

The config templates are examples, not proof that an external MCP server is installed or running.
