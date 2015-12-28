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
                title: "Sim Manager"
            }
                Button {
                    x: Theme.paddingLarge
                    id: stopButton
                    text: "Update"
                    onClicked: {
                        dbusNetwork.getProperties();
                        handleProperties(root.getPropertiesObject)
                    }
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
        }
    }


    function handleProperties(result) {
        var message = "";
        for (var key in result) {
            message = message + key + ": " + result[key] + "\n";
        }
        messageText.text = message;
    }

    function storeResultsTovariable(results) {
        root.getPropertiesObject = results;
    }

    DBusInterface {
        service: 'org.ofono'
        path: '/ril_0'
        iface: 'org.ofono.SimManager'
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

