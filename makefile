vimrc = ~/.vimrc
bashrc = ~/.bashrc
xresources = ~/.Xresources
muttrc = ~/.mutt/muttrc
muttcol = ~/.mutt/colors
scripts = ~/.scripts/*

all: folders vimrc bashrc xresources muttrc muttcol scripts

folders:
	mkdir -p scripts

scr: $(scripts)
	cp $(scripts) scripts

vimrc: $(vimrc)
	cp $(vimrc) vimrc

bash: $(bashrc)
	cp $(bashrc) bashrc

xresources: $(xresources)
	cp $(xresources) Xresources

mutt: $(muttrc)
	cp $(muttrc) muttrc

muttcol: $(muttcol)
	cp $(muttcol) mutt_colors
