DROP PROCEDURE cxc_rptcartgen;
EXECUTE PROCEDURE cxc_rptcartgen('','2023-05-31','','');
EXECUTE PROCEDURE cxc_rptcartgen('C','2022-07-13','15','13');
EXECUTE PROCEDURE cxc_rptcartgen('C','2022-07-13','15','79');
EXECUTE PROCEDURE cxc_rptcartgen('C','2022-07-21','','');
EXECUTE PROCEDURE cxc_rptcartgen('C','21/07/22','','');

CREATE PROCEDURE cxc_rptcartgen
(
	paramTpa		CHAR(1),
	paramFecha   	DATE,
	paramCia		CHAR(2),
	paramPla		CHAR(18)
)
RETURNING  
 CHAR(6),	-- No Cliente
 CHAR(80),  -- Nombre / Razon Social
 CHAR(2),   -- Uso
 DECIMAL,	-- Saldo
 DECIMAL,	-- Saldo 0-30 dias
 DECIMAL,	-- Saldo 31-60 dias
 DECIMAL,	-- Saldo 61-90 dias
 DECIMAL,	-- Saldo 91-180 dias
 DECIMAL,	-- Saldo +180 dias
 SMALLINT,	-- Dias credito
 CHAR(1),	-- Contrato
 DECIMAL;	-- Importe Pagare

DEFINE vcte 	CHAR(6);
DEFINE vnomcte 	CHAR(80);
DEFINE vtipdoc 	CHAR(2);
DEFINE vuso 	CHAR(2);
DEFINE vsaldo 	DECIMAL;
DEFINE vsaldo0 	DECIMAL;
DEFINE vsaldo30	DECIMAL;
DEFINE vsaldo60	DECIMAL;
DEFINE vsaldo90	DECIMAL;
DEFINE vsaldo180	DECIMAL;
DEFINE vdiasc	SMALLINT;
DEFINE vcontra	CHAR(1);
DEFINE vpagare	DECIMAL;
DEFINE vpla1 	CHAR(2);
DEFINE vpla2 	CHAR(2);
DEFINE vpla3 	CHAR(2);
DEFINE vpla4 	CHAR(2);
DEFINE vpla5 	CHAR(2);
DEFINE vpla6 	CHAR(2);
DEFINE vpla7 	CHAR(2);
DEFINE vpla8 	CHAR(2);
DEFINE vpla9 	CHAR(2);

LET vpla1,vpla2,vpla3,vpla4,vpla5,vpla6,vpla7,vpla8,vpla9 = get_plantas(paramPla);

LET vsaldo = 0;
LET vsaldo0 = 0;
LET vsaldo30 = 0;
LET vsaldo60 = 0;
LET vsaldo90 = 0;
LET vsaldo180 = 0;

IF paramTpa <> '' THEN
	IF	paramCia <> '' AND paramPla <> '' THEN
		FOREACH cClientes FOR
			SELECT cte_doc--,uso_doc
			INTO vcte--, vuso
			FROM doctos
			WHERE cia_doc = paramCia
				AND pla_doc in(vpla1,vpla2,vpla3,vpla4,vpla5,vpla6,vpla7,vpla8,vpla9)
				AND tpa_doc = paramTpa
				AND sta_doc = 'A' 
				AND (sal_doc <> 0.0 
				AND fult_doc <= paramFecha
				OR  fult_doc  > paramFecha 
				AND femi_doc <= paramFecha )        
			  GROUP BY 1--,2

			  LET vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180 = cxc_rptcartcte(paramTpa,paramFecha,paramCia,paramPla,vcte);
					
			  LET vnomcte = '';
				IF vcte <> '' THEN
					SELECT	NVL(CASE 
							WHEN TRIM(cliente.razsoc_cte) <> '' THEN
							   TRIM(cliente.razsoc_cte) 
							ELSE 
							   trim(cliente.ape_cte) || ' ' || TRIM(cliente.nom_cte) 
							END,''), NVL(dcred_cte,0), ncont_cte, NVL(limcon_cte,0), uso_cte
					INTO	vnomcte, vdiasc,vcontra,vpagare,vuso
					FROM	cliente
					WHERE	num_cte = vcte;
				END IF;
			  RETURN 	vcte,vnomcte,vuso,vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180,vdiasc,vcontra,vpagare
			  WITH RESUME;
		END FOREACH;   
	ELSE
		FOREACH cClientes FOR
			SELECT cte_doc--,uso_doc
			INTO vcte--, vuso
			FROM doctos
			WHERE tpa_doc = paramTpa
				AND sta_doc = 'A' 
				AND (sal_doc <> 0.0 
				AND fult_doc <= paramFecha
				OR  fult_doc  > paramFecha 
				AND femi_doc <= paramFecha )        
			  GROUP BY 1--,2

			  LET vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180 = cxc_rptcartcte(paramTpa,paramFecha,paramCia,paramPla,vcte);
					
			  LET vnomcte = '';
				IF vcte <> '' THEN
					SELECT	NVL(CASE 
							WHEN TRIM(cliente.razsoc_cte) <> '' THEN
							   TRIM(cliente.razsoc_cte) 
							ELSE 
							   trim(cliente.ape_cte) || ' ' || TRIM(cliente.nom_cte) 
							END,''), NVL(dcred_cte,0), ncont_cte, NVL(limcon_cte,0), uso_cte
					INTO	vnomcte, vdiasc,vcontra,vpagare,vuso
					FROM	cliente
					WHERE	num_cte = vcte;
				END IF;
			  RETURN 	vcte,vnomcte,vuso,vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180,vdiasc,vcontra,vpagare
			  WITH RESUME;
		END FOREACH;   
	END IF;
