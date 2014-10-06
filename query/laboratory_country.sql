  select NET_DEP_ID,trim(regexp_substr (COUNTRY, '[^|]+', 1, level)) COUNTRY
    from SEM_LIST_INFO 
  connect by level <= length (regexp_replace (COUNTRY, '[^|]+'))  + 1