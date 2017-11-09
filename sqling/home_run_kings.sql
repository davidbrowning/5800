SELECT m."nameFirst", m."nameLast", batting."yearID", h 
FROM batting 
JOIN (SELECT "yearID", MAX("HR") as h
FROM batting
GROUP BY "yearID") AS m_hr ON (m_hr."yearID" = batting."yearID" AND m_hr.h = batting."HR")
JOIN (SELECT DISTINCT "masterID", "nameFirst", "nameLast" FROM master) AS m ON (m."masterID" = batting."masterID")
ORDER BY batting."yearID"
