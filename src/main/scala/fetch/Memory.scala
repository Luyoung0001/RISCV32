package fetch

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import common.Consts._

class ImemPortIO extends Bundle {
    val addr = Input(UInt(WORD_LEN.W))
    val inst = Output(UInt(WORD_LEN.W))
}
class DmemPortIO extends Bundle {
    val addr = Input(UInt(WORD_LEN.W))
    val rdata = Output(UInt(WORD_LEN.W))
}

class Memory extends Module {
    val io = IO(new Bundle{
        val imem = new ImemPortIO()
        val dmem = new DmemPortIO()
    })

    // 生成 8bit * 16384 个寄存器作为存储器实体
    val mem = Mem(16384, UInt(8.W))

    // 加载存储器数据
    // loadMemoryFromFile(mem, "src/hex/fetch.hex")
    loadMemoryFromFile(mem, "src/hex/lw.hex")

    // 连接 4 * 8 = 32 bit 数据，输送到 inst
    // 高地址位于高字节，小端字节序
    io.imem.inst := Cat(
        mem(io.imem.addr + 3.U(WORD_LEN.W)),
        mem(io.imem.addr + 2.U(WORD_LEN.W)),
        mem(io.imem.addr + 1.U(WORD_LEN.W)),
        mem(io.imem.addr)
    )
    io.dmem.rdata := Cat(
        mem(io.dmem.addr + 3.U(WORD_LEN.W)),
        mem(io.dmem.addr + 2.U(WORD_LEN.W)),
        mem(io.dmem.addr + 1.U(WORD_LEN.W)),
        mem(io.dmem.addr)
    )

}
