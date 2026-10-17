# 03 — Git, GitHub, and SSH authentication

This guide records how the Zen Linux repository was first cloned, committed, and pushed from Debian.

## A. Git identity

```bash
git --version
git config --global user.name 'YOUR_COMMIT_NAME'
git config --global user.email 'YOUR_GITHUB_NOREPLY_EMAIL'
```

Use your **actual GitHub-provided noreply address** (GitHub → Settings → Emails), not the placeholder above. A public Git repository records commit author emails in history. GitHub may reject pushes containing a private email if email privacy protection is enabled. **Changing `git config` does not rewrite an existing commit's author email.**

## B. Clone the repository

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/TheProfitPilgrim/zen-linux.git
cd zen-linux
```

A public repository may be cloned without signing in. HTTPS was used initially; we switched to SSH for authenticated pushes.

## C. Create a secure SSH key

Check for existing keys **before creating new ones**:

```bash
ls -la ~/.ssh
```

If you don't already have a suitable SSH key:

```bash
ssh-keygen -t ed25519 -C 'zen-linux-github'
```

Accept the suggested file path if it won't overwrite an existing key. Use a passphrase. **Never commit or share the private key** (`~/.ssh/id_ed25519`). The `.pub` file is the shareable public key.

Add only the public key to [GitHub → SSH keys](https://github.com/settings/keys) as an **Authentication Key**:

```bash
cat ~/.ssh/id_ed25519.pub
```

Test:

```bash
ssh -T git@github.com
```

On the very first connection, compare GitHub's host-key fingerprint to [GitHub's published SSH fingerprints](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints) before accepting the host key. Successful authentication usually says GitHub does not provide shell access; that is expected.

## D. Switch origin to SSH and push

From within the repository:

```bash
git remote -v
git remote set-url origin git@github.com:TheProfitPilgrim/zen-linux.git
git remote -v
```

Stage and commit reviewed files:

```bash
git status --short
git add config/i3/config config/x11/40-zen-mouse.conf
git diff --cached --stat
git commit -m 'Save initial i3 and mouse configurations'
git push -u origin main
```

The initial commit is already present in this project's history; don't repeat it blindly when setting up a new machine. After the upstream is configured, ordinary `git push` / `git pull` is sufficient.

## E. Avoid entering your SSH passphrase on every push

An SSH agent can cache an **unlocked key in memory for the session**, without leaving the private key decrypted on disk.

```bash
echo "$SSH_AUTH_SOCK"  # should show an agent socket if one is available
ssh-add -l            # list currently loaded public-key identities
ssh-add ~/.ssh/id_ed25519
```

The last command asks for the key's passphrase and loads it into the running agent. Later terminals using the same agent can reuse it; after a reboot/login, you may need to unlock again. Never remove the key's passphrase merely for convenience.

## F. Email privacy incident recorded

The first push was rejected with `GH007: Your push would publish a private email address`. The GitHub account's email privacy protection was disabled and the push then succeeded. **Recommended follow-up:** configure the GitHub noreply email and re-enable the protection. An already-published commit still contains its existing author metadata unless its history is explicitly rewritten (not covered here).

## G. Daily workflow

```bash
git status
git add path/to/file
git diff --cached
git commit -m 'Explain the change'
git push
```

Never add passwords, tokens, key material, `.env` files, personal records, or unreleased copyrighted assets.
