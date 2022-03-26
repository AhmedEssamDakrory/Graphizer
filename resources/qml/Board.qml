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
    property var firstSelectedNode: null
    property var secondSelectedNode: null
    property int circleRadius: 20
    property var paintRequests: []

    function reset() {
        firstSelectedNode = null
        secondSelectedNode = null
    }

    onPaint: {
        drawRequests()
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
                        reset()
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

    function drawRequests()
    {
        while(paintRequests.length != 0) {
            const req = paintRequests.shift()
            console.log("mode: ", req.mode)

            switch(req.mode) {
            case Board.MODE.INSERTION:
                drawNode(req.x, req.y, req.color)
                break
            case Board.MODE.CONNECTION:
                drawEdge(req.x1, req.y1, req.x2, req.y2)
                break
            }
        }
    }

    function drawNode(x, y, color) {
        const ctx = getContext("2d")

        if (isValidPos(x, y) === false)
            return

        ctx.beginPath()
        ctx.lineWidth = 2
        ctx.fillStyle = color
        ctx.arc(x, y, 20, 0, 2 * Math.PI, false)
        ctx.fill()
    }

    function drawEdge(x1, y1, x2, y2) {
        const ctx = getContext("2d")
        ctx.lineWidth = 2;
        ctx.strokeStyle = "black"
        ctx.beginPath()
        ctx.moveTo(x1, y1)
        ctx.lineTo(x2, y2)
        ctx.stroke()
    }

    function clear() {
        const ctx = canvas.getContext('2d')
        ctx.clearRect(0, 0, width, height)
    }

    Connections {
        target: Driver.graph
        function onNodeInserted(x, y, c) {
            let req = {
                "mode": Board.MODE.INSERTION,
                "x": x,
                "y": y,
                "color": c
            }
            paintRequests.push(req)
            canvas.requestPaint()
        }

        function onEdgeConnected(x1, y1, x2, y2) {
            let req = {
                "mode": Board.MODE.CONNECTION,
                "x1": x1,
                "y1": y1,
                "x2": x2,
                "y2": y2
            }
            paintRequests.push(req)
            canvas.requestPaint()
        }
    }
}
