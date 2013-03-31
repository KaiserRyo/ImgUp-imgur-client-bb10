// Default empty project template
#include "Imgurl.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/pickers/FilePicker>
#include <bb/system/Clipboard>

using namespace bb::cascades;

Imgurl::Imgurl(bb::cascades::Application *app)
: QObject(app)
{
	uploader = new Uploader(API_KEY, this);
	cache = new Cache();
    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    qmlRegisterType<bb::cascades::pickers::FilePicker>("my.filepicker", 1, 0,"FilePicker");
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("_uploader", uploader);
    qml->setContextProperty("_cache", cache);
    qml->setContextProperty("_app", this);
	// create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    imagePreview = root->findChild<bb::cascades::ImageView*>("imagePreview");
    // set created root object as a scene
    app->setScene(root);
}
void Imgurl::copyToClipboard(QString url){
	bb::system::Clipboard clipboard;
	clipboard.clear();
	clipboard.insert("text/plain", url.toAscii());
}

