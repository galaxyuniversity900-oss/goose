# Android / Termux deployment

## Support status

Upstream Goose documents a native desktop application for macOS, Linux, and Windows and a CLI. This does not establish native Android/Termux support. Treat Android ARM64 as experimental and unverified until the exact Goose release and all native dependencies pass on the target device.

## Recommended topology

1. Run Goose CLI on a supported Linux/Windows/macOS host or server.
2. Keep Android/Termux as a lightweight client and local project workspace where practical.
3. Connect remotely only through an authenticated, encrypted channel. Never expose an unauthenticated Goose server on 0.0.0.0.
4. If testing a native Termux build, use a separate prefix/worktree and preserve the existing Termux environment.

## On-device checklist

- Confirm uname -m reports aarch64.
- Record Android version, Termux source/version, Rust toolchain, libc environment, and available storage.
- Check whether the exact release provides an Android-compatible binary. Do not assume a Linux glibc binary works under Android's Bionic libc.
- Inspect native dependency requirements before installing a large toolchain.
- Run goose --version, goose configure, a basic session, and one read-only MCP tool.
- Test process termination/restart, long sessions, storage permissions, and low-memory behavior.
- Mark each result PASS, FAIL, BLOCKED, or NOT TESTED with command output.

## Termux safety

- Do not run blanket pkg upgrade commands as a prerequisite.
- Do not reinstall tools already present and working.
- Do not store API keys in Git, shell history, screenshots, or project files.
- Do not use chmod -R 777 or expose all shared storage to filesystem MCP.
- Use a dedicated workspace and explicit permissions.
- Keep large runtime/model downloads on Wi-Fi; record sizes and checksums where available.

## Offline behavior

Cloud providers require network access. A local model provider can work offline only after its runtime and model weights are installed and verified. MCP servers may independently require internet. Label each tool local/offline or network-dependent.
