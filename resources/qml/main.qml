import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Graphizer")

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        radius: 10
        color: "yellow"

        Board {
            anchors.fill: parent
        }
    }
}
