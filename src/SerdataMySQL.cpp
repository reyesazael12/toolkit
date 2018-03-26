#include <mysql/my_global.h>
#include <mysql/mysql.h>

#include "Serdata.hpp"

namespace business
{
namespace serdata
{
    const char* Connector::serverDescription()
    {
        return mysql_get_client_info();
    }

    Connector::Connector(DatconectionMySQL& conection)
    {
        connect(conection);
    }

    void Connector::connect(DatconectionMySQL& conection) throw(Exception)
    {
        serverConnector = (void*)mysql_init(NULL);
        if (serverConnector == NULL)
        {
            throw Exception(mysql_errno((MYSQL*)serverConnector),mysql_error((MYSQL*)serverConnector));//fprintf(stderr, "%s\n", mysql_error(con));
            //return false;
        }

        if (mysql_real_connect((MYSQL*)serverConnector, conection.host, conection.usuario, conection.password,conection.database,conection.port, NULL, 0) == NULL)
        {
            throw Exception(mysql_errno((MYSQL*)serverConnector),mysql_error((MYSQL*)serverConnector));//fprintf(stderr, "%s\n", mysql_error(con));
            mysql_close((MYSQL*)serverConnector);
            //return false;
        }
    }
}
}