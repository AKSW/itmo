SELECT NET_DEP_ID, PCARD_ID,FIRST_NAME, PATRONYMIC, LAST_NAME, replace(replace(USRS_STATUS,'BOSS','true'),'USER','false') IS_BOSS FROM
  sem_person_info