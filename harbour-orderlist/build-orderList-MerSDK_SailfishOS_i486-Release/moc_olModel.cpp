/****************************************************************************
** Meta object code from reading C++ file 'olModel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.2.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../olModel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'olModel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.2.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_OLModel_t {
    QByteArrayData data[28];
    char stringdata[282];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_OLModel_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_OLModel_t qt_meta_stringdata_OLModel = {
    {
QT_MOC_LITERAL(0, 0, 7),
QT_MOC_LITERAL(1, 8, 12),
QT_MOC_LITERAL(2, 21, 0),
QT_MOC_LITERAL(3, 22, 14),
QT_MOC_LITERAL(4, 37, 10),
QT_MOC_LITERAL(5, 48, 10),
QT_MOC_LITERAL(6, 59, 10),
QT_MOC_LITERAL(7, 70, 5),
QT_MOC_LITERAL(8, 76, 10),
QT_MOC_LITERAL(9, 87, 12),
QT_MOC_LITERAL(10, 100, 13),
QT_MOC_LITERAL(11, 114, 7),
QT_MOC_LITERAL(12, 122, 15),
QT_MOC_LITERAL(13, 138, 10),
QT_MOC_LITERAL(14, 149, 6),
QT_MOC_LITERAL(15, 156, 4),
QT_MOC_LITERAL(16, 161, 6),
QT_MOC_LITERAL(17, 168, 8),
QT_MOC_LITERAL(18, 177, 4),
QT_MOC_LITERAL(19, 182, 11),
QT_MOC_LITERAL(20, 194, 9),
QT_MOC_LITERAL(21, 204, 11),
QT_MOC_LITERAL(22, 216, 11),
QT_MOC_LITERAL(23, 228, 11),
QT_MOC_LITERAL(24, 240, 13),
QT_MOC_LITERAL(25, 254, 4),
QT_MOC_LITERAL(26, 259, 15),
QT_MOC_LITERAL(27, 275, 5)
    },
    "OLModel\0countChanged\0\0sectionChanged\0"
    "importList\0exportList\0removeItem\0index\0"
    "moveItemUp\0moveItemDown\0moveSectionUp\0"
    "section\0moveSectionDown\0addNewItem\0"
    "folded\0name\0entity\0quantity\0note\0"
    "replaceItem\0setFolded\0setQuantity\0"
    "getSections\0getEntities\0getRoleOfItem\0"
    "role\0getOrderListTxt\0count\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_OLModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      17,   14, // methods
       1,  164, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   99,    2, 0x06,
       3,    0,  100,    2, 0x06,

 // methods: name, argc, parameters, tag, flags
       4,    0,  101,    2, 0x02,
       5,    0,  102,    2, 0x02,
       6,    1,  103,    2, 0x02,
       8,    1,  106,    2, 0x02,
       9,    1,  109,    2, 0x02,
      10,    1,  112,    2, 0x02,
      12,    1,  115,    2, 0x02,
      13,    6,  118,    2, 0x02,
      19,    7,  131,    2, 0x02,
      20,    2,  146,    2, 0x02,
      21,    2,  151,    2, 0x02,
      22,    0,  156,    2, 0x02,
      23,    0,  157,    2, 0x02,
      24,    2,  158,    2, 0x02,
      26,    0,  163,    2, 0x02,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::Int,    7,
    QMetaType::Void, QMetaType::Int,    7,
    QMetaType::Void, QMetaType::Int,    7,
    QMetaType::Void, QMetaType::QString,   11,
    QMetaType::Void, QMetaType::QString,   11,
    QMetaType::Void, QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,   14,   11,   15,   16,   17,   18,
    QMetaType::Void, QMetaType::Int, QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,    7,   14,   11,   15,   16,   17,   18,
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    7,   14,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    7,   17,
    QMetaType::QVariant,
    QMetaType::QVariant,
    QMetaType::QVariant, QMetaType::Int, QMetaType::QString,    7,   25,
    QMetaType::QString,

 // properties: name, type, flags
      27, QMetaType::Int, 0x00495001,

 // properties: notify_signal_id
       0,

       0        // eod
};

void OLModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        OLModel *_t = static_cast<OLModel *>(_o);
        switch (_id) {
        case 0: _t->countChanged(); break;
        case 1: _t->sectionChanged(); break;
        case 2: { bool _r = _t->importList();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 3: { bool _r = _t->exportList();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 4: _t->removeItem((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->moveItemUp((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->moveItemDown((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: _t->moveSectionUp((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->moveSectionDown((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->addNewItem((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4])),(*reinterpret_cast< QString(*)>(_a[5])),(*reinterpret_cast< QString(*)>(_a[6]))); break;
        case 10: _t->replaceItem((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4])),(*reinterpret_cast< QString(*)>(_a[5])),(*reinterpret_cast< QString(*)>(_a[6])),(*reinterpret_cast< QString(*)>(_a[7]))); break;
        case 11: _t->setFolded((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 12: _t->setQuantity((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 13: { QVariant _r = _t->getSections();
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 14: { QVariant _r = _t->getEntities();
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 15: { QVariant _r = _t->getRoleOfItem((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 16: { QString _r = _t->getOrderListTxt();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (OLModel::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OLModel::countChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (OLModel::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OLModel::sectionChanged)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject OLModel::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_OLModel.data,
      qt_meta_data_OLModel,  qt_static_metacall, 0, 0}
};


const QMetaObject *OLModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *OLModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_OLModel.stringdata))
        return static_cast<void*>(const_cast< OLModel*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int OLModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 17)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 17;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 17)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 17;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = count(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void OLModel::countChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void OLModel::sectionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
