# Oh My Zsh Mirage Theme

![Preview of Oh my zsh Mirage theme](./doc/img/ohmyzsh-mirage-preview.svg "Preview")

## Features

- Non-null exitcode visulation
- Show presence of sudo timestamp file
- Git support

## Installation

This assumes that you have Oh my zsh already installed and set up. If you have not done so, then follow the instructions on [their page](https://github.com/ohmyzsh/ohmyzsh#getting-started).

```shell
git clone git@github.com:robin-pfeiffer/ohmyzsh-mirage-theme.git
cd ohmyzsh-mirage-theme
./install.sh
  # Restart zsh
```

### Settings

Export variables from the Mirage theme to your `.zshrc` file. Below are the variables that can be altered.

```sh
export THEME_SHOW_SUDO=true
export THEME_SHOW_EXITCODE=true
export THEME_SHOW_SCM=true
export THEME_SHOW_VENV=true
```
