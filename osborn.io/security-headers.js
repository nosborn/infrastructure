async function handleRequest(request) {
  let response = await fetch(request)
  response = new Response(response.body, response)
  response.headers.set("Content-Security-Policy", "default-src 'none'; style-src 'self'; upgrade-insecure-requests")
  response.headers.set("Permissions-Policy", "interest-cohort=()")
  response.headers.set("Referrer-Policy", "strict-origin-when-cross-origin")
  response.headers.set("X-Frame-Options", "DENY")
  response.headers.set("X-XSS-Protection", "1; mode=block")
  return response
}

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})
