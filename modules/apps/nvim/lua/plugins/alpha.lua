local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
local header = {
    "                       ▒▒▒▒▒▒▒                                   ",
    "                   ▒░░░░░░▒▒▒▓▓▓▒▒▒                              ",
    "                 ▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒                            ",
    "                 ░▒▓▓▓▓▓▓▓▒░▒▒▒▒▒▒░▒░░                           ",
    "                 ░▒▓▒▒░░▒▒░░░░░░░░░▓▓▒▒▒▒                        ",
    "                 ░░░░░░░░▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▓                        ",
    "                 ░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓                        ",
    "                   ▒▒▒▒▒▒░░░▒▒▒▒▒░▒▒▒▒▒▓                         ",
    "                    ▒▒▒▒▒▒░░░▒▒▒▓▓▓▒▒▒▒▓▓▓█                      ",
    "                     ▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▓███                   ",
    "                    ▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓█████▓                ",
    "                  ▓▓▓▓▓▒▒░░▒░▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓███▓▓            ",
    "                 ▓▓▓▓▓▒░░░░▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓███▓▒░▒░░░▒░░        ",
    "            ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░▒   ",
    "        ▓██▓▓▓▓▓▓▓░░░░░▒▓▓▓▓█▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒░░░░░░░░░░░░░░░▓▓▓  ",
    "    ▓▓████▓▓▓▓▓▓▓░░░░░░░░▓▓░░░░▓▓▓▒▒▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░▒▓▓▓  ",
    "   ░░░░░░░▓▓▓▓▓▓▒░░░░░▒▓▓▓▓▒▒░░░░░▒▒▒▒▓▓▓▓▒░░░░░▓░░░░░░░░░░░▓▓▓  ",
    " ░░░░░░░░░░░░▓▓▓░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▓▓░░░░░░░░░░░░░░░░░░░░░▒▓   ",
    "                                                                 ",
    "     ███████╗  ██████╗ ██╗   ██╗ ███╗ ██╗███╗   ███╗    ██╗      ",
    "     ██╔═══██║██╔═══██╗██║   ██║ ███║ ██║████╗ ████║    ██║      ",
    "     ██║   ██║██║   ██║██║   ██║ ╚██║ ██║██╔████╔██║    ██║      ",
    "     ██║   ██║██║   ██║╚██╗ ██╔╝  ╚═╝ ██║██║╚██╔╝██║    ╚═╝      ",
    "     ███████╔╝╚██████╔╝ ╚████╔╝       ██║██║ ╚═╝ ██║    ██╗      ",
    "     ╚══════╝  ╚═════╝   ╚═══╝        ╚═╝╚═╝     ╚═╝    ╚═╝      ",
}

local calculator = {
    "                 11+15=23                                        ",
    "                                       - Renaud-Dov Devers       ",
}

local japon = {
    "           Tu stop tes pornos japonais.                          ",
    "                                       - Renaud-Dov Devers       ",
}

local need = {
    "           On a besoin de plus de quotes, merci de les           ",
    "           envoyer a @orysse sur discord   - Fan2Dov             ",
}

local quotes = {calculator, japon, need}

function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

local function random_h ()
    math.randomseed(os.time())
    return quotes[math.random(#quotes)]
end

dashboard.section.header.val = TableConcat(header, random_h())
dashboard.section.header.padding = -2

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME| Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC<CR>"),
    -- dashboard.button( "l", "󰒲  > Lazy check" , ":Lazy check<CR>"),
    dashboard.button( "q", "󰩈  Quit", "<cmd>qa<CR>" ),
}

dashboard.section.buttons.padding = -1


-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
autocmd FileType alpha setlocal nofoldenable
]])
