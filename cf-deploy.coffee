module.exports = (cfDeploy) ->
    buildpack: 'nodejs_v4_4_4_buildpack'
    deployable: '.'
    deployer: cfDeploy.deployers.awsDeployment
    diskLimit: '256M'
    memoryLimit: '256M'
    route: 'org-explorer'
    domain: 'mcf-np.local'
    startupCommand: 'npm start'
    environment:
        github_url: process.env.github_url
        github_user: process.env.github_user
        github_pac: process.env.github_pac
