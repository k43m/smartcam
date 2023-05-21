import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtLocation
import QtPositioning
import "images"

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("smartcam")

    ListView{
        id: l
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 200

        model: smartcam.cam
        delegate:
            Rectangle{
            id: del
            width: 200
            height: l.currentIndex === index ? 200 : 40
            Behavior on height {
                    NumberAnimation { duration: 100 }
            }
            Text{
                width: 100
                verticalAlignment: Text.AlignVCenter
                height: 30
                text:modelData[0]
                Button{
                    anchors.verticalCenter: parent.verticalCenter
                    width: 40
                    height: parent.height*0.8
                    anchors.right: parent.right
                    onClicked:
                    {
                        map.center =  QtPositioning.coordinate(modelData[1], modelData[2])
                        l.currentIndex = index
                    }
                    text:"Go To"
                }
            }
            Image{
                anchors.bottom: parent.bottom
                anchors.horizontalCenter:  parent.horizontalCenter
                id:img
                sourceSize.height: 150
                source : modelData[6]
                visible:  l.currentIndex === index
                Behavior on visible {
                    NumberAnimation { duration: 100 }
                }
            }
            Rectangle{
                width: parent.width
                height: 1
                color: "black"
                anchors.bottom: parent.bottom
            }
        }
    }

    Map{
        id:map
        anchors.left: l.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        //! [coord]
        zoomLevel: (maximumZoomLevel - minimumZoomLevel)
        center {
            // The Qt Company in Oslo
            latitude: 59.9485
            longitude: 10.7686
        }
        //! [coord]
        focus: true
        plugin:plghosm
        WheelHandler {
            id: wheel
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Repeater{
            model: smartcam.cam
            delegate: MapQuickItem {
                id: poiTheQtComapny
                parent: map
                sourceItem:
                    Rectangle {
                    id:pointMarker
                    width: 14; height: 14; color: modelData[3] === "OK" ? "green" : "#e41e25"; border.width: 2; border.color: "white"; smooth: true; radius: 7
                    Text{
                        id: pointText
                        anchors.top: pointMarker.bottom
                        anchors.left: pointMarker.right
                        text: "etat_marche: "+ modelData[3]+"\n"+ "niveau batterie: "+ modelData[4] +"\nversion software: "+ modelData[5]
                        color:"#242424"
                        font.bold: true
                        styleColor: "#ECECEC"
                    }
                }
                coordinate {
                    latitude: modelData[1]
                    longitude: modelData[2]
                }
                opacity: 1.0
                anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)


            }
        }


    }
    Plugin{
        id: plghosm
        name: "osm"
    }
}
