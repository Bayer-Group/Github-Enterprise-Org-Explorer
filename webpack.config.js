const webpack = require('webpack');
module.exports = {
    entry: "./public/scripts/main",
    module: {
        loaders: [
            {test: /.json/, loader: 'json'},
            {test: /.coffee$/, loader: 'coffee'},
            {test: /.cjsx$/, loaders: ['coffee', 'cjsx']}
        ]
    },
    resolve: {
        extensions: [
            '',
            '.js',
            '.json',
            '.coffee',
            '.cjsx'
        ]
    },
    devtool: "#source-map",
    output: {
        path: "./public/scripts/",
        filename: 'bundle.js'
    },
    plugins: [
        new webpack.DefinePlugin({
            'process.env': {
                NODE_ENV: '"production"'
            }
        }),
        new webpack.optimize.UglifyJsPlugin({minimize: true})
    ]
};