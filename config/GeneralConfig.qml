import Quickshell.Io

JsonObject {
    property string logo: ""
    property Apps apps: Apps {}
    property Idle idle: Idle {}
    property Battery battery: Battery {}

    component Apps: JsonObject {
        property list<string> terminal: ["foot"]
        property list<string> audio: ["pavucontrol"]
        property list<string> playback: ["mpv"]
        property list<string> explorer: ["thunar"]
    }

    component Idle: JsonObject {
        property bool lockBeforeSleep: true
        property bool inhibitWhenAudio: true
        property list<var> timeouts: [
            {
                timeout: 180,
                idleAction: "lock"
            },
            {
                timeout: 300,
                idleAction: "dpms off",
                returnAction: "dpms on"
            },
            {
                timeout: 600,
                idleAction: ["systemctl", "suspend-then-hibernate"]
            }
        ]
    }

    component Battery: JsonObject {
        property list<var> warnLevels: [
            {
                level: 20,
                title: qsTr("Низкий заряд батареи"),
                message: qsTr("Возможно вам стоит подключить зарядное устройство"),
                icon: "battery_android_frame_2"
            },
            {
                level: 10,
                title: qsTr("Вы видели предыдущее сообщение?"),
                message: qsTr("Вероятно вам стоит подключить зарядное устройство <b>сейчас</b>"),
                icon: "battery_android_frame_1"
            },
            {
                level: 5,
                title: qsTr("Критический уровень заряда батареи"),
                message: qsTr("ПОДКЛЮЧИТЕ ЗАРЯДНОЕ УСТРОЙСТВО ПРЯМО СЕЙЧАС!!"),
                icon: "battery_android_alert",
                critical: true
            },
        ]
        property int criticalLevel: 3
    }
}
