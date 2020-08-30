# Using Interception and its `space2meta` plugin

TODO: Missing the instructions on how to build and install the interception tools.

Installed:

```
sudo apt-get install -y libyaml-cpp-dev libevdev libevdev-tools libevdev-dev libudev-dev
```

Look for the one that says "keyboard", in my case these are the following entries for my Dell XPS 13 PS/2 keyboard:

```
$ cat /proc/bus/input/devices
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input4
U: Uniq=
H: Handlers=sysrq kbd event4 leds 
B: PROP=0
B: EV=120013
B: KEY=1100f02902000 8380307cf910f001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7
```

To test this, we can `cat` the `/dev/input/event4` (`event4` comes from the `Handlers` line) and then press some keys in the keyboard, we should see some output:

```
$ sudo cat /dev/input/event4
xH_-H_-H_H_ H_ H_dH_ H_ H_H_!H_!H_fH_!H_!H_H_
!H_
!H_
fH_D!H_D!H_DH_bQ"H_bQ"H_bQgH_"H_"H_H_ H_ H_dH_
"H_
"H_
gH_ H_ H_H_e    "H_e    "H_e    ^C
```

Let's use the `uinput` to know the name of the keyboard. In this case is "AT Translated Set 2 keyboard":

```
$ sudo uinput -p -d /dev/input/event4
NAME: AT Translated Set 2 keyboard
PRODUCT: 1
VENDOR: 1
BUSTYPE: BUS_I8042
DRIVER_VERSION: 65537
EVENTS:
  EV_SYN: [SYN_REPORT, SYN_CONFIG, SYN_MT_REPORT, SYN_DROPPED]
  EV_KEY: [KEY_ESC, ..., KEY_LEFTSHIFT, ..., KEY_BATTERY, KEY_UNKNOWN]
  EV_MSC: [MSC_SCAN]
  EV_LED: [LED_NUML, LED_CAPSL, LED_SCROLLL]
  EV_REP:
    REP_DELAY: 250
    REP_PERIOD: 33
```

Now let's compile a custom `space2meta` Interception plugin, that instead of meta, sends the `RIGHTCTRL`, since we have the RIGHTCTRL activating a poor man's layer with XKB:

```
$ git clone https://gitlab.com/interception/linux/plugins/space2meta.git
$ cd space2meta
$ sed -i 's/KEY_LEFTMETA/KEY_RIGHTCTRL/g' space2meta.c
$ mkdir build
$ cd build && cmake ..
$ make
$ sudo make install
```

Armed with the keyboard name and device path, let's create a `~/dotfiles/udev-interception/udevmon.yml` file that tells `udevmon` what to run:

```
$ cat ~/dotfiles/udev-interception/udevmon.yml
- JOB: "intercept -g /dev/input/event4 | space2meta | uinput -d /dev/input/event4"
  DEVICE:
    NAME: "AT Translated Set 2 keyboard"
    EVENTS:
      EV_KEY: [ KEY_SPACE ]
```

And now let's create a service for `udevmon`:

```
$ cat /etc/systemd/system/udevmon.service
[Unit]
Description=udevmon
Wants=systemd-udev-settle.service
After=systemd-udev-settle.service

[Service]
ExecStart=/usr/bin/nice -n -20 /usr/local/bin/udevmon -c /home/andre/dotfiles/udev-interception/udevmon.yml

[Install]
WantedBy=multi-user.target
```

And finally let's enable the service:

```
$ sudo systemctl enable --now udevmon
Created symlink /etc/systemd/system/multi-user.target.wants/udevmon.service → /etc/systemd/system/udevmon.service.
### WORKING!!!
```
