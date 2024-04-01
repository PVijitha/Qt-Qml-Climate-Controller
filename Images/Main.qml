import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtMultimedia 5.15


Window {
    width: 920
    height: 1080
    visible: true
    title: qsTr("Climate Controller")

    property string apiKey: "5f0da391e40169cf58e49f4dc260e0ca" // Replace with your actual API key
    property string city: "Trivandrum" // Replace with your desired city name
    property string temperature: ""
    property string humidity: ""
    property string windSpeed: ""
    property string precipitation: ""
    property string weather: ""

    function getCurrentTime() {
        var currentDate = new Date()
        var hours = currentDate.getHours().toString().padStart(2, '0')
        var minutes = currentDate.getMinutes().toString().padStart(2, '0')
        return hours + ":" + minutes
    }

    function fetchWeather(city) {
        var weatherRequest = new XMLHttpRequest()
        var weatherUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey
        weatherRequest.open("GET", weatherUrl)
        weatherRequest.onreadystatechange = function() {
            if (weatherRequest.readyState === XMLHttpRequest.DONE) {
                if (weatherRequest.status === 200) {
                    var response = JSON.parse(weatherRequest.responseText)
                    weather = response.weather[0].description
                    temperature = Math.floor(response.main.temp - 273.15) + "°C"
                    windSpeed = response.wind.speed
                    precipitation = response.hasOwnProperty('rain') ? response.rain['1h'] : (response.hasOwnProperty('snow') ? response.snow['1h'] : 0)
                    humidity = response.main.humidity
                }
            }
        }
        weatherRequest.send()
    }

    Rectangle {
        width: parent.width
        height: parent.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "black" }
            GradientStop { position: 0.3; color: "#1e1e1e" }
            GradientStop { position: 0.5; color: "#333333" }
            GradientStop { position: 0.7; color: "black" }
        }

        Text {
            x: 20
            y: 25
            text: "A / C"
            font.pixelSize: 25
            font.family: "Helvetica"
            color: "#dbdbdb"
        }

        RoundButton{
            x: 100
            y: 25
            id: acbtn
            property bool isAcOn: false
            text: isAcOn ? "On" : "Off"
            width: 80
            height: 30
            font.family: "Helvetica"
            palette.buttonText: "white"
            background: Rectangle {
                radius: 20
                width: 80
                height: 30
                color: acbtn.isAcOn ? "#24c5ff" : "transparent"
                border.color: acbtn.isAcOn ? "transparent" : "white"
            }
            onClicked: {
                acbtn.isAcOn = !acbtn.isAcOn
                console.log("Clicked 1")
            }
        }

        Text {
            x: 830
            y: 15
            id: timeDisplay
            text: getCurrentTime()
            font.pixelSize: 30
            color: "white"
            Timer {
                interval: 1000 // Update every second
                running: true
                repeat: true
                onTriggered: {
                    timeDisplay.text = getCurrentTime()
                }
            }
            Component.onCompleted: {
                // Initialize the time display when the component is completed
                timeDisplay.text = getCurrentTime()
            }
        }


        Image {
            x: 18
            y: 120
            id: cool
            source: "qrc:/cool-icon-white.png"
            width: 90
            height: 60
        }

        Knob{

        }

        Text {
            x: 440
            y: 182
            text: "AUTO CLIMATE"
            font.family: "Helvetica"
            font.pixelSize: 14
            color: "#dbdbdb"
        }

        RoundButton{
            x: 435
            y: 145
            id: auto
            property bool isAuto: false
            text: isAuto ? "On" : "Off"
            width: 112
            height: 30
            font.family: "Helvetica"
            palette.buttonText: "white"
            background: Rectangle {
                radius: 20
                width: 112
                height: 30
                color: auto.isAuto ? "#24c5ff" : "transparent"
                border.color: auto.isAuto ? "transparent" : "white"
            }
            onClicked: {
                auto.isAuto = !auto.isAuto
                console.log("Clicked 1")
            }
        }

        Image {
            id: fan
            x: 15
            y: 350
            width: 100
            height: 100
            clip: true
            source: "qrc:/fan.png"
            transform: Rotation {
                id: rotation
                origin.x: fan.width / 2
                origin.y: fan.height / 2
                angle: 0 // Initial angle
            }
        }

        SequentialAnimation {
            id: rotateAnimation
            property int isFanRunning: 0
            running: isFanRunning == 0 ? false : true
            loops: Animation.Infinite // Continuous rotation
            NumberAnimation {
                target: rotation
                property: "angle"
                from: rotation.angle // Set from current angle
                to: rotation.angle + 360 // Add a full circle to the current angle
                duration: 700// Rotation speed in milliseconds (adjust as needed)
            }
        }

        Item {
            id: shape1
            x: 159
            y: 401
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea
                width: 50
                height: 30
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = rotateAnimation.isFanRunning == 0 ? 1 : 0;
                        console.log("Clicked on the shape area! " + rotateAnimation.isFanRunning)
                    }
                }

                Shape {
                    id: customShape
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 1 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 1 ? "#34abeb" : "#dbdbdb"
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 300 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 30 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 30 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                    Text {
                        x: 10
                        text: "Lo"
                        font.family: "Helvetica"
                        color: rotateAnimation.isFanRunning >= 1 ? "white" : "black"
                        font.pointSize: 20
                    }
                }
            }
        }

        Item {
            id: shape2
            property int name2: 0
            x: 214
            y: 386
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea2
                width: 50
                height: 48
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = 2
                        console.log("Clicked on the shape area! " + rotateAnimation.isFanRunning)
                    }
                }

                Shape {
                    id: customShape2
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 2 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 2 ? "#34abeb" : "#dbdbdb"
                        // Behavior to animate color change
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 600 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 45 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 45 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                }
            }
        }
        Item {
            id: shape3
            property int name3: 0
            x: 269
            y: 371
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea3
                width: 50
                height: 65
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = 3
                    }
                }

                Shape {
                    id: customShape3
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 3 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 3 ? "#34abeb" : "#dbdbdb"
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 900 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 60 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 60 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                }
            }
        }
        Item {
            id: shape4
            property int name4: 0
            x: 324
            y: 356
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea4
                width: 50
                height: 80
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = 4
                        console.log("Clicked on the shape area! " + rotateAnimation.isFanRunning)
                    }
                }

                Shape {
                    id: customShape4
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 4 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 4 ? "#34abeb" : "#dbdbdb"
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 1200 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting point
                        PathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 75 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 75 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                }
            }
        }

        Item {
            id: shape5
            property int name5: 0
            x: 379.5
            y: 341
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea5
                width: 50
                height: 90
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = 5
                        console.log("Clicked on the shape area! " + rotateAnimation.isFanRunning)
                    }
                }

                Shape {
                    id: customShape5
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 5 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 5 ? "#34abeb" : "#dbdbdb"
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 1500 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting point
                        PathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 90 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 90 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                }
            }
        }
        Item {
            id: shape6
            x: 435
            y: 325
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea6
                width: 50
                height: 110
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = 6
                        console.log("Clicked on the shape area! " + rotateAnimation.isFanRunning)
                    }
                }

                Shape {
                    id: customShape6
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 6 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 6 ? "#34abeb" : "#dbdbdb"
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 1800 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting pointPathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 105 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 105 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                }
            }
        }

        Item {
            id: shape7
            property int name7: 0
            x: 490
            y: 310
            width: 200
            height: 150
            Rectangle {
                id: interactiveArea7
                width: 50
                height: 125
                color: "transparent" // Make the rectangle transparent

                MouseArea {
                    anchors.fill: parent
                    // Your mouse area properties and behaviors go here
                    onClicked: {
                        rotateAnimation.isFanRunning = 7
                        console.log("Clicked on the shape7 area!" + rotateAnimation.isFanRunning)
                    }
                }

                Shape {
                    id: customShape7
                    anchors.fill: parent // Make the shape fill the parent area
                    ShapePath {
                        strokeWidth: 2
                        strokeColor: rotateAnimation.isFanRunning >= 7 ? "#34abeb" : "#dbdbdb"
                        fillColor: rotateAnimation.isFanRunning >= 7 ? "#34abeb" : "#dbdbdb"
                        Behavior on fillColor {
                            ColorAnimation {
                                duration: 2100 // Duration of the animation in milliseconds
                            }
                        }
                        PathMove { x: 0; y: 0 } // Starting pointPathMove { x: 0; y: 0 } // Starting point
                        PathMove { x: 0; y: 0 } // Starting point
                        PathLine { x: 50; y: -15 } // Top-right corner
                        PathLine { x: 50; y: 120 } // Bottom-right corner (creates the trapezium effect)
                        PathLine { x: 0; y: 120 } // Bottom-left corner (creates the trapezium effect)
                        PathLine { x: 0; y: 00 } // Back to the starting point (closing the shape)
                    }
                    Text {
                        x: 10
                        y: 40
                        text: "Hi"
                        font.family: "Helvetica"
                        color: rotateAnimation.isFanRunning >= 7 ? "white" : "black"
                        font.pointSize: 20
                    }
                }
            }
        }

        RightPanel{

        }

    }

}


