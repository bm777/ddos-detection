import QtQuick 2.0

Rectangle {
    color: "#780000ff"
    width: 0.01 * parent.width; radius: 0.5 * width // size is controlled by width
    anchors{right: parent.right; margins: radius}
    height: parent.height / parent.contentHeight * parent.height
    y: parent.height / parent.contentHeight * parent.height
    visible: parent.height < parent.conteHeight
}
