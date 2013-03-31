// Default empty project template
#ifndef Imgurl_HPP_
#define Imgurl_HPP_

#include <QObject>
#include <bb/cascades/ImageView>
#include "uploader.h"
#include "apikey.h"
#include "Cache.h"
namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class Imgurl : public QObject
{
    Q_OBJECT
public:
    Imgurl(bb::cascades::Application *app);
    virtual ~Imgurl() {}
public slots:
	void copyToClipboard(QString url);
private:
	bb::cascades::ImageView* imagePreview;
	Uploader* uploader;
	Cache* cache;
};


#endif /* Imgurl_HPP_ */
