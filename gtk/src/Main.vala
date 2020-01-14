
public class Main : Gtk.Application {

	public const string installScript = 
	"#! bin/bash
sudo wget -O /usr/share/posidon.texter/texter.jar https://leoxshn.github.io/posidon-web/texter.jar -nv
sudo echo \"[Desktop Entry]\" > /usr/share/applications/posidon.texter.desktop
sudo echo \"Version=1.0\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Name=Texter\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"GenericName=Code editor\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Comment=Used to write code\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Categories=Utility;Education;GNOME;GTK;Code;Programming;\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Path=/usr/share/posidon.texter\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Exec=java -jar texter.jar\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Icon=application-default-icon\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Terminal=false\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Type=Application\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"MimeType=text/html;text/xml;\" >> /usr/share/applications/posidon.texter.desktop
sudo echo \"Keywords=Code;Programming;Texter;Text;\" >> /usr/share/applications/posidon.texter.desktop";

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
		var icons = new List<Gdk.Pixbuf>();
		icons.append(new Gdk.Pixbuf.from_resource ("/icons/128.png"));
		icons.append(new Gdk.Pixbuf.from_resource ("/icons/64.png"));
		icons.append(new Gdk.Pixbuf.from_resource ("/icons/32.png"));
		window.set_icon_list(icons);
		window.icon = new Gdk.Pixbuf.from_resource ("/icons/128.png");
		
		var cssProvider = new Gtk.CssProvider();
		cssProvider.load_from_data("
		.install-btn {
			background-image: linear-gradient(to bottom, #68b723, #3a9104);
			padding-top: 8px;
			padding-bottom: 8px;
			padding-left: 20px;
			padding-right: 20px;
		}
		.install-btn:disabled {
			background-image: none;
		}
		
		.web-btn {
			background-image: linear-gradient(to bottom, #a56de2, #7239b3);
			padding-top: 8px;
			padding-bottom: 8px;
			padding-left: 20px;
			padding-right: 20px;
		}
		");
		Gtk.StyleContext.add_provider_for_screen(window.get_screen(), cssProvider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
		
		var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 12);
		box.halign = Gtk.Align.CENTER;
		box.valign = Gtk.Align.CENTER;
		window.add(box);
		
		var bigIcon = new Gtk.Image.from_resource("/icons/texterIcon.png");
		bigIcon.margin_bottom = 12;
		box.add(bigIcon);
		
		var progress = new Gtk.ProgressBar ();
		box.add(progress);
		
		var installBtn = new Gtk.Button.with_label("Install");
		installBtn.get_style_context().add_class("suggested-action");
		installBtn.get_style_context().add_class("install-btn");
		installBtn.halign = Gtk.Align.CENTER;
		installBtn.valign = Gtk.Align.CENTER;
		installBtn.clicked.connect (() => {
			progress.show();
			installBtn.hide();
			try {
				FileStream stream = FileStream.open("/tmp/tmpTexterInstallScript.sh", "w");
				stream.puts (installScript);
				stream.flush();
				progress.fraction = 0.3;
				Process.spawn_command_line_async("pkexec sudo sh /tmp/tmpTexterInstallScript.sh");
				progress.fraction = 0.6;
			} catch (Error e) {
				print("error: %s\n", e.message);
			}
			Process.spawn_command_line_sync("rm /tmp/tmpTexterInstallScript.sh");
		});
		box.add(installBtn);
		
		window.show_all();
		progress.hide();
	}
	
	public static int main (string[] args) {
		var main = new Main ();
		return main.run(args);
	}
}
