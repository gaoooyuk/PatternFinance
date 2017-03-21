import QtQuick 2.5
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: composer
    width: parent.width
    height: editor.height
    radius: 10

    signal articleInfoChanged(string info)
    signal importArticleRequest(string url)

    function fillContentModel(contentArray) {
        content.clear()
        for (var i in contentArray) {
            content.append(contentArray[i])
        }
    }

    function initArticleInfo(ai) {
        editor.initArticleInfo(ai)
    }

    function importArticle(article) {
        editor.importArticle(article)
    }

    function dumpArticle() {
        var article = {}
        var d = []
        var tocs = []
        for (var i = 0; i < content.count; i++) {
            var e = content.get(i)
            d.push({
                       "type": e.type,
                       "ratio": e.ratio,
                       "content": e.content
                   })

            if ("sectionHeader" === e.type) {
                tocs.push(e.content)
            }
        }

        article.rawData = d
        article.tocs = tocs

        return article
    }

    ListModel {
        id: content
    }

    ArticleEditor {
        id: editor
        width: composer.width
        totalNumberOfChars: getTotalNumberOfChars()
        estimatedReadingMins: totalNumberOfChars/700
        coverImage: "../articledata/covers/shb365.png"
        contentModel: content
        onHeightChanged: {
            composer.height = editor.height
        }
        onArticleInfoChanged: {
            composer.articleInfoChanged(info)
        }
        onImportArticleRequest: {
            composer.importArticleRequest(url)
        }
    }
}
