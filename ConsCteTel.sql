CREATE PROCEDURE ConsCteTel
(
	paramLada	SMALLINT,
	paramTel 	INTEGER
)
RETURNING 	
 CHAR(6),
 CHAR(70),
 CHAR(30),
 CHAR(20),
 CHAR(40),
 CHAR(40), 
 CHAR(30),
 CHAR(6),
 DECIMAL(12,2),
 DATE,
 DECIMAL(12,2),
 DATE, 
 DECIMAL(12,2),
 CHAR(1),
 SMALLINT,
 INTEGER;
 
DEFINE num 		CHAR(6); 
DEFINE razsoc 	CHAR(70);
DEFINE ape 		CHAR(30); 
DEFINE nom 		CHAR(20);
DEFINE dir 		CHAR(40); 
DEFINE col 		CHAR(40);
DEFINE ciu 		CHAR(30); 
DEFINE codpo 	CHAR(6);
DEFINE cargo 	DECIMAL(12,2); 
DEFINE fecuca 	DATE; 
DEFINE abono 	DECIMAL(12,2); 
DEFINE fecuab 	DATE;
DEFINE saldo 	DECIMAL(12,2); 
DEFINE tip 		CHAR(1);
DEFINE lada 	SMALLINT;
DEFINE tel 		INTEGER;
FOREACH cursorcanc FOR 
	SELECT 	num_cte,razsoc_cte,ape_cte,nom_cte,dir_cte,
		   	col_cte,ciu_cte,codpo_cte,cargo_cte,fecuca_cte,abono_cte,fecuab_cte,
		   	saldo_cte,tip_cte,lada_cte,tel_cte 
	INTO 	num,razsoc, ape, nom, dir, col, 
		   	ciu, codpo,cargo, fecuca, abono, fecuab,saldo, tip, lada, tel 
	FROM 	cliente 
	WHERE  	lada_cte = paramLada 
			AND tel_cte  = paramTel 
	RETURN 	num, razsoc, ape, nom, dir, col, ciu, codpo,cargo, fecuca, abono, 
			fecuab, saldo, tip, lada, tel 
	WITH RESUME; 
END FOREACH;
END PROCEDURE;                                                                                                                                                                                        