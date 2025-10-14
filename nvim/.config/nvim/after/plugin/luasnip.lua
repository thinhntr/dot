local ls = require("luasnip")

ls.add_snippets("go", {
  ls.parser.parse_snippet("iferr", "if err != nil $1 {\n\treturn err$0\n}"),
})
