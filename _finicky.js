// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: ({ url }) => {
        const domains = [
          "linkedin.com",
          "instagram.com",
          "youtube.com",
          "youtu.be",
          "rescuetime.com",
          "facebook.com",
          "x.com",
        ];
        // finicky.log("Checking Host: " + url.host);


        return domains.some(domain => url.host === domain || url.host.endsWith(domain))
      },

      browser: "Safari"
    }
  ]
}
