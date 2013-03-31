/*
 * Database.h
 *
 *  Created on: 25-02-2013
 *      Author: michal
 */

#ifndef DATABASE_H_
#define DATABASE_H_

#include <QObject>
#include <bb/data/SqlDataAccess>
#include <QDir>
class Database
{
private:
    static bool instanceFlag;
    static Database *single;
    Database()
    {
    	init();
    	m_sda = new bb::data::SqlDataAccess(QDir::currentPath() + "/app/native/assets/db.db");
        //private constructor
    }
    bb::data::SqlDataAccess* m_sda;
public:
    static Database* instance();
    bb::data::SqlDataAccess* sda();
    void method();
    void init();
    ~Database()
    {
        instanceFlag = false;
    }
};

#endif /* DATABASE_H_ */
