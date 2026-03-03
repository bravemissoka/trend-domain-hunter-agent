#!/bin/bash

mkdir -p data reports prompts

# 5 trend oluştur
echo -e "AI Tools\nWeb3\nVR/AR\nQuantum Computing\nSaaS Automation" > data/trends.txt

# Her trende 10 marka adı üret
> data/generated_names.txt
while read trend; do
  for i in {1..10}; do
    echo "${trend}Brand${i}" >> data/generated_names.txt
  done
done < data/trends.txt

# Whois ile kontrol et ve sadece mevcut olanı kaydet
> data/available_domains.txt
while read name; do
  for ext in com ai; do
    domain="${name}.${ext}"
    if ! whois "$domain" >/dev/null 2>&1; then
      echo "$domain" >> data/available_domains.txt
    fi
  done
done < data/generated_names.txt

# Rapor oluştur
echo "# Trend Domain Hunter Report" > reports/final_report.md
echo "## Trends:" >> reports/final_report.md
cat data/trends.txt >> reports/final_report.md
echo "" >> reports/final_report.md
echo "## Generated Names:" >> reports/final_report.md
cat data/generated_names.txt >> reports/final_report.md
echo "" >> reports/final_report.md
echo "## Available Domains:" >> reports/final_report.md
cat data/available_domains.txt >> reports/final_report.md

echo "✅ Trend Domain Hunter script tamamlandı. Rapor: reports/final_report.md"
