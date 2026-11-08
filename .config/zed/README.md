# Zed Local Secrets

To configure MCP servers requiring API keys or tokens in Zed, keep private tokens in your local configuration or environment:

```json
{
  "context_servers": {
    "stitch": {
      "headers": {
        "X-Goog-Api-Key": "<YOUR_KEY>"
      }
    },
    "Sanity": {
      "headers": {
        "Authorization": "Bearer <YOUR_TOKEN>"
      }
    }
  }
}
```
