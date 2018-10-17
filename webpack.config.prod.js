const CopyWebpackPlugin = require('copy-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = {
    mode: 'production',
    module: {
        rules: [
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]'
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    { loader: "elm-webpack-loader"
                     , options: {
                         debug: false,
                         optimize: true
                     }}
                ],
            }
        ]
    },

    plugins: [
        new CleanWebpackPlugin(),
        new CopyWebpackPlugin([
            { from: 'src/assets', to: 'assets'}
        ])
    ],

    optimization: {
        minimizer: [
            new UglifyJsPlugin({
                uglifyOptions: {
                    ecma: 5,
                    compress: {
                        dead_code: true,
                        pure_getters: true,
                        keep_fargs: false,
                        unsafe: true,
                        unsafe_comps: true,
                        pure_funcs: [
                            '_elm_lang$core$Native_Utils.update',
                            'A2',
                            'A3',
                            'A4',
                            'A5',
                            'A6',
                            'A7',
                            'A8',
                            'A9',
                            'F2',
                            'F3',
                            'F4',
                            'F5',
                            'F6',
                            'F7',
                            'F8',
                            'F9'
                        ]
                    }
                }

            })
        ]
    }
};
