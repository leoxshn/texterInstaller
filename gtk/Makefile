
objs = src/Main.vala
pkgs = gtk+-3.0

all:
	valac --gresourcesdir=res --gresources=res/resources.xml --pkg $(pkgs) $(objs) -o texterInstaller --verbose

run: all
	./texterInstaller
