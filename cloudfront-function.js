// Umleitung von https://www.iubh-aws-projekt.com auf https://iubh-aws-projekt.com
function handler(event) {
    // Die eingehende Anfrage
    var request = event.request;
    // Die aufgerufene Domain
    var hostHeader = request.headers.host.value;

    // Herausfiltern der Domain (hier wird bspw. www.iubh-aws-projekt.com zu iubh-aws-projekt.com)
    var domainRegex = /(?:.*\.)?([a-z0-9\-]+\.[a-z]+)$/i;
    var match = hostHeader.match(domainRegex);
    // Liegt kein match vor, oder die Domain startet nicht mit .www, dann wird keine Weiterleitung vorgenommen
    if (!match || !hostHeader.startsWith('www.')) {
        return request;
    }
    var rootDomain = match[1];

    // Erstellung der URL für die Weiterleitung (https://iubh-aws-projekt.com)
    return {
        statusCode: 301,
        statusDescription: 'Moved Permanently',
        headers: {
            "location": { "value": "https://" + rootDomain + request.uri },
            "cache-control": { "value": "max-age=3600" }
        }
    };
}