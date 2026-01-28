pragma ComponentBehavior: Bound

import ".."
import qs.components
import qs.components.controls
import qs.components.containers
import qs.services
import qs.config
import QtQuick

CollapsibleSection {
    title: qsTr("Режим темы")
    description: qsTr("Светлая или тёмная тема")
    showBackground: true

    SwitchRow {
        label: qsTr("Тёмная тема")
        checked: !Colours.currentLight
        onToggled: checked => {
            Colours.setMode(checked ? "dark" : "light");
        }
    }
}
