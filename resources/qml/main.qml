import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Graphizer")

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        radius: 10
        color: "black"

        ColumnLayout {
            anchors.fill: parent
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.margins: 10

                TextButton {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 30
                    text: "Insert node"
                    textColor: "black"
                    color: "yellow"
                }
                TextButton {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 30
                    text: "Connect"
                    textColor: "black"
                    color: "yellow"
                }
                TextButton {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 30
                    text: "Run"
                    textColor: "black"
                    color: "yellow"
                }
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 500
                Layout.preferredHeight: 1
                color: "yellow"
            }
            Board {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

    }
}
