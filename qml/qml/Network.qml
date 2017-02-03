import QtQuick 2.5

QtObject {
    id: networkImpl

    function httpGet(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == xhr.DONE) { //  && xhr.status == 200
                callback(xhr.responseText);
            }
        }

        xhr.open('GET', url);
        xhr.send()

        return xhr
    }

    function httpPost(url, body, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == xhr.DONE) { //  && xhr.status == 200
                callback(xhr.responseText);
            }
        }

        xhr.open('POST', url, true);
        xhr.setRequestHeader("Content-type", "application/json; charset=utf-8");
        xhr.send(JSON.stringify(body))

        return xhr
    }
}
