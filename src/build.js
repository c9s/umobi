({
    // appDir: '.',
    // dir: '../compiled',
    baseUrl: '.',

    findNestedDependencies: true,
    skipModuleInsertion: true,

    //Uncomment to turn off uglify minification.
    //optimize: 'none',
    name: 'umobi',
    exclude: ['coffee-script','jquery'],
    out: 'umobi.min.js',

    //Stub out the cs module after a build since
    //it will not be needed.
    stubModules: ['cs'],
    paths: {
        'cs' :'cs',
        'coffee-script': 'coffee-script',
    },

    /*
    modules: [
        {
            name: 'main',
            exclude: ['coffee-script']
        }
    ]
    */
})
