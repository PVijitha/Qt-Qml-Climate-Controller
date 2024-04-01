import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtMultimedia 5.15
Item {

    x: 570
    y: 80
    width: 330
    height: parent.height - 145
    Rectangle{
        width: 330
        height: parent.height - 5
        radius: 5
        color: "#333333"

        Text {
            text: "MODE"
            font.family: "Helvetica"
            color: "white"
            x: 30
            y: 30
            font.pointSize: 20

        }

        RoundButton{
            x: 30
            y: 70
            id: modebtn
            property int mode: 1
            width: 270
            height: 130
            background: Rectangle {
                radius: 5
                width: 270
                height: 130
                color: acbtn.isAcOn && modebtn.mode == 1 ? "#34abeb" : "transparent"
                border.color: acbtn.isAcOn && modebtn.mode == 1 ? "transparent" : "#dbdbdb"
                Image {
                    width: 150
                    height: 110
                    source: "qrc:/output-onlinepngtools (2).png"
                    anchors.centerIn: parent
                }
            }
            onClicked: {
                modebtn.mode  = 1
                console.log("Clicked 1")
            }
        }

        RoundButton{
            x: 30
            y: 220
            id: modebtn2
            width: 270
            height: 130
            background: Rectangle {
                radius: 5
                width: 270
                height: 130
                color: acbtn.isAcOn && modebtn.mode == 2 ? "#34abeb" : "transparent"
                border.color: acbtn.isAcOn && modebtn.mode == 2 ? "transparent" : "#dbdbdb"
                Image {
                    width: 140
                    height: 110
                    source: "qrc:/output-onlinepngtools (1).png"
                    anchors.centerIn: parent
                }
            }
            onClicked: {
                modebtn.mode  = 2
                console.log("Clicked 1")
            }
        }

        RoundButton{
            x: 30
            y: 370
            id: modebtn3
            width: 270
            height: 130
            background: Rectangle {
                radius: 5
                width: 270
                height: 130
                color: acbtn.isAcOn && modebtn.mode == 3 ? "#34abeb" : "transparent"
                border.color: acbtn.isAcOn && modebtn.mode == 3 ? "transparent" : "#dbdbdb"
                Image {
                    width: 150
                    height: 110
                    source: "qrc:/output-onlinepngtools (3).png"
                    anchors.centerIn: parent
                }
            }
            onClicked: {
                modebtn.mode  = 3
                console.log("Clicked 1")
            }
        }

        RoundButton{
            x: 30
            y: 520
            id: modebtn4
            width: 270
            height: 130
            background: Rectangle {
                radius: 5
                width: 270
                height: 130
                color: acbtn.isAcOn && modebtn.mode == 4 ? "#34abeb" : "transparent"
                border.color: acbtn.isAcOn && modebtn.mode == 4 ? "transparent" : "#dbdbdb"
                Image {
                    width: 150
                    height: 110
                    source: "qrc:/output-onlinepngtools.png"
                    anchors.centerIn: parent
                }
            }
            onClicked: {
                modebtn.mode  = 4
                console.log("Clicked 1")
            }
        }
    }
}
