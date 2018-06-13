'use strict';

exports.handler = (event, context, callback) => {
  // Get contents of response.
  const response = event.Records[0].cf.response;
  const headers = response.headers;

  // Set new headers 
  headers['expect-ct'] = [{key: 'Expect-CT', value: 'report-uri="https://nosborn.report-uri.com/r/d/ct/enforce", enforce, max-age=86400'}]; 
  headers['referrer-policy'] = [{key: 'Referrer-Policy', value: 'same-origin'}]; 
  headers['strict-transport-security'] = [{key: 'Strict-Transport-Security', value: 'max-age=63072000; includeSubdomains; preload'}]; 
  headers['x-content-type-options'] = [{key: 'X-Content-Type-Options', value: 'nosniff'}]; 
  headers['x-frame-options'] = [{key: 'X-Frame-Options', value: 'DENY'}]; 
  headers['x-xss-protection'] = [{key: 'X-XSS-Protection', value: '1; mode=block'}]; 
    
  // Return modified response.
  callback(null, response);
};
