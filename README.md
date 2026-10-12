# Unix Tools

A collection of small, practical Unix command-line utilities for system administration, automation, and homelab management.

The project follows the Unix philosophy: build small tools that do one thing well, remain easy to understand, and can be used independently.

Tools are primarily written in Bash and designed for Unix-like environments, including macOS and Linux.

## Available tools

| Tool | Description |
|---|---|
| `wake-lab` | Wake up one or more configured computers using Wake-on-LAN. |

## Requirements

- Bash 4.3 or newer
- GNU Make or compatible Make implementation
- Standard Unix utilities
- Tool-specific dependencies listed below

### wake-lab

Requires `wakeonlan`, available through package managers such as Homebrew on macOS and APT on Debian/Ubuntu.

On macOS:

```bash
brew install bash wakeonlan
```

On Debian/Ubuntu:

```bash
sudo apt install wakeonlan
```

Make sure that `~/.local/bin` is included in your `PATH`.

## Installation

Clone the repository:

```bash
git clone https://github.com/crecabar/unix-tools.git
cd unix-tools
```

Install the tools:

```bash
make install
```

By default, installation uses:

| Path | Purpose |
|---|---|
| `~/.local/bin/` | Installed executables |
| `~/.config/unix-tools/` | User configuration files |

Installation does not require root privileges.

Existing user configuration files are preserved.

To reinstall the tools:

```bash
make reinstall
```

To remove installed executables:

```bash
make uninstall
```

Uninstallation preserves user configuration files.

## Configuration

Tools requiring local configuration use files under:

```text
~/.config/unix-tools/
```

Example configuration files are maintained in the repository under `config/`.

Local configurations should not be committed to version control. Avoid storing passwords, private keys, or other credentials in executable shell configuration files.

### Wake-on-LAN

Edit:

```text
~/.config/unix-tools/wake-lab.conf
```

Define hosts using a Bash associative array:

```bash
declare -A HOMELAB=(
  [NAS]="00:11:22:33:44:55"
  [SERVER]="AA:BB:CC:DD:EE:FF"
)
```

Replace the example MAC addresses with those of your own machines.

The configuration file is sourced by Bash and must therefore contain trusted local code.

## Usage

Wake all configured computers:

```bash
wake-lab all
```

Wake a single computer:

```bash
wake-lab NAS
```

Wake selected computers:

```bash
wake-lab NAS SERVER
```

Display help and available hosts:

```bash
wake-lab --help
```

The tool validates host names before sending Wake-on-LAN packets.

Wake-on-LAN requires compatible hardware, firmware and network configuration. Sending a magic packet does not guarantee that the target machine will wake successfully.

Broadcast packets may require additional network configuration when hosts are located on separate VLANs or subnets.

## Development

Validate Bash syntax:

```bash
bash -n bin/wake-lab
```

Install locally:

```bash
make install
```

Review available Make targets:

```bash
make help
```

Contributions should favor simple, portable implementations, explicit dependencies and separation between reusable code and machine-specific configuration.

## License

Copyright (C) 2026 Cristian Recabarren

This project is licensed under the **GNU General Public License, version 2 only (GPL-2.0-only)**.

See [LICENSE](LICENSE) for the full license text.

