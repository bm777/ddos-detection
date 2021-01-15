import QtQuick 2.0

Item {
    anchors.fill: parent
    Table {
        id: table
        //        anchors.horizontalCenter: parent.horizontalCenter
        //        width: 0.98 * rot.width; height: 0.4 * rot.width
        visible: false
        headerModel: [
            {text: "Date", width: 1/8},
            {text: "Protocol", width: 1/8},
            {text: "Source IP", width: 1/8},
            {text: "Source Port", width: 1/8},
            {text: "Dest IP", width: 1/8},
            {text: "Dest Port", width: 1/8},
            {text: "Description", width: 1/8},
            {text: "Action", width: 1/8},

        ]

        dataModel: [
        ["27/11/20", 6, "192.168.8.3", "2252", "192.168.8.10", "80", "Abnormal", "Discard"],

        ]
        onClicked: print('onClicked', row, JSON.stringify(rowData))
    }
}
