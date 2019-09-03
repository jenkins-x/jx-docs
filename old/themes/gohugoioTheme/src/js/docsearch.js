var docsearch = require('docsearch.js/dist/cdn/docsearch.js');
docsearch({ 
  apiKey: '8904bbd3ca621bef472e3de7e0e29532', 
  indexName: 'jenkins_x', 
  inputSelector: '#search-input', 
  algoliaOptions: { 'facetFilters': ["en-us"] },
  debug: false
});