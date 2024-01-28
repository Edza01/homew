SELECT
    tp.Vards,
    tp.Uzvards,
    tn.Nosaukums AS Nodala,
    DATE_FORMAT(tmpStrada.SakumaDatums, '%d.%m.%Y') AS SakumaDatums,
    CASE
        WHEN tmpStrada.BeiguDatums IS NULL THEN '(aktuāls)'
        ELSE DATE_FORMAT(tmpStrada.BeiguDatums, '%d.%m.%Y')
    END AS BeiguDatums
FROM
    tmpStrada
JOIN tmpPersonas tp ON tmpStrada.Persona = tp.ID
JOIN tmpNodalas tn ON tmpStrada.Nodala = tn.ID
WHERE
    TIMESTAMPDIFF(YEAR, tmpStrada.SakumaDatums, COALESCE(tmpStrada.BeiguDatums, NOW())) >= 2
ORDER BY
    tmpStrada.SakumaDatums;
