#!/bin/bash

echo "📦 Creo cartelle e manifesto..."

# Crea cartelle icone
mkdir -p static/icons

# Copia il TUO logo (personalizzato con contorno nero)
cp tuo_logo_192.png static/icons/logo-192.png
cp tuo_logo_512.png static/icons/logo-512.png

# Manifest JSON
cat > static/manifest.json <<EOF
{
  "name": "Tesserino Digitale",
  "short_name": "Tesserino",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#000000",
  "icons": [
    {
      "src": "/static/icons/logo-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/static/icons/logo-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
EOF

# Service worker base
cat > static/service-worker.js <<EOF
self.addEventListener('install', e => {
  e.waitUntil(
    caches.open('wbbs-cache').then(cache => {
      return cache.addAll(['/']);
    })
  );
});
self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(response => response || fetch(e.request))
  );
});
EOF

echo -e "\n✅ Fatto! Ora inserisci queste due righe nel <head> del tuo layout.html:\n"

echo '<link rel="manifest" href="{{ url_for(\'static\', filename=\'manifest.json\') }}">'
echo '<script>navigator.serviceWorker.register("/static/service-worker.js")</script>'

echo -e "\n✨ La tua app è ora installabile da mobile come un’app nativa!"

