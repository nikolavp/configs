// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: [
        finicky.matchHostnames(["linkedin.com"]),
        "*.linkedin.com/*"
      ],
      browser: "Safari"
    },
    {
      match: [
        finicky.matchHostnames(["youtube.com"]),
        "*.youtube.com/*"
      ],
      browser: "Safari"
    },
    {
      match: [
        finicky.matchHostnames(["rescuetime.com"]),
        "*.rescuetime.com/*"
      ],
      browser: "Safari"
    }
  ],

  rewrite: [
    {
      match: ({ url }) => url.protocol === "s3",
      url({ urlString, url }) {
        //if (urlString.search(/post-training-datasets.*parquet/) != -1) {
          //return {
               //protocol: "https",
               //host: "podium.poolsi.de",
               //pathname: `/dataset_viewer`,
               //search: `dataset_path=${urlString}`
          //};
        //}
        const bucket = url.host;
        let path = url.pathname.substring(1); // Remove the leading slash
        return {
             protocol: "https",
             host: "us-east-2.console.aws.amazon.com",
             pathname: `/s3/buckets/${bucket}`,
             search: `prefix=${path}`
        };
      }
    }
  ]
}
