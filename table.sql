

CREATE    TABLE  tmpPersonas
(
    ID INT,
    Vards VARCHAR(250),
    Uzvards VARCHAR(250)
);

CREATE     TABLE  tmpNodalas
(
    ID INT,
    Nosaukums VARCHAR(250)
);

CREATE     TABLE  tmpStrada
(
    Persona INT,
    Nodala INT,
    SakumaDatums DATETIME,
    BeiguDatums DATETIME
);

INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (1, 'Jānis', 'Bērziņš');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (2, 'Anna', 'Liepa');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (3, 'Krišs', 'Kalniņš');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (4, 'Tamāra', 'Andersone');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (5, 'Ilmārs', 'Pētersons');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (6, 'Jānis', 'Zirnis');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (7, 'Inta', 'Brūvere');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (8, 'Pēteris', 'Liepiņš');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (9, 'Ilze', 'Kakliņa');
INSERT INTO  tmpPersonas (ID, Vards, Uzvards) VALUES (10, 'Žanis', 'Zemzars');

INSERT INTO  tmpNodalas (ID, Nosaukums) VALUES (1, 'IT daļa');
INSERT INTO  tmpNodalas (ID, Nosaukums) VALUES (2, 'Grāmatvedība');
INSERT INTO  tmpNodalas (ID, Nosaukums) VALUES (3, 'Personāldaļa');
INSERT INTO  tmpNodalas (ID, Nosaukums) VALUES (4, 'Saimniecības daļa');
INSERT INTO  tmpNodalas (ID, Nosaukums) VALUES (5, 'Front desk');

INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (1, 4, '2005-12-06', NULL);
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (2, 5, '2015-01-12', '2017-02-01');
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (3, 3, '2007-03-18', NULL);
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (4, 2, '2020-07-14', '2021-01-01');
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (5, 1, '2021-11-03', NULL);
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (6, 1, '2019-12-09', NULL);
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (7, 3, '2007-01-11', NULL);
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (8, 5, '2003-02-17', '2007-04-03');
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (9, 2, '2002-04-10', '2019-01-01');
INSERT INTO  tmpStrada (Persona, Nodala, SakumaDatums, BeiguDatums) VALUES (10, 4, '2016-05-01', NULL);








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
