SELECT
    Vards,
    Uzvards,
    Nodala,
    DATE_FORMAT(SakumaDatums, '%d.%m.%Y') AS SakumaDatums,
    CASE
        WHEN BeiguDatums IS NULL THEN '(aktuāls)'
        ELSE DATE_FORMAT(BeiguDatums, '%d.%m.%Y')
    END AS BeiguDatums,
    WorkDays
FROM (
    SELECT
        tp.Vards,
        tp.Uzvards,
        tn.Nosaukums AS Nodala,
        tmpStrada.SakumaDatums,
        tmpStrada.BeiguDatums,
        DATEDIFF(COALESCE(tmpStrada.BeiguDatums, NOW()), tmpStrada.SakumaDatums) AS WorkDays
    FROM
        tmpStrada
    JOIN tmpPersonas tp ON tmpStrada.Persona = tp.ID
    JOIN tmpNodalas tn ON tmpStrada.Nodala = tn.ID
) AS WorkPeriods
ORDER BY
    WorkDays DESC
LIMIT 1;
