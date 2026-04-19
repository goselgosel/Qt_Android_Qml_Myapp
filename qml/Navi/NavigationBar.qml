import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

Rectangle {
    id: navBar
    color: "#ffffff"

    property int currentIndex: 0
    signal itemClicked(int index)

    Rectangle {
        width: parent.width
        height: 1
        color: "#e0e0e0"
        anchors.top: parent.top
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "W"
            label: "WeChat"
            isActive: navBar.currentIndex === 0
            onClicked: {
                navBar.currentIndex = 0
                navBar.itemClicked(0)
            }
        }

        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "C"
            label: "Contacts"
            isActive: navBar.currentIndex === 1
            onClicked: {
                navBar.currentIndex = 1
                navBar.itemClicked(1)
            }
        }

        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "D"
            label: "Discover"
            isActive: navBar.currentIndex === 2
            onClicked: {
                navBar.currentIndex = 2
                navBar.itemClicked(2)
            }
        }

        NavItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            iconText: "M"
            label: "Me"
            isActive: navBar.currentIndex === 3
            onClicked: {
                navBar.currentIndex = 3
                navBar.itemClicked(3)
            }
        }
    }
}