grammar Expr;

prog       : stat (NEWLINE stat)* EOF ;

stat       : loadFile | makeList | addToList | removeFromList | normalize | futures | historicalComp;

loadFile    : fileType STRING '=' filePath FILE ',' INT ',' INT
            ;

fileType    : COMMODITY
            | INFLATION
            | FACTOR
            ;

filePath    : STRING '/' filePath
            | STRING '/'
            ;

makeList    : LIST type STRING
            | LIST type STRING '=' listContent
            ;

listContent : STRING moreStrings
            ;

moreStrings : ',' STRING moreStrings
            |
            ;

type        : COMMODITY
            | INFLATION
            | FACTOR
            | PREDICTION
            ;

addToList   : STRING '.' ADD '(' STRING ')'
            ;

removeFromList  : STRING '.' REMOVE '(' STRING ')'
                ;

normalize   : STRING '.normalize(' STRING ')'
            ;

futures     : STRING '.' futuresFunction '(' DATE '-' DATE ',' DATE ',' futuresParams ')'
            ;

futuresFunction : REGRESSION
                ;

futuresParams   : futuresIterated
                | futuresWeighted
                ;

futuresIterated : STRING moreStrings

                ;

futuresWeighted : STRING '=' STRING
                | STRING '=' INT
                | STRING '=' INT moreWeights
                ;

moreWeights     : ',' STRING '=' INT moreWeights
                |
                ;

historicalComp : 'historicalComp' '(' STRING ')'
               | 'historicalComp' '(' DATE ',' STRING ',' (FLOAT | INT)')'
               ;


FILE     : [a-z]+ '.csv' ;
ADD      : 'ADD' ;
REMOVE   : 'REMOVE' ;
DATE     : INT '/' INT '/' INT ;

LIST     : 'LIST' ;

COMMODITY   : 'COMMODITY' ;
INFLATION   : 'INFLATION' ;
FACTOR      : 'FACTOR' ;
PREDICTION  : 'PREDICTION' ;
REGRESSION : 'REGRESSION' ;

STRING   : [a-zA-Z] [a-zA-Z0-9]* ;
INT      : [0-9]+ ;
FLOAT    : [0-9] +  ( '.' [0-9]+)? ;
NUM      : FLOAT | INT;

NEWLINE : '\r'? '\n' ;
WS      : [ \t]+ -> skip ;