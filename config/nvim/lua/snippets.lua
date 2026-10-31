-- ~/.config/nvim/lua/snippets.lua
-- Только свои сниппеты (апстрим-примеры luasnip убраны)

local ls = require("luasnip")
-- короткие алиасы...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local types = require("luasnip.util.types")

-- Остальные опции — по умолчанию.
ls.config.set_config(
    {
        history = true,
        -- Обновлять чаще, подробнее в :h events.
        updateevents = "TextChanged,TextChangedI",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = {{"choiceNode", "Comment"}}
                }
            }
        },
        -- У treesitter-hl приоритет 100, берём выше (по умолчанию 200).
        ext_base_prio = 300,
        -- минимальный шаг приоритета.
        ext_prio_increase = 1,
        enable_autosnippets = true
    }
)

--
-- Snippets by Koljasha
--

ls.add_snippets(
    "python",
    {
        -- шебанг
        s(
            "#!",
            {
                t({"#!/usr/bin/env "}),
                i(1, "python"),
                t({"", "", ""}),
                i(0)
            }
        ),
        -- шаблон __main__
        s(
            "ifmain",
            {
                t({"", "", ""}),
                t({"def main("}),
                i(1),
                t({"):"}),
                t({"", "\t"}),
                i(2, "pass"),
                t({"", "", "if __name__ == '__main__':"}),
                t({"", "\t"}),
                t({"main()"}),
                t({"", ""}),
                i(0)
            }
        ),
        -- функция python
        s(
            "def",
            {
                t({"def "}),
                i(1, "functionName"),
                t({"("}),
                i(2),
                t({"):"}),
                t({"", "\t"}),
                i(3, "pass"),
                t({"", ""}),
                i(0)
            }
        ),
        -- класс python
        s(
            "class",
            {
                t({"class "}),
                i(1, "ClassName"),
                t({"("}),
                i(2),
                t({"):"}),
                t({"", "\t"}),
                t({"def __init__(self"}),
                i(3),
                t({"):"}),
                t({"", "\t\t"}),
                i(4, "pass"),
                t({"", ""}),
                i(0)
            }
        )
    },
    {
        key = "python"
    }
)

ls.add_snippets(
    "sh",
    {
        -- шебанг
        s(
            "#!",
            {
                t({"#!/usr/bin/env "}),
                i(1, "bash"),
                t({"", "", ""}),
                i(0)
            }
        )
    },
    {
        key = "sh"
    }
)

ls.add_snippets(
    "html",
    {
        -- шаблон html:5
        s(
            "html:5",
            {
                t({"<!DOCTYPE html>", '<html lang="ru">', "<head>"}),
                t({"", '\t<meta charset="utf-8" />'}),
                t({"", "\t<title>"}),
                i(1, "MySite"),
                t({"</title>"}),
                t({"", '\t<meta name="viewport" content="width=device-width, initial-scale=1.0" />'}),
                t({"", "</head>", "<body>"}),
                t({"", ""}),
                i(0),
                t({"", "</body>", "</html>"})
            }
        )
    },
    {
        key = "html"
    }
)
