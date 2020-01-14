#! bin/bash
sudo wget -P /usr/share/posidon.texter https://leoxshn.github.io/posidon-web/texter.jar
sudo echo "[Desktop Entry]\n" > /usr/share/applications/posidon.texter.desktop
sudo echo "Version=1.0\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Name=Texter\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "GenericName=Code editor\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Comment=Used to write code\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Categories=Utility;Education;GNOME;GTK;Code;Programming;\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Path=/usr/share/posidon.texter\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Exec=java -jar texter.jar\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Icon=application-default-icon\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Terminal=false\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Type=Application\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "MimeType=text/html;text/xml;\n" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Keywords=Code;Programming;Texter;Text;\n" >> /usr/share/applications/posidon.texter.desktop