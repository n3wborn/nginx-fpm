const Encore = require("@symfony/webpack-encore");
const PurgeCssPlugin = require("purgecss-webpack-plugin");
const glob = require("glob-all");
const path = require("path");

if (!Encore.isRuntimeEnvironmentConfigured()) {
  Encore.configureRuntimeEnvironment(process.env.NODE_ENV || "dev");
}

Encore.setOutputPath("public/build/")
  .setPublicPath("/build")
  // https://devscast.tech/posts/tailwindcss-jit-symfony-16
  .enablePostCssLoader((config) => {
    config.postcssOptions = {
      path: "./postcss.config.js",
    };
  })

  .addEntry("app", "./assets/app.js")

  .enableStimulusBridge("./assets/controllers.json")
  .splitEntryChunks()
  .enableSingleRuntimeChunk()
  .cleanupOutputBeforeBuild()
  .enableBuildNotifications()
  .enableSourceMaps(!Encore.isProduction())
  .enableVersioning(Encore.isProduction())

  .configureBabel((config) => {
    config.plugins.push("@babel/plugin-proposal-class-properties");
  })

  .configureBabelPresetEnv((config) => {
    config.useBuiltIns = "usage";
    config.corejs = 3;
  })

  .enableTypeScriptLoader();

if (Encore.isProduction()) {
  Encore.addPlugin(
    new PurgeCssPlugin({
      paths: glob.sync([path.join(__dirname, "templates/**/*.html.twig")]),
      defaultExtractor: (content) => {
        return content.match(/[\w-/:]+(?<!:)/g) || [];
      },
    })
  );
}

module.exports = Encore.getWebpackConfig();
