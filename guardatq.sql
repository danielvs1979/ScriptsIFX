CREATE PROCEDURE guardatq(
	paramCte 	CHAR(6), 
	paramCia 	CHAR(2),
	paramPla 	CHAR(2), 
	paramDir 	CHAR(40), 
	paramCol 	CHAR(40),
	paramCiu 	CHAR(30), 
	paramObserv CHAR(40), 
	paramPrg 	CHAR(1),
	paramNum 	INT, 
	paramCapa 	DECIMAL(10,2), 
	paramPorcLl DECIMAL(10,2),
	paramPorcVa DECIMAL(10,2), 
	paramMesfab SMALLINT, 
	paramAnoFab SMALLINT,
	paramUltcar DATE, 
	paramDiasCa SMALLINT, 
	paramDiasom INT, 
	paramProxCa DATE, 
	paramRuta 	CHAR(4), 
	paramConp 	DECIMAL(10,2),
	paramUsr 	CHAR(8), 
	paramServ 	CHAR(1), 
	paramStat 	CHAR(1),
	paramFecBaj DATE, 
	paramUsrBaj CHAR(8), 
	paramPrecio CHAR(3),
	paramGps 	CHAR(30)
)
RETURNING SMALLINT;

INSERT INTO tanque(	numcte_tqe, 
					cia_tqe, 
					pla_tqe, 
					dir_tqe, 
					col_tqe,
					ciu_tqe,	
					observ_tqe, 
					prg_tqe, 
					numtqe_tqe, 
					capac_tqe, 
					porll_tqe, 
					porva_tqe, 
					mesfab_tqe, 
					anofab_tqe, 
					ultcar_tqe, 
					diasca_tqe, 
					diasom_tqe, 
					proxca_tqe, 
					ruta_tqe, 
					conprm_tqe, 
					usr_tqe, 
					serv_tqe, 
					stat_tqe, 
					precio_tqe, 
					gps_tqe)
VALUES			  (	paramCte, 
					paramCia, 
					paramPla, 
					paramDir, 
					paramCol,
					paramCiu, 
					paramObserv, 
					paramPrg, 
					paramNum, 
					paramCapa,
					paramPorcLl, 	
					paramPorcVa, 
					paramMesfab, 
					paramAnoFab,
					paramUltcar, 
					paramDiasCa, 
					paramDiasom, 
					paramProxCa, 
					paramRuta, 
					paramConp, 
					paramUsr, 
					paramServ,
					paramStat, 
					paramPrecio, 
					paramGps);

RETURN
 paramNum;
END PROCEDURE;                          