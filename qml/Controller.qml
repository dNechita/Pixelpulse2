import QtQuick 2.0

Item {
  id: controlItem
  property bool enabled: false
  property bool continuous: false
  property bool repeat: true
  property bool changingMode: false
  property real sampleRate: session.devices[0].DefaultRate
  property real sampleTime: 0.1
  readonly property int sampleCount: sampleTime * sampleRate

  function trigger() {
    session.sampleRate = sampleRate
    session.sampleCount = sampleCount
    session.start(continuous);
  }

  Timer {
    id: timer
    interval: 100
    onTriggered: { trigger() }
  }

  function toggle() {
    if (!enabled) {
      trigger();
      enabled = true;
    } else {
      enabled = false;
      if (continuous || sampleTime > 0.1) {
        session.cancel();
      }
    }
  }

  Connections {
    target: session
    onFinished: {
      if (!continuous) {
        if (repeat) {
            if (enabled) {
                timer.start();
            } else {
                enabled = false;
            }
        }
      }
      else {
        if (changingMode) {
            trigger();
            changingMode = false;
            console.log("changing mode");
        }
        else {
          enabled = false
        }
      }
    }
  }
}
