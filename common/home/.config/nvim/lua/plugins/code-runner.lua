return {
  {
    "CRAG666/code_runner.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
      require("code_runner").setup({
        -- Usa un terminal flotante (puedes cambiar a "tab" o "term")
        mode = "toggleterm",
        focus = true,
        startinsert = true,

        filetype = {
          -- Java: compila y corre el archivo actual (modo single-file)
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt",
          },
          -- C++: compila con g++ y corre
          cpp = {
            "cd $dir &&",
            "g++ -std=c++17 -Wall -o /tmp/$fileNameWithoutExt $fileName &&",
            "/tmp/$fileNameWithoutExt",
          },
          -- C: igual pero con gcc
          c = {
            "cd $dir &&",
            "gcc -Wall -o /tmp/$fileNameWithoutExt $fileName &&",
            "/tmp/$fileNameWithoutExt",
          },
          javascript = "node $file",
          typescript = "deno run $file",
          javascriptreact = "node $file",
          typescriptreact = "deno run $file",
          python = "python3 $file",
          rust = "cd $dir && cargo run",
          sh = "bash $file",
        },

        -- Para proyectos (Maven / Gradle / CMake)
        project = {
          -- Detecta proyectos Java con Maven
          ["pom.xml"] = {
            name = "Maven",
            command = "mvn compile exec:java",
          },
          -- Detecta proyectos Java con Gradle
          ["build.gradle"] = {
            name = "Gradle",
            command = "./gradlew run",
          },
          ["build.gradle.kts"] = {
            name = "Gradle (Kotlin DSL)",
            command = "./gradlew run",
          },
          -- CMake para C/C++
          ["CMakeLists.txt"] = {
            name = "CMake",
            command = "cmake -B build && cmake --build build && ./build/$(basename $PWD)",
          },
        },
      })
    end,

    keys = {
      -- Bajo <leader>c (grupo Code ya existente en LazyVim)
      -- ce y cE están libres; evitamos los slots ya ocupados
      { "<leader>ce", "<cmd>RunCode<CR>",    desc = "Execute (run file)" },
      { "<leader>cE", "<cmd>RunProject<CR>", desc = "Execute Project" },
    },
  },
}
