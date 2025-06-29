
tr=$(awk 'END {print NR}'  access.log)
uniq_ip=$(awk '{ip[$1]++} END {print length(ip)}' access.log)
methods=$(awk -F\" '{split($2, a, " "); methods[a[1]]++} END {for (m in methods) print m, methods[m]}'  access.log | sort)
popular_url=$(awk -F\" '{split($2, a, " "); urls[a[2]]++} END {max=0; for (u in urls) if (urls[u]>max) {max=urls[u]; popular=u} print popular}'  access.log)
echo
echo "Отчет сохранен в файл: report.txt"
{
  echo "Отчет о логе веб-сервера"
  echo "Общее количество запросов: $tr"
  echo "Количество уникальных IP-адресов: $uniq_ip"
  echo "Количество запросов по методам:"
  echo "$methods"
  echo "Самый популярный URL: $popular_url"
} > report.txt
