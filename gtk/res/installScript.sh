#! bin/bash
sudo wget -P /usr/share/posidon.texter https://leoxshn.github.io/posidon-web/texter.jar
sudo echo "[Desktop Entry]\n" > /usr/share/applications/posidon.texter.desktop
sudo echo "Version=1.0" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Name=Texter" >> /usr/share/applications/posidon.texter.desktop
sudo echo "GenericName=Code editor" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Comment=Used to write code" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Categories=Utility;Education;GNOME;GTK;Code;Programming;" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Path=/usr/share/posidon.texter" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Exec=java -jar texter.jar" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Icon=application-default-icon" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Terminal=false" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Type=Application" >> /usr/share/applications/posidon.texter.desktop
sudo echo "MimeType=text/html;text/xml;" >> /usr/share/applications/posidon.texter.desktop
sudo echo "Keywords=Code;Programming;Texter;Text;" >> /usr/share/applications/posidon.texter.desktop
