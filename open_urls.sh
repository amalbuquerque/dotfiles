#! /bin/bash

# capture the last 40 lines
tmux capture-pane -S -40

# save those lines
tmux save-buffer ~/.urls

# open the last URL on those lines
cat ~/.urls | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | tail -n 1 | xargs xdg-open &> /dev/null && rm -rf ~/.urls
