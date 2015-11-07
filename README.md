# Tim's dotfiles

They're the best. Handcrafted over the course of significantly less than
a single generation. There are a lot of inter-dependencies, by the way. Be
prepared for breakage if you only use a part of them.

## Window manager

I use `awesome`. The theme will read the colors from `xrdb -q` (so it will
look just like your terminal). The icons come from Font Awesome, so make
sure to have that installed. The taglist, etc, font is Open Sans Semibold.

The top bar give informations on network SSIDs, number of emails in the
INBOX and in Drafts, number of `pacman` updates (because Arch), `/home`
space used, date, time, and battery state.

## Email

`mutt` + `notmuch` + `offlineimaprc` + `msmtprc`

As far as mutt configurations goes, it's pretty minimal (and if you have
read the usual mutt tutorials you should not be surprised). `vim` bindings
all around.

## Terminal

`urxvt` and that's about it. There are some nice `.dircolors` too.

## Editor

Yeah, it's `vim` -- with a sane configuration. It should be ready to
go. The theme uses the colors from `xrdb` too, so it will adapt to your
shell colorscheme.

There are a few markdown (pandoc) related things. The most notable
is auto-completion of references from the standard pandoc location
(`~/.pandoc/default.json`).
