#ifndef __BusinessDatabase_H__
#define __BusinessDatabase_H__


#include "Business.hpp"


namespace business
{
namespace serdata
{
    struct DatconectionMySQL
    {
        const char *host;
        const char *usuario;
        const char *password;
        const char *database;
        unsigned int port;
        const char *unix_socket;
        unsigned long client_flag;

        int last_errono;
        const char * last_errmsg;
    };

    class Connector
    {
    private:
        void* serverConnector;
    public:
        Connector();
        Connector(DatconectionMySQL& connector);
        void connect(DatconectionMySQL& connector) throw(Exception);
        const char* serverDescription();
    };
}
}

#endif