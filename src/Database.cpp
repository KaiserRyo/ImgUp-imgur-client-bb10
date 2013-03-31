/*
 * Database.cpp
 *
 *  Created on: 25-02-2013
 *      Author: michal
 */

#include "Database.h"

bool Database::instanceFlag = false;
Database* Database::single = NULL;
Database* Database::instance(){
    if(! instanceFlag)
    {
        single = new Database();
        instanceFlag = true;
        return single;
    }
    else
    {
        return single;
    }
}

void Database::method()
{
}

bb::data::SqlDataAccess* Database::sda(){
	return m_sda;
}

void Database::init(){
//    if(!QFile::exists(QDir::homePath() + "/general.db"))
//    	QFile::copy(QDir::currentPath() + "/app/native/assets/db.db", QDir::homePath() + "/general.db");
}
