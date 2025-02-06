// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: [
        finicky.matchHostnames(["linkedin.com"]),
        "*.linkedin.com/*",

        finicky.matchHostnames(["youtube.com"]),
        "*.youtube.com/*",
        finicky.matchHostnames(["youtu.be"]),
        "*.youtu.be/*",

        finicky.matchHostnames(["rescuetime.com"]),
        "*.rescuetime.com/*"
      ],
      browser: "Safari"
    }
  ]
}
