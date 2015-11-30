# Tim's dotfiles

They're the best. Handcrafted over the course of significantly less than
a single generation. There are a lot of inter-dependencies, by the way. Be
prepared for breakage if you only use a part of them.

I use Arch Linux, so some widgets, paths, etc, may/will need to be adapted.

## Window manager

I use `bspwm`. The theme will read the colors from `xrdb` through the
`getcolor` function defined in `.bashrc`.

I use `conky` to get the system infos. The conky window can be toggled with
super - z.

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

`urxvt` and that's about it. There are some nice `.dircolors` too.

## Editor

Yeah, it's `vim` -- with a sane configuration. It should be ready to
go. The theme uses the colors from `xrdb` too, so it will adapt to your
shell colorscheme.

There are a few markdown (pandoc) related things. The most notable
is auto-completion of references from the standard pandoc location
(`~/.pandoc/default.json`).

## But does it looks nice?

*Not up to date*

![screenshot](https://raw.githubusercontent.com/tpoisot/dotfiles/master/scrot.png)
