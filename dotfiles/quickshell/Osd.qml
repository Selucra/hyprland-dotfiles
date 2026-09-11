import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: root

    property bool active: false
    property int displayPercentage: 0
    property string currentIcon: ""
    property int iconSize: 0

    Timer {
        id: hideTimer

        interval: 1500
        onTriggered: root.active = false
    }

    IpcHandler {
        function setBrightness(value: int) {
            root.currentIcon = "☀";
            root.iconSize = 28;
            triggerOSD(value);
        }

        function setVolume(value: int) {
            root.currentIcon = "";
            root.iconSize = 14;
            triggerOSD(value);
        }

        function triggerOSD(value) {
            root.displayPercentage = value;
            root.active = true;
            hideTimer.restart();
        }

        target: "osd"
    }

    LazyLoader {
        active: root.active

        PanelWindow {
            implicitWidth: 180
            implicitHeight: 45
            anchors.bottom: true
            margins.bottom: 5
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Overlay
            exclusionMode: WlrLayershell.Ignore

            Rectangle {
                anchors.fill: parent
                radius: height / 3
                color: "#80000000"

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 10
                    }

                    Text {
                        text: root.currentIcon
                        font.pixelSize: root.iconSize
                        color: '#7AA2F7'
                        Layout.preferredWidth: 18
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 8
                        radius: 10
                        color: "#313244"

                        Rectangle {
                            implicitWidth: Math.max(8, (parent.width * root.displayPercentage) / 100)
                            radius: parent.radius
                            color: '#7AA2F7'

                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                        }

                    }

                    Text {
                        text: root.displayPercentage + "%"
                        font.pixelSize: 13
                        font.bold: true
                        color: "#7AA2F7"
                        Layout.preferredWidth: 30
                        horizontalAlignment: Text.AlignHCenter
                    }

                }

            }

            mask: Region {
            }

        }

    }

}
