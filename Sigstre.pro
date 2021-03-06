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
TARGET = Sigstre

CONFIG += sailfishapp

SOURCES += src/Sigstre.cpp

OTHER_FILES += qml/Sigstre.qml \
    qml/cover/CoverPage.qml \
    rpm/Sigstre.changes.in \
    rpm/Sigstre.spec \
    rpm/Sigstre.yaml \
    translations/*.ts \
    Sigstre.desktop

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/Sigstre-de.ts

DISTFILES += \
    qml/pages/networkRegisteration.qml \
    qml/pages/simManager.qml \
    qml/pages/MainPage.qml \
    qml/pages/modem.qml \
    qml/pages/radioSettings.qml \
    qml/pages/voiceCallManager.qml \
    qml/pages/simToolKit.qml \
    qml/pages/connectionManager.qml \
    qml/pages/connectionContext.qml

