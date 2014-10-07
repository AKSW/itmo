  select substr(RES_DIR,2,8), substr(RES_DIR,11,12) from
  (select substr(trim((regexp_substr (RES_DIR, '[^|]+', 1, level))),7,999) RES_DIR
    from SEM_LIST_INFO 
  connect by level <= length (regexp_replace (RES_DIR, '[^|]+'))  + 1)