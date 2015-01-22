import QtQuick 2.1

MouseArea {
  anchors.top: parent.top
  anchors.horizontalCenter: parent.right
  anchors.bottom: parent.bottom
  width: 16

  cursorShape: Qt.SizeVerCursor

  function set(mouse) {
    channel.mode = signal.label == 'Voltage' ? 1 : 2; // TODO: `sourceMode` in signalInfo
	var out = Math.min(Math.max(axes.pxToY(mouse.y), signal.min), signal.max);
    if (mouse.modifiers & Qt.AltModifier) {
      signal.src.v1 = axes.snapy(out)
    }
    else {
      signal.src.v1 = out
    }
  }

  onPositionChanged: set(mouse)
  onClicked: set(mouse)

  DragDot {
    id: dragDot
    anchors.horizontalCenter: parent.horizontalCenter
    y: axes.yToPxClamped(value)

    value: signal.isOutput ? signal.src.v1 : signal.measurement
    filled: signal.isOutput
    color: "blue"
  }
}
