from fastapi import FastAPI, File, UploadFile, Response
from fastapi.middleware.cors import CORSMiddleware
from rembg import remove
import io

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
    # 1. Baca gambar yang diupload
    input_bytes = await file.read()
    
    # 2. Proses hapus background dengan rembg
    output_bytes = remove(input_bytes)
    
    # 3. Kembalikan file PNG hasil transparan
    return Response(
        content=output_bytes,
        media_type="image/png",
        headers={
            "Content-Disposition": f'attachment; filename="removed_{file.filename}.png"'
        }
    )