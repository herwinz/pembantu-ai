#!/bin/bash

# File log
LOG_FILE="logs/azure_monitor_log.json"

# Loop untuk menambahkan 60 log entry dalam 1 menit
for i in {1..60}; do
  # Simulasi waktu UTC (seperti Azure Monitor)
  CURRENT_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  # Simulasi data metrik Azure App Service
  CPU_PERCENT=$(awk -v min=10 -v max=95 'BEGIN{srand(); print min+rand()*(max-min)}')  # 10% - 95%
  MEMORY_BYTES=$((RANDOM % 5000000000 + 1000000000))  # 1GB - 6GB
  REQUEST_COUNT=$((RANDOM % 2000 + 500))  # 500 - 2500 requests
  LATENCY_MS=$(awk -v min=50 -v max=500 'BEGIN{srand(); print min+rand()*(max-min)}')  # 50ms - 500ms

  # Format data sebagai JSON
  JSON_LOG_ENTRY=$(cat <<EOF
{
  "timestamp": "$CURRENT_TIME",
  "metrics": {
    "CPU_Percent": $CPU_PERCENT,
    "Memory_Bytes": $MEMORY_BYTES,
    "Request_Count": $REQUEST_COUNT,
    "Latency_ms": $LATENCY_MS
  }
}
EOF
)

  # Tambahkan log ke file
  echo "$JSON_LOG_ENTRY" >> $LOG_FILE

  # Tunggu 1 detik sebelum iterasi berikutnya
  sleep 1
done

# Commit dan push perubahan ke GitHub
git add $LOG_FILE
git commit -m "Real-time Log Update: $(date -u)"
git push origin main
