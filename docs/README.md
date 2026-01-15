# Documentation Index

Welcome to the .dotfiles documentation! This directory contains comprehensive guides for understanding, configuring, and extending your dotfiles.

---

## 📚 Documentation Overview

### [Technical Documentation](TECHNICAL_DOCUMENTATION.md)
**Comprehensive technical reference for the entire dotfiles system.**

Topics covered:
- Architecture Overview
- Design Goals & Constraints
- Layer Model / Diagram
- Type Safety & Validation
- Core Components
- Usage Patterns / Recipes
- Critical Pitfalls
- Quick Reference (API)
- Security Considerations

**Best for**: Understanding the system architecture, troubleshooting issues, contributing to the project.

---

### [Configuration Guide](CONFIGURATION.md)
**Complete guide to configuring your dotfiles installation.**

Topics covered:
- Configuration files (`.config_dotfiles`, `.extra`, `.path`)
- User customization
- Platform-specific configuration
- Plugin configuration
- Terminal multiplexer setup
- Editor configuration
- Best practices and troubleshooting

**Best for**: Setting up your personal configuration, customizing behavior without forking.

---

### [Plugin System Guide](PLUGINS.md)
**In-depth guide to the `.redpill` plugin system.**

Topics covered:
- Plugin architecture and directory structure
- Plugin loading process
- Available plugins
- Creating custom plugins
- Plugin metadata with composure
- Custom aliases and completions
- Theme customization
- Best practices and troubleshooting

**Best for**: Extending functionality, creating custom commands, developing plugins.

---

### [Usage Recipes & Examples](RECIPES.md)
**Practical examples and recipes for common use cases.**

Topics covered:
- Installation scenarios (Linux, macOS, Windows)
- Daily development workflows (Web, Python, Java)
- Git workflows
- System administration
- Multi-platform setup
- Team collaboration
- Tips and tricks

**Best for**: Quick start, practical examples, learning by example.

---

## 🚀 Quick Start

New to the dotfiles? Follow this learning path:

1. **Install**: Follow the installation guide in [../README.md](../README.md)
2. **Configure**: Read [CONFIGURATION.md](CONFIGURATION.md) to set up your personal settings
3. **Explore**: Check out [RECIPES.md](RECIPES.md) for practical examples
4. **Extend**: Learn about plugins in [PLUGINS.md](PLUGINS.md)
5. **Deep Dive**: Review [TECHNICAL_DOCUMENTATION.md](TECHNICAL_DOCUMENTATION.md) for complete understanding

---

## 🔍 Find What You Need

### I want to...

#### **Install dotfiles on a new system**
→ [../README.md](../README.md#installation)  
→ [RECIPES.md - Installation Scenarios](RECIPES.md#installation-scenarios)

#### **Customize my configuration**
→ [CONFIGURATION.md](CONFIGURATION.md)  
→ [CONFIGURATION.md - User Customization Files](CONFIGURATION.md#user-customization-files)

#### **Add custom commands or aliases**
→ [CONFIGURATION.md - User Customization](CONFIGURATION.md#user-customization-files)  
→ [PLUGINS.md - Custom Aliases](PLUGINS.md#custom-aliases)

#### **Create a plugin**
→ [PLUGINS.md - Creating Custom Plugins](PLUGINS.md#creating-custom-plugins)

#### **Understand how the system works**
→ [TECHNICAL_DOCUMENTATION.md - Architecture Overview](TECHNICAL_DOCUMENTATION.md#architecture-overview)  
→ [TECHNICAL_DOCUMENTATION.md - Layer Model](TECHNICAL_DOCUMENTATION.md#layer-model--diagram)

#### **Set up for my development workflow**
→ [RECIPES.md - Daily Development Workflows](RECIPES.md#daily-development-workflows)

#### **Configure Git integration**
→ [RECIPES.md - Git Workflows](RECIPES.md#git-workflows)  
→ [CONFIGURATION.md - User Customization](CONFIGURATION.md#user-customization-files)

#### **Use it on multiple platforms**
→ [RECIPES.md - Multi-Platform Setup](RECIPES.md#multi-platform-setup)

#### **Troubleshoot an issue**
→ [TECHNICAL_DOCUMENTATION.md - Critical Pitfalls](TECHNICAL_DOCUMENTATION.md#critical-pitfalls)  
→ [CONFIGURATION.md - Troubleshooting](CONFIGURATION.md#troubleshooting)  
→ [PLUGINS.md - Troubleshooting](PLUGINS.md#troubleshooting)

#### **Ensure security**
→ [TECHNICAL_DOCUMENTATION.md - Security Considerations](TECHNICAL_DOCUMENTATION.md#security-considerations)

---

## 📖 Key Concepts

### Configuration Files
- **`.config_dotfiles`**: Main configuration (plugins, theme, locale)
- **`.extra`**: Personal commands and overrides (not tracked)
- **`.path`**: Custom PATH extensions (not tracked)

### Loading Order
1. Shell entry points (`.bash_profile`, `.bashrc`, etc.)
2. Core configuration (`.exports`, `.colors`, `.icons`)
3. Functionality (`.aliases`, `.functions`)
4. Plugin system (`.redpill`)
5. User customization (`.extra`)

### Plugin System
The `.redpill` directory contains a plugin architecture for:
- Modular functionality
- Custom aliases and completions
- Themed prompts with Git integration
- Function metadata

### Bootstrap Script
The `bootstrap.sh` script:
- Installs/updates dotfiles
- Preserves Git configuration
- Shows dry-run before changes
- Handles Vim plugin setup

---

## 🤝 Contributing

Improvements to documentation are welcome!

**Guidelines**:
- Verify against actual source code
- Include file and line number references
- Test procedures on supported platforms
- Update verification checklists

**Source Repository**: https://github.com/voku/dotfiles

---

## 📋 Documentation Status

| Document | Status | Last Updated |
|----------|--------|--------------|
| [TECHNICAL_DOCUMENTATION.md](TECHNICAL_DOCUMENTATION.md) | ✅ Complete | 2026-01-15 |
| [CONFIGURATION.md](CONFIGURATION.md) | ✅ Complete | 2026-01-15 |
| [PLUGINS.md](PLUGINS.md) | ✅ Complete | 2026-01-15 |
| [RECIPES.md](RECIPES.md) | ✅ Complete | 2026-01-15 |

---

## 🔗 External Resources

- **[GitHub Wiki](https://github.com/voku/dotfiles/wiki)** - Additional resources and screenshots
- **[Issues](https://github.com/voku/dotfiles/issues)** - Report bugs or request features
- **[Main README](../README.md)** - Quick start guide

---

## 📝 License

These dotfiles are licensed under the MIT License. See [../LICENSE-MIT.txt](../LICENSE-MIT.txt) for details.
