package fetch

import chisel3._
import org.scalatest._

import chiseltest._

class HexTest extends FlatSpec with ChiselScalatestTester {
    "mycpu" should "work through hex" in {
        test(new Top) { c=>
            // 在该代码块中描述测试
            while(c.io.exit.peek().litValue() == 0) {
                c.clock.step(1)

            }
        }

    }

}



