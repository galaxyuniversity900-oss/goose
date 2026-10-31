# Operating workflows

Recipes live in recipes/. Set GOOSE_RECIPE_PATH to this directory (or copy recipes into a user-owned recipe directory).

## Recommended sequence

1. project-audit.yaml — inspect without changing files.
2. deep-research.yaml — verify unfamiliar APIs, libraries, platform support, and licenses.
3. implement-feature.yaml or build-application.yaml — implement the scoped work.
4. build-mcp-server.yaml — build a tool server.
5. android-termux-compatibility.yaml — verify mobile/ARM64 constraints.
6. offline-deployment.yaml — prepare repeatable offline operation.
7. media-pipeline.yaml — implement media extraction/transcription/analysis.
8. verify-release.yaml — perform a no-publish release audit.
9. complete-project.yaml — continuous end-to-end project delivery.

## Local usage

Start an interactive session with goose session. Use the recipe picker/CLI invocation supported by the installed Goose version. Check goose --help and current recipe documentation for exact syntax; do not assume command syntax across versions.

## Git workflow

- Start from a clean working tree or preserve all existing user changes.
- Create a feature branch for nontrivial work.
- Commit small, coherent changes.
- Run tests before and after edits.
- Never merge, publish, or deploy without explicit authorization.

## Evidence reporting

Use PASS only for commands actually run with a successful exit code. Use FAIL for reproduced failures, BLOCKED for unavailable permissions/dependencies, and NOT TESTED for checks not executed.
