package fetch

import chisel3._
import chisel3.util._

class Top extends Module {
    val io = IO(new Bundle {
        val exit = Output(Bool())
    })

    // 实例化 Core、Memory 类，然后用 Module 硬件化
    val core    = Module(new Core())
    val memory  = Module(new Memory())

    // core 的 imme 和 memory 的 imme 应该互连
    core.io.imem <> memory.io.imem
    core.io.dmem <> memory.io.dmem 
    io.exit := core.io.exit

}




