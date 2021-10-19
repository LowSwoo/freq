# Остановка моделирования
quit -sim

# Выключение записи лог-файла
transcript off

# Удаление старой библиотеки при её наличии
if {[file exists work]} {
  vdel -lib work -all
}

# Создание новой библиотеки
vlib work
vmap work work

# Компилирование исходных кодов
vcom -93 -work work {../Source/src/clk_divider.vhd}
vcom -93 -work work {../Source/src/univibrator.vhd}
vcom -93 -work work {../Source/src/up_down_counter.vhd}
vcom -93 -work work {../Source/src/top.vhd}
vcom -93 -work work {../Source/tb/top_tb.vhd}

# Запуск симулятора
vsim -t 1ns work.top_tb

# Выключение отображения предупреждений из библиотек Std_Arith и Numeric_Std
set StdArithNoWarnings 0
set NumericStdNoWarnings 0

# Настройки отображения временных сигналов
add wave -r sim:/top_tb/dut/*
delete wave *
do wave.do

# Запуск моделирования на определённое время
run 300 us
