import QtQuick 2.15
import QtQuick.Window 2.1
import QtQuick.Controls 2.15

Window {
    id: root
    visible: true
    width: 1366
    height: 768
    property var list: []

    property real counter: 0
    property string state: "none"

    Item {
        id: main
        width:  parent.width * 0.4
        height: parent.height * 0.5
        anchors.centerIn: parent
        visible: true

        Rectangle {
            anchors.fill: parent
            color: "#c6c5c5"
        }

        // text for login
        Text {
            id: id_login
            text: "LOGIN"
            font.pointSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 0.1
        }

        // firs form for username
        TextField {
            id: input_username
            placeholderText: "Username"
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 0.25
            width: parent.width * 0.5

        }

        // firs form for password
        TextField {
            id: input_password
            placeholderText: "Password"
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 0.40
            width: parent.width * 0.5

        }
        Text {
            id: warning
            visible: false
            text: "wrong identifiers!"
            y: parent.height * .8
            anchors.horizontalCenter: parent.horizontalCenter

        }
        // cancel button
        Button {
            id: cancel
            text: "Cancel"
            y: parent.height * 0.6
            x: input_password.x
            background: Rectangle {
                anchors.fill: cancel
                color: "#ff2e52"
            }
            contentItem: Text {
                text: cancel.text
                color: "white"
            }
        }

        // login button
        Button {
            id: login
            text: "Login"
            y: parent.height * 0.6
            x: parent.width - input_password.width / 2 - login.width
            background: Rectangle {
                anchors.fill: login
                color: "#33b96d"
            }
            contentItem: Text {
                text: login.text
                color: "white"
            }

            MouseArea {
                anchors.fill: login
                onClicked: {
                    if(input_username.text == "admin" && input_password.text == "admin"){
                        main.visible = false
                        ui.visible = true
                    }else{
                        warning.visible = true
                    }
                }
            }
        }

    }


    // main interface
    Item {
        id: ui
        visible: false
        anchors.fill: parent

        Item {
            id: top
            y: root.height * .05
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * .2
            height: root.height * .06

            Rectangle {
                width: parent.width * 0.4
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                color: "#33b96d"
            }
            Text {
                text: "Normal"
                font.pointSize: 20
                x: parent.width / 2 + 5
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Item {
            id: bottom
            y: root.height * .12
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * .2
            height: root.height * .06

            Rectangle {
                width: parent.width * 0.4
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                color: "#ff2e52"
            }
            Text {
                text: "Abnormal"
                font.pointSize: 20
                x: parent.width / 2 + 5
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Table {
            y: root.height * 0.3
            id: table
            visible: true
            anchors.horizontalCenter: parent.horizontalCenter
            width: 0.98 * root.width; height: 0.4 * root.width
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

            dataModel: {
                var tmp = bridge.data
                var index = 0
                for(var i=0; i< tmp.length; i++){
                    if(tmp[i][6] == "Abnormal"){

                        list = tmp[i]
                        index = i
                    }
                }

              return bridge.data
            }
               /*[
            ["27/11/20", "6", "192.168.8.3", "2252", "192.168.8.10", "80", "Abnormal", "Discard"],
            ["27/11/20", "6", "192.168.8.3", "2252", "192.168.8.10", "80", "Abnormal", "Discard"],
            ["27/11/20", "6", "192.168.8.3", "2252", "192.168.8.10", "80", "Abnormal", "Discard"],
            ["27/11/20", "6", "192.168.8.3", "2252", "192.168.8.10", "80", "Abnormal", "Discard"],
            ]*/
            onClicked: print('onClicked', row, JSON.stringify(rowData))
        }
        Button {
            x: root.width - width - 10
            y: root.height * .02
            text: "Logout"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ui.visible = false
                    main.visible = true
                }

            }
        }
        Rectangle {
            visible: pop.visible
            anchors.fill: parent
            color: "#80000000"
        }

        Item {
            id: pop
            visible: {
                if(list.length != 0){
                    return true
                }else {
                    return false
                }
            }

            width: root.width * 0.4
            height: root.height * 0.4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                anchors.fill: parent
                color: "white"
                border.color: "black"
            }
            Text {
                text: "Alert !!!"
                font.pointSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
            }
            Text {
                text: "Abnormal Traffic"
                font.pointSize: 20
                y: 50
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
            }

            Text {
                id: id_source
                text: "Source IP:"
                font.pointSize: 14
                y: parent.height * 0.45
                x: 10
            }
            Text {
                y: id_source.y
                x: id_source.width + 20
                id: source
                font.pointSize: 14
                text: list[2]
            }

            Text {
                id: id_dest
                text: "Dest IP:"
                font.pointSize: 14
                y: parent.height * 0.45
                x: parent.width * 0.6
            }
            Text {
                id: dest
                text: list[4]
                font.pointSize: 14
                y: id_dest.y
                x: id_dest.x + id_dest.width + 10
            }

            //button
            Row {
                y: parent.height * 0.8
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Allow"
                }
                Button {
                    text: "Discard"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            state = "clicked"
                            pop.visible = false

                        }
                    }
                }
                Button {
                    text: "Ban"
                }

            }
        }

    }
}
