let SessionLoad = 1
if &cp | set nocp | endif
noremap  :call HighLightToggleHandler()
nnoremap 	 :A
let s:cpo_save=&cpo
set cpo&vim
nnoremap <Left> :tabprevious
nnoremap <Right> :tabnext
nnoremap  :call CloseIfNotLast()
nnoremap <silent> * :call F3SearchWord(expand("<cword>"))
nnoremap - :vsplit
nnoremap @ :call CloseIfNotLast()
nnoremap F :Explore
noremap H :call HighLightHandler(expand("<cword>"), 1)
map \rwp <Plug>RestoreWinPosn
map \swp <Plug>SaveWinPosn
nmap \ihn :IHN
nmap \is :IHS:A
nmap \ih :IHS
nnoremap _ :split
map <silent> f :call ShowFuncName()
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
nnoremap gm :execute '/<<<<<<<\|=======\|>>>>>>>'
nnoremap gb :Git blame
nnoremap gB :Git blame
nnoremap gG :execute "Git grep '\\<" .expand("<cword>") ."\\>'"
nnoremap gD :Git diff '" . expand("%") . "'".
noremap h :call HighLightHandler(expand("<cword>"), 0)
nmap n nf
nnoremap <silent> <Plug>(lsp-signature-help) :call lsp#ui#vim#signature_help#get_signature_help_under_cursor()
nnoremap <silent> <Plug>(lsp-previous-reference) :call lsp#internal#document_highlight#jump(-1)
nnoremap <silent> <Plug>(lsp-next-reference) :call lsp#internal#document_highlight#jump(+1)
nnoremap <silent> <Plug>(lsp-status) :echo lsp#get_server_status()
nnoremap <silent> <Plug>(lsp-peek-implementation) :call lsp#ui#vim#implementation(1)
nnoremap <silent> <Plug>(lsp-implementation) :call lsp#ui#vim#implementation(0)
xnoremap <silent> <Plug>(lsp-document-range-format) :<Home>silent <End>call lsp#internal#document_range_formatting#format({ 'bufnr': bufnr('%') })
nnoremap <silent> <Plug>(lsp-document-range-format) :set opfunc=lsp#internal#document_range_formatting#opfuncg@
vnoremap <silent> <Plug>(lsp-document-format) :<Home>silent <End>call lsp#internal#document_range_formatting#format({ 'bufnr': bufnr('%') })
nnoremap <silent> <Plug>(lsp-document-format) :call lsp#internal#document_formatting#format({ 'bufnr': bufnr('%') })
nnoremap <silent> <Plug>(lsp-workspace-symbol-search) :call lsp#internal#workspace_symbol#search#do({})
nnoremap <silent> <Plug>(lsp-workspace-symbol) :call lsp#ui#vim#workspace_symbol('')
nnoremap <silent> <Plug>(lsp-peek-type-definition) :call lsp#ui#vim#type_definition(1)
nnoremap <silent> <Plug>(lsp-type-hierarchy) :call lsp#internal#type_hierarchy#show()
nnoremap <silent> <Plug>(lsp-type-definition) :call lsp#ui#vim#type_definition(0)
nnoremap <silent> <Plug>(lsp-rename) :call lsp#ui#vim#rename()
nnoremap <silent> <Plug>(lsp-references) :call lsp#ui#vim#references()
nnoremap <silent> <Plug>(lsp-previous-diagnostic-nowrap) :call lsp#internal#diagnostics#movement#_previous_diagnostics("-wrap=0")
nnoremap <silent> <Plug>(lsp-previous-diagnostic) :call lsp#internal#diagnostics#movement#_previous_diagnostics()
nnoremap <silent> <Plug>(lsp-next-diagnostic-nowrap) :call lsp#internal#diagnostics#movement#_next_diagnostics("-wrap=0")
nnoremap <silent> <Plug>(lsp-next-diagnostic) :call lsp#internal#diagnostics#movement#_next_diagnostics()
nnoremap <silent> <Plug>(lsp-previous-warning-nowrap) :call lsp#internal#diagnostics#movement#_previous_warning("-wrap=0")
nnoremap <silent> <Plug>(lsp-previous-warning) :call lsp#internal#diagnostics#movement#_previous_warning()
nnoremap <silent> <Plug>(lsp-next-warning-nowrap) :call lsp#internal#diagnostics#movement#_next_warning("-wrap=0")
nnoremap <silent> <Plug>(lsp-next-warning) :call lsp#internal#diagnostics#movement#_next_warning()
nnoremap <silent> <Plug>(lsp-previous-error-nowrap) :call lsp#internal#diagnostics#movement#_previous_error("-wrap=0")
nnoremap <silent> <Plug>(lsp-previous-error) :call lsp#internal#diagnostics#movement#_previous_error()
nnoremap <silent> <Plug>(lsp-next-error-nowrap) :call lsp#internal#diagnostics#movement#_next_error("-wrap=0")
nnoremap <silent> <Plug>(lsp-next-error) :call lsp#internal#diagnostics#movement#_next_error()
nnoremap <silent> <Plug>(lsp-preview-focus) :call lsp#ui#vim#output#focuspreview()
nnoremap <silent> <Plug>(lsp-preview-close) :call lsp#ui#vim#output#closepreview()
nnoremap <silent> <Plug>(lsp-hover-preview) :call lsp#internal#document_hover#under_cursor#do({ 'ui': 'preview' })
nnoremap <silent> <Plug>(lsp-hover-float) :call lsp#internal#document_hover#under_cursor#do({ 'ui': 'float' })
nnoremap <silent> <Plug>(lsp-hover) :call lsp#internal#document_hover#under_cursor#do({})
nnoremap <silent> <Plug>(lsp-document-diagnostics) :call lsp#internal#diagnostics#document_diagnostics_command#do({})
nnoremap <silent> <Plug>(lsp-document-symbol-search) :call lsp#internal#document_symbol#search#do({})
nnoremap <silent> <Plug>(lsp-document-symbol) :call lsp#ui#vim#document_symbol()
nnoremap <silent> <Plug>(lsp-peek-definition) :call lsp#ui#vim#definition(1)
nnoremap <silent> <Plug>(lsp-definition) :call lsp#ui#vim#definition(0)
nnoremap <silent> <Plug>(lsp-peek-declaration) :call lsp#ui#vim#declaration(1)
nnoremap <silent> <Plug>(lsp-declaration) :call lsp#ui#vim#declaration(0)
nnoremap <silent> <Plug>(lsp-code-lens) :call lsp#ui#vim#code_lens()
nnoremap <silent> <Plug>(lsp-code-action-preview) :call lsp#ui#vim#code_action({ 'ui': 'preview' })
nnoremap <silent> <Plug>(lsp-code-action-float) :call lsp#ui#vim#code_action({ 'ui': 'float' })
nnoremap <silent> <Plug>(lsp-code-action) :call lsp#ui#vim#code_action({})
nnoremap <silent> <Plug>(lsp-call-hierarchy-outgoing) :call lsp#ui#vim#call_hierarchy_outgoing()
nnoremap <silent> <Plug>(lsp-call-hierarchy-incoming) :call lsp#ui#vim#call_hierarchy_incoming({})
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nnoremap <S-F3> :execute(g:f3_mode."previous")
nnoremap <F3> :execute(g:f3_mode."next")
noremap <C-H> :call HighLightToggleHandler()
nnoremap <C-W><C-W> :call CloseIfNotLast()
map <C-Down> :wincmd j
map <C-Up> :wincmd k
map <C-Right> :wincmd l
map <C-Left> :wincmd h
nmap <PageDown> f
nmap <Up> kf
nmap <Down> jf
nnoremap <F9> :call ToggleFuncName()
nnoremap <F2> :call ToggleMouse()
nnoremap <S-Tab> :AV
nnoremap <F8> :mksession! .session.vim:echo "Session saved"
nnoremap <C-F7> :execute "copen" | execute "AnsiEscOn" | execute "wincmd p" | execute "wa" | execute "AsyncRun make clean"
nnoremap <F7> :execute "copen" | execute "AnsiEscOn" | execute "wincmd p" | execute "wa" | execute "AsyncRun make -j 4"
nnoremap <F6> :set wrap!
nnoremap <F5> :w! /dev/null:checktime
nnoremap <C-T><Left> :tabprevious
nnoremap <C-T><Right> :tabnext
imap \ihn :IHN
imap \is :IHS:A
imap \ih :IHS
cnoremap <expr> q &diff ? 'qa' : 'q'
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set copyindent
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=fr
set hlsearch
set ignorecase
set incsearch
set path=
set path+=.
set path+=/usr/include
set path+=
set path+=
set path+=~/git/.
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/Bridge
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/ConsoleAsciiTable
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/ConsolePixel
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/ConsoleRead
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/Datalogger
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/FileWriteScript
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/HttpClient
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/HttpClientConsole
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/MailboxReadMessage
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/Process
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/RemoteDueBlink
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/ShellCommands
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/TemperatureWebPanel
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/TimeCheck
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/WiFiStatus
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/YunFirstConfig
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/examples/YunSerialTerminal
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.6.3/Bridge/src
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/Bridge
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/ConsoleAsciiTable
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/ConsolePixel
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/ConsoleRead
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/Datalogger
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/FileWriteScript
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/HttpClient
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/HttpClientConsole
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/MailboxReadMessage
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/Process
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/RemoteDueBlink
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/ShellCommands
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/TemperatureWebPanel
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/TimeCheck
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/WiFiStatus
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/YunFirstConfig
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/examples/YunSerialTerminal
set path+=~/git/Arduino/app/testdata/libraries/Bridge_1.7.0/Bridge/src
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/examples/CardInfo
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/examples/Datalogger
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/examples/DumpFile
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/examples/Files
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/examples/listfiles
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/examples/ReadWrite
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/src
set path+=~/git/Arduino/app/testdata/libraries/SD_1.1.1/SD/src/utility
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/examples/CardInfo
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/examples/Datalogger
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/examples/DumpFile
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/examples/Files
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/examples/listfiles
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/examples/ReadWrite
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/src
set path+=~/git/Arduino/app/testdata/libraries/SD_1.2.1/SD/src/utility
set path+=~/git/Arduino/app/testdata/sketches/Blink
set path+=~/git/AUnit.fbi/examples/advanced
set path+=~/git/AUnit.fbi/examples/AUnitPlatformIO
set path+=~/git/AUnit.fbi/examples/AUnitPlatformIO/src
set path+=~/git/AUnit.fbi/examples/basic
set path+=~/git/AUnit.fbi/examples/basic_verbose
set path+=~/git/AUnit.fbi/examples/continuous
set path+=~/git/AUnit.fbi/examples/filter
set path+=~/git/AUnit.fbi/examples/fixture
set path+=~/git/AUnit.fbi/examples/meta_asserts
set path+=~/git/AUnit.fbi/src/aunit
set path+=~/git/AUnit.fbi/tests/AUnitMetaTest
set path+=~/git/AUnit.fbi/tests/AUnitMoreTest
set path+=~/git/AUnit.fbi/tests/AUnitTest
set path+=~/git/AUnit.fbi/tests/CompareTest
set path+=~/git/AUnit.fbi/tests/FailingTest
set path+=~/git/AUnit.fbi/tests/FilterTest
set path+=~/git/AUnit.fbi/tests/Print64Test
set path+=~/git/AUnit.fbi/tests/SetupAndTeardownTest
set path+=~/git/benchmark/cmake
set path+=~/git/Craft/build/CMakeFiles/3.16.3/CompilerIdCXX
set path+=~/git/EpoxyDuino/cores/epoxy
set path+=~/git/EpoxyDuino/cores/epoxy/epoxy_test/Injection
set path+=~/git/EpoxyDuino/cores/epoxy/epoxy_test/Script
set path+=~/git/EpoxyDuino/cores/epoxy/epoxy_test/Script/Commands
set path+=~/git/EpoxyDuino/examples/BlinkSOS
set path+=~/git/EpoxyDuino/examples/CommandLine
set path+=~/git/EpoxyDuino/examples/PipeFail
set path+=~/git/EpoxyDuino/examples/StdioSerialEcho
set path+=~/git/EpoxyDuino/examples/StdioSerialWrite
set path+=~/git/EpoxyDuino/libraries/EpoxyEepromAvr/examples/HelloEpoxyEepromAvr
set path+=~/git/EpoxyDuino/libraries/EpoxyEepromAvr/src
set path+=~/git/EpoxyDuino/libraries/EpoxyEepromAvr/tests/EpoxyEepromAvrTest
set path+=~/git/EpoxyDuino/libraries/EpoxyEepromEsp/examples/HelloEpoxyEepromEsp
set path+=~/git/EpoxyDuino/libraries/EpoxyEepromEsp/src
set path+=~/git/EpoxyDuino/libraries/EpoxyEepromEsp/tests/EpoxyEepromEspTest
set path+=~/git/EpoxyDuino/libraries/EpoxyFS/examples/HelloEpoxyFS
set path+=~/git/EpoxyDuino/libraries/EpoxyFS/examples/SeekBenchmark
set path+=~/git/EpoxyDuino/libraries/EpoxyFS/src
set path+=~/git/EpoxyDuino/libraries/EpoxyFS/tests/EpoxyFSTest
set path+=~/git/EpoxyDuino/libraries/EpoxyMockDigitalWriteFast/examples/DigitalWriteFastDemo
set path+=~/git/EpoxyDuino/libraries/EpoxyMockFastLED
set path+=~/git/EpoxyDuino/libraries/EpoxyMockTimerOne
set path+=~/git/EpoxyDuino/tests
set path+=~/git/EpoxyDuino/tests/DigitalReadTest
set path+=~/git/EpoxyDuino/tests/InjectorTest
set path+=~/git/EpoxyDuino/tests/IPAddressTestDisabled
set path+=~/git/EpoxyDuino/tests/ScriptInjectionTest
set path+=~/git/EpoxyDuino/tests/ScriptParserTest
set path+=~/git/EpoxyDuino/tests/SimulatedTimeTest
set path+=~/git/Erwann
set path+=~/git/Erwann/nbproject/private
set path+=~/git/esp_debugger/build/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/esp_debugger/build/esp_debug_autogen
set path+=~/git/esp_debugger/build/esp_debug_autogen/3YJK5W5UP7
set path+=~/git/esp_debugger/build/esp_debug_autogen/PRMOGMWJPH
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen/include
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/autohide/AutoHideExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/autohide/AutoHideExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/deleteonclose/DeleteOnCloseTest_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/dockindock/DockInDockExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/dockindock/DockInDockExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/emptydockarea/EmptyDockAreaExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/emptydockarea/EmptyDockAreaExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/hideshow/HideShowExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/hideshow/HideShowExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/EWIEGA46WW
set path+=~/git/esp_debugger/build/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/YCY4FPCVH5
set path+=~/git/esp_debugger/ext/klive/common
set path+=~/git/esp_debugger/ext/klive/core
set path+=~/git/esp_debugger/ext/klive/core/hardware
set path+=~/git/esp_debugger/ext/klive/handlers/gadgets/clock
set path+=~/git/esp_debugger/ext/klive/handlers/gadgets/gdb
set path+=~/git/esp_debugger/ext/klive/handlers/gadgets/lines
set path+=~/git/esp_debugger/ext/klive/handlers/gadgets/z80
set path+=~/git/esp_debugger/ext/klive/handlers/gadgets/zx/spectrum
set path+=~/git/esp_debugger/ext/klive/handlers/memory
set path+=~/git/esp_debugger/ext/klive/handlers/project
set path+=~/git/esp_debugger/ext/klive/handlers/screen
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/demo
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/autohide
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/centralwidget
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/deleteonclose
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/dockindock
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/emptydockarea
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/hideshow
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/sidebar
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/examples/simple
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/src
set path+=~/git/esp_debugger/ext/Qt-Advanced-Docking-System/src/linux
set path+=~/git/esp_debugger/src/core
set path+=~/git/esp_debugger/src/handlers
set path+=~/git/EspMock/libraries/ESP8266mDNS/src
set path+=~/git/EspMock/libraries/ESP8266WiFi/src
set path+=~/git/EspMock/tests/dns-tests
set path+=~/git/EspMock/tests/network-tests
set path+=~/git/joboccara/examples/accumulate_range
set path+=~/git/joboccara/examples/copy_print
set path+=~/git/joboccara/examples/hello_world
set path+=~/git/joboccara/examples/istream_iterator
set path+=~/git/joboccara/examples/merge_adjacent
set path+=~/git/joboccara/NamedType/CMakeFiles/3.13.4/CompilerIdCXX
set path+=~/git/joboccara/NamedType/test
set path+=~/git/KDDockWidgets/build/CMakeFiles/3.13.4/CompilerIdCXX
set path+=~/git/KDDockWidgets/build/examples/dockwidgets
set path+=~/git/KDDockWidgets/build/examples/dockwidgets/kddockwidgets_example_autogen
set path+=~/git/KDDockWidgets/build/examples/dockwidgets/kddockwidgets_example_autogen/EWIEGA46WW
set path+=~/git/KDDockWidgets/build/examples/minimal
set path+=~/git/KDDockWidgets/build/examples/minimal/kddockwidgets_minimal_example_autogen
set path+=~/git/KDDockWidgets/build/examples/minimal/kddockwidgets_minimal_example_autogen/PBMXWPTGLO
set path+=~/git/KDDockWidgets/build/src
set path+=~/git/KDDockWidgets/build/src/kddockwidgets_autogen
set path+=~/git/KDDockWidgets/build/src/kddockwidgets_autogen/5KNYKF2XD7
set path+=~/git/KDDockWidgets/build/src/kddockwidgets_autogen/EWIEGA46WW
set path+=~/git/KDDockWidgets/build/src/kddockwidgets_autogen/FF5LUYR3FN
set path+=~/git/KDDockWidgets/build/src/kddockwidgets_autogen/PGVKHOT7RA
set path+=~/git/KDDockWidgets/build/src/private/multisplitter
set path+=~/git/KDDockWidgets/build/src/private/multisplitter/kddockwidgets_multisplitter_autogen
set path+=~/git/KDDockWidgets/build/src/private/multisplitter/kddockwidgets_multisplitter_autogen/EWIEGA46WW
set path+=~/git/KDDockWidgets/examples/dockwidgets
set path+=~/git/KDDockWidgets/examples/minimal
set path+=~/git/KDDockWidgets/src
set path+=~/git/KDDockWidgets/src/private
set path+=~/git/KDDockWidgets/src/private/indicators
set path+=~/git/KDDockWidgets/src/private/multisplitter
set path+=~/git/KDDockWidgets/src/private/multisplitter/examples/quick
set path+=~/git/KDDockWidgets/src/private/multisplitter/tests
set path+=~/git/KDDockWidgets/src/private/quick
set path+=~/git/KDDockWidgets/src/private/widgets
set path+=~/git/KDDockWidgets/tests
set path+=~/git/KDDockWidgets/tests/fuzzer
set path+=~/git/klive/build.clang/CMakeFiles/3.13.4/CompilerIdCXX
set path+=~/git/klive/build.clang/CMakeFiles/3.16.3/CompilerIdCXX
set path+=~/git/klive/build.clang/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen/EWIEGA46WW
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/deleteonclose/DeleteOnCloseTest_autogen
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/EWIEGA46WW
set path+=~/git/klive/build.clang/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/YCY4FPCVH5
set path+=~/git/klive/build.clang/klive_autogen
set path+=~/git/klive/build.clang/klive_autogen/23JPJC5HFW
set path+=~/git/klive/build.clang/klive_autogen/3YJK5W5UP7
set path+=~/git/klive/build.clang/klive_autogen/4WYOSESSBA
set path+=~/git/klive/build.clang/klive_autogen/5K2EUD5K24
set path+=~/git/klive/build.clang/klive_autogen/6UTL5QURK5
set path+=~/git/klive/build.clang/klive_autogen/72PQB5SULU
set path+=~/git/klive/build.clang/klive_autogen/TAC5DWH4SE
set path+=~/git/klive/build.clang/klive_autogen/X6NFHAVLQB
set path+=~/git/klive/build.clang/klive_autogen/ZSXPL33PUI
set path+=~/git/klive/build/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/demo/AdvancedDockingSystemDemo_autogen/include
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/autohide/AutoHideExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/autohide/AutoHideExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/deleteonclose/DeleteOnCloseTest_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/dockindock/DockInDockExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/dockindock/DockInDockExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/emptydockarea/EmptyDockAreaExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/emptydockarea/EmptyDockAreaExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/hideshow/HideShowExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/hideshow/HideShowExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/EWIEGA46WW
set path+=~/git/klive/build/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/YCY4FPCVH5
set path+=~/git/klive/build/klive_autogen
set path+=~/git/klive/build/klive_autogen/23JPJC5HFW
set path+=~/git/klive/build/klive_autogen/3YJK5W5UP7
set path+=~/git/klive/build/klive_autogen/4WYOSESSBA
set path+=~/git/klive/build/klive_autogen/5K2EUD5K24
set path+=~/git/klive/build/klive_autogen/6UTL5QURK5
set path+=~/git/klive/build/klive_autogen/72PQB5SULU
set path+=~/git/klive/build/klive_autogen/IFX4PSSHFK
set path+=~/git/klive/build/klive_autogen/TAC5DWH4SE
set path+=~/git/klive/build/klive_autogen/X6NFHAVLQB
set path+=~/git/klive/build/klive_autogen/Y67FQU55QO
set path+=~/git/klive/build/klive_autogen/ZSXPL33PUI
set path+=~/git/klive/build.ninja/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/centralwidget/CentralWidgetExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/deleteonclose/DeleteOnCloseTest_autogen
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/hideshow/HideShowExample_autogen
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/hideshow/HideShowExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/sidebar/SidebarExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/examples/simple/SimpleExample_autogen/EWIEGA46WW
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/EWIEGA46WW
set path+=~/git/klive/build.ninja/ext/Qt-Advanced-Docking-System/src/qtadvanceddocking_autogen/YCY4FPCVH5
set path+=~/git/klive/build.ninja/klive_autogen
set path+=~/git/klive/build.ninja/klive_autogen/23JPJC5HFW
set path+=~/git/klive/build.ninja/klive_autogen/3YJK5W5UP7
set path+=~/git/klive/build.ninja/klive_autogen/4WYOSESSBA
set path+=~/git/klive/build.ninja/klive_autogen/5K2EUD5K24
set path+=~/git/klive/build.ninja/klive_autogen/6UTL5QURK5
set path+=~/git/klive/build.ninja/klive_autogen/72PQB5SULU
set path+=~/git/klive/build.ninja/klive_autogen/IFX4PSSHFK
set path+=~/git/klive/build.ninja/klive_autogen/TAC5DWH4SE
set path+=~/git/klive/build.ninja/klive_autogen/X6NFHAVLQB
set path+=~/git/klive/build.ninja/klive_autogen/ZSXPL33PUI
set path+=~/git/klive/common
set path+=~/git/klive/core
set path+=~/git/klive/core/hardware
set path+=~/git/klive/core/hardware/spectrum
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/demo/AdvancedDockingSystemDemo_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/demo/AdvancedDockingSystemDemo_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/demo/AdvancedDockingSystemDemo_autogen/include
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/autohide/AutoHideExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/autohide/AutoHideExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/centralwidget/CentralWidgetExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/centralwidget/CentralWidgetExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/deleteonclose/DeleteOnCloseTest_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/dockindock/DockInDockExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/dockindock/DockInDockExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/emptydockarea/EmptyDockAreaExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/emptydockarea/EmptyDockAreaExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/hideshow/HideShowExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/hideshow/HideShowExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/sidebar/SidebarExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/sidebar/SidebarExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/simple/SimpleExample_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/examples/simple/SimpleExample_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/src/qtadvanceddocking_autogen
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/src/qtadvanceddocking_autogen/EWIEGA46WW
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/build/src/qtadvanceddocking_autogen/YCY4FPCVH5
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/demo
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/autohide
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/centralwidget
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/deleteonclose
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/dockindock
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/emptydockarea
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/hideshow
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/sidebar
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/examples/simple
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/src
set path+=~/git/klive/ext/Qt-Advanced-Docking-System/src/linux
set path+=~/git/klive/handlers/gadgets/clock
set path+=~/git/klive/handlers/gadgets/console
set path+=~/git/klive/handlers/gadgets/gdb
set path+=~/git/klive/handlers/gadgets/lines
set path+=~/git/klive/handlers/gadgets/z80
set path+=~/git/klive/handlers/gadgets/zx/spectrum
set path+=~/git/klive/handlers/gadgets/zx/spectrum/rst16
set path+=~/git/klive/handlers/memory
set path+=~/git/klive/handlers/project
set path+=~/git/klive/handlers/screen
set path+=~/git/llama.cpp
set path+=~/git/llama.cpp/build/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/llama.cpp/examples
set path+=~/git/llama.cpp/examples/embedding
set path+=~/git/llama.cpp/examples/main
set path+=~/git/llama.cpp/examples/perplexity
set path+=~/git/llama.cpp/examples/quantize
set path+=~/git/llama.cpp/examples/quantize-stats
set path+=~/git/llama.cpp/tests
set path+=~/git/mbozada/Craft/CMakeFiles/3.16.3/CompilerIdCXX
set path+=~/git/mbozada/Craft/src
set path+=~/git/Qt-Advanced-Docking-System/build/CMakeFiles/3.13.4/CompilerIdCXX
set path+=~/git/Qt-Advanced-Docking-System/build/demo/AdvancedDockingSystemDemo_autogen
set path+=~/git/Qt-Advanced-Docking-System/build/demo/AdvancedDockingSystemDemo_autogen/EWIEGA46WW
set path+=~/git/Qt-Advanced-Docking-System/build/examples/centralwidget/CentralWidgetExample_autogen
set path+=~/git/Qt-Advanced-Docking-System/build/examples/centralwidget/CentralWidgetExample_autogen/EWIEGA46WW
set path+=~/git/Qt-Advanced-Docking-System/build/examples/deleteonclose/DeleteOnCloseTest_autogen
set path+=~/git/Qt-Advanced-Docking-System/build/examples/sidebar/SidebarExample_autogen
set path+=~/git/Qt-Advanced-Docking-System/build/examples/sidebar/SidebarExample_autogen/EWIEGA46WW
set path+=~/git/Qt-Advanced-Docking-System/build/examples/simple/SimpleExample_autogen
set path+=~/git/Qt-Advanced-Docking-System/build/examples/simple/SimpleExample_autogen/EWIEGA46WW
set path+=~/git/Qt-Advanced-Docking-System/build/src/qtadvanceddocking_autogen
set path+=~/git/Qt-Advanced-Docking-System/build/src/qtadvanceddocking_autogen/EWIEGA46WW
set path+=~/git/Qt-Advanced-Docking-System/build/src/qtadvanceddocking_autogen/YCY4FPCVH5
set path+=~/git/Qt-Advanced-Docking-System/demo
set path+=~/git/Qt-Advanced-Docking-System/examples/centralwidget
set path+=~/git/Qt-Advanced-Docking-System/examples/deleteonclose
set path+=~/git/Qt-Advanced-Docking-System/examples/sidebar
set path+=~/git/Qt-Advanced-Docking-System/examples/simple
set path+=~/git/Qt-Advanced-Docking-System/src
set path+=~/git/Qt-Advanced-Docking-System/src/linux
set path+=~/git/rle
set path+=~/git/SaturnLib
set path+=~/git/SaturnLib/build/CMakeFiles/3.13.4/CompilerIdCXX
set path+=~/git/SaturnLib/src
set path+=~/git/setup/scripts/leak/test
set path+=~/git/setup/skel/skeleton
set path+=~/git/setup/skel/test
set path+=~/git/setup/skel/w2
set path+=~/git/setup/skel/wildcard
set path+=~/git/setup/vim/pack/ext/start/vim-lsp/test/testproject/src
set path+=~/git/sfml-breakout/src
set path+=~/git/simple-observable-qt
set path+=~/git/snippets/adventOfCode2020/day_1_1
set path+=~/git/snippets/adventOfCode2020/day_1_2
set path+=~/git/snippets/adventOfCode2020/day_2_1
set path+=~/git/snippets/adventOfCode2020/day_2_2
set path+=~/git/snippets/adventOfCode2020/day_3_1
set path+=~/git/snippets/adventOfCode2020/day_3_2
set path+=~/git/snippets/adventOfCode2020/day_4_1
set path+=~/git/snippets/adventOfCode2020/day_4_2
set path+=~/git/snippets/adventOfCode2020/day_5_1
set path+=~/git/snippets/adventOfCode2020/day_5_2
set path+=~/git/snippets/adventOfCode2020/day_6_1
set path+=~/git/snippets/boost/bimap
set path+=~/git/snippets/consprod
set path+=~/git/snippets/crc
set path+=~/git/snippets/fluent/comma
set path+=~/git/snippets/fluent/crtp
set path+=~/git/snippets/fluent/set_seggregate
set path+=~/git/snippets/fluent/singleton_policy
set path+=~/git/snippets/hash
set path+=~/git/snippets/lambda_algorithm
set path+=~/git/snippets/max_locked
set path+=~/git/snippets/move
set path+=~/git/snippets/pyramid
set path+=~/git/snippets/reader_writer
set path+=~/git/snippets/reg
set path+=~/git/snippets/remove
set path+=~/git/snippets/rle
set path+=~/git/snippets/sbc
set path+=~/git/snippets/setup/skel
set path+=~/git/snippets/stl/chrono
set path+=~/git/snippets/t
set path+=~/git/snippets/tokenizer
set path+=~/git/snippets/union
set path+=~/git/squares
set path+=~/git/synth/bin/synth
set path+=~/git/synth/build2/CMakeFiles/3.22.1/CompilerIdCXX
set path+=~/git/synth/build/CMakeFiles/3.13.4/CompilerIdCXX
set path+=~/git/synth/lib/src
set path+=~/git/synth/single_file_synth
set path+=~/git/synth/tests
set path+=~/git/synth/tests/hook
set path+=~/git/TinyConsole/examples/console
set path+=~/git/TinyConsole/src
set path+=~/git/TinyConsole/tests/tiny-string-tests
set path+=~/git/TinyMqtt/examples/advanced/mqtt_class_binder
set path+=~/git/TinyMqtt/examples/client-without-wifi
set path+=~/git/TinyMqtt/examples/client-with-wifi
set path+=~/git/TinyMqtt/examples/simple-broker
set path+=~/git/TinyMqtt/examples/simple-client
set path+=~/git/TinyMqtt/examples/tinymqtt-test
set path+=~/git/TinyMqtt/examples/W5500/client-with-W5500-ESP8266
set path+=~/git/TinyMqtt/examples/W5500/client-with-W5500-RP2040
set path+=~/git/TinyMqtt/src
set path+=~/git/TinyMqtt/tests/c
set path+=~/git/TinyMqtt/tests/classbind-tests
set path+=~/git/TinyMqtt/tests/compile-tests
set path+=~/git/TinyMqtt/tests/debug-mode
set path+=~/git/TinyMqtt/tests/length-tests.todo
set path+=~/git/TinyMqtt/tests/local-tests
set path+=~/git/TinyMqtt/tests/network-tests
set path+=~/git/TinyMqtt/tests/nowifi-tests
set path+=~/git/TinyMqtt/tests/string-indexer-tests
set path+=~/git/TinyMqtt/tests/topic-tests
set path+=~/git/tmp/klive/klive
set path+=~/git/tmp/klive/klive/core
set path+=~/git/tmp/klive/klive/core/hardware
set path+=~/git/tmp/klive/klive/handlers/gadgets/clock
set path+=~/git/tmp/klive/klive/handlers/memory
set path+=~/git/tmp/klive/klive/handlers/project
set path+=~/git/tmp/klive/klive/handlers/screen
set path+=~/git/z80/Libraries/audio
set path+=~/git/z80/Libraries/Box
set path+=~/git/z80/Libraries/cpp
set path+=~/git/z80/Libraries/Crypt
set path+=~/git/z80/Libraries/cstrings
set path+=~/git/z80/Libraries/gif
set path+=~/git/z80/Libraries/hash
set path+=~/git/z80/Libraries/kio
set path+=~/git/z80/Libraries/LibraryTester/Source
set path+=~/git/z80/Libraries/MemPool
set path+=~/git/z80/Libraries/Names
set path+=~/git/z80/Libraries/Qt
set path+=~/git/z80/Libraries/rng
set path+=~/git/z80/Libraries/Templates
set path+=~/git/z80/Libraries/unix
set path+=~/git/z80/Libraries/Z80/Emu
set path+=~/git/z80/Libraries/Z80/goodies
set path+=~/git/z80/zasm/Source
set previewheight=3
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,~/.vim/pack/tpope/start/fugitive,~/.vim/pack/hsaturn/start/awake,~/.vim/pack/ext/start/vim-lsp,~/.vim/pack/ext/start/awake,~/.vim/pack/ext/start/asyncrun,~/.vim/pack/ext/start/AnsiEsc,~/.vim/pack/all/start/vim-nix,/var/lib/vim/addons,/etc/vim,/usr/share/vim/vimfiles,/usr/share/vim/vim82,/usr/share/vim/vimfiles/after,/etc/vim/after,/var/lib/vim/addons/after,~/.vim/after
set scrolloff=4
set shiftwidth=2
set shortmess=filnxtToOSI
set smartindent
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set noswapfile
set tabstop=2
set wildignorecase
set nowritebackup
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/git/TinyBash/tests/pc
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
argglobal
enew
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal copyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != ''
setlocal filetype=
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal smartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOSI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
