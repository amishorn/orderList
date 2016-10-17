#include "oListItem.h"

OListItem::OListItem(QObject *parent) : QObject(parent) { }

OListItem::OListItem(const bool folded, const QString section, const QString name, const QString entity, const QString quantity, const QString note, QObject *parent)
    : QObject(parent), _folded(folded), _section(section), _name(name), _entity(entity), _amount(quantity), _note(note) {
    _selected = false;
}

bool OListItem::selected() const {

    return _selected;
}

void OListItem::setSelected(bool state) {

    if (state != _selected) {
        _selected = state;
        emit selectedChanged();
    }
}

bool OListItem::folded() const {

    return _folded;
}

void OListItem::setFolded(bool folded) {

    if (folded != _folded) {
        _folded = folded;
        emit foldChanged();
    }
}

QString OListItem::section() const {

    return _section;
}

void OListItem::setSection(QString section) {

    if (section != _section) {
        _section = section;
        emit sectionChanged();
    }
}

QString OListItem::name() const {

    return _name;
}

void OListItem::setName(QString name) {

    if (name != _name) {
        _name = name;
        emit nameChanged();
    }
}

QString OListItem::entity() const {

    return _entity;
}

void OListItem::setEntity(QString entity) {

    if (entity != _entity) {
        _entity = entity;
        emit entityChanged();
    }
}

QString OListItem::quantity() const {

    return _amount;
}

void OListItem::setQuantity(QString amount) {

    if (amount != _amount) {
        _amount = amount;
        emit quantityChanged();
    }
}

QString OListItem::note() const {

    return _note;
}

void OListItem::setNote(QString note) {

    if (note != _note) {
        _note = note;
        emit noteChanged();
    }
}
