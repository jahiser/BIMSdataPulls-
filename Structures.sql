--For wells it should just be the following permit types: 
--HIGHRATE        High Rate Infiltration
--REUSE                Reclaimed Water
--SPRAY                Wastewater Irrigation
--LAGOONS        Other Non-Discharge Wastewater
--WWRECYC        Closed-Loop Recycle

-- Stuctures 

SELECT P.NUM as PermitNumber,
date(p.ORIGINALISSUEDDATE) as ORIGINAL_ISSUED, 
EIU.desc as STUCTURE_TYPE,
PT.desc as Permit_Type,     
FCTY.Name facility,

EI.num as IDENTIFIER ,

w.FLOWRATE  as FLOW_RATE,
w.CAPACITY   as CAPACITY,
w.DESIGNEDFREEBOARD as DESIGNED_FB,
w.STRUCTURALFREEBOARD  as STRUC_FB,
L.desc as LINER_TYPE,
DATE(W.CLOSEDDT)  aS closed_Date,
EIL.LOCATIONLATNUM as Latitude,
EIL.LOCATIONLONGNUM as Longitude 

FROM  (((((((((((((
                Permit P join PERMITENVINT PEI on P.ID = PEI.PERMITID )
                JOIN permitType PT on PT.id = p.permittypeID and PT.refcode in ('WWRECYC ','LAGOONS ','REUSE   ','HIGHRATE','SPRAY    ')) 
                JOIN PERMITSTATUS PS on P.permitStatusId = PS.ID and PS.REFCODE in ('ACTIVE','EXPIRED') )
                JOIN ENVINT EI on EI.ID = PEI.ENVINTID and PEI.EXPIRATIONDT is null and EI.EXPIRATIONDT is null)
                JOIN WASTESTRUCTURE W on W.ID = EI.ID)
                
                JOIN Status EIS on EIS.id = EI.statusid and EIS.refcode = 'ACTIVE')
               JOIN ENVINTENVINTUSAGE EIEIU on EIEIU.ENVINTID =  EI.id)
                
                JOIN ENVINTUSAGE EIU  on EIU.id = EIEIU.ENVINTUSAGEId and EIU.refcode in ('STRMONOF','STRWSSTO','STRWSRST','WETLAND''STRWSTPT','STRLAGON','STRDRYST','STRWETST','STRWSTPD','STRTREAT')  )
                JOIN Facility FCTY on FCTY.iD = P.FacilityID)
                JOIN OWNER O on O.iD = FCTY.OWNERID)
                JOIN COUNTY C on C.iD = FCTY.COUNTYID)
                LEFT OUTER JOIN ENVINTLOCATION EIL on EIL.ENVINTID = EI.ID)
                LEFT OUTER JOIN LinerTYpe L on L.id = W.LINERTYPEID)
                
