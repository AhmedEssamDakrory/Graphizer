import QtQuick

Rectangle {
    property alias text: textContent.text
    property alias textColor: textContent.color

    signal clicked()

    implicitHeight: textContent.height
    implicitWidth: textContent.width
    radius: height / 2
    opacity: mouseArea.containsMouse ? 0.9 : 1

    Text {
        id: textContent
        anchors.centerIn: parent
        font.bold: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: parent.clicked()
    }
}