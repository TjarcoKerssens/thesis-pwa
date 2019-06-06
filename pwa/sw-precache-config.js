module.exports = {
  staticFileGlobs: [
    'src/**/*',
    'manifest.json',
    'images/**/*'
  ],
  runtimeCaching: [
    {
      urlPattern: /\/@webcomponents\/webcomponentsjs\//,
      handler: 'fastest'
    }
  ]
};
