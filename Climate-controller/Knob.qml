import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtMultimedia 5.15




Item {
    x: 125
    y: 155
    width: 200
    height: 200
    Rectangle {
        id: slider
        width: 250
        height: 15
        color: "transparent"

        property int sliderValue: 15

        Rectangle {
            id: leftTrack
            width: handle.x + handle.width / 2
            height: 4
            color: "#34abeb" // Color for the left side
            anchors.verticalCenter: parent.verticalCenter
            clip: true // Clip the track to avoid overflow
        }

        Rectangle {
            id: rightTrack
            width: slider.width - handle.x - handle.width / 2
            height: 4
            color: "grey" // Color for the right side
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            clip: true // Clip the track to avoid overflow
        }

        Rectangle {
            id: handle
            width: 15
            height: 15
            radius: 15
            color: "white"
            x: (sliderValue - 15) * (slider.width - width) / (40 - 15)

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: slider.width - parent.width

                onPositionChanged: {
                    var stepSize = (slider.width - handle.width) / (40 - 15);
                    handle.x = Math.round(handle.x / stepSize) * stepSize;

                    leftTrack.width = handle.x + handle.width / 2;
                    rightTrack.width = slider.width - handle.x - handle.width / 2;

                    slider.sliderValue = Math.floor((handle.x + handle.width / 2) / stepSize) + 15;
                    console.log(slider.sliderValue);
                }
            }
        }
    }

    Text {
        x: 260
        text: slider.sliderValue + "°C"
        font.family: "Helvetica"
        color: "white"
        font.pointSize: 9
    }


}

