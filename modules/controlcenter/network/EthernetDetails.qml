pragma ComponentBehavior: Bound

import ".."
import "../components"
import qs.components
import qs.components.controls
import qs.components.effects
import qs.components.containers
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

DeviceDetails {
    id: root

    required property Session session
    readonly property var ethernetDevice: root.session.ethernet.active

    device: ethernetDevice

    Component.onCompleted: {
        if (ethernetDevice && ethernetDevice.interface) {
            Nmcli.getEthernetDeviceDetails(ethernetDevice.interface, () => {});
        }
    }

    onEthernetDeviceChanged: {
        if (ethernetDevice && ethernetDevice.interface) {
            Nmcli.getEthernetDeviceDetails(ethernetDevice.interface, () => {});
        } else {
            Nmcli.ethernetDeviceDetails = null;
        }
    }

    headerComponent: Component {
        ConnectionHeader {
            icon: "cable"
            title: root.ethernetDevice?.interface ?? qsTr("Неизвестно")
        }
    }

    sections: [
        Component {
            ColumnLayout {
                spacing: Appearance.spacing.normal

                SectionHeader {
                    title: qsTr("Статус подключения")
                    description: qsTr("Настройки подключения для этого устройства")
                }

                SectionContainer {
                    ToggleRow {
                        label: qsTr("Покдлючено")
                        checked: root.ethernetDevice?.connected ?? false
                        toggle.onToggled: {
                            if (checked) {
                                Nmcli.connectEthernet(root.ethernetDevice?.connection || "", root.ethernetDevice?.interface || "", () => {});
                            } else {
                                if (root.ethernetDevice?.connection) {
                                    Nmcli.disconnectEthernet(root.ethernetDevice.connection, () => {});
                                }
                            }
                        }
                    }
                }
            }
        },
        Component {
            ColumnLayout {
                spacing: Appearance.spacing.normal

                SectionHeader {
                    title: qsTr("Характеристики устройства")
                    description: qsTr("Дополнительная информация")
                }

                SectionContainer {
                    contentSpacing: Appearance.spacing.small / 2

                    PropertyRow {
                        label: qsTr("Интерфейс")
                        value: root.ethernetDevice?.interface ?? qsTr("Неизвестно")
                    }

                    PropertyRow {
                        showTopMargin: true
                        label: qsTr("Подключено")
                        value: root.ethernetDevice?.connection || qsTr("Не подключено")
                    }

                    PropertyRow {
                        showTopMargin: true
                        label: qsTr("Состоние")
                        value: root.ethernetDevice?.state ?? qsTr("Неизвестно")
                    }
                }
            }
        },
        Component {
            ColumnLayout {
                spacing: Appearance.spacing.normal

                SectionHeader {
                    title: qsTr("Информация о подключении")
                    description: qsTr("Детали сетевого подключения")
                }

                SectionContainer {
                    ConnectionInfoSection {
                        deviceDetails: Nmcli.ethernetDeviceDetails
                    }
                }
            }
        }
    ]
}
