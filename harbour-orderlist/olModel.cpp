/**************************************************************
 * shlisthandler.cpp
 *
 * This class (QML model) provides functions and roles for an
 * easy hosting and access of a list with QString elements. It
 * also provides functions to load and save a custom list as
 * well as for modifications.
 *
 * Author:      R. Christen
 * Date:        2016-02-10
 */

#include <QDir>
#include <QFile>
#include <QTextStream>
#include "olModel.h"

#include <QDebug>

OLModel::OLModel(QObject *parent) : QAbstractListModel(parent) {

    importList();
}

QHash<int, QByteArray> OLModel::roleNames() const{

    QHash<int, QByteArray> roles;
    roles[CheckRole] = "selected";
    roles[VisRole] = "folded";
    roles[SecRole] = "section";
    roles[NameRole] = "name";
    roles[EntRole] = "entity";
    roles[QuantRole] = "quantity";
    roles[NoteRole] = "note";

    return roles;
}

int OLModel::rowCount(const QModelIndex &) const {

    return _oList.size();
}

QVariant OLModel::data(const QModelIndex &index, int role) const {

    if(!index.isValid()) { return QVariant(); }
    if(role == CheckRole) { return QVariant(_oList[index.row()]->selected()); }
    if(role == VisRole) { return QVariant (_oList[index.row()]->folded()); }
    if(role == SecRole) { return QVariant(_oList[index.row()]->section()); }
    if(role == NameRole) { return QVariant(_oList[index.row()]->name()); }
    if(role == EntRole) { return QVariant(_oList[index.row()]->entity()); }
    if(role == QuantRole) { return QVariant(_oList[index.row()]->quantity()); }
    if(role == NoteRole) { return QVariant(_oList[index.row()]->note()); }

    return QVariant();
}

