@echo off

rem Add location of Make to PATH environment var
set PATH=%APPDATA%\xPacks\windows-build-tools\xpack-windows-build-tools-4.4.0-1\bin;%PATH%

rem Add location of RISC-V GCC to PATH environment var
set PATH=%APPDATA%\xPacks\riscv-none-elf-gcc\xpack-riscv-none-elf-gcc-12.2.0-3\bin;%PATH%

rem Change to directory this batch file resides in
cd "%~dp0"

rem Open a new command prompt (inherits this environment)
%ComSpec%
