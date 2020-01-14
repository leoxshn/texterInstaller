
[CCode(cheader_filename = "resources.c")]
public class Main : Gtk.Application {
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
			progress
			print("bananas");
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
