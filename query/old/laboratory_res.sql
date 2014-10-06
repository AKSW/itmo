  select NET_DEP_ID,replace(regexp_substr(((regexp_substr (RES_DIR, '[^|]+', 1, level))),'\d\d\.\d\d\.\d\d'),'.','') RES_DIR
    from SEM_LIST_INFO 
  connect by level <= length (regexp_replace (RES_DIR, '[^|]+'))  + 1