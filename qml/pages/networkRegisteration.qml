import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.dbus 2.0

Page {
    id: root
    property var getPropertiesObject;
    property int index: 1;
    property var foundBasestations: Object.create(null)

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
                title: "Network Registeration"
            }
            Row {
                Button {
                    x: Theme.paddingLarge
                    id: stopButton
                    text: "Stop updating"
                    onClicked: {
                        timer.running = false;
                        stopButton.text = "Updating stopped";
                    }
                }
                Button {
                    text: "Add test stations"
                    onClicked: {
                        addTestStations();
                    }
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
            Timer {
                id: timer
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    dbusNetwork.getProperties();
                    handleNetworkRegistrationProperties(root.getPropertiesObject)
                }
            }
        }
    }


    function handleNetworkRegistrationProperties(result) {
        var message = "";
        var foundKeys = "";
        for (var key in result) {
            message = message + key + ": " + result[key] + "\n";
            foundKeys = foundKeys + " " + key;
        }
        var currentBasestation = Object.create(null);

        if(result['CellId']) {
            currentBasestation['CellId'] = result['CellId'];
            currentBasestation['LocationAreaCode'] = result['LocationAreaCode'];
            currentBasestation['MobileCountryCode'] = result['MobileCountryCode'];
            currentBasestation['MobileNetworkCode'] = result['MobileNetworkCode'];
            root.foundBasestations[currentBasestation['CellId']] = currentBasestation;
        }

        message = message + "\nPrevious Basestations\n";

        /*var listOfStations = root.foundBasestations.values();
        var listOfKeys = listOfStations[0].keys();
        var header = "";
        for (key in listOfKeys) {
            header = header + key + " ";
        }
        message = message + header + "\n";*/

        var singleBS = "";
        for (var basestationKey in root.foundBasestations) {
            var basestation = root.foundBasestations[basestationKey]
            for (key in basestation) {
                //console.log("Feature: " + key + " Value: " + basestation[key]);
                singleBS = singleBS + basestation[key] + " ";
            }
            message = message + singleBS + "\n";
            singleBS = "";
        }
        messageText.text = message;
    }

    function storeResultsTovariable(results) {
        root.getPropertiesObject = results;
    }

    DBusInterface {
        service: 'org.ofono'
        path: '/ril_0'
        iface: 'org.ofono.NetworkRegistration'
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

        function getModems() {
            var result = call('GetModems', undefined);
            console.log("Called GetModems. Result: " + result);
            signalStrength.text = result;
        }
    }

    function addTestStations() {
        var testStation = createTestStation(root.index);
        root.foundBasestations[testStation['CellId']] = testStation;
        root.index++;
    }

    function createTestStation(number) {
        var testStation = Object.create(null);
        testStation['CellId'] = number * 1000;
        testStation['LocationAreaCode'] = number * 10;
        testStation['MobileCountryCode'] = number * 20;
        testStation['MobileNetworkCode'] = number * 15;
        var msg = "";
        for (var key in testStation) {
            msg = msg + "Key: " + key + " Value: " + testStation[key] + " ";
        }
        //console.log("New station created: " + msg);
        return testStation;
    }
}

