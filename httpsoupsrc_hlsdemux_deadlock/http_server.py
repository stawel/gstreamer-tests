import http.server
import socketserver
import os
import time

PORT = 8000

class DelayedFileHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        filepath = super().translate_path(self.path)
        print(filepath)
        if not filepath.endswith("/") and not os.path.isfile(filepath):
            print("sleep: 2s")
            time.sleep(2)
            self.send_error(404, "File not found")
        else:
            super().do_GET()

if __name__ == "__main__":
    handler = DelayedFileHandler
    with socketserver.TCPServer(("", PORT), handler) as httpd:
        print(f"port: {PORT}")
        httpd.serve_forever()
