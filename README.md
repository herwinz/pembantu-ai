
# 📊 **Real-Time Azure App Service Log Simulator**

**Proyek ini bertujuan untuk menghasilkan data log real-time yang menyerupai output dari Azure Monitor API. Data log ini digunakan untuk penelitian *"Cloud Sizing Automation for Platform as a Service (PaaS) based on Historical Analysis"* pada Azure App Service.**

---

## 🚀 **Fitur Utama**

1. **Metrik yang Dicatat**:
   - **CPU Usage**: Persentase penggunaan CPU.
   - **Memory Usage**: Penggunaan memori dalam bytes.
   - **Request Count**: Jumlah permintaan per interval.
   - **Latency**: Durasi rata-rata permintaan dalam milidetik.

2. **Format Data Log**:
   Data log disimpan dalam **format JSON** agar mudah dianalisis menggunakan berbagai tools seperti Python, Grafana, atau Azure Dashboard.

   **Contoh Data Log**:
   ```json
   {
     "timestamp": "2024-06-17T12:30:45Z",
     "metrics": {
       "CPU_Percent": 73.5,
       "Memory_Bytes": 2147483648,
       "Request_Count": 2100,
       "Latency_ms": 123.5
     }
   }
   ```

3. **Automasi dengan GitHub Actions**:
   - Workflow berjalan **setiap menit** untuk menghasilkan data log.
   - Script otomatis memperbarui file log dan melakukan commit serta push ke repository.

---

## 📂 **Struktur Repository**

```
pembantu-ai/
├── logs/
│   └── azure_monitor_log.json      # File log real-time
├── scripts/
│   └── auto_log_update.sh          # Script untuk generate log
├── .github/
│   └── workflows/
│       └── realtime_logs.yml       # Workflow GitHub Actions
└── README.md                       # Dokumentasi proyek
```

---

## 🛠️ **Cara Kerja**

### **1. Script Utama: auto_log_update.sh**
Script ini bertanggung jawab untuk:
- Mensimulasikan **data metrik** mirip dengan Azure Monitor.
- Menambahkan data baru ke file `logs/azure_monitor_log.json`.
- Melakukan **commit** dan **push** otomatis ke GitHub.

**Contoh Script**:
```bash
#!/bin/bash

# File log
LOG_FILE="logs/azure_monitor_log.json"

# Simulasi waktu UTC
CURRENT_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Simulasi data metrik
CPU_PERCENT=$(awk -v min=10 -v max=95 'BEGIN{srand(); print min+rand()*(max-min)}')
MEMORY_BYTES=$((RANDOM % 5000000000 + 1000000000))
REQUEST_COUNT=$((RANDOM % 2000 + 500))
LATENCY_MS=$(awk -v min=50 -v max=500 'BEGIN{srand(); print min+rand()*(max-min)}')

# Format JSON
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

# Commit dan push ke GitHub
git add $LOG_FILE
git commit -m "Real-time Log Update: $CURRENT_TIME"
git push origin main
```

---

### **2. Workflow GitHub Actions: realtime_logs.yml**
Workflow ini dijalankan **setiap menit** menggunakan `cron` scheduler di GitHub Actions.

**Contoh Workflow**:
```yaml
name: Real-Time Azure Log Simulation

on:
  schedule:
    - cron: "*/1 * * * *"  # Update setiap 1 menit
  workflow_dispatch:        # Bisa dijalankan manual

jobs:
  real-time-logger:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Setup Git
        run: |
          git config --global user.name "herwinz"
          git config --global user.email "berlianherwindra@gmail.com"

      - name: Run Real-Time Log Update
        run: |
          chmod +x scripts/auto_log_update.sh
          ./scripts/auto_log_update.sh
```

---

## 📊 **Output Data Log**

File **`logs/azure_monitor_log.json`** akan diperbarui setiap menit dengan entry JSON baru seperti berikut:
```json
{
  "timestamp": "2024-06-17T12:30:45Z",
  "metrics": {
    "CPU_Percent": 73.5,
    "Memory_Bytes": 2147483648,
    "Request_Count": 2100,
    "Latency_ms": 123.5
  }
}
```

---

## 📈 **Analisis Data Log**
Data log ini bisa digunakan untuk:
- Analisis historis penggunaan sumber daya.
- Pengoptimalan auto-scaling berbasis **CPU, Memori, dan Request Count**.
- Visualisasi menggunakan **Grafana**, **Python**, atau **Azure Dashboard**.

---

## 🚀 **Kontribusi dan Pengembangan Lanjutan**
Jika kamu ingin berkontribusi:
1. Fork repository ini.
2. Buat branch baru untuk fitur atau perbaikan.
3. Submit **Pull Request**.

---

## 🧑‍💻 **Tentang Proyek Ini**
Proyek ini dikembangkan untuk membantu penelitian **Cloud Sizing Automation for PaaS** dengan menghasilkan data log simulasi yang realistis.

**Dikembangkan oleh**: [Berlian Herwindra](mailto:berlianherwindra@gmail.com)

---
