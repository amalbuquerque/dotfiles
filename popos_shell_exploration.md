# this works

```
gdbus call --session --dest com.System76.PopShell --object-path /com/System76/PopShell --method com.System76.PopShell.WindowList

gdbus call --session --dest com.System76.PopShell --object-path /com/System76/PopShell --method com.System76.PopShell.FocusRight

gdbus call --session --dest com.System76.PopShell --object-path /com/System76/PopShell --method com.System76.PopShell.Launcher
```

# All of these work if we enable unsafe_mode
# Alt + F2, run `lg` (Looking Glass) and then `global.context.unsafe_mode = true`
# See https://askubuntu.com/a/1412426/210363

After doing the unsafe thing all of these work.

```
dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Main.overview.toggle();'

dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Main.overview.show();'

dbus-send --session --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Object.getOwnPropertyNames(Main.shellDBusService.constructor.prototype);'

dbus-send --session --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.workspace_manager.get_active_workspace();'

dbus-send --session --type=method_call --print-reply --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.workspace_manager.get_active_workspace().list_windows();'

dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.workspace_manager.get_active_workspace().get_neighbor(Meta.MotionDirection.LEFT).activate(global.get_current_time());'

dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'global.workspace_manager.get_active_workspace().get_neighbor(Meta.MotionDirection.RIGHT).activate(global.get_current_time());'
```

```
gsettings list-recursively org.gnome.desktop.wm.keybindings | grep switch-to-workspace
```

To set a new keybinding:

```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[\"<Super>8\"]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[\"<Super>9\"]"
```
