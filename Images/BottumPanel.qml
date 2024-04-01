import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtMultimedia 5.15

Item {


    Rectangle{
        x: 10
        y: 478
        width: 530
        height: 300
        radius: 5
        color: "#333333"

        Component.onCompleted: {
            fetchWeather(city)
        }

        Text {
            text: "WEATHER"
            font.family: "Helvetica"
            color: "white"
            x: 30
            y: 30
            font.pointSize: 20
        }

        Timer {
            id: timer
            interval: 6000 // 1 minute in milliseconds
            running: true
            repeat: true
            onTriggered: {
                // Increment the counter and loop back to 1 if it reaches 4
                sunny.climate = (sunny.climate < 3) ? sunny.climate + 1 : 0
            }
        }

        Image {
            property int climate: 0
            x: 50
            y: 100
            id: sunny
            source: "qrc:/output-onlinepngtools (6).png"
            visible: climate == 0 ? true : false
            width: 55
            height: 55
        }

        Image {
            x: 35
            y: 100
            id: snow
            source: "qrc:/snows.png"
            visible: sunny.climate == 1 ? true : false
            width: 85
            height: 70
        }

        Image {
            x: 55
            y: 115
            id: rainy
            source: "qrc:/rainy-day.png"
            visible: sunny.climate == 2 ? true : false
            width: 50
            height: 40
        }

        Image {
            x: 50
            y: 107
            id: cloudy
            source: "qrc:/cloudy (1).png"
            visible: sunny.climate == 3 ? true : false
            width: 55
            height: 55
        }

        Text {
            text: "Sunny"
            visible: sunny.climate == 0 ? true : false
            font.family: "Helvetica"
            color: "white"
            x: 53
            y: 155
            font.pointSize: 13
        }

        Text {
            text: "Snow"
            visible: sunny.climate == 1 ? true : false
            font.family: "Helvetica"
            color: "white"
            x: 53
            y: 155
            font.pointSize: 13
        }

        Text {
            text: "Rainy"
            visible: sunny.climate == 2 ? true : false
            font.family: "Helvetica"
            color: "white"
            x: 53
            y: 155
            font.pointSize: 13
        }

        Text {
            text: "Cloudy"
            visible: sunny.climate == 3 ? true : false
            font.family: "Helvetica"
            color: "white"
            x: 53
            y: 155
            font.pointSize: 13
        }

        Text {
            text: "weather"
            font.family: "Helvetica"
            color: "#dbdbdb"
            x: 59
            y: 178
            font.pointSize: 7
        }

        Text {
            text: windSpeed + "km/h"
            font.family: "Helvetica"
            color: "white"
            x: 53
            y: 230
            font.pointSize: 13
        }

        Text {
            text: "wind"
            font.family: "Helvetica"
            color: "#dbdbdb"
            x: 65
            y: 250
            font.pointSize: 7
        }

        Image {
            x: 247
            y: 109
            id: temp
            source: "qrc:/output-onlinepngtools (5).png"
            width: 45
            height: 40
        }


        Text {
            text: "23°C"
            font.family: "Helvetica"
            color: "white"
            x: 252
            y: 155
            font.pointSize: 13
        }

        Text {
            text: "inside car"
            font.family: "Helvetica"
            color: "#dbdbdb"
            x: 250
            y: 175
            font.pointSize: 7
        }

        Text {
            text: temperature
            font.family: "Helvetica"
            color: "white"
            x: 252
            y: 230
            font.pointSize: 13
        }

        Text {
            text: "outside car"
            font.family: "Helvetica"
            color: "#dbdbdb"
            x: 250
            y: 250
            font.pointSize: 7
        }

        Image {
            x: 425
            y: 107
            id: humidityImg
            source: "qrc:/humidity.png"
            width: 45
            height: 40
        }

        Text {
            text: humidity + "%"
            font.family: "Helvetica"
            color: "white"
            x: 428
            y: 155
            font.pointSize: 13
        }

        Text {
            text: "humidity"
            font.family: "Helvetica"
            color: "#dbdbdb"
            x: 428
            y: 175
            font.pointSize: 7
        }

        Text {
            text: precipitation + "%"
            font.family: "Helvetica"
            color: "white"
            x: 428
            y: 230
            font.pointSize: 13
        }

        Text {
            text: "precipitation"
            font.family: "Helvetica"
            color: "#dbdbdb"
            x: 423
            y: 250
            font.pointSize: 7
        }
    }
}
