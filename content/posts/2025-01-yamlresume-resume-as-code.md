+++
title = "YAMLResume - Resume as Code"
date = "2025-01-31T10:00:00+07:00"
draft = false
tags = ["cli", "yaml", "latex", "resume", "llm", "ai"]
description = ""
+++

I've been using [YAMLResume](https://yamlresume.dev) to manage my resume. The killer feature? Having your resume in YAML makes it trivial to use LLMs for analysis, editing, and improvement.

## Why YAML + LLMs?

- **LLM-friendly format** - paste your YAML into Claude or ChatGPT and ask for feedback, improvements, or to tailor it for a specific job description
- **Tailored resumes** - use templates and YAML tools to generate role-specific versions
- **Version control** - track changes with git, compare versions, revert mistakes
- **Professional output** - generates clean LaTeX-based PDFs

The workflow becomes: edit YAML → get LLM feedback → refine → generate PDF.

## Setup on macOS

### 1. Install LaTeX (BasicTeX)

YAMLResume needs LaTeX for PDF generation:

```bash
brew install --cask basictex
```

Add TeX to your PATH in `~/.zshrc`:

```bash
export PATH="/Library/TeX/texbin:$PATH"
```

### 2. Install Required LaTeX Packages

```bash
sudo tlmgr update --self
sudo tlmgr install moderncv fontawesome5 collection-fontsrecommended
```

### 3. Install YAMLResume

```bash
brew install yamlresume
```

## Usage with justfile

I use a simple `justfile` for convenience:

```just
# List available commands
default:
    @just --list

# Build resume from YAML
build:
    yamlresume build resume.yml
```

Then just run:

```bash
just build
```

## Troubleshooting

If you get errors about missing `.cls` or `.sty` files:

```bash
sudo tlmgr install <package-name>
```

To find which package provides a file:

```bash
tlmgr search --global --file <filename>
```

Or the easiest approach - just ask Claude Code to fix the LaTeX errors for you :)

## Resources

- GitHub: https://github.com/yamlresume/yamlresume
- Documentation: https://yamlresume.dev/docs
- YAML schema reference: https://yamlresume.dev/docs/schema
