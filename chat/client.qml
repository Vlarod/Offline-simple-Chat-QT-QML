import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.5

Window {
    objectName: "secondClient"
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Client")

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    Label {
        id: labelNick
        x: 13
        y: 27
        width: 85
        height: 16
        color: "#08427b"
        text: qsTr("Client")
        font.italic: true
        font.bold: true
        font.pointSize: 20
    }

    TextField {
        id: textFieldMessage
        x: 13
        y: 59
        width: 450
        height: 40
        placeholderText: qsTr("Message")
    }

    Button {
        id: buttonSend
        x: 492
        y: 59
        text: qsTr("Send")
        onClicked: {
            backend.sendMessage(labelNick.text, textFieldMessage.text)
            textFieldMessage.clear()
        }
    }
    TextField {
        id: textFieldChooseName
        x: 13
        y: 59
        width: 450
        height: 40
        placeholderText: qsTr("Choose name")
    }

    Button {
        id: buttonChooseName
        x: 491
        y: 59
        text: qsTr("Choose")
        onClicked: {
            buttonChooseName.visible = false;
            textFieldChooseName.visible = false;
            var nick = backend.register1(textFieldChooseName.text);
            labelNick.text = nick;
        }
    }

    TextArea {
        id: textAreaMessages
        x: 13
        y: 105
        width: 450
        height: 343
        text: backend.messageC2
        font.underline: false
        font.bold: true
    }
}
