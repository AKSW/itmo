  select distinct trim((regexp_substr (RES_DIR, '[^|]+', 1, level))) RES_DIR
    from SEM_LIST_INFO 
  connect by level <= length (regexp_replace (RES_DIR, '[^|]+'))  + 1