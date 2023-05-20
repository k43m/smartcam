import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtLocation
import QtPositioning
import smartcam

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("smartcam")

    ListView{
        id: l
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 100

        model: smartcam.cam
        delegate: Text{
            width: 100
            verticalAlignment: Text.AlignVCenter
            height: 30
            text:modelData[0]
            Component.onCompleted: console.log(modelData[1])
            Button{
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: parent.height*0.8
                anchors.right: parent.right
                onClicked: map.center =  QtPositioning.coordinate(modelData[1], modelData[2])
                text:"Go To"
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
