from flask import Flask, request, jsonify
from flask_cors import CORS
import yt_dlp
import os

app = Flask(__name__)
CORS(app)  # PovolĂ­ doplĹku komunikovat se serverem

# Cesta do sloĹľky Downloads (Windows)
DOWNLOAD_PATH = os.path.join(os.path.expanduser('~'), 'Downloads')

@app.route('/download', methods=['POST'])
def download():
    data = request.json
    video_url = data.get('url')
    
    if not video_url:
        return jsonify({"error": "ChybĂ­ URL"}), 400

    ydl_opts = {
        'format': 'best',
        'outtmpl': os.path.join(DOWNLOAD_PATH, '%(title)s.%(ext)s'),
    }

    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            ydl.download([video_url])
        return jsonify({"message": "StahovĂˇnĂ­ zahĂˇjeno!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    print(f"Server bÄ›ĹľĂ­ a bude stahovat do: {DOWNLOAD_PATH}")
    app.run(port=5000)
