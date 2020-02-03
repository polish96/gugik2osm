insert into prg.delta
    select
        pa.lokalnyid,
        pa.teryt_msc,
        pa.teryt_simc,
        pa.teryt_ulica,
        pa.teryt_ulic,
        pa.nr,
        pa.pna,
        pa.gml geom
    from prg.pa
    join prg.pa_hashed prg using (lokalnyid)
    left join osm_hashed osm
        on (prg.hash = osm.hash and st_dwithin(st_transform(prg.geom, 2180), st_transform(osm.geom, 2180), 50))
    where
        prg.geom && ST_Transform(ST_MakeEnvelope(%(xmin)s, %(ymin)s, %(xmax)s, %(ymax)s, 3857), 2180)
        and
        osm.hash is null
;
