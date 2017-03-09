"use strict";

function initWritersTable() {
    var data = [];
    var container = document.getElementById('handsontable');
    var hot = new Handsontable(container, {
        data: data,
        minSpareRows: 10,
        rowHeaders: true,
        colHeaders: true,
        colHeaders: ['ID', '类型', '姓名', '是否激活', '激活时间', 
            '微信', '邮箱', 'QQ', '电话', '微信公众号', 
            '雪球', '今日头条', '凤凰号', '百度百家', 'Medium'],
        columns: [
            {data: 0}, {data: 1}, {data: 2}, {data: 3, type: 'checkbox'}, {data: 4},
            {data: 5}, {data: 6}, {data: 7}, {data: 8}, {data: 9},
            {data: 10}, {data: 11}, {data: 12}, {data: 13}, {data: 14}
        ],
        contextMenu: true,
        afterChange: function() {
            var tmpData = JSON.parse(JSON.stringify(data));
            // now tmpData has a copy of data that can be manipulated
            // without breaking the Handsontable data source object
        }
    });
}