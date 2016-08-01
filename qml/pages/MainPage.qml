import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
        model: ListModel {
            ListElement { sensor: "Network Registeration"; address: "networkRegisteration.qml" }
            ListElement { sensor: "Sim Manager"; address: "simManager.qml" }
            ListElement { sensor: "Modem"; address: "modem.qml" }
            ListElement { sensor: "Radio Settings"; address: "radioSettings.qml" }
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

