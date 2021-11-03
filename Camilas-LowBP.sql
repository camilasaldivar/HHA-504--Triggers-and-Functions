use synthea;

Show tables;

delimiter $$

CREATE TRIGGER LowSystolic BEFORE INSERT ON clinical_data
FOR EACH ROW 
BEGIN
IF NEW.systolic <= 90 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE ABOVE 90 mg!';
END IF;
END; $$

delimiter ;


delimiter $$

CREATE TRIGGER LowDiastolic BEFORE INSERT ON clinical_data
FOR EACH ROW 
BEGIN
IF NEW.diastolic <= 60 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Diastolic BP MUST BE ABOVE 60 mg!';
END IF;
END; $$

delimiter ;

###### Confirming the trigger works

INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (373437, 'Doe', 80, 60);


DELIMITER $$
CREATE FUNCTION InsuranceCoverage2(cost DECIMAL(10,2))
RETURNS VARCHAR(20)
BEGIN
DECLARE InsuranceCoverage VARCHAR(20);
IF cost = 129.16 THEN

SET InsuranceCoverage = "FullyCovered";

ELSEIF cost < 129.16 THEN
SET InsuranceCoverage = "NotFullyCovered";

ELSEIF cost <129.16 AND COST>=0 THEN
SET InsuranceCoverage = "NotFullyCovered";


END IF;
RETURN (InsuranceCoverage);
END; $$
DELIMITER 

