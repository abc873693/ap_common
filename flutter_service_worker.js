'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.ico": "7db418a94cf88b41bc22e274a39a9112",
"manifest.json": "e3544538ffa9733454cdcfe84a0052b4",
"icons/Icon-192.png": "c6f1fbe2f7298bc5b9de50115b4c675d",
"icons/Icon-512.png": "300e5d3a398bc58a95de678decddda39",
"assets/NOTICES": "7292072f430337b925d36b4dded9d770",
"assets/assets/images/drawer-icon.webp": "22c87aae3602816ad4f8d2151d132117",
"assets/assets/images/kuasap3.webp": "8f3ad6f20518bcaca760eaad341ff63a",
"assets/assets/images/section_jiangong.webp": "7c96a64e3ba20d55d37bb73c16e63d6d",
"assets/assets/images/kuasap2.webp": "534201f2529ea74ae1256b4c24d760b6",
"assets/assets/images/section_first2.webp": "7b073c7d07ad1fd4d858c8e8b9031b9d",
"assets/assets/images/section_yanchao.webp": "c654b2abef56dbf8fec81adc5dc718ad",
"assets/assets/images/section_first1.webp": "7869ad4259db5e81c43f72efb57e8ea6",
"assets/assets/images/section_nanzi.webp": "5685b7e80bb1bb08185c0a6005ed515d",
"assets/assets/images/section_qijin.webp": "f2a896089897436f6c44b4fb57a6f6fa",
"assets/assets/images/kuasap_text.webp": "eb2eb2e99c8580fb9ff656de920c5742",
"assets/assets/images/K.webp": "b5282cfbb87d76d24f82745357aedcde",
"assets/assets/images/kuasap.webp": "1cd641961a31024e387699f0b6e046fc",
"assets/assets/coursetable.json": "c7b2ecfdc135f36b515f9b6088df8660",
"assets/assets/user_info.json": "f6b5f245a2a1cde332a94739842b0177",
"assets/assets/scores.json": "b612e6a3265548bf7fbc53a043e37502",
"assets/assets/semesters.json": "3cef353243f9918a2096f7a220a98109",
"assets/assets/notifications.json": "c7bd6350f8e6d3ed2788eaff71b956e7",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/AssetManifest.json": "6cbcf501c87bab0c3fa185c4b47699e6",
"assets/packages/ap_common/assets/icons/barcode.png": "38db3163e28387c37b02078bd1c9dd8d",
"assets/packages/ap_common/assets/icons/calendar-import.png": "30085b26b9ff01989965276970dea537",
"assets/packages/ap_common/assets/icons/qrcode.png": "8639d3523c7b695a4d18b06f9e31ec1a",
"assets/packages/ap_common/assets/images/dash_line.webp": "ac0f479db7ab22ebf7e2a04a5c17b74e",
"assets/packages/ap_common/assets/images/dash_line_dark_theme.webp": "496ec80bebb732e39bc822082344bfef",
"assets/packages/ap_common/assets/images/ic_email.webp": "2315a6976d77044aa5c20e05b4c5c21c",
"assets/packages/ap_common/assets/images/drawer-background.webp": "bfd35bb1208613a9dda8cea3261ee813",
"assets/packages/ap_common/assets/images/kuas_itc.webp": "39be02173d8ce4add0e5f987ed1c0e4d",
"assets/packages/ap_common/assets/images/ic_github.webp": "79ff1629aa4f57c767b7fe163743ddf4",
"assets/packages/ap_common/assets/images/drawer-background-dark-theme.webp": "6fcbe652fd6c285eb60996875fdc076f",
"assets/packages/ap_common/assets/images/kuasap_text.webp": "eb2eb2e99c8580fb9ff656de920c5742",
"assets/packages/ap_common/assets/images/ic_fb.webp": "a2798761b05c0b389ba03920fb9c9fe5",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"main.dart.js_2.part.js": "46bdd342b7c54b864e63b66a121225c8",
"index.html": "0269559bd27253f87d68cad9ffa64c62",
"/": "0269559bd27253f87d68cad9ffa64c62",
"main.dart.js_3.part.js": "ca30850b33e7231dbeb4faee9a1fe285",
"main.dart.js": "60636ab7d0845b8f2f90ea3f2de71544",
"main.dart.js_1.part.js": "b391fce138ca379e22c0f05555d26f89",
"version.json": "8a96bed33dc67aeed6374372b5590a59"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
