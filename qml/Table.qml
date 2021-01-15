import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import "script.js" as Code

Item { // size controlled by width
    id: root

// public
    property variant headerModel: [ // widths must add to 1

    ]

    property variant dataModel: [

    ]
    property string st: ""

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.65;  height: 400
//    Rectangle {
//        color: "white"
//        visible: true
//        width: root.width
//        height: root.height
//    }
//    Text {
//        id: point_text
//        text: "Logs"
//        y: - 80
//        x: root.width * 0.3
//        color: "#880000ff"
//        font.pointSize: root.width * 0.023
//    }


    Rectangle {
        id: header
//        x: root.width * 0.1
        width: parent.width;  height: 50
        color: 'gray'
//        radius: 0.01 * root.width

        Rectangle { // half height to cover bottom rounded corners
            width: parent.width;  height: 0.5 * parent.height
            color: parent.color
            anchors.bottom: parent.bottom
        }


        ListView { // header
            anchors.fill: parent
            orientation: ListView.Horizontal
            interactive: false

            model: headerModel

            delegate: Item { // cell
                width: modelData.width * root.width;  height: header.height

                Text {
                    x: 0.02 * root.width
                    text: modelData.text
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:  20 //0.06 * root.width
                    color: 'white'
                }
            }
        }
    }


    ListView { // data
        anchors{fill: parent;  topMargin: header.height}
        interactive: contentHeight > height
        clip: true
        model: dataModel

        delegate: Item { // row
            width: root.width;  height: header.height
            opacity: !mouseArea.pressed? 1: 0.3 // pressed state

            property int     row:     index     // outer index
            property variant rowData: modelData // much faster than listView.model[row]

            Row {

                anchors.fill: parent

                Repeater { // index is column
                    model: rowData // headerModel.length

                    delegate: Item { // cell
                        width: headerModel[index].width * root.width;  height: header.height

                        Text {
                            x: 0.02 * root.width
//                            x: root.width * 0.11
                            text: modelData
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 20
                        }
                    }
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent

                onClicked:  {
                    root.clicked(row, rowData)

                }
            }
        }

        ScrollBar{}
    }


    // ============================confirmer=================================================
}
