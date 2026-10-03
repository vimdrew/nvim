# nvim

Two branches:

- `main`: minimal, plain Lua, no plugins
- `ide`: `main` plus plugins via `vim.pack`

## Clone

```sh
# minimal
git clone git@github.com:vimdrew/nvim.git ~/.config/nvim

# ide
git clone -b ide git@github.com:vimdrew/nvim.git ~/.config/nvim
```

## Switch branches

```sh
git switch main
git switch ide
```

Commit or stash first, or git may refuse.

## See branches

```sh
git branch -a                     # local + remote
git log --oneline --graph --all   # history of both
git diff main ide --stat          # files that differ
git show main:init.lua            # a file from the other branch
```

## Consolidate

Carry minimal changes into ide:

```sh
git switch main
# edit, commit
git switch ide
git merge main
git push
```

Never merge `ide` into `main`, or plugins leak into minimal.

## Update ide

Inside nvim on the `ide` branch:

```
:lua vim.pack.update()
```

Then commit the lockfile:

```sh
git add nvim-pack-lock.json
git commit -m "update plugins"
git push
```
