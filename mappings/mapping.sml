create view foo as construct {
  <http://s> <http://o> ?dep .
}
WITH
   ?dep = uri(concat("http://example.com/", ?NET_DEP_ID))
FROM [[SELECT * FROM sem_list_info]]
