#!/usr/bin/env bash
# Lightweight repo-contract tests for fzf-tab that DON'T require
# zsh + fzf to be installed (so they run on minimal CI images).
#
# Pins:
#   1. fzf-tab.plugin.zsh is the documented entrypoint and exists.
#   2. README references the entrypoint filename.
#   3. modules/ holds the build artifacts for completion-tag
#      capture (the optional but documented ftb-tmux-popup hook).
#   4. The .ztst test file is non-empty (catches accidental clears).

set -uo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

ok=1

[[ -f fzf-tab.plugin.zsh ]] || { echo "FAIL  fzf-tab.plugin.zsh missing"; ok=0; }
[[ -s fzf-tab.plugin.zsh ]] || { echo "FAIL  fzf-tab.plugin.zsh empty"; ok=0; }
[[ -f fzf-tab.zsh ]] || { echo "FAIL  fzf-tab.zsh missing"; ok=0; }
grep -qF 'fzf-tab.plugin.zsh' README.md || { echo "FAIL  README does not reference fzf-tab.plugin.zsh"; ok=0; }
[[ -s test/fzftab.ztst ]] || { echo "FAIL  test/fzftab.ztst missing or empty"; ok=0; }
[[ -d modules ]] || { echo "FAIL  modules/ directory missing"; ok=0; }

if [[ $ok -eq 1 ]]; then
    echo "OK  fzf-tab repo contract holds"
    exit 0
else
    echo "FAIL  fzf-tab repo contract breached"
    exit 1
fi
