# My NixOS Flake

This repository contains my personal NixOS configurations for two machines: my laptop (`vamos`) and my desktop computer (`solaire`). These configurations are managed using the Nix Flake system to ensure reproducibility and ease of deployment.

## Structure

- `flake.nix`: The main entry point for the Nix flake.
- `hosts/`: Directory containing the specific configurations for each host (`vamos` and `solaire`).
- `modules/`: Reusable NixOS modules shared between different configurations.
- `home/`: Userspace configuration, divided between laptop and desktop.

## Hosts

### Vamos (Laptop)

This is the configuration for my laptop, `vamos`. It uses Gnome, and includes settings optimized for power management, and lightweight applications.

### Solaire (Desktop)

This is the configuration for my desktop computer, `solaire`. It also uses Gnome, and adds Nvidia drivers.

## Usage

### Applying the Configuration

To apply the configuration on a machine, use the following steps:

1. Clone this repository:

```bash
git clone https://github.com/nezia1/nixos-config.git
cd nixos-config
```

2. Switch to the desired configuration:

   ```bash
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

   Replace `<hostname>` with either `vamos` or `solaire` depending on the machine you are configuring.

### Example

For the laptop (`vamos`):

```bash
sudo nixos-rebuild switch --flake .#vamos
```

For the desktop (`solaire`):

```bash
sudo nixos-rebuild switch --flake .#solaire
```

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
