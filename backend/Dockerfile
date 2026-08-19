# Gunakan Python versi ringan
FROM python:3.9-slim

# Install ffmpeg (wajib untuk yt-dlp memproses video)
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# Atur folder kerja
WORKDIR /app

# Copy file requirements dan install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy semua file Python kamu
COPY . .

# Hugging Face mewajibkan server berjalan di port 7860
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]