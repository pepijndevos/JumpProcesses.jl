using Documenter, JumpProcesses

docpath = Base.source_dir()
assetpath = joinpath(docpath, "src", "assets")
cp(joinpath(docpath, "Manifest.toml"), joinpath(assetpath, "Manifest.toml"), force = true)
cp(joinpath(docpath, "Project.toml"), joinpath(assetpath, "Project.toml"), force = true)

include("pages.jl")

mathengine = MathJax3(Dict(:loader => Dict("load" => ["[tex]/require", "[tex]/mathtools"]),
                           :tex => Dict("inlineMath" => [["\$", "\$"], ["\\(", "\\)"]],
                                        "packages" => [
                                            "base",
                                            "ams",
                                            "autoload",
                                            "mathtools",
                                            "require",
                                        ])))

makedocs(sitename = "JumpProcesses.jl",
         authors = "Chris Rackauckas",
         modules = [JumpProcesses],
         clean = true, doctest = false, linkcheck = true, warnonly = [:missing_docs],
         format = Documenter.HTML(; assets = ["assets/favicon.ico"],
                                  canonical = "https://docs.sciml.ai/JumpProcesses/",
                                  prettyurls = (get(ENV, "CI", nothing) == "true"),
                                  mathengine),
         pages = pages)

deploydocs(repo = "github.com/SciML/JumpProcesses.jl.git";
           push_preview = true)
