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
        color: "white"

        ColumnLayout {
            anchors.fill: parent
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.margins: 10

                TextButton {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 30
                    text: "Insert node"
                    textColor: "white"
                    color: "#348ceb"
                }
                TextButton {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 30
                    text: "Connect"
                    textColor: "white"
                    color: "#348ceb"
                }
                TextButton {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 30
                    text: "Run"
                    textColor: "white"
                    color: "#348ceb"
                }
            }
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 500
                Layout.preferredHeight: 1
                color: "#348ceb"
            }
            Board {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

    }
}
