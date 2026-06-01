const http = require("http");
const fs = require("fs");
const path = require("path");

const root = __dirname;
const port = 8787;

const types = {
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".webp": "image/webp",
  ".glb": "model/gltf-binary",
  ".gltf": "model/gltf+json"
};

function send(res, status, body, type = "text/plain; charset=utf-8") {
  res.writeHead(status, {
    "Content-Type": type,
    "Access-Control-Allow-Origin": "*"
  });
  res.end(body);
}

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://127.0.0.1:${port}`);
  const decoded = decodeURIComponent(url.pathname);
  const safePath = path.normalize(decoded).replace(/^(\.\.[/\\])+/, "");
  const filePath = path.join(root, safePath === "/" ? "bone-debug-preview.html" : safePath);

  if (!filePath.startsWith(root)) {
    send(res, 403, "Forbidden");
    return;
  }

  fs.readFile(filePath, (err, data) => {
    if (err) {
      send(res, 404, "Not found");
      return;
    }
    send(res, 200, data, types[path.extname(filePath).toLowerCase()] || "application/octet-stream");
  });
});

server.listen(port, "127.0.0.1", () => {
  console.log(`Bone debug preview: http://127.0.0.1:${port}/bone-debug-preview.html`);
});
