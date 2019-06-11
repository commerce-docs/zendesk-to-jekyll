This simple Ruby script converts a JSON response returned by [Magento Help Center](https://support.magento.com/hc/en-us) ZenDesk API to [Jekyll](https://jekyllrb.com/) format using [kramdown](https://github.com/gettalong/kramdown) library.

You'll need the kramdown gem to use this:

```bash
gem install kramdown
```

Now, if you want to generate Jekyll topics from a JSON file _how-to.json_ that contains ZenDesk API response with several topics, try this:

```bash
ruby zendesk-to-jekyll.rb how-to.json
```

Find generated topics in the `output` directory.
