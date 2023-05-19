import QtQuick
import QtQuick.Window
import QtLocation
import QtPositioning

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Map{
        anchors.fill: parent
        //! [coord]
            zoomLevel: (maximumZoomLevel - minimumZoomLevel)/2
            center {
                // The Qt Company in Oslo
                latitude: 59.9485
                longitude: 10.7686
            }
        //! [coord]

            focus: true
            plugin:plgh

    }
    Plugin{
        id: plgh
        name: "osm"
    }
}
