grammar Expr;

prog        :
            ;

loadFile    : fileType STRING '=' filePath FILE ',' INT ',' INT
            ;

fileType    : COMMODITY
            | INFLATION
            | FACTOR
            ;

filePath    : STRING '/' filePath
            | STRING '/' STRING
            ;

makeList    : LIST type STRING
            | LIST type STRING '=' listContent
            ;

listContent : STRING moreStrings
            ;

moreStrings : ',' STRING moreStrings
            |
            ;

type        : COMMODITITY
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

futures     : STRING '.' futuresFunction '(' futuresParams ') 
            ;

futuresParams   : futuresIterated
                | futuresWeighted
                ;

futuresIterated : STRING moreStrings        ## gold.regression(rainfall, turb, asda)

                ;

futuresWeighted : STRING '=' STRING         ## two lists, example: gold.regression(myFactors=weights)
                | STRING '=' INT            ## list w/ equal weights, example gold.regression(myFactors=121999)
                | STRING '=' INT moreWeights
                ;

moreWeights     : ',' STRING '=' INT moreWeights ## example: gold.regression(rainfall=1, gdp=1, turb=1)
                |
                ;

/////
ADD IN CHECK FUNCTION:
    calling futures, and comparing to actual historical value

ADDITIONAL TO FUTURES:
    (1) what historical range are we pulling from
    (2) how far in the future you want a prediction

ALSO TO DO
    (1) TEST
    (2) TEST CASES
    (3) UPDATE README




INT      : [0-9]+ ;
FLOAT    : [0-9] +  ( '.' [0-9]+)? ;
STRING   : [a-zA-Z0-9]+ ;
FILE     : [a-z]+ '.csv' ;
LIST     : 'LIST' ;
ADD      : 'ADD' ;
REMOVE   : 'REMOVE' ;

COMMODITY   : 'COMMODITY' ;
INFLATION   : 'INFLATION' ;
FACTOR      : 'FACTOR' ;
PREDICTION  : 'PREDICTION' ;