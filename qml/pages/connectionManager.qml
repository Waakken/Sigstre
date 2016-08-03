import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.dbus 2.0

Page {
    id: root
    property var getPropertiesObject;

    SilicaFlickable {
        contentHeight: column.height
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        VerticalScrollDecorator {}
        Column {
            width: root.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Theme.paddingLarge
            id: column
            PageHeader {
                title: "Connection Manager"
            }
            TextEdit {
                x: Theme.paddingLarge
                id: messageText
                text: ""
                font.family: "Latin Modern Math"
                wrapMode: TextInput.WordWrap
                width: parent.width
                color: Theme.highlightColor
                readOnly: true
            }
            Timer {
                id: timer
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    dbusNetwork.getProperties();
                    messageText.text = topPage.handleProperties(root.getPropertiesObject);
                }
            }
        }
    }
    function storeResultsTovariable(results) {
        root.getPropertiesObject = results;
    }
    DBusInterface {
        service: 'org.ofono'
        path: '/ril_0'
        iface: 'org.ofono.ConnectionManager'
        id: dbusNetwork
        bus: DBus.SystemBus

        function getProperties() {
            typedCall('GetProperties',
                      undefined,
                      storeResultsTovariable,
                      function() {
                          console.log('call failed')
                      })
        }
    }
}

