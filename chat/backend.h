#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <map>
#include <string>
#include <vector>

#define ZERO_INDEX 0
#define ONE_INDEX 1

struct sClient {
    std::string sName;
    std::string sMessage;
    int messageIndex;
};

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY newMessage)
    Q_PROPERTY(QString messageC2 READ messageC2 WRITE setMessageC2 NOTIFY newMessage)

public:
    Q_INVOKABLE void sendMessage(const QString &nick, const QString &message);
    Q_INVOKABLE QString register1(const QString &nick);

    explicit BackEnd(QObject *parent = nullptr);

    QString message();
    QString messageC2();

    void setMessage(const QString &message);
    void setMessageC2(const QString &message);

signals:
    void newMessage();
    void newMessageC2();

private:
    std::map<std::string, struct sClient> clients;
    std::vector<QString> messages;
};

#endif // BACKEND_H

