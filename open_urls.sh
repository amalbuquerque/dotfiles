#! /bin/bash

# capture the last 40 lines
tmux capture-pane -S -40

# save those lines
tmux save-buffer ~/.urls

OPENER=xdg-open
case `uname` in
  Darwin)
    OPENER=open
  ;;
  Linux)
    OPENER=xdg-open
  ;;
esac

# open the last URL on those lines
cat ~/.urls | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | tail -n 1 | xargs $OPENER &> /dev/null && rm -rf ~/.urls
