import Quickshell.Io

JsonObject {
    property bool enabled: true
    property bool showOnHover: false
    property int maxShown: 7
    property int maxWallpapers: 9 // Warning: even numbers look bad
    property string specialPrefix: "@"
    property string actionPrefix: ">"
    property bool enableDangerousActions: false // Allow actions that can cause losing data, like shutdown, reboot and logout
    property int dragThreshold: 50
    property bool vimKeybinds: false
    property list<string> hiddenApps: []
    property UseFuzzy useFuzzy: UseFuzzy {}
    property Sizes sizes: Sizes {}

    component UseFuzzy: JsonObject {
        property bool apps: false
        property bool actions: false
        property bool schemes: false
        property bool variants: false
        property bool wallpapers: false
    }

    component Sizes: JsonObject {
        property int itemWidth: 600
        property int itemHeight: 57
        property int wallpaperWidth: 280
        property int wallpaperHeight: 200
    }

    property list<var> actions: [
        {
            name: "Калькулятор",
            icon: "calculate",
            description: "Простые математические вычисления (через Qalc)",
            command: ["autocomplete", "calc"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Цветовая схема",
            icon: "palette",
            description: "Изменить текущую цветовую схему",
            command: ["autocomplete", "scheme"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Обои",
            icon: "image",
            description: "Изменить текущие обои",
            command: ["autocomplete", "wallpaper"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Вариация",
            icon: "colors",
            description: "Изменить вариацию текущей цветовой схемы",
            command: ["autocomplete", "variant"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Прозрачность",
            icon: "opacity",
            description: "Изменить настройки прозрачности шелла",
            command: ["autocomplete", "transparency"],
            enabled: false,
            dangerous: false
        },
        {
            name: "Случайные",
            icon: "casino",
            description: "Установить случайные обои",
            command: ["caelestia", "wallpaper", "-r"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Светлая тема",
            icon: "light_mode",
            description: "Включить режим светлой темы для цветовой схемы",
            command: ["setMode", "light"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Тёмная тема",
            icon: "dark_mode",
            description: "Включить режим тёмной темы для цветовой схемы",
            command: ["setMode", "dark"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Выключение",
            icon: "power_settings_new",
            description: "Выключить систему",
            command: ["systemctl", "poweroff"],
            enabled: true,
            dangerous: true
        },
        {
            name: "Перезагрузка",
            icon: "cached",
            description: "Перезагрузить систему",
            command: ["systemctl", "reboot"],
            enabled: true,
            dangerous: true
        },
        {
            name: "Выход",
            icon: "exit_to_app",
            description: "Выйти из текущей сессии",
            command: ["loginctl", "terminate-user", ""],
            enabled: true,
            dangerous: true
        },
        {
            name: "Блокировка",
            icon: "lock",
            description: "Заблокировать текущую сессию",
            command: ["loginctl", "lock-session"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Спящий режим",
            icon: "bedtime",
            description: "Перевести систему в спящий режим (гибернация)",
            command: ["systemctl", "suspend-then-hibernate"],
            enabled: true,
            dangerous: false
        },
        {
            name: "Настройки",
            icon: "settings",
            description: "Настроить шелл",
            command: ["caelestia", "shell", "controlCenter", "open"],
            enabled: true,
            dangerous: false
        }
    ]
}
