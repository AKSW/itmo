  select NET_DEP_ID,substr(trim(regexp_substr (RES_DIR, '[^|]+', 1, level)),8,8) RES_DIR
    from SEM_LIST_INFO 
  connect by level <= length (regexp_replace (RES_DIR, '[^|]+'))  + 1