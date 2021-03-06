
public class Main : Gtk.Application {

	public const string installScript = 
	"#! bin/bash
sudo rm /usr/share/posidon.texter/texter.jar
sudo wget https://posidon.io/texter/texter.jar -nv -P /usr/share/posidon.texter
sudo cp /tmp/tmpTexterIcon128.png -T /usr/share/icons/hicolor/128x128/apps/posidon.texter.png
sudo cp /tmp/tmpTexterIcon64.png -T /usr/share/icons/hicolor/64x64/apps/posidon.texter.png
sudo cp /tmp/tmpTexterIcon48.png -T /usr/share/icons/hicolor/48x48/apps/posidon.texter.png
sudo cp /tmp/tmpTexterIcon32.png -T /usr/share/icons/hicolor/32x32/apps/posidon.texter.png
sudo cp /tmp/tmpTexterIcon16.png -T /usr/share/icons/hicolor/16x16/apps/posidon.texter.png
sudo rm /tmp/tmpTexterIcon128.png
sudo rm /tmp/tmpTexterIcon64.png
sudo rm /tmp/tmpTexterIcon48.png
sudo rm /tmp/tmpTexterIcon32.png
sudo rm /tmp/tmpTexterIcon16.png
sudo echo \"[Desktop Entry]\" > /usr/share/applications/posidon.texter.desktop
sudo echo \"Version=1.0\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Name=Texter\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"GenericName=Code editor\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Comment=Used to write code\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Categories=Utility;Education;GNOME;GTK;Code;Programming;Development;IDE;WebDevelopment;\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Path=/usr/share/posidon.texter\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Exec=java -jar texter.jar %U\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Icon=posidon.texter\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Terminal=false\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Type=Application\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"MimeType=text/plain;inode/directory;\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Keywords=Code;Programming;Texter;Text;\" >> /usr/share/applications/posidon.texter.desktop
sudo gtk-update-icon-cache --force /usr/share/icons/hicolor
sudo update-desktop-database /usr/share/applications";

	public const string uninstallScript = 
	"#! bin/bash
sudo rm -rf /usr/share/posidon.texter
sudo rm /usr/share/icons/hicolor/128x128/apps/posidon.texter.png
sudo rm /usr/share/icons/hicolor/64x64/apps/posidon.texter.png
sudo rm /usr/share/icons/hicolor/48x48/apps/posidon.texter.png
sudo rm /usr/share/icons/hicolor/32x32/apps/posidon.texter.png
sudo rm /usr/share/icons/hicolor/16x16/apps/posidon.texter.png
sudo rm /usr/share/applications/posidon.texter.desktop
sudo gtk-update-icon-cache --force /usr/share/icons/hicolor
sudo update-desktop-database /usr/share/applications";

	public Main () {
		Object (
			application_id: "posidon.texter.installer",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}
	
	protected override void activate () {
		
		var window = new Gtk.ApplicationWindow(this);
		Gdk.set_program_class("texter-installer");
		window.title = "texter installer";
		window.window_position = Gtk.WindowPosition.CENTER;
		window.set_default_size (320, 260);
		window.resizable = false;
		window.destroy.connect (Gtk.main_quit);
		try { window.icon = new Gdk.Pixbuf.from_resource ("/appIcon/48.svg"); }
		catch (Error e) {}
		
		var cssProvider = new Gtk.CssProvider();
		cssProvider.load_from_data(".btn {
			padding-top: 8px;
			padding-bottom: 8px;
			padding-left: 22px;
			padding-right: 22px;
		}");
		Gtk.StyleContext.add_provider_for_screen(window.get_screen(), cssProvider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
		
		var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 12);
		box.halign = Gtk.Align.CENTER;
		box.valign = Gtk.Align.CENTER;
		window.add(box);
		
		var bigIcon = new Gtk.Image.from_resource("/texterIcon/128.svg");
		bigIcon.margin_bottom = 12;
		box.add(bigIcon);
		
		var label = new Gtk.Label ("Loading...");
		box.add(label);
		
		var installBtn = new Gtk.Button.with_label("Install");
		var uninstallBtn = new Gtk.Button.with_label("Uninstall");
		installBtn.get_style_context().add_class("suggested-action");
		installBtn.get_style_context().add_class("btn");
		installBtn.halign = Gtk.Align.CENTER;
		installBtn.valign = Gtk.Align.CENTER;
		installBtn.clicked.connect (() => {
			label.show();
			installBtn.hide();
			uninstallBtn.hide();
			try {
				FileStream stream = FileStream.open("/tmp/tmpTexterInstallScript.sh", "w");
				stream.puts (installScript);
				stream.flush();
				new Gdk.Pixbuf.from_resource ("/texterIcon/128.svg").save ("/tmp/tmpTexterIcon128.png", "png");
				new Gdk.Pixbuf.from_resource ("/texterIcon/64.svg").save ("/tmp/tmpTexterIcon64.png", "png");
				new Gdk.Pixbuf.from_resource ("/texterIcon/48.svg").save ("/tmp/tmpTexterIcon48.png", "png");
				new Gdk.Pixbuf.from_resource ("/texterIcon/32.svg").save ("/tmp/tmpTexterIcon32.png", "png");
				new Gdk.Pixbuf.from_resource ("/texterIcon/16.svg").save ("/tmp/tmpTexterIcon16.png", "png");
				Process.spawn_command_line_sync("pkexec sudo sh /tmp/tmpTexterInstallScript.sh");
				Process.spawn_command_line_sync("rm /tmp/tmpTexterInstallScript.sh");
				label.label = "Done!";
			} catch (Error e) {
				label.label = "error: " + e.message;
			}
		});
		box.add(installBtn);
		
		uninstallBtn.get_style_context().add_class("destructive-action");
		uninstallBtn.get_style_context().add_class("btn");
		uninstallBtn.halign = Gtk.Align.CENTER;
		uninstallBtn.valign = Gtk.Align.CENTER;
		uninstallBtn.clicked.connect (() => {
			label.show();
			uninstallBtn.hide();
			installBtn.hide();
			try {
				FileStream stream = FileStream.open("/tmp/tmpTexterUninstallScript.sh", "w");
				stream.puts (uninstallScript);
				stream.flush();
				Process.spawn_command_line_sync("pkexec sudo sh /tmp/tmpTexterUninstallScript.sh");
				Process.spawn_command_line_sync("rm /tmp/tmpTexterUninstallScript.sh");
				label.label = "Done!";
			} catch (Error e) {
				label.label = "error: " + e.message;
			}
		});
		box.add(uninstallBtn);
		
		window.show_all();
		label.hide();
	}
	
	public static int main (string[] args) {
		return new Main().run(args);
	}
}