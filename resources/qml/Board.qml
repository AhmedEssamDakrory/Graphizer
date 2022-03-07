import QtQuick

Canvas {
    id:canvas
    property int paintX: -1
    property int paintY: -1
    property color drawColor: "black"
    property int circleRadius: 20

    onPaint: drawCircle()

    MouseArea {
        id:mousearea
        hoverEnabled:true
        anchors.fill: parent
        onClicked: {
            paintX = mouseX
            paintY = mouseY
            requestPaint()
        }
    }

    function isValidPos()
    {
        return !(paintX - circleRadius <= canvas.x ||
                 paintX + circleRadius >= canvas.x + canvas.width ||
                 paintY - circleRadius <= canvas.y ||
                 paintY + circleRadius >= canvas.y + canvas.height)
    }

    function drawCircle() {
        const ctx = getContext("2d");

        if (isValidPos() === false)
            return

        ctx.beginPath()
        ctx.lineWidth = 2
        ctx.strokeStyle = drawColor
        ctx.arc(paintX, paintY, 20, 0, 2 * Math.PI, false);
        ctx.stroke();
    }

    function clear() {
        const ctx = canvas.getContext('2d')
        ctx.clearRect(0, 0, width, height)
    }
}
