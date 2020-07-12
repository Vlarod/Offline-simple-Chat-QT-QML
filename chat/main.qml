import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.5
import io.qt.examples.backend 1.0

Window {
    objectName: "mainClient"
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Main")

    BackEnd {
        id: backend
    }

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
        text: qsTr("Main")
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
        x: 491
        y: 59
        text: qsTr("Send")
        onClicked: {
            backend.sendMessage(labelNick.text, textFieldMessage.text)
            textFieldMessage.clear()
        }
    }

    TextArea {
        id: textAreaMessages
        x: 13
        y: 112
        width: 450
        height: 343
        text: backend.message;
        font.underline: false
        font.bold: true
    }

    Button {
        id: buttonAddClient
        x: 520
        y: 7
        width: 112
        height: 21
        text: qsTr("Open Client")
        onClicked: {
            var component = Qt.createComponent("client.qml");
            var browserWindow = component.createObject(this);
            buttonAddClient.enabled = false;
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

}



