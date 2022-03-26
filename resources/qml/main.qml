import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Driver

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Graphizer")

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10

            TextButton {
                id: insertButton
                Layout.preferredWidth: 100
                Layout.preferredHeight: 30
                text: "Insert node"
                textColor: "white"
                color: "#348ceb"

                onClicked: board.mode = Board.MODE.INSERTION
            }
            TextButton {
                id: connectButton
                Layout.preferredWidth: 100
                Layout.preferredHeight: 30
                text: "Connect"
                textColor: "white"
                color: "#348ceb"

                onClicked: board.mode = Board.MODE.CONNECTION
            }
            TextButton {
                id: runButton
                Layout.preferredWidth: 100
                Layout.preferredHeight: 30
                text: "Run"
                textColor: "white"
                color: "#348ceb"

                onClicked: {
                    board.mode = Board.MODE.IDLE
                    Driver.graph.runDSU()
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 500
            Layout.preferredHeight: 1
            color: "#348ceb"
        }
        Board {
            id: board
            Layout.fillWidth: true
            Layout.fillHeight: true
            mode: Board.MODE.INSERTION
        }
    }
}
