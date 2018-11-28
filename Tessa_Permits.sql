 -- Duplicates beacuse of regulated activities 
 -- Cannot do inpsctions because it's causing duplicats for ras 
 -- Cannot do field and Dry tons together 
 -- Cannot do relate permit because of duplicates 
 -- updated 11-28-2018 to include Tessa's lastest request 
 
 SELECT distinct  
 P.NUM as PERMIT, 
 date(p.EFFECTIVEDATE) as PERMIT_ISSUED_DT,
 PT.desc as PERMIT_TYPE,   
 C.NAME as COUNTY, 
 R.name as REGION,
 FCTY.Name as  facility,
 case when FS.refcode = 'ACTIVE  ' then 1 else 0 end as FACILITY_ACTIVE,
 FS.desc as FACILITY_STATUS,

CASE WHEN O.ORGANIZATIONNAME IS NULL THEN RTRIM(O.FIRSTNAME) || CASE WHEN O.MIDDLENAME IS NULL 
           THEN ' ' ELSE ' ' || RTRIM( O.MIDDLENAME) END || ' '|| RTRIM(O.LASTNAME) ELSE O.ORGANIZATIONNAME END AS Owner ,

FLOC.locationLatNum        as  Lat ,
FLOC.locationLongNum        as  Long,
US.FIRSTNAME || ' ' || US.lastname as PRIMARY_REVIEWER,

p.PRMTTEDFLOWQTYGPD as PERMITED_FLOW, 
P.ASBUILTFLOWQTYGPD as AS_BUILT_FLOW, 
p.DOMESTICPCT as Domestic,
P.STORMWATERPCT AS Stormwater,
P.INDUSTRIALPCT as industrial,
date(P.ORIGINALISSUEDDATE) as Original_Issued_DT, 
sum(f.ACREAGE) as FIELD_ACRES,
sum(RS.ESTDRYTONSQTY) as DRY_TONS,

        


''                 as ECM_LINK,
' '                as BlankField_1,
' '                as BlankField_2


FROM ((((( (((((( ((((  ((

	Permit P JOIN PermitType PT on PT.id = P.permitTypeId and  programcategoryid ='2W1WFMYG0006KD84EKJ3RBNABT' 
                                                              and refcode not in ('COLLECT ','DEEMED  ','GRAVITY ','CERTAPPR','PUMP    ','GWREMNON','DSTRANML'))
	JOIN PERMITSTATUS PS on P.permitStatusId = PS.ID and  PS.REFCODE in ('ACTIVE','EXPIRED'))
	JOIN Facility FCTY on FCTY.iD = P.FacilityID)
	JOIN OWNER O on O.iD = FCTY.OWNERID)
        JOIN COUNTY C on C.iD = FCTY.COUNTYID) 
        JOIN REGION R on P.adminRegionId = R.id)
        JOIN STATUS FS on FS.id = FCTY.FACILITYSTATUSID)
        JOIN PERMITREVIEWER PR on PR.permitid = P.id and PR.ISPRIMARY =1)
        JOIN USER US on US.id = PR.userid) 
        JOIN PERMITFACREGACTVTY PFRA on  PFRA.PERMITID = P.id)
        JOIN FACILITYREGACTVTY FRA on FRA.Id = PFRA.FCLTYREGACTVTYID)
        JOIN REGACTIVITYTYPE RA on RA.id = FRA.REGACTIVITYTYPEID)
        LEFT OUTER JOIN   ENVINTLOCATION  FLOC ON FLOC.ENVINTID  = FCTY.id)
     
        LEFT OUTER JOIN  PermitEnvInt pei on PEI.permitId = P.id)
        LEFT OUTER JOIN   EnvInt ei  on pei.envIntId = ei.id AND pei.expirationDt is null)
        LEFT OUTER JOIN Field f  on f.id  = ei.id)
        LEFT OUTER JOIN RESIDUALSOURCE RS  on RS.permitid  = P.id)
                                                      
 
       
        
      
 Group By 
  P.NUM ,
 date(p.EFFECTIVEDATE) ,
 PT.desc ,  
 C.NAME ,
 R.name, 
 FCTY.Name , 
    FS.refcode,
 FS.desc ,
 
CASE WHEN O.ORGANIZATIONNAME IS NULL THEN RTRIM(O.FIRSTNAME) || CASE WHEN O.MIDDLENAME IS NULL 
           THEN ' ' ELSE ' ' || RTRIM( O.MIDDLENAME) END || ' '|| RTRIM(O.LASTNAME) ELSE O.ORGANIZATIONNAME END   ,
FLOC.locationLatNum,        
FLOC.locationLongNum ,
US.FIRSTNAME || ' ' || US.lastname ,
 p.PRMTTEDFLOWQTYGPD,
P.ASBUILTFLOWQTYGPD, 
p.DOMESTICPCT ,
P.STORMWATERPCT , 
P.INDUSTRIALPCT   ,
P.ORIGINALISSUEDDATE


	 
	 
 

 
 		 
 
