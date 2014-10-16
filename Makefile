vimrc = ~/.vimrc
bashrc = ~/.bashrc
xresources = ~/.Xresources
muttrc = ~/.mutt/muttrc
muttcol = ~/.mutt/colors
scripts = ~/.scripts/*
schemes = ~/.schemes/*.xresources

all: folders vimrc bashrc xresources mutt muttcol scripts schemes

folders:
	mkdir -p scripts
	mkdir -p schemes

schemes: $(schemes)
	cp $(schemes) schemes

scr: $(scripts)
	cp $(scripts) scripts

vimrc: $(vimrc)
	cp $(vimrc) vimrc

bashrc: $(bashrc)
	cp $(bashrc) bashrc

xresources: $(xresources)
	cp $(xresources) Xresources

mutt: $(muttrc)
	cp $(muttrc) muttrc

muttcol: $(muttcol)
	cp $(muttcol) mutt_colors
