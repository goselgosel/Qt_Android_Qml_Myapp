// 本地持久化服务（Storage.js）
// 说明：
// 1) QtQuick.LocalStorage 底层即 SQLite（应用私有目录，随 App 生命周期持久存在）。
// 2) 这里把 SQL 细节封装成统一 API，页面层只调用 load/save，避免散落 SQL 语句。
// 3) 当前采用 KV 表结构，优点是迁移成本低；后续可平滑升级为多表模型。

.import QtQuick.LocalStorage 2.0 as LS

var _db = null

function _database() {
    if (_db !== null) {
        return _db
    }

    // openDatabaseSync 参数：
    // name/version/description/estimated_size（字节）
    _db = LS.LocalStorage.openDatabaseSync("DailyToolkitDB", "1.0", "Daily toolkit local data", 2 * 1024 * 1024)
    _db.transaction(function(tx) {
        // KV 表：k = 业务键，v = 字符串值（JSON/文本/数字字符串均可）
        tx.executeSql("CREATE TABLE IF NOT EXISTS kv_store (k TEXT UNIQUE NOT NULL, v TEXT)")
    })
    return _db
}

function setValue(key, value) {
    var db = _database()
    db.transaction(function(tx) {
        // INSERT OR REPLACE 可覆盖写入，简化“先查后改”的流程。
        tx.executeSql("INSERT OR REPLACE INTO kv_store(k, v) VALUES(?, ?)", [key, value])
    })
}

function getValue(key, fallbackValue) {
    var db = _database()
    var result = fallbackValue
    db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT v FROM kv_store WHERE k = ?", [key])
        if (rs.rows.length > 0) {
            result = rs.rows.item(0).v
        }
    })
    return result
}

function saveNotes(text) {
    setValue("notes_text", text)
}

function loadNotes() {
    return getValue("notes_text", "")
}

function saveTodoList(todoArray) {
    setValue("todo_items_json", JSON.stringify(todoArray))
}

function loadTodoList() {
    var raw = getValue("todo_items_json", "[]")
    try {
        var data = JSON.parse(raw)
        // 防御式校验：即使历史值异常也不让页面崩溃。
        return Array.isArray(data) ? data : []
    } catch (e) {
        return []
    }
}

function saveNumber(key, value) {
    setValue(key, String(value))
}

function loadNumber(key, fallbackValue) {
    var raw = getValue(key, String(fallbackValue))
    var n = Number(raw)
    return isFinite(n) ? n : fallbackValue
}
