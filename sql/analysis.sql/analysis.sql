USE HealthcareAnalytics;
GO

SELECT COUNT(*) AS TotalRecords
FROM dbo.diabetic_data;

SELECT TOP 10 *
FROM dbo.diabetic_data;

SELECT
	readmitted,
	COUNT(*) AS TotalPatients
FROM dbo.diabetic_data
GROUP BY readmitted
ORDER BY TotalPatients DESC;

SELECT
    COUNT(*) AS TotalEncounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS ReadmittedWithin30Days,
    CAST(
        SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate
FROM dbo.diabetic_data;


USE HealthcareAnalytics;
GO

SELECT
    age,
    COUNT(*) AS TotalEncounters,
    SUM(CASE 
        WHEN readmitted = '<30' THEN 1 
        ELSE 0 
    END) AS ReadmittedWithin30Days,
    CAST(
        SUM(CASE 
            WHEN readmitted = '<30' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate
FROM dbo.diabetic_data
GROUP BY age
ORDER BY ReadmissionRate DESC;

USE HealthcareAnalytics;
GO

SELECT
    readmitted,
    COUNT(*) AS TotalEncounters,
    CAST(AVG(time_in_hospital * 1.0) AS DECIMAL(5,2)) AS AverageLengthOfStay
FROM dbo.diabetic_data
GROUP BY readmitted
ORDER BY AverageLengthOfStay DESC;

USE HealthcareAnalytics;
GO

SELECT
    COUNT(*) AS TotalEncounters,
    CAST(AVG(time_in_hospital * 1.0) AS DECIMAL(5,2)) AS AverageLengthOfStay
FROM dbo.diabetic_data;

USE HealthcareAnalytics;
GO

SELECT
    admission_type_id,
    COUNT(*) AS TotalEncounters
FROM dbo.diabetic_data
GROUP BY admission_type_id
ORDER BY TotalEncounters DESC;

USE HealthcareAnalytics;
GO

SELECT
    admission_type_id,
    CASE
        WHEN admission_type_id = 1 THEN 'Emergency'
        WHEN admission_type_id = 2 THEN 'Urgent'
        WHEN admission_type_id = 3 THEN 'Elective'
        WHEN admission_type_id = 4 THEN 'Newborn'
        WHEN admission_type_id = 5 THEN 'Not Available'
        WHEN admission_type_id = 6 THEN 'Not Specified'
        WHEN admission_type_id = 7 THEN 'Trauma Center'
        WHEN admission_type_id = 8 THEN 'Not Mapped'
        ELSE 'Unknown'
    END AS AdmissionType,
    COUNT(*) AS TotalEncounters,
    SUM(CASE
        WHEN readmitted = '<30' THEN 1
        ELSE 0
    END) AS ReadmittedWithin30Days,
    CAST(
        SUM(CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate
FROM dbo.diabetic_data
GROUP BY admission_type_id
ORDER BY ReadmissionRate DESC;

USE HealthcareAnalytics;
GO

SELECT
    discharge_disposition_id,
    COUNT(*) AS TotalEncounters
FROM dbo.diabetic_data
GROUP BY discharge_disposition_id
ORDER BY TotalEncounters DESC;

USE HealthcareAnalytics;
GO

SELECT
    discharge_disposition_id,
    COUNT(*) AS TotalEncounters,
    SUM(CASE
        WHEN readmitted = '<30' THEN 1
        ELSE 0
    END) AS ReadmittedWithin30Days,
    CAST(
        SUM(CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate
FROM dbo.diabetic_data
GROUP BY discharge_disposition_id
HAVING COUNT(*) >= 500
ORDER BY ReadmissionRate DESC;

USE HealthcareAnalytics;
GO

SELECT
    discharge_disposition_id,

    CASE
        WHEN discharge_disposition_id = 1
            THEN 'Home'
        WHEN discharge_disposition_id = 2
            THEN 'Another Short-Term Hospital'
        WHEN discharge_disposition_id = 3
            THEN 'Skilled Nursing Facility'
        WHEN discharge_disposition_id = 4
            THEN 'Intermediate Care Facility'
        WHEN discharge_disposition_id = 5
            THEN 'Another Inpatient Care Institution'
        WHEN discharge_disposition_id = 6
            THEN 'Home with Home Health'
        WHEN discharge_disposition_id = 7
            THEN 'Left AMA'
        WHEN discharge_disposition_id = 18
            THEN 'Missing / NULL'
        WHEN discharge_disposition_id = 22
            THEN 'Rehabilitation Facility'
        WHEN discharge_disposition_id = 25
            THEN 'Not Mapped'
        WHEN discharge_disposition_id = 11
            THEN 'Expired'
        ELSE 'Other'
    END AS DischargeDestination,

    COUNT(*) AS TotalEncounters,

    SUM(
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END
    ) AS ReadmittedWithin30Days,

    CAST(
        SUM(
            CASE
                WHEN readmitted = '<30' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate

FROM dbo.diabetic_data

GROUP BY discharge_disposition_id

HAVING COUNT(*) >= 500

ORDER BY ReadmissionRate DESC;

USE HealthcareAnalytics;
GO

SELECT
    number_inpatient,
    COUNT(*) AS TotalEncounters,
    SUM(
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END
    ) AS ReadmittedWithin30Days,
    CAST(
        SUM(
            CASE
                WHEN readmitted = '<30' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate
FROM dbo.diabetic_data
GROUP BY number_inpatient
ORDER BY number_inpatient;

USE HealthcareAnalytics;
GO

SELECT
    CASE
        WHEN number_inpatient = 0 THEN '0 visits'
        WHEN number_inpatient BETWEEN 1 AND 2 THEN '1-2 visits'
        WHEN number_inpatient BETWEEN 3 AND 4 THEN '3-4 visits'
        ELSE '5+ visits'
    END AS PreviousInpatientVisits,

    COUNT(*) AS TotalEncounters,

    SUM(
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END
    ) AS ReadmittedWithin30Days,

    CAST(
        SUM(
            CASE
                WHEN readmitted = '<30' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate

FROM dbo.diabetic_data

GROUP BY
    CASE
        WHEN number_inpatient = 0 THEN '0 visits'
        WHEN number_inpatient BETWEEN 1 AND 2 THEN '1-2 visits'
        WHEN number_inpatient BETWEEN 3 AND 4 THEN '3-4 visits'
        ELSE '5+ visits'
    END

ORDER BY
    CASE
        WHEN MIN(number_inpatient) = 0 THEN 1
        WHEN MIN(number_inpatient) = 1 THEN 2
        WHEN MIN(number_inpatient) = 3 THEN 3
        ELSE 4
    END;

    USE HealthcareAnalytics;
GO

SELECT
    readmitted,
    COUNT(*) AS TotalEncounters,
    CAST(AVG(num_medications * 1.0) AS DECIMAL(5,2)) AS AverageMedications
FROM dbo.diabetic_data
GROUP BY readmitted
ORDER BY AverageMedications DESC;

USE HealthcareAnalytics;
GO

SELECT
    number_emergency,
    COUNT(*) AS TotalEncounters,
    SUM(
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END
    ) AS ReadmittedWithin30Days,
    CAST(
        SUM(
            CASE
                WHEN readmitted = '<30' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate
FROM dbo.diabetic_data
GROUP BY number_emergency
ORDER BY number_emergency;

USE HealthcareAnalytics;
GO

SELECT
    CASE
        WHEN number_emergency = 0 THEN '0 visits'
        WHEN number_emergency BETWEEN 1 AND 2 THEN '1-2 visits'
        WHEN number_emergency BETWEEN 3 AND 4 THEN '3-4 visits'
        ELSE '5+ visits'
    END AS PreviousEmergencyVisits,

    COUNT(*) AS TotalEncounters,

    SUM(
        CASE
            WHEN readmitted = '<30' THEN 1
            ELSE 0
        END
    ) AS ReadmittedWithin30Days,

    CAST(
        SUM(
            CASE
                WHEN readmitted = '<30' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS ReadmissionRate

FROM dbo.diabetic_data

GROUP BY
    CASE
        WHEN number_emergency = 0 THEN '0 visits'
        WHEN number_emergency BETWEEN 1 AND 2 THEN '1-2 visits'
        WHEN number_emergency BETWEEN 3 AND 4 THEN '3-4 visits'
        ELSE '5+ visits'
    END

ORDER BY
    CASE
        WHEN MIN(number_emergency) = 0 THEN 1
        WHEN MIN(number_emergency) = 1 THEN 2
        WHEN MIN(number_emergency) = 3 THEN 3
        ELSE 4
    END;
