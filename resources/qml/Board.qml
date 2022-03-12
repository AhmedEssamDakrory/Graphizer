import QtQuick
import QtQml
import Driver

Canvas {
    id: canvas

    enum MODE {
        IDLE,
        INSERTION,
        CONNECTION
    }
    property int mode: MODE.INSERTION
    property int paintX: -1
    property int paintY: -1
    property var firstSelectedNode: null
    property var secondSelectedNode: null
    property color drawColor: "black"
    property int circleRadius: 20

    function reset() {
        paintX = -1
        paintY = -1
        firstSelectedNode = null
        secondSelectedNode = null
    }

    onPaint: {
        switch(mode) {
        case Board.MODE.INSERTION:
            drawNode()
            break
        case Board.MODE.CONNECTION:
            drawEdge()
            break
        }
    }

    MouseArea {
        id: mousearea
        hoverEnabled:true
        anchors.fill: parent
        onClicked: {
            console.log(mouseX, mouseY)
            switch(mode) {
            case Board.MODE.INSERTION:
                Driver.graph.insertNode(mouseX, mouseY)
                break
            case Board.MODE.CONNECTION:
                const selectedNode = Driver.graph.selectNode(mouseX, mouseY)
                if (isValidPos(selectedNode.x, selectedNode.y)) {
                    if (firstSelectedNode == null) {
                        firstSelectedNode = selectedNode
                    } else {
                        secondSelectedNode = selectedNode
                        Driver.graph.connect(firstSelectedNode.x, firstSelectedNode.y,
                                             secondSelectedNode.x, secondSelectedNode.y)
                        requestPaint()
                    }
                }
                break
            }
        }
    }

    function isValidPos(x, y)
    {
        return !(x - circleRadius <= canvas.x ||
                 x + circleRadius >= canvas.x + canvas.width ||
                 y - circleRadius <= canvas.y ||
                 y + circleRadius >= canvas.y + canvas.height)
    }

    function drawNode() {
        const ctx = getContext("2d")

        if (isValidPos(paintX, paintY) === false)
            return

        ctx.beginPath()
        ctx.lineWidth = 2
        ctx.strokeStyle = drawColor
        ctx.arc(paintX, paintY, 20, 0, 2 * Math.PI, false)
        ctx.stroke()
        reset()
    }

    function drawEdge () {
        const ctx = getContext("2d")
        ctx.lineWidth = 2;
        ctx.strokeStyle = drawColor
        ctx.beginPath()
        ctx.moveTo(firstSelectedNode.x, firstSelectedNode.y)
        ctx.lineTo(secondSelectedNode.x, secondSelectedNode.y)
        ctx.stroke()
        reset()
    }

    function clear() {
        const ctx = canvas.getContext('2d')
        ctx.clearRect(0, 0, width, height)
    }

    Connections {
        target: Driver.graph
        function onNodeInserted(x, y) {
            canvas.paintX = x
            canvas.paintY = y
            canvas.requestPaint()
        }
    }
}
