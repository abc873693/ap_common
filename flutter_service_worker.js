'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js_10.part.js": "b0a6dde11b36670a33558adc38cb1b2e",
"main.dart.js_1.part.js": "c25da22c130376e91bc40ea19da1f3a2",
"assets/AssetManifest.json": "0b770d9fbb749704d1f167a1d4e01a29",
"assets/assets/scores.json": "b612e6a3265548bf7fbc53a043e37502",
"assets/assets/notifications.json": "53eed3eb240122efedf6e67cb84e3ef4",
"assets/assets/user_info.json": "f6b5f245a2a1cde332a94739842b0177",
"assets/assets/semesters.json": "3cef353243f9918a2096f7a220a98109",
"assets/assets/coursetable.json": "f72a76c4d1cf31de4f0c75d71f046e64",
"assets/assets/images/section_first2.webp": "7b073c7d07ad1fd4d858c8e8b9031b9d",
"assets/assets/images/section_qijin.webp": "f2a896089897436f6c44b4fb57a6f6fa",
"assets/assets/images/section_yanchao.webp": "c654b2abef56dbf8fec81adc5dc718ad",
"assets/assets/images/kuasap.webp": "1cd641961a31024e387699f0b6e046fc",
"assets/assets/images/kuasap3.webp": "8f3ad6f20518bcaca760eaad341ff63a",
"assets/assets/images/drawer-icon.webp": "22c87aae3602816ad4f8d2151d132117",
"assets/assets/images/kuasap_text.webp": "eb2eb2e99c8580fb9ff656de920c5742",
"assets/assets/images/kuasap2.webp": "534201f2529ea74ae1256b4c24d760b6",
"assets/assets/images/K.webp": "b5282cfbb87d76d24f82745357aedcde",
"assets/assets/images/section_nanzi.webp": "5685b7e80bb1bb08185c0a6005ed515d",
"assets/assets/images/section_jiangong.webp": "7c96a64e3ba20d55d37bb73c16e63d6d",
"assets/assets/images/section_first1.webp": "7869ad4259db5e81c43f72efb57e8ea6",
"assets/NOTICES": "79a4424433416b162ef93f24d902d16b",
"assets/packages/ap_common_flutter_ui/assets/images/drawer_background_dark.webp": "6fcbe652fd6c285eb60996875fdc076f",
"assets/packages/ap_common_flutter_ui/assets/images/nkutst_itc.webp": "39be02173d8ce4add0e5f987ed1c0e4d",
"assets/packages/ap_common_flutter_ui/assets/images/dash_line_dark.webp": "496ec80bebb732e39bc822082344bfef",
"assets/packages/ap_common_flutter_ui/assets/images/fb.webp": "a2798761b05c0b389ba03920fb9c9fe5",
"assets/packages/ap_common_flutter_ui/assets/images/nsysu_gdsc.png": "e268c6cfc5ef0f74cd76470671d30a69",
"assets/packages/ap_common_flutter_ui/assets/images/email.webp": "2315a6976d77044aa5c20e05b4c5c21c",
"assets/packages/ap_common_flutter_ui/assets/images/github.webp": "79ff1629aa4f57c767b7fe163743ddf4",
"assets/packages/ap_common_flutter_ui/assets/images/drawer_background_light.webp": "bfd35bb1208613a9dda8cea3261ee813",
"assets/packages/ap_common_flutter_ui/assets/images/instagram.png": "5dfa6665c75960a074bf3029ebfd5b70",
"assets/packages/ap_common_flutter_ui/assets/images/dash_line_light.webp": "ac0f479db7ab22ebf7e2a04a5c17b74e",
"assets/packages/ap_common_flutter_ui/assets/icons/barcode.png": "38db3163e28387c37b02078bd1c9dd8d",
"assets/packages/ap_common_flutter_ui/assets/icons/qrcode.png": "8639d3523c7b695a4d18b06f9e31ec1a",
"assets/packages/ap_common_flutter_ui/assets/icons/calendar_import.png": "30085b26b9ff01989965276970dea537",
"assets/AssetManifest.bin.json": "df54525a50ff9a1b09c5f09390101e79",
"assets/fonts/MaterialIcons-Regular.otf": "a767c40ab19ee213f5e1663c350fa42d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "f09c6ae0b122f85074f3dc538ade284e",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"index.html": "bae41c08d0d328776590586398031e49",
"/": "bae41c08d0d328776590586398031e49",
"manifest.json": "e2f34746c7c5bfe2a035a3645068c9cd",
"flutter_bootstrap.js": "4e56246b075b647ec32093d5f041a584",
"main.dart.js": "752ccd2408532db67e02936df98bd994",
"favicon.ico": "7db418a94cf88b41bc22e274a39a9112",
"main.dart.js_8.part.js": "5f496bfe5ec01b7a538d42ca47940137",
"main.dart.js_2.part.js": "f5cc61b15682c80167fdb3711911a98b",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"version.json": "b88e64fecf85c96634c653e2683d4b71",
"icons/Icon-maskable-512.png": "300e5d3a398bc58a95de678decddda39",
"icons/Icon-maskable-192.png": "c6f1fbe2f7298bc5b9de50115b4c675d",
"icons/Icon-192.png": "c6f1fbe2f7298bc5b9de50115b4c675d",
"icons/Icon-512.png": "300e5d3a398bc58a95de678decddda39",
"main.dart.js_6.part.js": "e8b5ec189456d5943a033daa391e7519"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
