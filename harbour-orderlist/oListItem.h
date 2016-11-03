#ifndef OLISTITEM_H
#define OLISTITEM_H

#include <QObject>

class OListItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool selected READ selected NOTIFY selectedChanged)
    Q_PROPERTY(bool folded READ folded NOTIFY foldChanged)
    Q_PROPERTY(QString section READ section NOTIFY sectionChanged)
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString entity READ entity NOTIFY entityChanged)
    Q_PROPERTY(QString quantity READ quantity NOTIFY quantityChanged)
    Q_PROPERTY(QString note READ note NOTIFY noteChanged)

public:
    explicit OListItem(QObject *parent=0);
    explicit OListItem(const bool folded, const QString section, const QString name, const bool selected,
                       const QString entity, const QString quantity, const QString note, QObject *parent=0);

    bool selected() const;
    void setSelected(bool state);

    bool folded() const;
    void setFolded(bool folded);

    QString section() const;
    void setSection(QString section);

    QString quantity() const;
    void setQuantity(QString quantity);

    QString entity() const;
    void setEntity(QString entity);

    QString name() const;
    void setName(QString name);

    QString note() const;
    void setNote(QString note);

private:
    bool _selected;
    bool _folded;
    QString _section;
    QString _name;
    QString _entity;
    QString _amount;
    QString _note;

signals:
    void selectedChanged();
    void foldChanged();
    void sectionChanged();
    void nameChanged();
    void entityChanged();
    void quantityChanged();
    void noteChanged();
};

#endif // OListItem_H
