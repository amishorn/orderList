#ifndef OLMODEL_H
#define OLMODEL_H

#include <QAbstractListModel>
#include <QStandardPaths>
#include <QList>
#include <QDomDocument>
#include "oListItem.h"

class OLModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum ShlRoles {
        CheckRole = Qt::UserRole +1,
        VisRole = Qt::UserRole +2,
        SecRole = Qt::UserRole +3,
        QuantRole = Qt::UserRole +4,
        EntRole = Qt::UserRole +5,
        NameRole = Qt::UserRole +6,
        NoteRole = Qt::UserRole +7
    };

    explicit OLModel(QObject *parent=0);

    virtual int rowCount(const QModelIndex &) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);
    virtual Qt::ItemFlags flags(const QModelIndex &index) const;

    QHash<int, QByteArray> roleNames() const;

    int count();

    Q_INVOKABLE bool importList();
    Q_INVOKABLE bool exportList();
    Q_INVOKABLE void removeItem(int index);
    Q_INVOKABLE void moveItemUp(int index);
    Q_INVOKABLE void moveItemDown(int index);
    Q_INVOKABLE void moveSectionUp(QString section);
    Q_INVOKABLE void moveSectionDown(QString section);
    Q_INVOKABLE void addNewItem(bool folded, QString section, QString name, QString entity, QString quantity, QString note);
    Q_INVOKABLE void replaceItem(int index, bool folded, QString section, QString name, QString entity, QString quantity, QString note);
    Q_INVOKABLE void setFolded(int index, bool folded);
    Q_INVOKABLE void setQuantity(int index, QString quantity);
    Q_INVOKABLE QVariant getSections();
    Q_INVOKABLE QVariant getEntities();
    Q_INVOKABLE QVariant getRoleOfItem(int index, QString role);
    Q_INVOKABLE QString getOrderListTxt();

private:
    QList<OListItem*> _oList;
    const QString _olDataFolder = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    const QString _olCustListURI = QStandardPaths::writableLocation(QStandardPaths::DataLocation) + "/custOrderList.xml";
    const QString _xmlRoot = "OrderList";
    const QString _xmlid = "id";
    const QString _xmlSec = "Section";
    const QString _xmlFolded = "Folded";
    const QString _xmlItem = "Item";
    const QString _xmlName = "Name";
    const QString _xmlEntity = "Entity";
    const QString _xmlQuantity = "Quantity";
    const QString _xmlNote = "Note";

    OListItem *newItem(bool folded, QString section, QString name, QString entity, QString quantity = "1", QString note = "");
    QDomElement addNode(QDomDocument doc, QDomNode parentNode, const QString tag, QString value = QString::null);
    int indexOfSection(QString section);
    int lastIndexOfSection(QString section);

signals:
    void countChanged();
    void sectionChanged();
};

#endif // SHLISTHANDLER_H
