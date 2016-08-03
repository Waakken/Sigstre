import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
        model: ListModel {
            ListElement { sensor: "Connection Context"; address: "connectionContext.qml" }
            ListElement { sensor: "Connection Manager"; address: "connectionManager.qml" }
            ListElement { sensor: "Modem"; address: "modem.qml" }
            ListElement { sensor: "Network Registeration"; address: "networkRegisteration.qml" }
            ListElement { sensor: "Radio Settings"; address: "radioSettings.qml" }
            ListElement { sensor: "Sim Manager"; address: "simManager.qml" }
            ListElement { sensor: "Sim Toolkit"; address: "simToolKit.qml" }
            ListElement { sensor: "Voice Call Manager"; address: "voiceCallManager.qml" }
        }
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Ofono reader")
        }
        delegate: BackgroundItem {
            id: delegate
            Label {
                x: Theme.paddingLarge
                text: sensor
                anchors.horizontalCenter: parent.horizontalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl(address))
            }
        }
        VerticalScrollDecorator {}
    }
}

