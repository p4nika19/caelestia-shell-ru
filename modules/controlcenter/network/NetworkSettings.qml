pragma ComponentBehavior: Bound

import ".."
import "../components"
import qs.components
import qs.components.controls
import qs.components.containers
import qs.components.effects
import qs.services
import qs.config
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: root

    required property Session session

    spacing: Appearance.spacing.normal

    SettingsHeader {
        icon: "router"
        title: qsTr("Настройки сети")
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Ethernet")
        description: qsTr("Информация об Ethernet устройстве")
    }

    SectionContainer {
        contentSpacing: Appearance.spacing.small / 2

        PropertyRow {
            label: qsTr("Всего устройств")
            value: qsTr("%1").arg(Nmcli.ethernetDevices.length)
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Подключенные устройства")
            value: qsTr("%1").arg(Nmcli.ethernetDevices.filter(d => d.connected).length)
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Беспроводные подключения")
        description: qsTr("Настройки WiFi сети")
    }

    SectionContainer {
        ToggleRow {
            label: qsTr("WiFi включен")
            checked: Nmcli.wifiEnabled
            toggle.onToggled: {
                Nmcli.enableWifi(checked);
            }
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("VPN")
        description: qsTr("Настройки VPN провадера")
        visible: Config.utilities.vpn.enabled || Config.utilities.vpn.provider.length > 0
    }

    SectionContainer {
        visible: Config.utilities.vpn.enabled || Config.utilities.vpn.provider.length > 0

        ToggleRow {
            label: qsTr("VPN включен")
            checked: Config.utilities.vpn.enabled
            toggle.onToggled: {
                Config.utilities.vpn.enabled = checked;
                Config.save();
            }
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Провайдеры")
            value: qsTr("%1").arg(Config.utilities.vpn.provider.length)
        }

        TextButton {
            Layout.fillWidth: true
            Layout.topMargin: Appearance.spacing.normal
            Layout.minimumHeight: Appearance.font.size.normal + Appearance.padding.normal * 2
            text: qsTr("⚙ Управление VPN провайдерами")
            inactiveColour: Colours.palette.m3secondaryContainer
            inactiveOnColour: Colours.palette.m3onSecondaryContainer

            onClicked: {
                vpnSettingsDialog.open();
            }
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Текущее подключение")
        description: qsTr("Информация об активном сетевом подключении")
    }

    SectionContainer {
        contentSpacing: Appearance.spacing.small / 2

        PropertyRow {
            label: qsTr("Сеть")
            value: Nmcli.active ? Nmcli.active.ssid : (Nmcli.activeEthernet ? Nmcli.activeEthernet.interface : qsTr("Не подключена"))
        }

        PropertyRow {
            showTopMargin: true
            visible: Nmcli.active !== null
            label: qsTr("Качество сигнала")
            value: Nmcli.active ? qsTr("%1%").arg(Nmcli.active.strength) : qsTr("N/A")
        }

        PropertyRow {
            showTopMargin: true
            visible: Nmcli.active !== null
            label: qsTr("Безопасность")
            value: Nmcli.active ? (Nmcli.active.isSecure ? qsTr("Защищено") : qsTr("Открыть")) : qsTr("N/A")
        }

        PropertyRow {
            showTopMargin: true
            visible: Nmcli.active !== null
            label: qsTr("Частота")
            value: Nmcli.active ? qsTr("%1 МГц").arg(Nmcli.active.frequency) : qsTr("N/A")
        }
    }

    Popup {
        id: vpnSettingsDialog

        parent: Overlay.overlay
        anchors.centerIn: parent
        width: Math.min(600, parent.width - Appearance.padding.large * 2)
        height: Math.min(700, parent.height - Appearance.padding.large * 2)

        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: StyledRect {
            color: Colours.palette.m3surface
            radius: Appearance.rounding.large
        }

        StyledFlickable {
            anchors.fill: parent
            anchors.margins: Appearance.padding.large * 1.5
            flickableDirection: Flickable.VerticalFlick
            contentHeight: vpnSettingsContent.height
            clip: true

            VpnSettings {
                id: vpnSettingsContent

                anchors.left: parent.left
                anchors.right: parent.right
                session: root.session
            }
        }
    }
}
