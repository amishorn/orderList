# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-orderlist

CONFIG += sailfishapp \
    c++11

#icon86.files = icons/86x86/$${TARGET}.png
#icon108.files = icons/108x108/$${TARGET}.png
#icon128.files = icons/128x128/$${TARGET}.png
#icon256.files = icons/256x256/$${TARGET}.png

#icon86.path = /usr/share/icons/hicolor/86x86/apps
#icon108.path = /usr/share/icons/hicolor/108x108/apps
#icon128.path = /usr/share/icons/hicolor/128x128/apps
#icon256.path = /usr/share/icons/hicolor/256x256/apps

#INSTALLS += icon86 icon108 icon128 icon256

SOURCES += \
    src/orderList.cpp \
    olModel.cpp \
    oListItem.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    translations/*.ts \
    qml/pages/AddItem.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

DEFINES += APP_VERSION=\\\"$$VERSION\\\"

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n \ DConf

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/orderList-de.ts

HEADERS += \
    olModel.h \
    oListItem.h

QT += core \
    xml

DISTFILES += \
    qml/pages/SettingsPage.qml \
    harbour-orderlist.desktop \
    rpm/harbour-orderlist.spec \
    rpm/harbour-orderlist.yaml \
    qml/harbour-orderlist.qml \
    qml/pages/QuantSelector.qml \
    AboutPage.qml \
    qml/pages/AboutPage.qml \
    rpm/harbour-orderlist.changes

