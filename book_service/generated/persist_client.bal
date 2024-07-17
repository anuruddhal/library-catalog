// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/persist.sql as psql;

const BOOK = "books";
const AUTHOR = "authors";
const DIGITAL_COPY = "digitalcopies";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [BOOK]: {
            entityName: "Book",
            tableName: "Book",
            fieldMetadata: {
                id: {columnName: "id", dbGenerated: true},
                title: {columnName: "title"},
                isbn: {columnName: "isbn"},
                year: {columnName: "year"},
                genre: {columnName: "genre"},
                authorId: {columnName: "authorId"},
                "author.id": {relation: {entityName: "author", refField: "id"}},
                "author.name": {relation: {entityName: "author", refField: "name"}},
                "digitalcopy.id": {relation: {entityName: "digitalcopy", refField: "id"}},
                "digitalcopy.bookId": {relation: {entityName: "digitalcopy", refField: "bookId"}},
                "digitalcopy.fileUrl": {relation: {entityName: "digitalcopy", refField: "fileUrl"}},
                "digitalcopy.format": {relation: {entityName: "digitalcopy", refField: "format"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                author: {entity: Author, fieldName: "author", refTable: "Author", refColumns: ["id"], joinColumns: ["authorId"], 'type: psql:ONE_TO_MANY},
                digitalcopy: {entity: DigitalCopy, fieldName: "digitalcopy", refTable: "DigitalCopy", refColumns: ["bookId"], joinColumns: ["id"], 'type: psql:ONE_TO_ONE}
            }
        },
        [AUTHOR]: {
            entityName: "Author",
            tableName: "Author",
            fieldMetadata: {
                id: {columnName: "id", dbGenerated: true},
                name: {columnName: "name"},
                "book[].id": {relation: {entityName: "book", refField: "id"}},
                "book[].title": {relation: {entityName: "book", refField: "title"}},
                "book[].isbn": {relation: {entityName: "book", refField: "isbn"}},
                "book[].year": {relation: {entityName: "book", refField: "year"}},
                "book[].genre": {relation: {entityName: "book", refField: "genre"}},
                "book[].authorId": {relation: {entityName: "book", refField: "authorId"}}
            },
            keyFields: ["id"],
            joinMetadata: {book: {entity: Book, fieldName: "book", refTable: "Book", refColumns: ["authorId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}}
        },
        [DIGITAL_COPY]: {
            entityName: "DigitalCopy",
            tableName: "DigitalCopy",
            fieldMetadata: {
                id: {columnName: "id", dbGenerated: true},
                bookId: {columnName: "bookId"},
                fileUrl: {columnName: "fileUrl"},
                format: {columnName: "format"},
                "book.id": {relation: {entityName: "book", refField: "id"}},
                "book.title": {relation: {entityName: "book", refField: "title"}},
                "book.isbn": {relation: {entityName: "book", refField: "isbn"}},
                "book.year": {relation: {entityName: "book", refField: "year"}},
                "book.genre": {relation: {entityName: "book", refField: "genre"}},
                "book.authorId": {relation: {entityName: "book", refField: "authorId"}}
            },
            keyFields: ["id"],
            joinMetadata: {book: {entity: Book, fieldName: "book", refTable: "Book", refColumns: ["id"], joinColumns: ["bookId"], 'type: psql:ONE_TO_ONE}}
        }
    };

    public isolated function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [BOOK]: check new (dbClient, self.metadata.get(BOOK), psql:MYSQL_SPECIFICS),
            [AUTHOR]: check new (dbClient, self.metadata.get(AUTHOR), psql:MYSQL_SPECIFICS),
            [DIGITAL_COPY]: check new (dbClient, self.metadata.get(DIGITAL_COPY), psql:MYSQL_SPECIFICS)
        };
    }

    isolated resource function get books(BookTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get books/[int id](BookTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post books(BookInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BOOK);
        }
        sql:ExecutionResult[] result = check sqlClient.runBatchInsertQuery(data);
        return from sql:ExecutionResult inserted in result
            where inserted.lastInsertId != ()
            select <int>inserted.lastInsertId;
    }

    isolated resource function put books/[int id](BookUpdate value) returns Book|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BOOK);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/books/[id].get();
    }

    isolated resource function delete books/[int id]() returns Book|persist:Error {
        Book result = check self->/books/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BOOK);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get authors(AuthorTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get authors/[int id](AuthorTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post authors(AuthorInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(AUTHOR);
        }
        sql:ExecutionResult[] result = check sqlClient.runBatchInsertQuery(data);
        return from sql:ExecutionResult inserted in result
            where inserted.lastInsertId != ()
            select <int>inserted.lastInsertId;
    }

    isolated resource function put authors/[int id](AuthorUpdate value) returns Author|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(AUTHOR);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/authors/[id].get();
    }

    isolated resource function delete authors/[int id]() returns Author|persist:Error {
        Author result = check self->/authors/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(AUTHOR);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get digitalcopies(DigitalCopyTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get digitalcopies/[int id](DigitalCopyTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post digitalcopies(DigitalCopyInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DIGITAL_COPY);
        }
        sql:ExecutionResult[] result = check sqlClient.runBatchInsertQuery(data);
        return from sql:ExecutionResult inserted in result
            where inserted.lastInsertId != ()
            select <int>inserted.lastInsertId;
    }

    isolated resource function put digitalcopies/[int id](DigitalCopyUpdate value) returns DigitalCopy|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DIGITAL_COPY);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/digitalcopies/[id].get();
    }

    isolated resource function delete digitalcopies/[int id]() returns DigitalCopy|persist:Error {
        DigitalCopy result = check self->/digitalcopies/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DIGITAL_COPY);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

