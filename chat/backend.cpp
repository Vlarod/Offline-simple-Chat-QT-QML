#include "backend.h"

void BackEnd::sendMessage(const QString &nick, const QString &message)
{
    std::map<std::string, struct sClient>::iterator it;
    for (it = clients.begin(); it != clients.end(); it++)
        {
            if(it->first == nick.toStdString()) {
                std::string newMess = it->second.sMessage + "\n***" + nick.toStdString() + "***: " + message.toStdString();
                it->second.sMessage = newMess;
                messages.at(it->second.messageIndex) = QString::fromStdString(newMess);
            } else {
                std::string newMess = it->second.sMessage + "\n" + nick.toStdString() + ": " + message.toStdString();
                it->second.sMessage = newMess;
                messages.at(it->second.messageIndex) = QString::fromStdString(newMess);
            }
        }
    newMessage();
}

QString BackEnd::register1(const QString &nick)
{
    sClient newClient;
    newClient.sName = nick.toStdString();
    newClient.sMessage = "";
    newClient.messageIndex = clients.size();

    clients.insert(std::pair<std::string, struct sClient>(newClient.sName, newClient));

    return nick;
}

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
    clients = std::map<std::string, struct sClient>();
    messages = std::vector<QString>();
    QString m_message;
    QString m_messageC2;
    messages.push_back(m_message);
    messages.push_back(m_messageC2);
}

QString BackEnd::message()
{
    return messages.at(ZERO_INDEX);
}

QString BackEnd::messageC2()
{
    return messages.at(ONE_INDEX);
}

void BackEnd::setMessage(const QString &message)
{
    if (message == messages.at(ZERO_INDEX))
        return;

    messages.at(ZERO_INDEX) = message;
}

void BackEnd::setMessageC2(const QString &message)
{
    if (message == messages.at(ONE_INDEX))
        return;

    messages.at(ONE_INDEX) = message;
}
