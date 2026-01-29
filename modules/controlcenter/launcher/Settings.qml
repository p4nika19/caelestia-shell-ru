pragma ComponentBehavior: Bound

import ".."
import "../components"
import qs.components
import qs.components.controls
import qs.components.effects
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    required property Session session

    spacing: Appearance.spacing.normal

    SettingsHeader {
        icon: "apps"
        title: qsTr("Настройки лаунчера")
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Основные")
        description: qsTr("Основные настройки лаунчера")
    }

    SectionContainer {
        ToggleRow {
            label: qsTr("Включен")
            checked: Config.launcher.enabled
            toggle.onToggled: {
                Config.launcher.enabled = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Показывать при наведении")
            checked: Config.launcher.showOnHover
            toggle.onToggled: {
                Config.launcher.showOnHover = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Vim бинды")
            checked: Config.launcher.vimKeybinds
            toggle.onToggled: {
                Config.launcher.vimKeybinds = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Включить опасные действия")
            checked: Config.launcher.enableDangerousActions
            toggle.onToggled: {
                Config.launcher.enableDangerousActions = checked;
                Config.save();
            }
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Отображение")
        description: qsTr("Настройки отображения и внешнего вида")
    }

    SectionContainer {
        contentSpacing: Appearance.spacing.small / 2

        PropertyRow {
            label: qsTr("Максимум отображаемых предметов")
            value: qsTr("%1").arg(Config.launcher.maxShown)
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Максимум обоев")
            value: qsTr("%1").arg(Config.launcher.maxWallpapers)
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Порог начала перетаскивания")
            value: qsTr("%1 px").arg(Config.launcher.dragThreshold)
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Префиксы")
        description: qsTr("Настройки команд префиксов")
    }

    SectionContainer {
        contentSpacing: Appearance.spacing.small / 2

        PropertyRow {
            label: qsTr("Специальный префикс")
            value: Config.launcher.specialPrefix || qsTr("Нет")
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Действующий префикс")
            value: Config.launcher.actionPrefix || qsTr("Нет")
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Fuzzy поиск")
        description: qsTr("Настройки поиска Fuzzy")
    }

    SectionContainer {
        ToggleRow {
            label: qsTr("Приложения")
            checked: Config.launcher.useFuzzy.apps
            toggle.onToggled: {
                Config.launcher.useFuzzy.apps = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Действия")
            checked: Config.launcher.useFuzzy.actions
            toggle.onToggled: {
                Config.launcher.useFuzzy.actions = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Схемы")
            checked: Config.launcher.useFuzzy.schemes
            toggle.onToggled: {
                Config.launcher.useFuzzy.schemes = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Вариации")
            checked: Config.launcher.useFuzzy.variants
            toggle.onToggled: {
                Config.launcher.useFuzzy.variants = checked;
                Config.save();
            }
        }

        ToggleRow {
            label: qsTr("Обои")
            checked: Config.launcher.useFuzzy.wallpapers
            toggle.onToggled: {
                Config.launcher.useFuzzy.wallpapers = checked;
                Config.save();
            }
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Размеры")
        description: qsTr("Настройки размеров для предметов лаунчера")
    }

    SectionContainer {
        contentSpacing: Appearance.spacing.small / 2

        PropertyRow {
            label: qsTr("Ширина предметов")
            value: qsTr("%1 px").arg(Config.launcher.sizes.itemWidth)
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Высота предметов")
            value: qsTr("%1 px").arg(Config.launcher.sizes.itemHeight)
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Ширина обоев")
            value: qsTr("%1 px").arg(Config.launcher.sizes.wallpaperWidth)
        }

        PropertyRow {
            showTopMargin: true
            label: qsTr("Высота обоев")
            value: qsTr("%1 px").arg(Config.launcher.sizes.wallpaperHeight)
        }
    }

    SectionHeader {
        Layout.topMargin: Appearance.spacing.large
        title: qsTr("Скрытые приложения")
        description: qsTr("Приложения скрытые из лаунчера")
    }

    SectionContainer {
        contentSpacing: Appearance.spacing.small / 2

        PropertyRow {
            label: qsTr("Все скрытые")
            value: qsTr("%1").arg(Config.launcher.hiddenApps ? Config.launcher.hiddenApps.length : 0)
        }
    }
}
