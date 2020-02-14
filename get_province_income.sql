-- @block Bookmarked query
-- @group SNIS DRC
-- @name get monthly sum of revenue by Province

-- SELECT SUM(CAST(DV.value AS INT)) AS value,
SELECT CAST(DV.value AS INT) AS value,
       OU.namelevel2 AS province_name,
       periods.enddate AS period_end,
       periods.iso AS period,
       OU.uidlevel3 AS zone_id,
       OU.uidlevel5 AS fosa_id, 
       DE.name AS data_element_name
FROM datavalue DV
JOIN dataelement DE
  ON DE.dataelementid = DV.dataelementid
JOIN _periodstructure PERIODS
  ON DV.periodid = PERIODS.periodid
JOIN public._orgunitstructure OU
  ON DV.sourceid = OU.organisationunitid
JOIN public.categoryoptioncombo COC
  ON DV.categoryoptioncomboid = COC.categoryoptioncomboid
WHERE (DE.name LIKE '%A 4.4%')
  AND periods.enddate > '20170101'
  AND periods.enddate < '20191231'
-- GROUP BY periods.enddate,
--         OU.namelevel2,
--         OU.uidlevel5