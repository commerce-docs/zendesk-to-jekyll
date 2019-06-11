This simple Ruby script converts a JSON file returned by [Magento Help Center](https://support.magento.com/hc/en-us) ZenDesk API to Jekyll format using kramdown library.
To be able to use it, you'll need the kramdown gem:

```bash
gem install kramdown
```

Now, if you want to generate Jekyll topics from a JSON file _how-to.json_ that contains ZenDesk API response with several topics, try this:

```bash
ruby zendesk-to-jekyll.rb how-to.json
```
