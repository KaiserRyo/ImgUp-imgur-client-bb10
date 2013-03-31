/*
 * Cache.cpp
 *
 *  Created on: 24-02-2013
 *      Author: michal
 */

#include "Cache.h"


Cache::Cache()
{
	// TODO Auto-generated constructor stub

}

Cache::~Cache() {
	// TODO Auto-generated destructor stub
}

QVariant Cache::getSendImages(){
	QString query("SELECT * FROM uploaded");
	return Database::instance()->sda()->execute(query);
}
void Cache::addSendImage(QString filepath, QVariantMap imageInfo){
	QString name = QFileInfo(filepath).fileName();
	QString query("INSERT INTO uploaded (name, imgur_page, original, date, path) VALUES ('%1','%2', '%3', datetime(), '%4')");
	query = query.arg(name).arg(imageInfo["imgur_page"].toString()).arg(imageInfo["original"].toString()).arg(filepath);
	qDebug() << name;
	qDebug() << "=======================";
	Database::instance()->sda()->execute(query);
}

void Cache::cleanSendImages(){
	QString query("DELETE FROM uploaded WHERE subscribed_to = '%1'");
	Database::instance()->sda()->execute(query);
}

