local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "gopls", "pylsp", "matlab_ls", "marksman", "clangd", "elixirls", "rust_analyzer" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.hls.setup {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "ormolu",
    },
  },
  single_file_support = true,
}

lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "/home/damianmelia/.local/share/nvim/mason/bin/jdtls", -- Ensure this is the correct path to your jdtls executable
    "-configuration",
    "/home/damianmelia/.cache/jdtls/config", -- Corrected path
    "-data",
    "/home/damianmelia/.cache/jdtls/workspace", -- Corrected path
  },
  filetypes = { "java" },

  init_options = {
    jvm_args = {},
    workspace = "/home/damianmelia/.cache/jdtls/workspace",
    java_home = "/usr/lib/jvm/java-21-openjdk-amd64", -- Replace with your JDK path
  },

  single_file_support = true,
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("pom.xml", "build.gradle", ".git")(fname) or vim.fn.getcwd()
  end,
}

lspconfig.prismals.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "prisma-language-server", "--stdio" },
  filetypes = { "prisma" },
  settings = {
    prisma = {
      prismaFmtBinPath = "",
    },
  },
}

lspconfig.pylsp.setup {
  on_attach = on_attach,
  on_init = on_init,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = true, executable = "pyflakes" },
        -- pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = capabilities,
}

lspconfig.racket_langserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "racket", "--lib", "racket-langserver" },
  filetypes = { "racket" },
  single_file_support = true,
}

lspconfig.texlab.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "texlab",
  },
  filetypes = { "tex", "bib" },

  settings = {
    texlab = {
      bibtexFormatter = "texlab",
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = false,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = {},
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false,
      },
    },
  },
}

lspconfig.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

-- elixir
lspconfig.elixirls.setup {
  cmd = { "/home/damianmelia/elixir-ls/language_server.sh" },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.sqlls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "ddl" },
}

lspconfig.matlab_ls.setup {
  settings = {
    matlab = {
      indexWorkspace = true,
      installPath = "/usr/local/MATLAB/R2024b",
      matlabConnectionTiming = "onStart",
      telemetry = false,
    },
  },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}
