addEventListener("fetch", event => {
  event.respondWith(handle(event.request));
});

var csp = [
  "default-src 'none'",
  "style-src www.w3.org",
  "upgrade-insecure-requests",
  "report-uri https://nosborn.report-uri.com/r/d/csp/enforce"
];

async function handle(request) {
  let response = await fetch(request);
  response = new Response(response.body, response);

  let url = new URL(request.url);
  let wkdRegExp = new RegExp(/\.well-known\/openpgpkey\/hu\//);
  if (wkdRegExp.test(url.pathname)) {
    response.headers.set("Access-Control-Allow-Origin", "*");
  }

  response.headers.set("Content-Security-Policy", csp.join("; "));
  response.headers.set("Referrer-Policy", "same-origin");
  response.headers.set("X-Frame-Options", "SAMEORIGIN");
  response.headers.set("X-XSS-Protection", "1; mode=block");

  return response;
}
