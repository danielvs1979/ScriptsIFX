CREATE PROCEDURE QryPeOr
(	
	paramCia    CHAR(2),
	paramPla    CHAR(2),
	paramFi		DATE,
	paramFf     DATE	
)

	RETURNING 
		INT,						
		DATETIME YEAR TO MINUTE,	
		CHAR(1),					
		CHAR(6),					
		SMALLINT,				 	
		INT,						
		SMALLINT,					
		CHAR(4),					
		CHAR(40),					
		CHAR(1),					
		DATE,						
		CHAR(1),					
		CHAR(8),					
		CHAR(1),					
		DATETIME YEAR TO MINUTE,	
		CHAR(8),					
		DATE,						
		CHAR(8),					
		CHAR(50),					
		SMALLINT,					
		DATETIME YEAR TO MINUTE, 	
		CHAR(8),					
		SMALLINT,					
		DATETIME YEAR TO MINUTE, 	
		CHAR(8),					
		CHAR(2),					
		DATETIME YEAR TO MINUTE,	
		CHAR(1);					


	DEFINE	num		INT;
	DEFINE	fhr		DATETIME YEAR TO MINUTE;
	DEFINE	tipo	CHAR(1);
	DEFINE  numcte  CHAR(6);
	DEFINE 	lada	SMALLINT;
	DEFINE	tel		INT;
	DEFINE  numtqe	SMALLINT;
	DEFINE	ruta	CHAR(4);
	DEFINE	observ	CHAR(40);
	DEFINE	rfa		CHAR(1);
	DEFINE	fecsur  DATE;
	DEFINE	edo 	CHAR(1);
	DEFINE	usr 	CHAR(8);
	DEFINE	edotx	CHAR(1);
	DEFINE	fhtx 	DATETIME YEAR TO MINUTE;
	DEFINE	usrtx 	CHAR(8);
	DEFINE  fecrsur DATE;
	DEFINE  usrcan 	CHAR(8);
	DEFINE	motcan 	CHAR(50);
	DEFINE	nmod 	SMALLINT;
	DEFINE	fhrp 	DATETIME YEAR TO MINUTE;
	DEFINE	usrrp   CHAR(8);
	DEFINE	nmtx	SMALLINT;
	DEFINE	fhptx 	DATETIME YEAR TO MINUTE;
	DEFINE	usrtp 	CHAR(8);
	DEFINE	tmcan 	CHAR(2);
	DEFINE	horrsur DATETIME HOUR TO MINUTE;
	DEFINE	tpdo 	CHAR(1);


	FOREACH cCursorDef FOR

		SELECT		num_ped,
					fhr_ped,
					tipo_ped,
					numcte_ped,
					lada_ped,
					tel_ped,
					numtqe_ped,
					ruta_ped,
					observ_ped,
					rfa_ped,
					fecsur_ped,
					edo_ped,
					usr_ped,
					edotx_ped,
					fhtx_ped,
					usrtx_ped,
					fecrsur_ped,
					usrcan_ped,
					motcan_ped,
					nmod_ped,
					fhrp_ped,
					usrrp_ped,
					nmtx_ped,
					fhptx_ped,
					usrtp_ped,
					tmcan_ped,
					horrsur_ped,
					tpdo_ped
		INTO		num,
					fhr,
					tipo,
					numcte,
					lada,
					tel,
					numtqe,
					ruta,
					observ,
					rfa,
					fecsur,
					edo,
					usr,
					edotx,
					fhtx,
					usrtx,
					fecrsur,
					usrcan,
					motcan,
					nmod,
					fhrp,
					usrrp,
					nmtx,
					fhptx,
					usrtp,
					tmcan,
					horrsur,
					tpdo
		FROM		pedidos
		WHERE		fecsur_ped >= paramFi
		AND			fecsur_ped <= paramFf
		AND			edo_ped IN ('p', 'P')
		AND			tpdo_ped = 'S'
		AND			EXISTS (SELECT	cve_rut FROM ruta WHERE cia_rut = paramCia AND pla_rut = paramPla AND cve_rut = ruta_ped)
		ORDER BY 	numcte_ped
		RETURN 		num,
					fhr,
					tipo,
					numcte,
					lada,
					tel,
					numtqe,
					ruta,
					observ,
					rfa,
					fecsur,
					edo,
					usr,
					edotx,
					fhtx,
					usrtx,
					fecrsur,
					usrcan,
					motcan,
					nmod,
					fhrp,
					usrrp,
					nmtx,
					fhptx,
					usrtp,
					tmcan,
					horrsur,
					tpdo
		WITH RESUME;

	END FOREACH; 

END PROCEDURE;