# Tim's dotfiles

They're the best. Handcrafted over the course of significantly less than a
single generation. There are a lot of inter-dependencies, by the way. Be
prepared for breakage if you only use a part of them. Most of the things
you see read, in one way or another, from `~/.Xresources`.

I use Arch Linux, so some widgets, paths, etc, may/will need to be adapted.

## Window manager

I use `bspwm`. The theme will read the colors from `xrdb` through the
`getcolor` function defined in `.bashrc`.

I use `lemonbar` to get the system infos. The bar can be toggled with
super-z. It shows *very* minimal informations: date, time, emails, wireless
ssid, power, status of some disks, volume and mic status, and spotify status.

## Email

`mutt` + `notmuch` + `offlineimaprc` + `msmtprc` + `abook`

As far as mutt configurations goes, it's pretty minimal (and if you have
read the usual mutt tutorials you should not be surprised). `vim` bindings
all around.

Most important key bindings are `M` to move a message, `I` to get back to the
inbox, `a` to create a new contact, and `A` to send a message to the archive.

My email server is hosted by Gandi (they're great), and the `offlineimaprc`
and `msmtprc` reflect that. If you use something else, or Gmail, go read
the appropriate documentation.

## Terminal

`xterm` and that's about it. There are some nice `.dircolors` too.

## Editor

Yeah, it's `vim` -- with a sane configuration. It should be ready to
go. The theme uses the colors from `xrdb` too, so it will adapt to your
shell colorscheme.

There are a few markdown (pandoc) related things. The most notable
is auto-completion of references from the standard pandoc location
(`~/.pandoc/default.json`).

## But does it looks nice?

I would say it does.

![screenshot](https://raw.githubusercontent.com/tpoisot/dotfiles/master/scrot.png)
