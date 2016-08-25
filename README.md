# Github Enterprise Org Explorer

UI to help with GHE org exploration and discovery.

# Why?

Github Enterprise is an amazing tool if you already know what you're looking for, but we've found that the exploration and discovery aspect of the product is really lacking.  The goal of this project is to create a simple and easy to deploy UI to help enterprise developers find out about the available organizations in their Github Enterprise instance.

# Requirements

This project was built internally and tested with:
- NPM `>=3.0.0`
- Node  `>=6.0.0`

Required environment variables on startup:
- `github_url` - The domain name (and port if needed) of your Github Enterprise instance in the format of `domain[:port]` without a protocol.  The Github API is via [basic auth](https://developer.github.com/v3/auth/#basic-authentication) so HTTPS is enforced.  Not using HTTPS for your Github Enterprise instance? Why the heck not?
- `github_user` - The user name of whoever will be running the UI.
- `github_pac` - A [personal access token](https://github.com/blog/1509-personal-api-tokens) from the provided user with the default grants.

Optional environment variables:
- `port` - Used to override the port that the application will start on

# Running in development mode

- Make sure your environment variables are set
- `npm i`
- `npm run dev`
- navigate to http://localhost:3099/

# Running in production

- `npm i`
- `npm run package`
- `npm prune --production`
- Push the final code wherever it needs to be (we use CloudFoundy so for us it's a push to the cloud.  For you it might be zipping up the current folder)
- Make sure your environment variables are set wherever the code is going to run
- `npm start` - If you're not running in something that will monitor your application I would suggest a tool like [forever](https://github.com/foreverjs/forever)
