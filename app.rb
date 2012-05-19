require './d3status'
IMAGE_UP = File.join("images", "diabloup.png")
IMAGE_DOWN = File.join("images", "diablodown.png")
DURATION = 5 #5 minutes

def get_image_name
  parser = D3Parser.new
  if parser.us_server == "Available"
    IMAGE_UP
  else
    IMAGE_DOWN
  end
end

def get_tray_image
  java.awt.Toolkit::default_toolkit.get_image(get_image_name)
end


include Java

import java.awt.TrayIcon
import java.awt.event.MouseListener

abort "System Tray not supported" unless java.awt.SystemTray::isSupported

tray = java.awt.SystemTray::system_tray
image = get_tray_image

popup = java.awt.PopupMenu.new
exit_item = java.awt.MenuItem.new("Exit")

exit_item.addActionListener do
  java.lang.System::exit(0)
end

popup.add(exit_item)
trayIcon = TrayIcon.new(image, "D3 Status", popup)
trayIcon.image_auto_size = true
tray.add(trayIcon)

loop do 
  sleep DURATION
  trayIcon.setImage(get_tray_image)
end