ELSE
	IF	paramCia <> '' AND paramPla <> '' THEN
		FOREACH cClientes FOR
			SELECT cte_doc--,uso_doc
			INTO vcte--, vuso
			FROM doctos
			WHERE cia_doc = paramCia
				AND pla_doc in(vpla1,vpla2,vpla3,vpla4,vpla5,vpla6,vpla7,vpla8,vpla9)				
				AND sta_doc = 'A' 
				AND (sal_doc <> 0.0 
				AND fult_doc <= paramFecha
				OR  fult_doc  > paramFecha 
				AND femi_doc <= paramFecha )        
			  GROUP BY 1--,2

			  LET vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180 = cxc_rptcartcte(paramTpa,paramFecha,paramCia,paramPla,vcte);
					
			  LET vnomcte = '';
				IF vcte <> '' THEN
					SELECT	NVL(CASE 
							WHEN TRIM(cliente.razsoc_cte) <> '' THEN
							   TRIM(cliente.razsoc_cte) 
							ELSE 
							   trim(cliente.ape_cte) || ' ' || TRIM(cliente.nom_cte) 
							END,''), NVL(dcred_cte,0), ncont_cte, NVL(limcon_cte,0), uso_cte
					INTO	vnomcte, vdiasc,vcontra,vpagare,vuso
					FROM	cliente
					WHERE	num_cte = vcte;
				END IF;
			  RETURN 	vcte,vnomcte,vuso,vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180,vdiasc,vcontra,vpagare
			  WITH RESUME;
		END FOREACH;   
	ELSE
		FOREACH cClientes FOR
			SELECT cte_doc--,uso_doc
			INTO vcte--, vuso
			FROM doctos
			WHERE sta_doc = 'A' 
				AND (sal_doc <> 0.0 
				AND fult_doc <= paramFecha
				OR  fult_doc  > paramFecha 
				AND femi_doc <= paramFecha )        
			  GROUP BY 1--,2

			  LET vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180 = cxc_rptcartcte(paramTpa,paramFecha,paramCia,paramPla,vcte);
					
			  LET vnomcte = '';
				IF vcte <> '' THEN
					SELECT	NVL(CASE 
							WHEN TRIM(cliente.razsoc_cte) <> '' THEN
							   TRIM(cliente.razsoc_cte) 
							ELSE 
							   trim(cliente.ape_cte) || ' ' || TRIM(cliente.nom_cte) 
							END,''), NVL(dcred_cte,0), ncont_cte, NVL(limcon_cte,0), uso_cte
					INTO	vnomcte, vdiasc,vcontra,vpagare,vuso
					FROM	cliente
					WHERE	num_cte = vcte;
				END IF;
			  RETURN 	vcte,vnomcte,vuso,vsaldo,vsaldo0,vsaldo30,vsaldo60,vsaldo90,vsaldo180,vdiasc,vcontra,vpagare
			  WITH RESUME;
		END FOREACH;   
	END IF;
END IF;
END PROCEDURE;

SELECT cte_doc,uso_doc,SUM(car_doc),SUM(abo_doc),SUM(sal_doc),
          MAX(fven_doc),MIN(femi_doc),MAX(fult_doc) 
      FROM doctos 
      WHERE cia_doc MATCHES '15'
        AND pla_doc MATCHES '13'
        AND tpa_doc MATCHES 'C'
        AND sta_doc = 'A' 
        AND (sal_doc <> 0.0 
        AND fult_doc <= '2022-07-20' 
        OR  fult_doc  > '2022-07-20' 
        AND femi_doc <= '2022-07-20' )
      GROUP BY 1,2
      
      SELECT cte_doc,uso_doc
      FROM doctos 
      WHERE tpa_doc MATCHES 'C'
        AND sta_doc = 'A' 
        AND (sal_doc <> 0.0 
        AND fult_doc <= '2022-07-21' 
        OR  fult_doc  > '2022-07-21' 
        AND femi_doc <= '2022-07-21' )
      GROUP BY 1,2

SELECT *
      FROM doctos 
      WHERE cte_doc MATCHES '007232'
      order by femi_doc desc