bool OLModel::setData(const QModelIndex &index, const QVariant &value, int role) {

    QModelIndex modIndex = createIndex(index.row(),1);
    QVector<int> roles = roleNames().keys().toVector();

    if(index.isValid()) {
        if(role == CheckRole) {
            _oList[index.row()]->setSelected(value.toBool());
            if(_oList[index.row()]->selected() == value.toBool()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
        if(role == VisRole) {
            _oList[index.row()]->setFolded(value.toBool());
            if(_oList[index.row()]->folded() == value.toBool()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
        if(role == SecRole) {
            _oList[index.row()]->setSection(value.toString());
            if(_oList[index.row()]->section() == value.toString()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
        if(role == NameRole) {
            _oList[index.row()]->setName(value.toString());
            if(_oList[index.row()]->name() == value.toString()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
        if(role == EntRole) {
            _oList[index.row()]->setEntity(value.toString());
            if(_oList[index.row()]->entity() == value.toString()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
        if(role == QuantRole) {
            _oList[index.row()]->setQuantity(value.toString());
            if(_oList[index.row()]->quantity() == value.toString()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
        if(role == NoteRole) {
            _oList[index.row()]->setNote(value.toString());
            if(_oList[index.row()]->note() == value.toString()) {
                emit QAbstractListModel::dataChanged(modIndex, modIndex, roles);
                return true;
            }
        }
    }

    return false;
}

Qt::ItemFlags OLModel::flags(const QModelIndex &index) const {

    return index.flags();
}

int OLModel::count() {

    return rowCount(QModelIndex());
}

void OLModel::updateEntry(int index) {
    emit QAbstractItemModel::dataChanged(createIndex(index,1), createIndex(index,1), roleNames().keys().toVector());
}

bool OLModel::importList() {

    QDomDocument doc(_olCustListURI);
    QFile file(_olCustListURI);
    if (!file.open(QIODevice::ReadOnly))
        return false;
    if (!doc.setContent(&file)) {
        file.close();
        return false;
    }
    file.close();

    QDomElement docElem = doc.documentElement();
    QDomNodeList secList = docElem.elementsByTagName(_xmlSec);

    for(int i=0; i<secList.count(); i++) {
        QDomNode s = secList.at(i);
        QDomNode sS = s.attributes().namedItem(_xmlName).firstChild();
        QDomNode sV = s.attributes().namedItem(_xmlFolded).firstChild();
        QDomNodeList itemList = s.childNodes();

        for(int j=0; j<itemList.count(); j++) {
            QDomNode n = itemList.at(j);
            QDomNode nN = n.attributes().namedItem(_xmlName).firstChild();
            QDomNode nS = n.namedItem(_xmlSel).firstChild();
            QDomNode nE = n.namedItem(_xmlEntity).firstChild();
            QDomNode nQ = n.namedItem(_xmlQuantity).firstChild();
            QDomNode nNd = n.namedItem(_xmlNote).firstChild();

            addNewItem((sV.nodeValue().compare("true", Qt::CaseInsensitive) == 0), sS.nodeValue(), nN.nodeValue(),
                       (nS.nodeValue().compare("true", Qt::CaseInsensitive) == 0), nE.nodeValue(), nQ.nodeValue(), nNd.nodeValue());
        }
    }

    return true;
}

QDomElement OLModel::addNode(QDomDocument doc, QDomNode parentNode, const QString tag, const QString value) {

    QDomElement n = doc.createElement(tag);
    parentNode.appendChild(n);

    if(!value.isNull()) {
        n.appendChild(doc.createTextNode(value));
    }

    return n;
}

/* exportList delets the file if it already exist. In any case
 * it writes the entire list into a new xml file.
 */
bool OLModel::exportList() {

    QDomDocument doc;
    QDomNode root;
    QDomElement secNode;
    QDir dir;
    QString sec = QString::null;
    int index = 0;

    QFile file(_olCustListURI);
    if(file.exists()) file.remove();

    if(!QDir(_olCustListURI).exists()) dir.mkpath(_olDataFolder);

    if(!file.open(QIODevice::ReadWrite)) return false;
    else {
        doc.appendChild(doc.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'"));
        root = addNode(doc, doc, _xmlRoot);
    }

    while(index < _oList.count()) {

        // create a section if it doesn't exist already or is null
        if((sec != _oList[index]->section()) || secNode.isNull()) {
            sec = _oList[index]->section();
            secNode = addNode(doc, root, _xmlSec);
            secNode.setAttribute(_xmlName, sec);
            secNode.setAttribute(_xmlFolded, "true"); //(_oList[index]->folded() ? "true" : "false"));
        }

        // add item to appropriate section
        QDomElement itemNode = addNode(doc, secNode, _xmlItem);
        itemNode.setAttribute(_xmlName, _oList[index]->name());
        addNode(doc, itemNode, _xmlSel, (_oList[index]->selected() ? "true" : "false"));
        addNode(doc, itemNode, _xmlEntity, _oList[index]->entity());
        addNode(doc, itemNode, _xmlQuantity, _oList[index]->quantity());
        addNode(doc, itemNode, _xmlNote, _oList[index]->note());
        index++;
    }

    QTextStream xmlFile(&file);
    doc.save(xmlFile, 4);

    file.flush();
    file.close();
    return true;
}

void OLModel::clearSelection() {

    foreach(OListItem* sel, _oList)
        sel->setSelected(false);

    qDebug() << "cleared";
}

void OLModel::addNewItem(bool folded, QString section, QString name, bool selected, QString entity, QString quantity, QString note) {

    int index = 0;
    OListItem *newShlItem = new OListItem(folded, section, name, selected, entity, quantity, note);

    /* search for first match */
    while(index < _oList.count())
        if(_oList[index]->section() != newShlItem->section()) index++;
        else break;

    /* search for last match */
    while(index < _oList.count())
        if(_oList[index]->section() == newShlItem->section()) index++;
        else break;

    beginInsertRows(QModelIndex(), index, index);
    _oList.insert(index, newShlItem);
    endInsertRows();

}

void OLModel::replaceItem(int index, bool folded, QString section, QString name, bool selected, QString entity, QString quantity, QString note) {

    OListItem *newShlItem = new OListItem(folded, section, name, selected, entity, quantity, note);

    if(_oList[index]->section() != newShlItem->section()) {
        beginRemoveRows(QModelIndex(), index, index);
        _oList.removeAt(index);
        endRemoveRows();

        addNewItem(folded, section, name, selected, entity, quantity, note);
    }
    else {
        _oList.replace(index, newShlItem);
        emit QAbstractItemModel::dataChanged(createIndex(index,1), createIndex(index,1), roleNames().keys().toVector());
    }
}

void OLModel::removeItem(int index) {

    beginRemoveRows(QModelIndex(), index, index);
    _oList.removeAt(index);
    endRemoveRows();
}

void OLModel::moveItemUp(int index) {

    if(index > 0) {
        if(_oList[index]->section() != _oList[index-1]->section()) {
            _oList[index]->setFolded(_oList[index-1]->folded());
            _oList[index]->setSection(_oList[index-1]->section());
            emit QAbstractItemModel::dataChanged(createIndex(index,1), createIndex(index,1), roleNames().keys().toVector());
        }
        else {
            beginMoveRows(QModelIndex(), index, index, QModelIndex(), index -1);
            _oList.move(index, index -1);
            qDebug() << "item moved";
            endMoveRows();
        }
    }
}

void OLModel::moveItemDown(int index) {

    if((index < count())) {
        if(_oList[index]->section() != _oList[index+1]->section()) {
            _oList[index]->setSection(_oList[index+1]->section());
            _oList[index]->setFolded(_oList[index+1]->folded());
            emit QAbstractItemModel::dataChanged(createIndex(index,1), createIndex(index,1), roleNames().keys().toVector());
        }
        else {
            beginMoveRows(QModelIndex(), index, index, QModelIndex(), index +2);
            _oList.move(index, index +1);
            endMoveRows();
        }
    }
}

int OLModel::indexOfSection(QString section) {

    int index = 0;

    /* search for first match */
    while(index < _oList.count())
        if(_oList[index]->section() != section) index++;
        else return index;


    return 0;
}

int OLModel::lastIndexOfSection(QString section) {

    int index = _oList.count() -1;

    /* search for last match */
    while(index > 0)
        if(_oList[index]->section() != section) index--;
        else return index;

    return 0;
}

void OLModel::moveSectionUp(QString section) {

    QStringList secList = getSections().toStringList();
    int secIndex = secList.indexOf(section);

    if(secIndex > 0) {
        int firstSecInd = indexOfSection(section);
        int firstNewSecInd = indexOfSection(secList[secIndex-1]);
        int lastSecInd = lastIndexOfSection(section);

        beginMoveRows(QModelIndex(), firstSecInd, lastSecInd, QModelIndex(), firstNewSecInd);
        while(firstSecInd <= lastSecInd)
            _oList.move(firstSecInd++, firstNewSecInd++);
        endMoveRows();
    }
}

void OLModel::moveSectionDown(QString section) {

    QStringList secList = getSections().toStringList();
    int secIndex = secList.indexOf(section);

    if(secIndex < secList.count()-1) {
        int firstSecInd = indexOfSection(section);
        int lastSecInd = lastIndexOfSection(section);
        int lastNewSecInd = lastIndexOfSection(secList[secIndex+1]);

        beginMoveRows(QModelIndex(), firstSecInd, lastSecInd, QModelIndex(), lastNewSecInd +1);
        while(firstSecInd <= lastSecInd) {
            _oList.move(lastSecInd--, lastNewSecInd--);}
        endMoveRows();
    }
}

OListItem *OLModel::newItem(bool folded, QString section, QString name, QString entity, bool selected, QString quantity, QString note) {

    return new OListItem(folded, section, name, selected, entity, quantity, note);
}

void OLModel::setFolded(int index, bool folded) {

    _oList[index]->setFolded(folded);
    emit QAbstractListModel::dataChanged(
                createIndex(index,1), createIndex(index,1), roleNames().keys().toVector());
}

void OLModel::setQuantity(int index, QString quantity) {

    _oList[index]->setQuantity(quantity);
    emit QAbstractListModel::dataChanged(
                createIndex(index,1), createIndex(index,1), roleNames().keys().toVector());
}

QVariant OLModel::getRoleOfItem(int index, QString role)
{
    return data(createIndex(index,1), roleNames().key(role.toLocal8Bit()));
}

QVariant OLModel::getSections() {

    QList<QString> sections;
    QList<OListItem*>::Iterator i = _oList.begin();

    while(i < _oList.end()) {
        if(!sections.contains((*i)->section()))
            sections << (*i)->section();
        i++;
    }

    return QVariant(sections);
}

QVariant OLModel::getEntities() {

    QList<QString> entities;
    QList<OListItem*>::Iterator i = _oList.begin();

    while(i < _oList.end()) {
        if(!entities.contains((*i)->entity()))
            entities << (*i)->entity();
        i++;
    }

    return QVariant(entities);
}

QString OLModel::getOrderListTxt() {

    QString oListTxt;
    QList<OListItem*>::Iterator i = _oList.begin();

    while(i < _oList.end()) {
        if((*i)->selected() == true) {
            oListTxt += ("- " + (*i)->quantity() +
                         "\t" + (*i)->entity() +
                         "\t" + (*i)->name() +
                         (((*i)->note() != "") ? (" (" + (*i)->note() + ")\n") : "\n"));
        }
        i++;
    }

    return oListTxt;
}
