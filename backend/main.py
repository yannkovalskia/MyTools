from fastapi import FastAPI, File, UploadFile, Response, Form
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
from rembg import remove
from PIL import Image
import io
import os
import tempfile
import yt_dlp

app = FastAPI(
    title="MyTools API",
    description="Backend API untuk Aplikasi Android Multi-Tools"
)

# Agar API bisa diakses dari HP lokal atau device lain
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def home():
    return {"status": "success", "message": "MyTools Backend API is Running!"}

@app.post("/api/remove-bg")
async def remove_background(file: UploadFile = File(...)):
    
    input_bytes = await file.read()
    output_bytes = remove(input_bytes)
    
    return Response(
        content=output_bytes,
        media_type="image/png",
        headers={
            "Content-Disposition": f'attachment; filename="removed_{file.filename}.png"'
        }
    )

@app.post("/api/upscale")
async def upscale_image(
    file: UploadFile = File(...), 
    scale: int = Form(...)  # Menerima pilihan 2, 4, atau 8 dari Flutter
):
    # 1. Baca gambar yang diupload
    input_bytes = await file.read()
    image = Image.open(io.BytesIO(input_bytes)).convert("RGB")
    
    # 2. Hitung resolusi baru
    new_width = image.width * scale
    new_height = image.height * scale
    
    # 3. Proses Upscale (Menggunakan Lanczos sbg placeholder High-Quality AI)
    # TODO: Bisa diganti dengan inference Real-ESRGAN/OpenCV DNN di kemudian hari
    upscaled_image = image.resize((new_width, new_height), Image.Resampling.LANCZOS)
    
    # 4. Convert kembali ke bytes
    output_buffer = io.BytesIO()
    upscaled_image.save(output_buffer, format="PNG")
    
    # 5. Kembalikan file PNG hasil upscale
    return Response(
        content=output_buffer.getvalue(),
        media_type="image/png",
        headers={
            "Content-Disposition": f'attachment; filename="upscaled_{scale}x_{file.filename}.png"'
        }
    )


@app.post("/api/download-video")
async def download_video(url: str = Form(...)):
    try:
        # 1. Buat folder temporary (sementara) untuk menyimpan hasil download
        temp_dir = tempfile.mkdtemp()
        
        # 2. Atur konfigurasi yt-dlp
        ydl_opts = {
            'outtmpl': os.path.join(temp_dir, '%(title)s.%(ext)s'),
            'format': 'best',          # Ambil kualitas video + audio terbaik
            'quiet': True,             # Sembunyikan log panjang di terminal
            'noplaylist': True,        # Hanya unduh 1 video meskipun linknya playlist
        }
        
        # 3. Proses ekstraksi dan download
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            downloaded_file_path = ydl.prepare_filename(info)
        
        # 4. Kirim kembali file videonya ke aplikasi Flutter
        return FileResponse(
            path=downloaded_file_path, 
            filename=os.path.basename(downloaded_file_path),
            media_type='video/mp4'
        )
        
    except Exception as e:
        return {"status": "error", "message": f"Gagal mengunduh: {str(e)}"}