import qs.components
import qs.components.effects
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    required property var deviceDetails

    spacing: Appearance.spacing.small / 2

    StyledText {
        text: qsTr("IP Адрес")
    }

    StyledText {
        text: root.deviceDetails?.ipAddress || qsTr("Недоступно")
        color: Colours.palette.m3outline
        font.pointSize: Appearance.font.size.small
    }

    StyledText {
        Layout.topMargin: Appearance.spacing.normal
        text: qsTr("Маска подсети")
    }

    StyledText {
        text: root.deviceDetails?.subnet || qsTr("Недоступно")
        color: Colours.palette.m3outline
        font.pointSize: Appearance.font.size.small
    }

    StyledText {
        Layout.topMargin: Appearance.spacing.normal
        text: qsTr("Шлюз")
    }

    StyledText {
        text: root.deviceDetails?.gateway || qsTr("Недоступно")
        color: Colours.palette.m3outline
        font.pointSize: Appearance.font.size.small
    }

    StyledText {
        Layout.topMargin: Appearance.spacing.normal
        text: qsTr("DNS Серверы")
    }

    StyledText {
        text: (root.deviceDetails && root.deviceDetails.dns && root.deviceDetails.dns.length > 0) ? root.deviceDetails.dns.join(", ") : qsTr("Недоступно")
        color: Colours.palette.m3outline
        font.pointSize: Appearance.font.size.small
        wrapMode: Text.Wrap
        Layout.maximumWidth: parent.width
    }
}
