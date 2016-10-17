/****************************************************************************
** Meta object code from reading C++ file 'oListItem.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.2.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../oListItem.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'oListItem.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.2.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_OListItem_t {
    QByteArrayData data[16];
    char stringdata[159];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_OListItem_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_OListItem_t qt_meta_stringdata_OListItem = {
    {
QT_MOC_LITERAL(0, 0, 9),
QT_MOC_LITERAL(1, 10, 15),
QT_MOC_LITERAL(2, 26, 0),
QT_MOC_LITERAL(3, 27, 11),
QT_MOC_LITERAL(4, 39, 14),
QT_MOC_LITERAL(5, 54, 11),
QT_MOC_LITERAL(6, 66, 13),
QT_MOC_LITERAL(7, 80, 15),
QT_MOC_LITERAL(8, 96, 11),
QT_MOC_LITERAL(9, 108, 8),
QT_MOC_LITERAL(10, 117, 6),
QT_MOC_LITERAL(11, 124, 7),
QT_MOC_LITERAL(12, 132, 4),
QT_MOC_LITERAL(13, 137, 6),
QT_MOC_LITERAL(14, 144, 8),
QT_MOC_LITERAL(15, 153, 4)
    },
    "OListItem\0selectedChanged\0\0foldChanged\0"
    "sectionChanged\0nameChanged\0entityChanged\0"
    "quantityChanged\0noteChanged\0selected\0"
    "folded\0section\0name\0entity\0quantity\0"
    "note\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_OListItem[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       7,   56, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   49,    2, 0x06,
       3,    0,   50,    2, 0x06,
       4,    0,   51,    2, 0x06,
       5,    0,   52,    2, 0x06,
       6,    0,   53,    2, 0x06,
       7,    0,   54,    2, 0x06,
       8,    0,   55,    2, 0x06,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       9, QMetaType::Bool, 0x00495001,
      10, QMetaType::Bool, 0x00495001,
      11, QMetaType::QString, 0x00495001,
      12, QMetaType::QString, 0x00495001,
      13, QMetaType::QString, 0x00495001,
      14, QMetaType::QString, 0x00495001,
      15, QMetaType::QString, 0x00495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,
       5,
       6,

       0        // eod
};

void OListItem::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        OListItem *_t = static_cast<OListItem *>(_o);
        switch (_id) {
        case 0: _t->selectedChanged(); break;
        case 1: _t->foldChanged(); break;
        case 2: _t->sectionChanged(); break;
        case 3: _t->nameChanged(); break;
        case 4: _t->entityChanged(); break;
        case 5: _t->quantityChanged(); break;
        case 6: _t->noteChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::selectedChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::foldChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::sectionChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::nameChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::entityChanged)) {
                *result = 4;
            }
        }
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::quantityChanged)) {
                *result = 5;
            }
        }
        {
            typedef void (OListItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&OListItem::noteChanged)) {
                *result = 6;
            }
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject OListItem::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_OListItem.data,
      qt_meta_data_OListItem,  qt_static_metacall, 0, 0}
};


const QMetaObject *OListItem::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *OListItem::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_OListItem.stringdata))
        return static_cast<void*>(const_cast< OListItem*>(this));
    return QObject::qt_metacast(_clname);
}

int OListItem::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = selected(); break;
        case 1: *reinterpret_cast< bool*>(_v) = folded(); break;
        case 2: *reinterpret_cast< QString*>(_v) = section(); break;
        case 3: *reinterpret_cast< QString*>(_v) = name(); break;
        case 4: *reinterpret_cast< QString*>(_v) = entity(); break;
        case 5: *reinterpret_cast< QString*>(_v) = quantity(); break;
        case 6: *reinterpret_cast< QString*>(_v) = note(); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void OListItem::selectedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void OListItem::foldChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void OListItem::sectionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void OListItem::nameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void OListItem::entityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void OListItem::quantityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void OListItem::noteChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}
QT_END_MOC_NAMESPACE
