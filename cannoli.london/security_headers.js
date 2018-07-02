'use strict';

exports.handler = (event, context, callback) => {
  // Get contents of response.
  const response = event.Records[0].cf.response;
  const headers = response.headers;

  // Set new headers.
  headers['content-security-policy'] = [{
    key: 'Content-Security-Policy',
    value: 'default-src \'none\'; script-src \'self\' \'unsafe-eval\' \'unsafe-inline\' https://cdnjs.cloudflare.com https://code.jquery.com https://maxcdn.bootstrapcdn.com https://nominatim.openstreetmap.org https://unpkg.com; style-src \'self\' \'unsafe-inline\' https://cdnjs.cloudflare.com https://maxcdn.bootstrapcdn.com https://unpkg.com; img-src \'self\' data: https://*.tiles.mapbox.com https://api.mapbox.com https://cdnjs.cloudflare.com https://nominatim.openstreetmap.org https://unpkg.com; connect-src \'self\' https://*.tiles.mapbox.com https://unpkg.com; font-src https://cdnjs.cloudflare.com https://maxcdn.bootstrapcdn.com; upgrade-insecure-requests; report-uri https://nosborn.report-uri.com/r/d/csp/enforce'
  }];
  headers['expect-ct'] = [{
    key: 'Expect-CT',
    value: 'report-uri="https://nosborn.report-uri.com/r/d/ct/enforce", enforce, max-age=86400'
  }];
  headers['referrer-policy'] = [{
    key: 'Referrer-Policy',
    value: 'same-origin'
  }];
  headers['strict-transport-security'] = [{
    key: 'Strict-Transport-Security',
    value: 'max-age=63072000; includeSubdomains; preload'
  }];
  headers['x-content-type-options'] = [{
    key: 'X-Content-Type-Options',
    value: 'nosniff'
  }];
  headers['x-frame-options'] = [{
    key: 'X-Frame-Options',
    value: 'DENY'
  }];
  headers['x-xss-protection'] = [{
    key: 'X-XSS-Protection',
    value: '1; mode=block'
  }];

  // Return modified response.
  callback(null, response);
};
