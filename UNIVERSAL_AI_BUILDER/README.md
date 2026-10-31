# Universal AI Builder — Goose Distribution Layer

A practical, evidence-first development environment built on upstream Goose. It packages secure defaults, reusable recipes, MCP extension templates, setup scripts, diagnostics, and CI checks. It extends Goose through supported configuration and extension points; it does not replace or silently fork the Goose runtime.

## Delivery status

- Upstream Goose architecture and custom-distribution, configuration, and recipe documentation reviewed.
- Dedicated branch: feature/universal-ai-builder.
- Pull request: https://github.com/galaxyuniversity900-oss/goose/pull/1
- Added configuration defaults, MCP examples, reusable recipes, setup scripts, security and Android notes, and CI validation.
- Static YAML/recipe validation is implemented in scripts/validate.py and GitHub Actions.
- Not yet verified: Goose installation on a real host, OpenAI authentication, MCP process startup, recipe execution through Goose, PowerShell execution, and Android/Termux native compatibility. Repository file creation is not proof of runtime completion.

## Capabilities

- Evidence-first project audit and deep research.
- Full application implementation, regression testing, documentation, and release checks.
- MCP server design and implementation.
- Android ARM64/Termux compatibility assessment.
- Offline-first dependency preparation and runtime validation.
- Audio/video/image extraction, transcription, OCR, and analysis workflows.
- Security boundaries, least-privilege tools, and explicit approval for destructive or external actions.

## Supported host strategy

Upstream Goose documents Desktop for macOS, Linux, and Windows, plus a CLI. Use a supported host first. Android/Termux is experimental; native support must be demonstrated on the exact device and release.

## Installation

### 1. Install Goose

Follow the official platform-specific instructions:
https://goose-docs.ai/docs/getting-started/installation

The upstream Linux/macOS CLI installer is published at:
https://github.com/aaif-goose/goose/releases/download/stable/download_cli.sh

Review the official installer and release details before executing it. Avoid running unreviewed remote scripts with elevated privileges.

### 2. Configure OpenAI

Run:

```bash
goose configure
```

Choose the OpenAI provider and a model available to your OpenAI Platform project. Use Goose's supported secret storage for the API key. Do not paste the key into this repository, config examples, shell commands, screenshots, or logs.

OpenAI API usage is billed separately from ChatGPT subscriptions. Set project budgets and usage limits before sustained agent workflows.

Provider guide:
https://goose-docs.ai/docs/getting-started/providers

### 3. Install this distribution layer

Unix-like hosts:

```bash
bash UNIVERSAL_AI_BUILDER/scripts/bootstrap.sh
```

To replace existing distribution-owned recipe/doc copies, backups are created:

```bash
bash UNIVERSAL_AI_BUILDER/scripts/bootstrap.sh --force
```

Windows PowerShell:

```powershell
.\UNIVERSAL_AI_BUILDER\scripts\bootstrap.ps1
```

These scripts copy recipes and docs into a dedicated Goose config subdirectory. They do not install Goose, configure API credentials, or install MCP server binaries.

Load defaults and start Goose:

```bash
source "$HOME/.config/goose/universal-ai-builder/env.sh"
goose configure
goose session
```

Windows:

```powershell
. "$env:APPDATA\Block\goose\universal-ai-builder\env.ps1"
goose configure
goose session
```

### 4. Verify the host

```bash
bash UNIVERSAL_AI_BUILDER/scripts/doctor.sh
python3 -m pip install PyYAML==6.0.2
python3 UNIVERSAL_AI_BUILDER/scripts/validate.py
```

The doctor checks basic host executables only. It does not authenticate a provider or prove MCP connectivity.

### 5. Configure MCP extensions

Review:
- mcp/extensions.example.yaml
- config/config.example.yaml
- docs/SECURITY.md

Merge only the entries needed into Goose's config. Replace the workspace path with one dedicated project directory. Install each selected MCP server separately. Keep extensions disabled until their command and tool list are verified. Store tokens using Goose secret storage and grant minimum permissions.

Extension guide:
https://goose-docs.ai/docs/getting-started/using-extensions

## Package and launcher

Build a portable ZIP containing the recipes, documentation, configuration templates, and scripts:

```bash
python3 UNIVERSAL_AI_BUILDER/scripts/package.py
```

The ZIP is written to `UNIVERSAL_AI_BUILDER/dist/universal-ai-builder-config-pack.zip`. It contains a SHA-256 manifest and is integrity-checked after creation. GitHub Actions also builds and uploads this pack as the `universal-ai-builder-config-pack` artifact for 30 days.

After bootstrap, use the `uaib` launcher:

```bash
uaib session
uaib --help
```

The launcher loads the distribution's safe environment defaults and forwards arguments to the installed Goose CLI.

## Recipes

Set the recipe directory if needed:

```bash
export GOOSE_RECIPE_PATH="$HOME/.config/goose/universal-ai-builder/recipes"
```

Available recipes:
- project-audit.yaml — inspect an existing project without changing files.
- deep-research.yaml — research with source provenance and uncertainty.
- implement-feature.yaml — implement a scoped feature safely.
- build-application.yaml — end-to-end application delivery.
- build-mcp-server.yaml — MCP server engineering.
- android-termux-compatibility.yaml — Android/ARM64 compatibility.
- offline-deployment.yaml — prepare Wi-Fi downloads and offline runtime.
- media-pipeline.yaml — media extraction, ASR, OCR, and analysis.
- verify-release.yaml — release audit without publishing.
- complete-project.yaml — continuous end-to-end delivery.

Use the installed Goose version's recipe picker/CLI syntax. Check goose --help and the official recipe guide rather than assuming command syntax across releases:
https://goose-docs.ai/docs/guides/recipes/recipe-reference

## Android / Termux

Read docs/ANDROID-TERMUX.md. Native Goose support is not claimed. Recommended approach: run Goose on a supported PC/server and use Android as a client/workspace, or conduct an isolated on-device build experiment. Never expose a remote Goose service without authentication, TLS, and network restrictions.

## CI validation

GitHub Actions checks YAML syntax, basic Goose recipe/config contracts, and shell script syntax. These checks do not prove Goose runtime compatibility, provider access, MCP startup, or successful app builds. Those require integration tests on the target host.

## Upstream and legal

- Upstream Goose: https://github.com/aaif-goose/goose
- Custom distributions: https://github.com/aaif-goose/goose/blob/main/CUSTOM_DISTROS.md
- Config files: https://goose-docs.ai/docs/guides/config-files
- Recipes: https://goose-docs.ai/docs/guides/recipes/recipe-reference
- ACP providers: https://goose-docs.ai/docs/guides/acp-providers

Goose is Apache-2.0 licensed. Preserve upstream notices and identify modifications. Do not imply endorsement by the Goose project.
