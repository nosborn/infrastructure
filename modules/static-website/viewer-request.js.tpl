function handler(event) {
  var request = event.request;

  if ([${redirect_hosts}].includes(request.headers.host.value.toLowerCase())) {
    return {
      headers: {
        location: {
          value: 'https://${host}' + request.uri,
        },
      },
      statusCode: 301,
      statusDescription: "Moved",
    };
  }

  return request;
}
