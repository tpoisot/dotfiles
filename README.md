# Tim's dotfiles

They're the best. Handcrafted over the course of significantly less than
a single generation. There are a lot of inter-dependencies, by the way. Be
prepared for breakage if you only use a part of them.

The fonts used are DejaVu Sans Condensed and DejaVu Sans Mono; and some Font
Awesome for the top bar.

I use Arch Linux, so some widgets, paths, etc, may/will need to be adapted.

## Window manager

I use `awesome`. The theme will read the colors from `xrdb -q` (so it will
look just like your terminal). The icons come from Font Awesome, so make
sure to have that installed.

The top bar give informations on network SSIDs, volume of speakers and
microphone, number of emails in the INBOX and in Drafts, number of `pacman`
updates (because Arch), `/home` space used, date, time, and battery state. The
widgets are updated every 10 seconds.

Most of the action happens in `.config/awesome/rc.lua`, notably the widgets. If
you need to adapt them to the specifics of your system, this is where you
should look.

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

![screenshot](https://raw.githubusercontent.com/tpoisot/dotfiles/master/scrot.png)
