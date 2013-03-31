/*
 * Cache.h
 *
 *  Created on: 24-02-2013
 *      Author: michal
 */

#ifndef CACHE_H_
#define CACHE_H_

#import <QObject>
#import <QDir>
#include <bb/data/SqlDataAccess>
#include <QFileInfo>
#include "Database.h"

class Cache : public QObject{
	Q_OBJECT
public:
	Cache();
	virtual ~Cache();
public slots:
	QVariant getSendImages();
	void addSendImage(QString filepath, QVariantMap imageInfo);
	void cleanSendImages();
};
#endif /* CACHE_H_ */
