# dotfiles

**Contains configurations/settings & requirements related to my Linux operating systems(s).**

<hr style="border:2px solid gray"> </hr>

## Applying the Dotfiles Configuration on your Local Machine

1. Install [Chezmoi](https://github.com/twpayne/chezmoi), a dotfiles management system.

2. Initialize `chezmoi` with your dotfiles repo.

   ```bash
   chezmoi init https://github.com/CodesOfRishi/dotfiles.git
   ```
   This will check out the repo and any submodules and optionally create a `chezmoi` config file for you.

3. Check what changes that `chezmoi` will make to your `$HOME` directory by running:

   ```bash
   chezmoi diff
   ```

4. If you're happy with the changes that `chezmoi` will make then run:

   ```bash
   chezmoi apply -v
   ```

5. If you are not happy with the changes to a file then either edit it with:

   ```bash
   chezmoi edit $FILE
   ```

6. Or, invoke a merge tool (by default `vimdiff`) to merge changes between the current contents of the file, the file in your working copy, and the computed contents of the file:

   ```bash
   chezmoi merge $FILE
   ```

You can also directly pull & apply the latest changes from your repo with:

```bash
chezmoi update -v
```

<hr style="border:2px solid gray"> </hr>



## [LICENSE](https://github.com/CodesOfRishi/linux-gnu-conf/blob/main/LICENSE)

The MIT License (MIT)

Copyright (c) 2021 Rishi K.
