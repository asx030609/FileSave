
--		NONE = 0,
--		BOOL = 1,
--		BYTEBOOL = 2,
--		BYTE = 3,
--		SHORT = 4,
--		WORD = 5,
--		DWORD = 6,
--		INT = 7,
--		FLOAT = 8,
--		SYS = 9,
--		STR = 11,
--		TIME = 12

SELECT * FROM DMT_TAGU;
SELECT * FROM DMT_TAGU WHERE ADDRESSU LIKE '%DBD%';
----ExtJs的DataType是从词典里找的
SELECT * FROM SYS_DICTIONARYU WHERE DICTIONARY_KEYU LIKE 'DataType';
SELECT * FROM SYS_DICTIONARY_DETAILU WHERE DICTIONARY_IDU IN (SELECT IDU FROM SYS_DICTIONARYU WHERE DICTIONARY_KEYU LIKE 'DataType');